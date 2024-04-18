defmodule BaserowEx.BaserowClient do
  @moduledoc false

  alias BaserowEx.BaserowClient.Client
  alias BaserowEx.User.TokenAuth
  alias BaserowEx.User.TokenRefresh

  @spec call(String.t(), String.t()) :: Client.t()
  def call(email, password) do
    with {:ok, tokens} <- TokenAuth.call(email, password, []),
         {:ok, client} <-
           Client.changeset(%{
             access_token: tokens.access_token,
             refresh_token: tokens.refresh_token,
             email: email,
             password: password
           }) do
      client
    end
  end

  @spec try_refresh_token(Client.t()) :: {:ok, Client.t()} | {:error, any()}
  def try_refresh_token(client) do
    with {:ok, refreshed_token} <- TokenRefresh.call(client.refresh_token, []),
         {:ok, refreshed_client} <-
           Client.changeset(%{
             access_token: refreshed_token.access_token,
             refresh_token: client.refresh_token,
             email: client.email,
             password: client.password
           }) do
      {:ok, refreshed_client}
    else
      _ ->
        {:error, ""}
    end
  end
end
