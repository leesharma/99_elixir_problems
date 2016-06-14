ExUnit.start
defmodule Problem7Test do
  use ExUnit.Case, async: true

  test "flattens a list of lists" do
    assert [1, 2, 3, 4, 5, 6] == Problem7.flatten([[1, 2], [3, 4], [5, 6]])
  end

  test "very long list" do
    assert [1, 2, 3, 4, 5, 6] == Problem7.flatten([1, [2, [3, 4], 5], 6])
  end

  test "very long list" do
    list = List.duplicate([1, [1, [1], 1], 1], 200_000)
    assert List.duplicate(1, 1_000_000) == Problem7.flatten(list)
  end

  test "a flat list returns itself" do
    assert [1, 2, 3, 4, 5] == Problem7.flatten([1, 2, 3, 4, 5])
  end

  test "an empty list returns itself" do
    assert [] == Problem7.flatten([])
  end
end


defmodule Problem7 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Flatten a nested list structure.

  Transform a list, possibly holding lists as elements into a `flat' list by
  replacing each list with its elements (recursively).

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec flatten(list) :: boolean
  def flatten(list), do: do_flatten([], list) |> Enum.reverse

  defp do_flatten(result, []), do: result
  defp do_flatten(acc, [head | tail]) when is_list(head) do
    acc
    |> do_flatten(head)
    |> do_flatten(tail)
  end
  defp do_flatten(acc, [head | tail]) do
     [head | acc]
     |> do_flatten(tail)
  end
end
