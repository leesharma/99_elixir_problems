ExUnit.start
defmodule Problem24Test do
  use ExUnit.Case, async: true

  test "basic sample" do
    assert [9, 25, 2] == Problem24.sample_range(3, 30, {1, 1, 1})
  end

  test "long range" do
    assert [222984, 790509, 33863] == Problem24.sample_range(3, 1_000_000, {1, 1, 1})
  end

  test "sampling more elements than the range length" do
    assert [1, 3, 2] == Problem24.sample_range(1_000, 3, {1, 1, 1})
  end

  test "sampling zero elements returns an empty list" do
    assert [] == Problem24.sample_range(0, 100)
  end

  test "different seeds yield different results" do
    assert Problem24.sample_range(5, 1_000, {1, 1, 1}) !=
      Problem24.sample_range(5, 1_000, {12345, 67890, 08642})
  end

  test "sampling negative elements raises an error" do
    assert_raise FunctionClauseError, fn ->
      Problem24.sample_range(-1, 10)
    end
  end

  test "range must end in a number greater than 1" do
    assert_raise FunctionClauseError, fn ->
      Problem24.sample_range(3, -5)
    end
  end
end


defmodule Problem24 do
  @moduledoc false
  @vsn 0.1

  @doc """
  Lotto: Draw N different random numbers from the set 1..M.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec sample_range(integer, integer, {integer, integer, integer}) :: [integer]
  def sample_range(n, final, rand_seed \\ :os.timestamp) when n >= 0 and final >= 1 do
    :random.seed(rand_seed)
    list = 1..final |> Enum.to_list

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
