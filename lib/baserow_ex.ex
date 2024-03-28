defmodule BaserowEx do
  @moduledoc """
  Documentation for `BaserowEx`.
  """

  defdelegate token_auth(email, password, opts \\ []), to: BaserowEx.User.TokenAuth, as: :call

  defdelegate token_refresh(refresh_token, opts \\ []), to: BaserowEx.User.TokenRefresh, as: :call

  defdelegate token_verify(refresh_token, opts \\ []), to: BaserowEx.User.TokenVerify, as: :call

  defdelegate list_workspaces(opts \\ []), to: BaserowEx.Workspaces.ListWorkspaces, as: :call
end
