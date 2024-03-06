defmodule BaserowEx.Workspaces.ListWorkspaces do
  @http_client Application.compile_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
  def call do
    @http_client.get(client(), "http://www.google.com")
  end

  defp client do
    @http_client.build_client()
  end
end
