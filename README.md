# ApiReleaseDemo

## ports

see config/<env>.exs

## run

```
iex -S mix run
curl -d '{"my_name_is": "Slim Shady"}' -H "Content-Type: application/json" -X POST http://localhost:8081/hello
```

## docker

```
sudo docker image build -t elixir/api_release_demo .
sudo docker run elixir/api_release_demo
```
