# BaserowEx

**An Elixir Library for interfacing Baserow Backend API**

The [Baserow](https://baserow.io/) is a open platform to create scalable databases and applications without coding.

## API types

Baserow has two types of API, a [web-frontend]((https://baserow.io/api-docs)) rest API to be used after you create your database schema, offering endpoints to create, read, update your database data. This library was **not** designed to work with this API.

BaserowEx was built to work with another API, the [Backend API](https://api.baserow.io/api/redoc/), which has actions that refer to the Baserow environment, such as user control, workspaces, integrations, snapshots, and others.

## what motivated ##

The first factor that motivated the creation of this library was to have an interface that already returned to whoever was using it, response structures, errors, objects that talk directly to an Elixir application.

When starting to design the library, a second reason was born that could be a very interesting advantage, the "session" control of the API.

The authentication strategy used by Baserow is the acquisition of an `access_token` through `username` and `password`. When the token loses its validity, it is necessary to try to refresh the `access_token`, and when the `refresh_token` also becomes invalid, it will be necessary to call the first authentication again, to obtain a new pair of `access_token` and `refresh_token`

BaserowEx offers a client that manages this session for you. You only need to build the client on the first call and after that, it will be used to control the session for all future actions of your application on the platform.

## instalation ##

To use BaserowEx, you can add it to your application's dependencies.

```elixir
def deps do
  [
    {:baserow_ex, "~> 0.1"}
  ]
end
```

## to use ##

After creating your account on Baserow, the first action you will need to take is to build a client using your credentials

```elixir
client = BaserowEx.client("email@foo.com", "my_secret_password")
```

After having your client built, it must be used to execute the actions.

All BaserowEx functions will return a triple tuple, where the second element will be a client with the updated session data, and then the new client must be used in the next call, as in the example below.

```elixir
client = BaserowEx.client("email@foo.com", "my_secret_password")
{:ok, updated_client, workspaces} = BaserowEx.list_workspaces(client)

# now the updated_client should be used instead of the client
{:ok, updated_again_client, list_of_elements} = BaserowEx.another_action(updated_client)
```

## the future ##

The library is just beginning.

Today, in addition to the function of listing the workspaces of an authorized user, there are authentication and token refresh functions (if they were used by the library, why not make them available, right?).

The idea is to add interfaces to all API endpoints.

## community ##

Baserow has a community of users that creates new templates, and feeds the tool's ecosystem. I hope that BaserowEx can serve as an incentive so that people who use Baserow in Elixir applications can also make the ecosystem formed by the "merge" of these two technologies richer and richer

thank you very much :purple_heart