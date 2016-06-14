ExUnit.start
defmodule Problem13Test do
  use ExUnit.Case, async: true

  test "encode_direct basic list" do
    assert [{3, 1}, 2, {3, 3}, {2, 4}, 5] ==
      Problem13.encode_direct([1, 1, 1, 2, 3, 3, 3, 4, 4, 5])
  end

  test "encode_direct char list" do
    assert [{3, ?a}, {2, ?b}, ?c, ?a, {3, ?b}, {3, ?c}] ==
      Problem13.encode_direct 'aaabbcabbbccc'
  end

  test "very long list" do
    list = [1 | List.duplicate(0, 1_000_000)]
    assert [1, {1_000_000, 0}] == Problem13.encode_direct(list)
  end

  test "an empty list returns itself" do
    assert [] == Problem13.encode_direct([])
  end
end


defmodule Problem13 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Run-length encoding of a list (direct solution).

  Implement the so-called run-length encoding data compression method directly.
  I.e. don't explicitly create the sublists containing the duplicates, as in
  problem 9, but only count them. As in problem P11, simplify the result list
  by replacing the singleton lists (1 X) by X.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec encode_direct([elem]) :: [{number, elem} | elem] when elem: var
  def encode_direct(list) do
    do_encode_direct([], list)
  end

  defp do_encode_direct(result, []), do: Enum.reverse(result)
  defp do_encode_direct(acc, [value | tail]) do
    updated_acc = case acc do
      [{count, ^value} | acc_tail] -> [{count + 1, value} | acc_tail]
      [^value | acc_tail]          -> [{2, value} | acc_tail]
      acc                          -> [value | acc]
    end

    updated_acc |> do_encode_direct(tail)
  end
end
