defmodule BaserowEx.User.TokenAuth.InputParams do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %{
          email: String.t(),
          password: String.t()
        }

  @primary_key false
  @fields [:email, :password]
  @required_fields [:email, :password]

  embedded_schema do
    field(:email, :string)
    field(:password, :string)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> apply_action(:validate_params)
  end
end
