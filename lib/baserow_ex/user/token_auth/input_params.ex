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
  end

  @spec validate_params(map()) :: {:error, Ecto.Changeset.t()} | {:ok, any()}
  def validate_params(params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true, changes: changes} ->
        {:ok, changes}
    end
  end
end
