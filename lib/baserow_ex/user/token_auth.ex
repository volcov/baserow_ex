defmodule BaserowEx.User.TokenAuth do
  @moduledoc """
  Authenticates an existing user based on their email and their password.
  If successful, an access token and a refresh token will be returned.
  """

  alias BaserowEx.User.TokenAuth.InputParams
  alias BaserowEx.User.TokenAuth.ResponseParams

  @api_uri "https://api.baserow.io/api/user/token-auth/"

  @spec call(String.t(), String.t(), Keyword.t()) ::
          {:error, any()} | BaserowEx.User.TokenAuth.ResponseParams.t()
  def call(email, password, opts) do
    params = %{
      email: email,
      password: password
    }

    with {:ok, valid_params} <- InputParams.changeset(params),
         {:ok, %{body: body}} <- post(map_body(valid_params), opts) do
      ResponseParams.changeset(body)
    end
  end

  defp map_body(params) do
    %{
      email: params.email,
      password: params.password
    }
  end

  defp client(opts) do
    http_client().build_client(opts)
  end

  defp http_client() do
    Application.get_env(:baserow_ex, :http_client, BaserowEx.HTTPClient.Tesla)
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
end
