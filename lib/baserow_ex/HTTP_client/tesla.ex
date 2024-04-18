defmodule BaserowEx.HTTPClient.Tesla do
  @moduledoc false

  @behaviour BaserowEx.HTTPClient

  @impl BaserowEx.HTTPClient
  def build_client(opts) do
    default_middleware = [
      Tesla.Middleware.JSON
    ]

    access_token = Keyword.get(opts, :access_token)

    middleware =
      if access_token do
        default_middleware ++
          [{Tesla.Middleware.Headers, [{"authorization", "JWT #{access_token}"}]}]
      else
        default_middleware
      end

    Tesla.client(middleware)
  end

  @impl BaserowEx.HTTPClient
  def get(client, uri, opts \\ []) do
    Tesla.get(client, uri, opts)
  end

  @impl BaserowEx.HTTPClient
  def post(client, uri, body, opts) do
    Tesla.post(client, uri, body, opts)
  end
end
