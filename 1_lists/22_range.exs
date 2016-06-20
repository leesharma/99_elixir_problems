ExUnit.start
defmodule Problem22Test do
  use ExUnit.Case, async: true

  test "basic range" do
    assert [1, 2, 3, 4, 5] == Problem22.range(1, 5)
  end

  test "char range" do
    assert 'ABCDEFGHIJKLMNOP' == Problem22.range(?A, ?P)
  end

  test "long range" do
    list = 1..1_000_000 |> Enum.to_list
    assert list == Problem22.range(1, 1_000_000)
  end

  test "backwards range" do
    assert [5, 4, 3, 2, 1] == Problem22.range(5, 1)
  end

  test "range with the same start and end value returns a single-entry array" do
    assert [1] == Problem22.range(1, 1)
  end

  test "range can be negative" do
    assert [-2, -1, 0, 1, 2] == Problem22.range(-2, 2)
  end
end


defmodule Problem22 do
  @moduledoc false
  @vsn 0.1

  @doc """
  Create a list containing all integers within a given range, inclusive.

  Note: I'm solving this problem without the use of Range.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec range(elem, elem) :: [elem] when elem: integer | char
  def range(start, final) when start > final do
    range(final, start) |> Enum.reverse
  end
  def range(start, final) do
    do_range([start], final)
  end

  defp do_range([final | _] = list, final), do: Enum.reverse list
  defp do_range([head | _] = list, final) when head < final do
    [head + 1 | list]
    |> do_range(final)
  end
end
