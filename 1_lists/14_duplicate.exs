ExUnit.start
defmodule Problem14Test do
  use ExUnit.Case, async: true

  test "duplicate basic list" do
    assert [1, 1, 2, 2, 3, 3, 3, 3, 4, 4] == Problem14.duplicate [1, 2, 3, 3, 4]
  end

  test "duplicate char list" do
    assert 'aabbccccdd' == Problem14.duplicate 'abccd'
  end

  test "very long list" do
    # Use List.duplicate/2 for testing long lists
    list = [1 | List.duplicate(0, 500_000)]
    assert [1, 1 | List.duplicate(0, 1_000_000)] == Problem14.duplicate(list)
  end

  test "an empty list returns itself" do
    assert [] == Problem14.duplicate([])
  end
end


defmodule Problem14 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Duplicate the elements of a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec duplicate([elem]) :: [elem] when elem: var
  def duplicate(list) do
    do_duplicate([], list)
  end

  defp do_duplicate(result, []), do: Enum.reverse(result)
  defp do_duplicate(acc, [head | tail]) do
    [head, head | acc]
    |> do_duplicate(tail)
  end
end
