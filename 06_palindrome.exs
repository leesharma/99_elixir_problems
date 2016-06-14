ExUnit.start
defmodule Problem6Test do
  use ExUnit.Case, async: true

  test "checks if a list is a palindrome" do
    assert true == Problem6.palindrome?([1, 2, 3, 2, 1])
  end

  test "checks if a char list is a palindrome" do
    assert true == Problem6.palindrome?('madamimadam')
  end

  test "a non-palindrome is not a palindrome" do
    refute true == Problem6.palindrome?([1, 2, 3, 4, 5])
  end

  test "very long list" do
    list = List.duplicate(0, 1_000_000)
    assert true == Problem6.palindrome?(list)
  end

  test "an empty list is a palindrome" do
    assert true == Problem6.palindrome?([])
  end

  test "a list with one element is a palindrome" do
    assert true == Problem6.palindrome?([0])
  end
end


defmodule Problem6 do
  @moduledoc false
  @vsn 0.1

  @doc """
  (*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).

  This is part of Ninety-Nine Haskell Problems, based on Ninety-Nine Prolog
  Problems and Ninety-Nine Lisp Problems.
  """

  @spec palindrome?(list) :: bool
  def palindrome?(list) do
    list == Enum.reverse(list)
  end
end
