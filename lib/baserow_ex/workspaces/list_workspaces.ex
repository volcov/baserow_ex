defmodule BaserowEx.Workspaces.ListWorkspaces do
  @http_client Application.compile_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
  def call(opts \\ []) do
    @http_client.get(client(opts), "https://api.baserow.io/api/workspaces/")
  end

  defp client(opts) do
    @http_client.build_client(opts)
  end
end
