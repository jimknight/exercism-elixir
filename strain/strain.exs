defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep_process(list, fun, [])
  end

  defp keep_process([], _, result) do
    result
  end

  defp keep_process([head|tail], fun, result) do
    case fun.(head) do
      true -> keep_process(tail, fun, result ++ [head])
      false -> keep_process(tail, fun, result)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    discard_process(list, fun, [])
  end

  defp discard_process([], _, result) do
    result
  end

  defp discard_process([head|tail], fun, result) do
    case fun.(head) do
      true -> discard_process(tail, fun, result)
      false -> discard_process(tail, fun, result ++ [head])
    end
  end

end
