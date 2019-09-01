defmodule Raindrops do
  @raindrop_factors [3, 5, 7]

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) when number == 3, do: "Pling"
  def convert(number) when number == 5, do: "Plang"
  def convert(number) when number == 7, do: "Plong"

  def convert(number) do
    divisors = calc_divisors(number)

    case Enum.empty?(divisors) do
      true -> Integer.to_string(number)
      false -> divisors |> Enum.map(&convert/1) |> Enum.join
    end
  end

  @spec calc_divisors(integer()) :: [integer()]
  defp calc_divisors(number) do
    @raindrop_factors |> Enum.filter(&(Integer.gcd(&1, number) == &1))
  end
end
