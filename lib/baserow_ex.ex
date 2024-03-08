defmodule BaserowEx do
  @moduledoc """
  Documentation for `BaserowEx`.
  """

  defdelegate token_auth(email, password, opts \\ []), to: BaserowEx.User.TokenAuth, as: :call
  defdelegate list_workspaces(opts \\ []), to: BaserowEx.Workspaces.ListWorkspaces, as: :call
end
