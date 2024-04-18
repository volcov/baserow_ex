defmodule BaserowEx.Workspaces.ListWorkspaces.ResponseParams do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %{
          id: integer(),
          name: String.t()
        }

  @primary_key false
  @fields [:id, :name]
  @required_fields [:id, :name]

  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> apply_action(:validate_params)
  end
end
