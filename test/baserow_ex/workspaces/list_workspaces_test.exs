defmodule BaserowEx.Workspaces.ListWorkspacesTest do
  use ExUnit.Case, assync: true

  import Mox

  alias BaserowEx.BaserowClient
  alias BaserowEx.Workspaces.ListWorkspaces
  alias BaserowEx.Workspaces.ListWorkspaces.ResponseParams

  setup :verify_on_exit!

  describe "ListWorkspaces" do
    test "success: receives an workspace list" do
      expect(HTTPClientMock, :build_client, 2, fn _opts ->
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

      expect(HTTPClientMock, :get, fn _client, _uri, _opts ->
        {:ok,
         %{
           status: 200,
           body: [
             %{
               "id" => 0,
               "name" => "workspace_one"
             },
             %{
               "id" => 1,
               "name" => "workspace_two"
             }
           ]
         }}
      end)

      client = BaserowClient.call("email@foo.com", "my_secret_password")
      {:ok, _client, response} = ListWorkspaces.call(client, [])

      assert response == [
               %ResponseParams{id: 0, name: "workspace_one"},
               %ResponseParams{id: 1, name: "workspace_two"}
             ]
    end

    test "success: receives an workspace list, after refreshing token" do
      expect(HTTPClientMock, :build_client, 4, fn _opts ->
        :ok
      end)

      expect(HTTPClientMock, :post, 2, fn _client, _uri, _body, _opts ->
        {:ok,
         %{
           status: 200,
           body: %{
             "access_token" => "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkN",
             "refresh_token" => "zEwMjU2MTYxLCJpYXQiOjE3MTAyNTU1NjEsImp0aSI6IjBkB"
           }
         }}
      end)

      expect(HTTPClientMock, :get, fn _client, _uri, _opts ->
        {:ok,
         %{
           status: 401
         }}
      end)

      expect(HTTPClientMock, :get, fn _client, _uri, _opts ->
        {:ok,
         %{
           status: 200,
           body: [
             %{
               "id" => 0,
               "name" => "workspace_one"
             },
             %{
               "id" => 1,
               "name" => "workspace_two"
             }
           ]
         }}
      end)

      client = BaserowClient.call("email@foo.com", "my_secret_password")
      {:ok, _client, response} = ListWorkspaces.call(client, [])

      assert response == [
               %ResponseParams{id: 0, name: "workspace_one"},
               %ResponseParams{id: 1, name: "workspace_two"}
             ]
    end
  end
end
