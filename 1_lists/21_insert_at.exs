ExUnit.start
defmodule Problem21Test do
  use ExUnit.Case, async: true

  test "insert into a basic list" do
    assert [1, 2, 2, 3, 4, 5, 6] == Problem21.insert_at(2, [1, 2, 3, 4, 5, 6], 2)
  end

  test "insert into a char list" do
    assert 'abcxdefghijk' == Problem21.insert_at(?x, 'abcdefghijk', 3)
  end

  test "insert into a list backwards" do
    assert 'abcdefgh' == Problem21.insert_at(?h, 'abcdefg', -1)
  end

  test "very long list" do
    list = List.duplicate(0, 1_000_000)
    assert [0 | list] == Problem21.insert_at(0, list, 900_000)
  end

  test "an insertion index larger than the list appends to the end of the list" do
    assert [1, 2, 3] == Problem21.insert_at(3, [1, 2], 1_000_000)
  end

  test "an empty list returns the element in the list" do
    assert '?' == Problem21.insert_at(??, [], 5)
  end
end


defmodule Problem21 do
  @moduledoc false
  @vsn 0.1

  @doc """
  Insert an element at a given position into a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec insert_at(any, [any], number) :: [any]
  def insert_at(elem, [], _) do
    [elem]
  end

  def insert_at(elem, list, n) when n < 0 do
    split_i = Enum.count(list) + n + 1
    insert_at(elem, list, split_i)
  end

  def insert_at(elem, list, n) do
    {head, tail} = list |> Enum.split(n)
    head ++ [elem | tail]
  end
end
