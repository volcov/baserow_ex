defmodule BaserowEx.HTTPClient.Tesla do
  @moduledoc false

  @behaviour BaserowEx.HTTPClient

  @impl BaserowEx.HTTPClient
  def build_client(_opts) do
    middleware = [
      Tesla.Middleware.JSON
    ]

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
