defmodule ApiReleaseDemo.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/" do
    send_resp(
      conn,
      200,
      ~s(you can say "hello" by posting {"my_name_is": <your name>} to "/hello")
    )
  end

  get "/favicon.ico" do
    send_resp(conn, 200, "")
  end

  post "/hello" do
    response =
      case conn.body_params do
        %{"my_name_is" => name} -> %{hello: name}
        _ -> %{hello: "stranger"}
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(response))
  end

  match _ do
    send_resp(conn, 404, "not found.")
  end
end
