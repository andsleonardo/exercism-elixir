defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    List.foldr(list, [], &keep_update(&2, &1, fun.(&1)))
  end

  def keep_update(acc, e, true), do: List.insert_at(acc, 0, e)
  def keep_update(acc, _, false), do: acc

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    List.foldr(list, [], &discard_update(&2, &1, fun.(&1)))
  end

  def discard_update(acc, _, true), do: acc
  def discard_update(acc, e, false), do: List.insert_at(acc, 0, e)
end
