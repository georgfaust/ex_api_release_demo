defmodule ApiReleaseDemo.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  @index ~s(you can say "hallo" by posting {"my_name_is": <your name>} to "/hello")
  @favicon ""

  get("/", do: send_resp(conn, 200, @index))
  get("/favicon.ico", do: send_resp(conn, 200, @favicon))

  post "/hallo" do
    name =
      case Map.get(conn, :body_params) do
        %{"my_name_is" => name} -> name
        _ -> "stranger"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{hallo: name}))
  end

  match(_, do: send_resp(conn, 404, "not found."))
end
