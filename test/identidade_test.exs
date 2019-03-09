defmodule IdentidadeTest do
  use ExUnit.Case
  doctest Identidade

  test "greets the world" do
    assert Identidade.hello() == :world
  end
end
