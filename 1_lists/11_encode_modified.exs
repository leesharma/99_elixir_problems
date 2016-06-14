ExUnit.start
defmodule Problem11Test do
  use ExUnit.Case, async: true

  test "encode_modified basic list" do
    assert [{3, 1}, 2, {3, 3}, {2, 4}, 5] ==
      Problem11.encode_modified([1, 1, 1, 2, 3, 3, 3, 4, 4, 5])
  end

  test "encode_modified char list" do
    assert [{3, ?a}, {2, ?b}, ?c, ?a, {3, ?b}, {3, ?c}] ==
      Problem11.encode_modified 'aaabbcabbbccc'
  end

  test "very long list" do
    list = [1 | List.duplicate(0, 1_000_000)]
    assert [1, {1_000_000, 0}] == Problem11.encode_modified(list)
  end

  test "an empty list returns itself" do
    assert [] == Problem11.encode_modified([])
  end
end


defmodule Problem11 do
  @moduledoc false
  @vsn 0.1

  @doc """
  Modify the result of problem 1.10 in such a way that if an element has no
  duplicates it is simply copied into the result list. Only elements with
  duplicates are transferred as {N,E} terms.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec encode_modified([elem]) :: [{number, elem} | elem] when elem: var
  def encode_modified(list) do
    chunked_list = list |> Enum.chunk_by(&(&1))
    do_encode_modified([], chunked_list)
  end

  defp do_encode_modified(result, []), do: Enum.reverse(result)
  defp do_encode_modified(acc, [head | tail]) do
    # Solved with a case statement instead of pattern matching in the function
    # arguments in order to avoid duplicating the second half of the function.
    elem = case head do
      [value]     -> value
      [value | _] -> {Enum.count(head), value}
    end

    [elem | acc]
    |> do_encode_modified(tail)
  end
end
