ExUnit.start
defmodule Problem20Test do
  use ExUnit.Case, async: true

  test "remove_at basic list" do
    assert {[1, 2, 4, 5, 6], 3} == Problem20.remove_at([1, 2, 3, 4, 5, 6], 2)
  end

  test "remove_at char list" do
    assert {'abcefghijk', ?d} == Problem20.remove_at('abcdefghijk', 3)
  end

  test "remove_at list backwards" do
    assert {'abcdfg', ?e} == Problem20.remove_at('abcdefg', -3)
  end

  test "very long list" do
    [elem | new_list] = list = List.duplicate(0, 1_000_000)
    assert {new_list, elem} == Problem20.remove_at(list, 900_000)
  end

  test "a removal index larger than the list removes nil" do
    assert {[1, 2], nil} == Problem20.remove_at([1, 2], 1_000_000)
  end

  test "an empty list removes nil" do
    assert {[], nil} == Problem20.remove_at([], 5)
  end
end


defmodule Problem20 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Remove the K'th element from a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec remove_at([elem], number) :: {[elem], elem} when elem: var
  def remove_at(list, n) do
    list
    |> Enum.count
    |> do_remove_at(list, n)
  end

  defp do_remove_at(len, list, n) when n > len, do: {list, nil}
  defp do_remove_at(_, list, n) do
    {head, [removed | tail]} = list |> Enum.split(n)
    {head ++ tail, removed}
  end
end
