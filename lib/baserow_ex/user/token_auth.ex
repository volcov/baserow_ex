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

    with {:ok, valid_params} <- InputParams.changeset(params),
         {:ok, %{body: body}} <- post(valid_params, opts) do
      ResponseParams.changeset(body)
    end
  end

  defp client(opts) do
    @http_client.build_client(opts)
  end

  defp post(body, opts) do
    opts
    |> client()
    |> @http_client.post(
      @api_uri,
      body,
      []
    )
  end
end
