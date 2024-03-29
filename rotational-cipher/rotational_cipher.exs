defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&transform(&1, shift))
    |> to_string
  end

  defp transform(char, shift) when char in ?a..?z do
    rem(char - ?a + shift, 26) + ?a
  end

  defp transform(char, shift) when char in ?A..?Z do
    rem(char - ?A + shift, 26) + ?A
  end

  defp transform(char, _), do: char
end
