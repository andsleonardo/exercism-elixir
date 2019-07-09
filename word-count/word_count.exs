defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words_list = to_words_list(sentence)
    Map.new(words_list, &{ &1, occurrences_count(words_list, &1) })
  end

  defp to_words_list(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r/[^\p{L}\d\-]/u, " ")
    |> String.split
  end

  defp occurrences_count(enum, element) do
    Enum.count(enum, &(&1 == element))
  end
end
