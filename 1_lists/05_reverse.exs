ExUnit.start
defmodule Problem5Test do
  use ExUnit.Case, async: true

  test "returns the reverse of a list" do
    assert [5, 4, 3, 2, 1] == Problem5.reverse([1, 2, 3, 4, 5])
  end

  test "returns the reverse of a char list" do
    assert 'olleh' == Problem5.reverse('hello')
  end

  test "very long list" do
    list = Enum.to_list(1..1_000_000)
    [first | _] = list |> Problem5.reverse
    assert 1_000_000 == first
  end

  test "reverse of an empty list is an empty list" do
    assert [] == Problem5.reverse([])
  end
end


defmodule Problem5 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Reverse a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec reverse([elem]) :: [elem] when elem: var
  def reverse(list), do: do_reverse([], list)
  defp do_reverse(result, []),   do: result
  defp do_reverse(acc, [head | tail]) do
    [head | acc]
    |> do_reverse(tail)
  end
end
