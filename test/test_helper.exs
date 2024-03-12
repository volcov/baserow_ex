Mox.defmock(HTTPClientMock, for: BaserowEx.HTTPClient)
Application.put_env(:baserow_ex, :http_client, HTTPClientMock)

ExUnit.start()
