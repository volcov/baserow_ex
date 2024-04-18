defmodule BaserowEx.BaserowClient.Client do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %{
          access_token: String.t(),
          refresh_token: String.t(),
          email: String.t(),
          password: String.t()
        }

  @primary_key false
  @fields [:access_token, :refresh_token, :email, :password]

  embedded_schema do
    field(:access_token, :string, redact: true)
    field(:refresh_token, :string, redact: true)
    field(:email, :string)
    field(:password, :string, redact: true)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> apply_action(:validate_params)
  end
end
