defmodule BaserowEx.User.TokenVerify do
  @moduledoc """
  Verifies if the refresh token is valid and can be used to generate a new access_token.
  Unlike the original api, which returns other data,
  this module will only return a boolean saying whether the token is valid or not.
  """

  alias BaserowEx.User.TokenVerify.InputParams

  @api_uri "https://api.baserow.io/api/user/token-verify/"

  @spec call(String.t(), Keyword.t()) :: boolean()
  def call(refresh_token, opts) do
    params = %{
      refresh_token: refresh_token
    }

    with {:ok, valid_params} <- InputParams.changeset(params),
         {:ok, %{body: body}} <- post(map_body(valid_params), opts),
         {:ok, :valid_token} <- verify_body(body) do
      true
    else
      _ ->
        false
    end
  end

  defp verify_body(%{"user" => _user}) do
    {:ok, :valid_token}
  end

  defp verify_body(%{"error" => _error}) do
    {:error, :token_invalid_or_expired}
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
