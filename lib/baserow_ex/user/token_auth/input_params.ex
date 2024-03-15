defmodule BaserowEx.User.TokenAuth.InputParams do
  @moduledoc false

  @mail_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

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
    |> validate_format(:email, @mail_regex, message: "invalid_email")
    |> apply_action(:validate_params)
  end
end
