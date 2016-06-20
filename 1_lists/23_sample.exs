ExUnit.start
defmodule Problem23Test do
  use ExUnit.Case, async: true

  test "basic sample" do
    assert [9, 25, 2] == Problem23.sample(1..30 |> Enum.to_list, 3, {1, 1, 1})
  end

  test "char sample" do
    assert 'HUB' == Problem23.sample(?A..?Z |> Enum.to_list, 3, {1, 1, 1})
  end

  test "long sample" do
    list = 1..1_000_000 |> Enum.to_list
    assert [222984, 790509, 33863] == Problem23.sample(list, 3, {1, 1, 1})
  end

  test "sampling more elements than the list length" do
    assert [1, 3, 2] == Problem23.sample([1, 2, 3], 1_000, {1, 1, 1})
  end

  test "sampling zero elements returns an empty list" do
    assert [] == Problem23.sample([1, 2, 3], 0)
  end

  test "different seeds yield different results" do
    assert Problem23.sample([1, 2, 3, 4, 5], 3, {1, 1, 1}) !=
      Problem23.sample([1, 2, 3, 4, 5], 3, {12345, 67890, 08642})
  end

  test "sampling negative elements raises an error" do
    assert_raise FunctionClauseError, fn ->
      Problem23.sample([1, 2, 3], -1)
    end
  end
end


defmodule Problem23 do
  @moduledoc false
  @vsn 0.1

  @doc """
  Extract a given number of randomly selected elements from a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec sample([any], integer, {integer, integer, integer}) :: [any]
  def sample(list, n, rand_seed \\ :os.timestamp) when n >= 0 do
    :random.seed(rand_seed)
    do_sample([], list, n)
  end

  defp do_sample(result, _, 0),      do: result
  defp do_sample(result, [], _),     do: result
  defp do_sample(result, [item], _), do: [item | result]
  defp do_sample(acc, list, n) do
    split_index = Enum.count(list) - 1 |> :random.uniform
    {head, [item | tail]} = list |> Enum.split(split_index)

    [item | acc]
    |> do_sample(head ++ tail, n - 1)
  end
end
