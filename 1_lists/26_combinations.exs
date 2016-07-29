ExUnit.start
defmodule Problem26Test do
  use ExUnit.Case, async: true

  test "basic combinations" do
    assert [[1, 2], [1, 3], [2, 3]] ==
      Problem26.combinations([1, 2, 3], 2)
  end

  test "char combinations" do
    assert ['AB', 'AC', 'BC'] ==
      ?A..?C |> Enum.to_list |> Problem26.combinations(2)
  end

  test "longer combinations" do
    list = 1..1_000 |> Enum.to_list
    assert 499_500 == list |> Problem26.combinations(2) |> Enum.count
  end

  test "combinations on an empty list yields an empty list of lists" do
    assert [[]] == Problem26.combinations([], 5)
  end

  test "selecting none from a set yields a set comtaining an empty list" do
    assert [[]] = Problem26.combinations([1, 2, 3], 0)
  end
end


defmodule Problem26 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Generate the combinations of K distinct objects chosen from the N
  elements of a list

  In how many ways can a committee of 3 be chosen from a group of 12 people? We
  all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the
  well-known binomial coefficients). For pure mathematicians, this result may be
  great. But we want to really generate all the possibilities in a list.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec combinations([arg], integer) :: [[arg]] when arg: any
  def combinations([], _), do: [[]]
  def combinations(_, 0),  do: [[]]
  def combinations(list, k) do
    remaining_combinations = fn(i) -> remaining_combinations(list, k, i) end
    invalid_length         = fn(combo) -> Enum.count(combo) != k end

    combos = for {head, index} <- Enum.with_index(list),
                 tail          <- remaining_combinations.(index) do
      [head | tail]
    end

    Enum.reject(combos, invalid_length)
  end

  @docp """
  Given a list, a size, and an index, returns all combinations of the list after
  the index.
  """

  defp remaining_combinations(list, size, index) do
    list
    |> Enum.drop(index + 1)
    |> combinations(size - 1)
  end
end
