defmodule BaserowEx.User.TokenVerifyTest do
  use ExUnit.Case, assync: true

  import Mox

  alias BaserowEx.User.TokenVerify

  setup :verify_on_exit!

  describe "TokenVerify" do
    test "success: return true if refresh_token is valid" do
      expect(HTTPClientMock, :build_client, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           body: %{
             "user" => %{}
           }
         }}
      end)

      assert TokenVerify.call(
               "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN",
               []
             )
    end

    test "failure: return false if refresh_token is invalid" do
      expect(HTTPClientMock, :build_client, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           body: %{
             "error" => %{}
           }
         }}
      end)

      refute TokenVerify.call(
               "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN",
               []
             )
    end
  end
end
