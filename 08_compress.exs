ExUnit.start
defmodule Problem8Test do
  use ExUnit.Case, async: true

  test "compress basic list" do
    assert [1, 2, 3, 4, 5] == Problem8.compress([1, 1, 1, 2, 3, 3, 3, 4, 4, 5])
  end

  test "compress char list" do
    assert 'abcabc' == Problem8.compress 'aaaaaaaabbccccccccccabbbbbbbbbbbbccc'
  end

  test "an already compressed list returns itself" do
    list = 'abcabcabc'
    assert list == Problem8.compress(list)
  end

  test "very long list" do
    list = [1 | List.duplicate(0, 1_000_000)]
    assert [1, 0] == Problem8.compress(list)
  end

  test "an empty list returns itself" do
    assert [] == Problem8.compress([])
  end
end


defmodule Problem8 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Eliminate consecutive duplicates of list elements.

  If a list contains repeated elements they should be replaced with a single
  copy of the element. The order of the elements should not be changed.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec compress([elem]) :: [elem] when elem: var
  def compress(list) do
    do_compress([], list, nil)
  end

  defp do_compress(result, [], _), do: Enum.reverse(result)
  defp do_compress(acc, [last | tail], last), do: do_compress(acc, tail, last)
  defp do_compress(acc, [head | tail], last) do
    [head | acc]
    |> do_compress(tail, head)
  end
end
