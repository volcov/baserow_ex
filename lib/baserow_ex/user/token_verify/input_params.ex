defmodule BaserowEx.User.TokenVerify.InputParams do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %{
          refresh_token: String.t()
        }

  @primary_key false
  @fields [:refresh_token]
  @required_fields [:refresh_token]

  embedded_schema do
    field(:refresh_token, :string)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> apply_action(:validate_params)
  end
end
