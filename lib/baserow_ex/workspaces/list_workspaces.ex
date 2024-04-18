defmodule BaserowEx.Workspaces.ListWorkspaces do
  @moduledoc """
  This module is responsible for listing all workspaces of an authorized user, and will map them into a list of maps containing id and name
  """

  alias BaserowEx.BaserowClient
  alias BaserowEx.Workspaces.ListWorkspaces.ResponseParams

  @api_uri "https://api.baserow.io/api/workspaces/"

  @doc """
  this function receives a BaserowEx client, and will make the call to the endpoint that lists the workspaces, managing the token session if necessary.

  the return will be in the standard format of this library:
  {:ok, BaserowClient.Client.t(), list()}

  the client returned in the triple tuple must be used by subsequent calls from the application,
  or even by other calls that are not from this module, this will guarantee session control

  ## Example

      iex> BaserowEx.Workspaces.ListWorkspaces.call(client)
      {:ok, BaserowClient.Client.t(), [%ResponseParams{id: 0, name: "workspace_one"}]

  """
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
        call(refreshed_client, [])

      _ ->
        {:error, :unable_reauth}
    end
  end
end
