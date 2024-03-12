defmodule BaserowEx.User.TokenAuthTest do
  use ExUnit.Case, assync: true

  describe "TokenAuth" do
    test "success: receives an access_token and an refresh_token" do
      assert "" == BaserowEx.User.TokenAuth.call("email@email", "password", [])
    end
  end
end
