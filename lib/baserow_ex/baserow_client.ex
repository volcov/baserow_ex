defmodule BaserowEx.BaserowClient do
  @moduledoc """
  The Baserow API uses an authentication strategy based on an email and password to obtain your access_token,
  which means that when the access_token expires, it will be necessary to call the refresh_token endpoint,
  and when it becomes invalid, it will be necessary to call the initial endpoint passing username and password once again.

  This module is responsible for making these calls, and building a client that will be returned by each BaserowEx function,
  containing all the necessary data so that the user does not need to manage the session.
  """

  alias BaserowEx.BaserowClient.Client
  alias BaserowEx.User.TokenAuth
  alias BaserowEx.User.TokenRefresh

  @doc """
  calls the authentication endpoint and returns the client with the session data
  """
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

  @doc """
  calls the refresh_token endpoint and returns the client with the new session data
  """
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
