defmodule BaserowEx.User.TokenAuthTest do
  use ExUnit.Case, assync: true

  import Mox

  setup :verify_on_exit!

  describe "TokenAuth" do
    test "success: receives an access_token and an refresh_token" do
      expect(HTTPClientMock, :build_client, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           status: 200,
           body: %{
             "access_token" => "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN",
             "refresh_token" => "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkB"
           }
         }}
      end)

      assert {:ok,
              %BaserowEx.User.TokenAuth.ResponseParams{
                access_token: "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN",
                refresh_token: "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkB"
              }} == BaserowEx.User.TokenAuth.call("email@email.com", "password", [])
    end

    test "failure: receives an error when gives wrong params" do
      assert {:error, :invalid_email} == BaserowEx.User.TokenAuth.call("teste", "password", [])
    end

    test "failure: receives an error when creds is invalid" do
      expect(HTTPClientMock, :build_client, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           status: 401
         }}
      end)

      assert {:error, :invalid_email_or_password} ==
               BaserowEx.User.TokenAuth.call("email@email.com", "password", [])
    end
  end
end
