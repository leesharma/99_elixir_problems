ExUnit.start
defmodule Problem4Test do
  use ExUnit.Case, async: true

  test "returns the length of a list" do
    assert 4 == Problem4.length([1, 2, 3, 4])
  end

  test "returns the length of a char list" do
    assert 5 == Problem4.length('hello')
  end

  test "very long list" do
    list = Enum.to_list(1..1_000_000)
    assert 1_000_000 == Problem4.length(list)
  end

  test "length of an empty list is 0" do
    assert 0 == Problem4.length([])
  end
end


defmodule Problem4 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Find the number of elements of a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec length(list) :: number
  def length(list), do: do_length(list, 0)
  defp do_length([], len),      do: len
  defp do_length([_ | t], len), do: do_length(t, len+1)
end
