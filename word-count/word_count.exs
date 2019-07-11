defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> to_words_list
    |> Enum.reduce(%{}, &update_count/2)
  end

  defp to_words_list(sentence) do
    sentence
    |> String.downcase
    |> String.split(~r/[^\p{L}\d\-]/u, trim: true)
  end

  defp update_count(el, acc) do
    Map.update(acc, el, 1, &(&1 + 1))
  end
end
