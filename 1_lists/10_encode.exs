ExUnit.start
defmodule Problem10Test do
  use ExUnit.Case, async: true

  test "encode basic list" do
    assert [{3, 1}, {1, 2}, {3, 3}, {2, 4}, {1, 5}] ==
      Problem10.encode([1, 1, 1, 2, 3, 3, 3, 4, 4, 5])
  end

  test "encode char list" do
    assert [{3, ?a}, {2, ?b}, {1, ?c}, {1, ?a}, {3, ?b}, {3, ?c}] ==
      Problem10.encode 'aaabbcabbbccc'
  end

  test "very long list" do
    list = [1 | List.duplicate(0, 1_000_000)]
    assert [{1, 1}, {1_000_000, 0}] == Problem10.encode(list)
  end

  test "an empty list returns itself" do
    assert [] == Problem10.encode([])
  end
end


defmodule Problem10 do
  @moduledoc false
  @vsn 0.2

  @doc """
  (*) Run-length encoding of a list. Use the result of problem P09 to implement
  the so-called run-length encoding data compression method. Consecutive
  duplicates of elements are encoded as lists (N E) where N is the number of
  duplicates of the element E.

  Note: insead of the last problem's answer, I will use Enum.chunk_by/2 and
  Enum.count/1.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec encode([elem]) :: [{number, elem}] when elem: var
  def encode(list) do
    chunked_list = list |> Enum.chunk_by(&(&1))
    do_encode([], chunked_list)
  end

  defp do_encode(result, []), do: Enum.reverse(result)
  defp do_encode(acc, [[value | _] = head | tail]) do
    [{Enum.count(head), value} | acc]
    |> do_encode(tail)
  end
end
