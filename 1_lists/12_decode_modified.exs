ExUnit.start
defmodule Problem12Test do
  use ExUnit.Case, async: true

  test "decode_modified basic list" do
    assert [1, 1, 1, 2, 3, 3, 3, 4, 4, 5] ==
      Problem12.decode_modified [{3, 1}, 2, {3, 3}, {2, 4}, 5]
  end

  test "decode_modified char list" do
    assert 'aaabbcabbbccc' ==
      Problem12.decode_modified [{3, ?a}, {2, ?b}, ?c, ?a, {3, ?b}, {3, ?c}]
  end

  test "very long list" do
    list = [1 | List.duplicate(0, 1_000_000)]
    assert list == Problem12.decode_modified [1, {1_000_000, 0}]
  end

  test "an empty list returns itself" do
    assert [] == Problem12.decode_modified([])
  end
end


defmodule Problem12 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (**) Decode a run-length encoded list.

  Given a run-length code list generated as specified in problem 11. Construct
  its uncompressed version.

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec decode_modified([{number, elem} | elem]) :: [elem] when elem: var
  def decode_modified(list) do
    do_decode_modified([], list)
  end

  defp do_decode_modified(result, []), do: Enum.reverse(result)
  defp do_decode_modified(acc, [{count, value} | tail]) do
    List.duplicate(value, count) ++ acc
    |> do_decode_modified(tail)
  end
  defp do_decode_modified(acc, [value | tail]) do
    [value | acc]
    |> do_decode_modified(tail)
  end
end
