ARG MIX_ENV="prod"

FROM hexpm/elixir:1.14.1-erlang-24.3.4.3-alpine-3.14.6 AS build

RUN apk add --no-cache build-base git python3 curl

WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/

RUN mix deps.compile

COPY lib lib
RUN mix compile

COPY config/runtime.exs config/
RUN mix release

# app stage
FROM alpine:3.14.2 AS app

ARG MIX_ENV

RUN apk add --no-cache libstdc++ openssl ncurses-libs

ENV USER="elixir"
WORKDIR "/home/${USER}/app"

RUN addgroup -g 1000 -S "${USER}" && adduser -s /bin/sh -u 1000 -G "${USER}" -h "/home/${USER}" -D "${USER}" && su "${USER}"

USER "${USER}"

COPY --from=build --chown="${USER}":"${USER}" /app/_build/"${MIX_ENV}"/rel/api_release_demo ./

ENTRYPOINT ["bin/api_release_demo"]

CMD ["start"]