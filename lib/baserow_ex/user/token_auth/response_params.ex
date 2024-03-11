defmodule BaserowEx.User.TokenAuth.ResponseParams do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %{
          access_token: String.t(),
          refresh_token: String.t()
        }

  @primary_key false
  @fields [:access_token, :refresh_token]
  @required_fields [:access_token, :refresh_token]

  embedded_schema do
    field(:access_token, :string)
    field(:refresh_token, :string)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> apply_action(:validate_params)
  end
end
