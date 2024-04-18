defmodule BaserowEx do
  @moduledoc """
  This module defines the external API for the BaserowEx.
  Each function actually delegates to a public function in their respective context
  """

  @doc deletegate_to: {BaserowEx.BaserowClient, :call, 2}
  defdelegate client(username, password), to: BaserowEx.BaserowClient, as: :call

  defdelegate token_auth(email, password, opts \\ []), to: BaserowEx.User.TokenAuth, as: :call

  defdelegate token_refresh(refresh_token, opts \\ []), to: BaserowEx.User.TokenRefresh, as: :call

  defdelegate token_verify(refresh_token, opts \\ []), to: BaserowEx.User.TokenVerify, as: :call

  @doc deletegate_to: {BaserowEx.Workspaces.ListWorkspaces, :call, 2}
  defdelegate list_workspaces(baserow_client, opts \\ []),
    to: BaserowEx.Workspaces.ListWorkspaces,
    as: :call
end
