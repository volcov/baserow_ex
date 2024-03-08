defmodule BaserowEx.User.TokenAuth do
  alias BaserowEx.User.TokenAuth.InputParams
  alias BaserowEx.User.TokenAuth.ResponseParams

  @http_client Application.compile_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
  @api_uri "https://api.baserow.io/api/user/token-auth/"

  @spec call(String.t(), String.t(), Keyword.t()) ::
          {:error, any()} | BaserowEx.User.TokenAuth.ResponseParams.t()
  def call(email, password, opts) do
    params = %{
      email: email,
      password: password
    }

    with {:ok, valid_params} <- InputParams.validate_params(params),
         {:ok, %{body: body}} <- post(valid_params, opts),
         {:ok, valid_response} <- ResponseParams.validate_params(body) do
      %ResponseParams{
        access_token: valid_response.access_token,
        refresh_token: valid_response.refresh_token
      }
    end
  end

  defp client(opts) do
    @http_client.build_client(opts)
  end

  defp post(body, opts) do
    @http_client.post(
      client(opts),
      @api_uri,
      body,
      []
    )
  end
end
