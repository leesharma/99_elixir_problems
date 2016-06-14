ExUnit.start
defmodule Problem2Test do
  use ExUnit.Case, async: true

  test "returns the penultimate item of a list" do
    assert 4 == Problem2.penultimate([1, 2, 3, 4, 5])
  end

  test "returns the penultimate item of a char list" do
    assert ?l == Problem2.penultimate('hello')
  end

  test "very long list" do
    list = Enum.to_list(1..1_000_000)
    assert 999_999 == Problem2.penultimate(list)
  end

  test "raises exception for an empty list" do
    assert_raise FunctionClauseError, fn ->
      Problem2.penultimate []
    end
  end

  test "raises exception for a list with one entry" do
    assert_raise FunctionClauseError, fn ->
      Problem2.penultimate [1]
    end
  end
end


defmodule Problem2 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Find the last but one element of a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec penultimate([elem]) :: elem when elem: var
  def penultimate([item, _]),  do: item
  def penultimate([_ | tail]), do: penultimate(tail)
end
