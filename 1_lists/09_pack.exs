ExUnit.start
defmodule Problem9Test do
  use ExUnit.Case, async: true

  test "pack basic list" do
    assert [[1, 1, 1], [2], [3, 3, 3], [4, 4], [5]] ==
      Problem9.pack([1, 1, 1, 2, 3, 3, 3, 4, 4, 5])
  end

  test "pack char list" do
    assert ['aaa', 'bb', 'c', 'a', 'bbb', 'ccc'] ==
      Problem9.pack 'aaabbcabbbccc'
  end

  test "very long list" do
    list = [1 | List.duplicate(0, 1_000_000)]
    assert [[1], List.duplicate(0, 1_000_000)] == Problem9.pack(list)
  end

  test "an empty list returns itself" do
    assert [] == Problem9.pack([])
  end
end


defmodule Problem9 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Pack consecutive duplicates of list elements into sublists. If a list
  contains repeated elements they should be placed in separate sublists.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec pack([elem]) :: [elem] when elem: var
  def pack(list) do
    do_pack([], list, nil)
  end

  defp do_pack(result, [], _), do: Enum.reverse result
  defp do_pack([chunk | acc], [current | remaining], current) do
    chunk = [current | chunk]
    [chunk | acc]
    |> do_pack(remaining, current)
  end
  defp do_pack(acc, [next | remaining], _current) do
    [[next] | acc]
    |> do_pack(remaining, next)
  end
end
