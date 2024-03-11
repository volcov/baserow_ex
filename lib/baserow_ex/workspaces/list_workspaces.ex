defmodule BaserowEx.Workspaces.ListWorkspaces do
  @moduledoc false

  @http_client Application.compile_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
  def call(opts \\ []) do
    raise("not implemented")
    # @http_client.get(client(opts), "https://api.baserow.io/api/workspaces/")
  end

  defp client(opts) do
    @http_client.build_client(opts)
  end
end
