ExUnit.start
defmodule Problem19Test do
  use ExUnit.Case, async: true

  test "rotate basic list" do
    assert [3, 4, 5, 6, 1, 2] == Problem19.rotate([1, 2, 3, 4, 5, 6], 2)
  end

  test "rotate char list" do
    assert 'defghijkabc' == Problem19.rotate('abcdefghijk', 3)
  end

  test "rotate list backwards" do
    assert 'efgabcd' == Problem19.rotate('abcdefg', -3)
  end

  test "very long list" do
    list = List.duplicate(0, 1_000_000)
    assert list == Problem19.rotate(list, 900_000)
  end

  test "many rotations" do
    assert [1, 2] == Problem19.rotate([1, 2], 1_000_000)
  end

  test "an empty list returns itself" do
    assert [] == Problem19.rotate([], 5)
  end

  test "rotating zero places returns the list" do
    assert [1, 2, 3] = Problem19.rotate([1, 2, 3], 0)
  end
end


defmodule Problem19 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Rotate a list N places to the left.

  Hint: Use the predefined functions length and (++).

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec rotate([elem], number) :: [elem] when elem: var
  def rotate([], _),   do: []
  def rotate(list, 0), do: list
  def rotate(list, n) do
    list
    |> split_index(n)
    |> do_rotate(list)
  end

  @spec do_rotate(number, [elem]) :: [elem] when elem: var
  defp do_rotate(split_index, list) do
    {tail, head} = Enum.split(list, split_index)
    head ++ tail
  end

  @spec split_index(list, number) :: number
  defp split_index(list, n) when n >= 0, do: rem(n, Enum.count(list))
  defp split_index(list, n) do
    count = Enum.count(list)
    count - rem(-n, count)
  end
end
