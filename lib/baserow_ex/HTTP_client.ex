defmodule BaserowEx.HTTPClient do
  @moduledoc false

  @type client :: any()
  @type uri :: String.t() | URI.t()
  @type opts :: Keyword.t()

  @callback build_client(any()) :: client()
  @callback get(client(), uri(), opts()) :: {:ok, any()} | {:error, any()}
  @callback post(client(), uri(), any(), opts()) :: {:ok, any()} | {:error, any()}
end
