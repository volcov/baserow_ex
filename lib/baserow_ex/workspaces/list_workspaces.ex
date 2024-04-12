defmodule BaserowEx.Workspaces.ListWorkspaces do
  @moduledoc false

  alias BaserowEx.BaserowClient
  alias BaserowEx.Workspaces.ListWorkspaces.ResponseParams

  @api_uri "https://api.baserow.io/api/workspaces/"

  @spec call(BaserowClient.Client.t(), Keyword.t()) ::
          {:ok, BaserowClient.Client.t(), list(ResponseParams.t())}
          | {:error, :unknown_error}
  def call(baserow_client, opts) do
    case get(opts ++ [access_token: baserow_client.access_token]) do
      {:ok, %{body: body, status: 200}} ->
        workspaces =
          body
          |> Enum.map(fn ws ->
            {:ok, workspace} = ResponseParams.changeset(ws)
            workspace
          end)

        {:ok, baserow_client, workspaces}

      {:ok, %{status: 401}} ->
        try_refresh(baserow_client)

      _ ->
        {:error, :unknown_error}
    end
  end

  defp client(opts) do
    http_client().build_client(opts)
  end

  defp http_client do
    Application.get_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
  end

  defp get(opts) do
    opts
    |> client()
    |> http_client().get(
      @api_uri,
      []
    )
  end

  defp try_refresh(baserow_client) do
    case BaserowClient.try_refresh_token(baserow_client) do
      {:ok, refreshed_client} ->
        IO.puts("CAI NO REFREHS")
        call(refreshed_client, [])

      _ ->
        {:error, :unable_reauth}
    end
  end
end
