defmodule BaserowEx.HTTPClient.Tesla do
  @behaviour BaserowEx.HTTPClient

  @impl BaserowEx.HTTPClient
  def build_client(opts \\ []) do
    Tesla.client(opts)
  end

  @impl BaserowEx.HTTPClient
  def get(client, uri, opts \\ []) do
    Tesla.get(client, uri, opts)
  end
end
