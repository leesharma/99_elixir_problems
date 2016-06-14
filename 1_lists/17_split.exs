ExUnit.start
defmodule Problem17Test do
  use ExUnit.Case, async: true

  test "split basic list" do
    assert {[1, 2], [3, 4, 5, 6]} == Problem17.split([1, 2, 3, 4, 5, 6], 2)
  end

  test "split char list" do
    assert {'abc', 'defg'} == Problem17.split('abcdefg', 3)
  end

  test "very long list" do
    list = List.duplicate(0, 1_000_000)
    new_list = List.duplicate(0, 500_000)
    assert {new_list, new_list} ==
      Problem17.split(list, 500_000)
  end

  test "an empty list returns itself" do
    assert {[], []} == Problem17.split([], 5)
  end

  test "splitting at index 0 returns [] and the full list" do
    assert {[], [1, 2, 3]} == Problem17.split([1, 2, 3], 0)
  end

  test "split index must be at least 0" do
    assert_raise FunctionClauseError, fn ->
      Problem17.split('abcde', -1)
    end
  end
end


defmodule Problem17 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Split a list into two parts; the length of the first part is given.

  Do not use any predefined predicates.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec split([elem], number) :: {[elem], [elem]} when elem: var
  def split(list, n) when n >= 0 do
    do_split([], list, n, n)
  end

  defp do_split(acc, remaining, n, 0), do: {Enum.reverse(acc), remaining}
  defp do_split(acc, [], _, _),        do: {Enum.reverse(acc), []}
  defp do_split(acc, [head | tail], n, count) do
    [head | acc] |> do_split(tail, n, count - 1)
  end
end
