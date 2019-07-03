defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &translate(&1))
  end

  def translate(char) do
    case char do
      ?A -> ?U
      ?T -> ?A
      ?C -> ?G
      ?G -> ?C
    end
  end
end
