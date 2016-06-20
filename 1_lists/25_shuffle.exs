ExUnit.start
defmodule Problem25Test do
  use ExUnit.Case, async: true

  test "basic sample" do
    assert [1, 4, 3, 5, 2] == Problem25.shuffle(1..5 |> Enum.to_list, {1, 1, 1})
  end

  test "char sample" do
    assert 'ACDB' == Problem25.shuffle(?A..?D |> Enum.to_list, {1, 1, 1})
  end

  test "longer sample" do
    list = List.duplicate(0, 1_000)
    assert list == Problem25.shuffle(list, {1, 1, 1})
  end

  test "shuffling an empty list yields an empty list" do
    assert [] == Problem25.shuffle([])
  end

  test "different seeds yield different results" do
    assert Problem25.shuffle([1, 2, 3, 4, 5], {1, 1, 1}) !=
      Problem25.shuffle([1, 2, 3, 4, 5], {12345, 67890, 08642})
  end
end


defmodule Problem25 do
  @moduledoc false
  @vsn 0.1

  @doc """
  Generate a random permutation of the elements of a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec shuffle([any], {integer, integer, integer}) :: [any]
  def shuffle(list, rand_seed \\ :os.timestamp) do
    sample(list, Enum.count(list), rand_seed)
  end

  # Copied from Problem 23
  @spec sample([any], integer, {integer, integer, integer}) :: [any]
  def sample(list, n, rand_seed \\ :os.timestamp) when n >= 0 do
    :random.seed(rand_seed)
    do_sample([], list, n)
  end

  defp do_sample(result, [], 0),     do: result
  defp do_sample(result, [item], _), do: [item | result]
  defp do_sample(acc, list, n) do
    split_index = Enum.count(list) - 1 |> :random.uniform
    {head, [item | tail]} = list |> Enum.split(split_index)

    [item | acc]
    |> do_sample(head ++ tail, n - 1)
  end
end
