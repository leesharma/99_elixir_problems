ExUnit.start
defmodule Problem15Test do
  use ExUnit.Case, async: true

  test "replicate basic list" do
    assert [1, 1, 1, 2, 2, 2, 2, 2, 2] == Problem15.replicate([1, 2, 2], 3)
  end

  test "replicate char list" do
    assert 'aaabbbccccccddd' == Problem15.replicate 'abccd', 3
  end

  test "very long list" do
    # Use List.replicate/2 for testing long lists
    list = [1 | List.duplicate(0, 500_000)]
    assert [1, 1 | List.duplicate(0, 1_000_000)] ==
      Problem15.replicate(list, 2)
  end

  test "many replications" do
    assert List.duplicate(0, 1_000_000) ==
      Problem15.replicate([0], 1_000_000)
  end

  test "an empty list returns itself" do
    assert [] == Problem15.replicate([], 5)
  end

  test "replicating 0 times returns an empty list" do
    assert [] == Problem15.replicate([1, 2, 3], 0)
  end
end


defmodule Problem15 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Replicate the elements of a list a given number of times.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec replicate([elem], number) :: [elem] when elem: var
  def replicate(list, times) when times >= 0 do
    do_replicate([], list, times, times)
  end

  defp do_replicate(result, [], _, _), do: Enum.reverse(result)
  defp do_replicate(acc, [_ | tail], times, 0) do
    acc
    |> do_replicate(tail, times, times)
  end
  defp do_replicate(acc, [head | _] = list, times, current_count) do
    [head | acc]
    |> do_replicate(list, times, current_count - 1)
  end
end
