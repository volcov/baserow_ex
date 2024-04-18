defmodule BaserowEx.User.TokenRefreshTest do
  use ExUnit.Case, assync: true

  import Mox

  alias BaserowEx.User.TokenRefresh

  setup :verify_on_exit!

  describe "TokenRefresh" do
    test "success: receives an access_token" do
      expect(HTTPClientMock, :build_client, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           status: 200,
           body: %{
             "access_token" => "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN"
           }
         }}
      end)

      assert {:ok,
              %TokenRefresh.ResponseParams{
                access_token: "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN"
              }} ==
               TokenRefresh.call(
                 "BlIjoicmVmcmVzaCIsImV4cCI6MTcxMTc2OTA1NSwiaWF0IjoxNzExMTY0MjU1LCJqdGkiOiJmZTd",
                 []
               )
    end

    test "failure: receives an error when gives wrong params" do
      assert {:error, :wrong_input_data} == TokenRefresh.call(123, [])
    end

    test "failure: receives an error when token is expired" do
      expect(HTTPClientMock, :build_client, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           status: 401
         }}
      end)

      assert {:error, :token_invalid_or_expired} ==
               TokenRefresh.call(
                 "BlIjoicmVmcmVzaCIsImV4cCI6MTcxMTc2OTA1NSwiaWF0IjoxNzExMTY0MjU1LCJqdGkiOiJmZTd",
                 []
               )
    end
  end
end
