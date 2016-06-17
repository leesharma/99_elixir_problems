ExUnit.start
defmodule Problem18Test do
  use ExUnit.Case, async: true

  test "slice basic list" do
    assert [2, 3, 4] == Problem18.slice([1, 2, 3, 4, 5, 6], 2, 4)
  end

  test "slice char list" do
    assert 'cdefg' == Problem18.slice('abcdefghijk', 3, 7)
  end

  test "very long list" do
    list = List.duplicate(0, 1_000_000)
    new_list = List.duplicate(0, 1_000)
    assert new_list == Problem18.slice(list, 999_000, 999_999)
  end

  test "an empty list returns itself" do
    assert [] == Problem18.slice([], 5, 6)
  end

  test "starting a slice past a list returns an empty list" do
    assert [] == Problem18.slice([1, 2], 5, 6)
  end

  test "slicing past a list returns the remainder of the list" do
    assert [4, 5] == Problem18.slice([1, 2, 3, 4, 5], 4, 100)
  end

  test "end index must be at least the start index" do
    assert_raise FunctionClauseError, fn ->
      Problem18.slice([1, 2, 3], 2, 0)
    end
  end
end


defmodule Problem18 do
  @moduledoc false
  @vsn 0.2

  @doc """
  (**) Extract a slice from a list.

  Given two indices, i and k, the slice is the list containing the elements
  between the i'th and k'th element of the original list (both limits included).
  Start counting the elements with 1.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec slice([elem], number, number) :: [elem] when elem: var
  def slice(list, start, final) when final >= start do
    final_length = final - start + 1

    list
    |> skip(start)
    |> take(final_length)
  end

  def skip([], _), do: []
  def skip(list, 1), do: list
  def skip([_ | tail], n) when n >= 1, do: skip(tail, n-1)

  def take(list, n) when n > 0 do
    do_take([], list, n)
  end

  defp do_take(result, [], _), do: Enum.reverse result
  defp do_take(result, _, 0),  do: Enum.reverse result
  defp do_take(acc, [head | tail], n) do
    [head | acc]
    |> do_take(tail, n-1)
  end
end
