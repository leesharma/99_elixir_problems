ExUnit.start
defmodule Problem1Test do
  use ExUnit.Case, async: true

  test "returns the last item of a list" do
    assert 5 == Problem1.last([1, 2, 3, 4, 5])
  end

  test "returns the last item of a char list" do
    assert ?o == Problem1.last('hello')
  end

  test "very long list" do
    list = Enum.to_list(1..1_000_000)
    assert 1_000_000 == Problem1.last(list)
  end

  test "raises exception for an empty list" do
    assert_raise FunctionClauseError, fn ->
      Problem1.last []
    end
  end
end


defmodule Problem1 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Finds the last element of a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec last([elem]) :: elem when elem: var
  def last([item]),     do: item
  def last([_ | tail]), do: last(tail)
end
