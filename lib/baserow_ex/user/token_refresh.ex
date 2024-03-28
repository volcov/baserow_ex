defmodule BaserowEx.User.TokenRefresh do
  @moduledoc """
  Generate a new access_token that can be used to continue operating on Baserow
  starting from a valid refresh token.
  """

  alias BaserowEx.User.TokenRefresh.InputParams
  alias BaserowEx.User.TokenRefresh.ResponseParams

  @api_uri "https://api.baserow.io/api/user/token-refresh/"

  @spec call(String.t(), Keyword.t()) ::
          {:ok, ResponseParams}
          | {:error, :token_invalid_or_expired}
          | {:error, :wrong_input_data}
          | {:error, :unknow_error}
  def call(refresh_token, opts) do
    params = %{
      refresh_token: refresh_token
    }

    with {:ok, valid_params} <- InputParams.changeset(params),
         {:ok, %{body: body, status: 200}} <- post(map_body(valid_params), opts) do
      ResponseParams.changeset(body)
    else
      {:ok, %{status: 401}} ->
        {:error, :token_invalid_or_expired}

      {:error, %Ecto.Changeset{} = _changeset} ->
        {:error, :wrong_input_data}

      _ ->
        {:error, :unknown_error}
    end
  end

  defp map_body(params) do
    %{
      refresh_token: params.refresh_token
    }
  end

  defp post(body, opts) do
    opts
    |> client()
    |> http_client().post(
      @api_uri,
      body,
      []
    )
  end

  defp client(opts) do
    http_client().build_client(opts)
  end

  defp http_client do
    Application.get_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
  end
end
