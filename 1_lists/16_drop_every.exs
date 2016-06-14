ExUnit.start
defmodule Problem16Test do
  use ExUnit.Case, async: true

  test "drop_every basic list" do
    assert [1, 3, 5] == Problem16.drop_every([1, 2, 3, 4, 5, 6], 2)
  end

  test "drop_every char list" do
    assert 'abdeghjkmnp' == Problem16.drop_every('abcdefghijklmnop', 3)
  end

  test "very long list" do
    list = List.duplicate(0, 1_000_000)
    assert List.duplicate(0, 800_000) ==
      Problem16.drop_every(list, 5)
  end

  test "an empty list returns itself" do
    assert [] == Problem16.drop_every([], 5)
  end

  test "dropping every 1 returns an empty list" do
    assert [] == Problem16.drop_every([1, 2, 3], 1)
  end

  test "drop frequency must be at least 1" do
    assert_raise FunctionClauseError, fn ->
      Problem16.drop_every('abcde', 0)
    end
    assert_raise FunctionClauseError, fn ->
      Problem16.drop_every('abcde', -1)
    end
  end
end


defmodule Problem16 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Drop every N'th element from a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec drop_every([elem], number) :: [elem] when elem: var
  def drop_every(list, drop_freq) when drop_freq >= 1 do
    do_drop_every([], list, drop_freq, drop_freq)
  end

  defp do_drop_every(result, [], _, _), do: Enum.reverse result
  defp do_drop_every(acc, [_ | tail], drop_freq, 1) do
    acc
    |> do_drop_every(tail, drop_freq, drop_freq)
  end
  defp do_drop_every(acc, [head | tail], drop_freq, count) do
    [head | acc]
    |> do_drop_every(tail, drop_freq, count - 1)
  end
end
