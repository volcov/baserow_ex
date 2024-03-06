defmodule BaserowExTest do
  use ExUnit.Case
  doctest BaserowEx

  test "greets the world" do
    assert BaserowEx.hello() == :world
  end
end
