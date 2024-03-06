defmodule BaserowEx do
  @moduledoc """
  Documentation for `BaserowEx`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BaserowEx.hello()
      :world

  """
  def hello do
    :world
  end

  defdelegate list_workspaces, to: BaserowEx.Workspaces.ListWorkspaces, as: :call
end
