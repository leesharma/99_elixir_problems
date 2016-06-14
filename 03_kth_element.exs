ExUnit.start
defmodule Problem3Test do
  use ExUnit.Case, async: true

  test "returns the kth element of a list" do
    assert 4 == Problem3.element_at([1, 2, 3, 4, 5], 4)
  end

  test "raises exception for an empty list" do
    assert_raise FunctionClauseError, fn ->
      Problem3.element_at [], 2
    end
  end

  test "very long list" do
    list = Enum.to_list(1..1_000_000)
    assert 999_999 == Problem3.element_at(list, 999_999)
  end

  test "raises exception for k < 1" do
    assert_raise FunctionClauseError, fn ->
      Problem3.element_at([1, 3, 5, 7, 9], 0)
    end
  end

  test "raises exception for k > list length" do
    assert_raise FunctionClauseError, fn ->
      Problem3.element_at([1, 3, 5, 7, 9], 100_000)
    end
  end
end


defmodule Problem3 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Find the K'th element of a list. The first element in the list is number 1.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec element_at([elem], number) :: elem when elem: var
  def element_at([item, _], 1),  do: item
  def element_at([_ | tail], n), do: element_at(tail, n-1)
end
