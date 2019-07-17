defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t) :: {atom, list(String.t) | String.t}
  def of_rna(rna) do
    case valid_rna?(rna) do
      true -> {:ok, translate_rna(rna)}
      _ -> {:error, "invalid RNA"}
    end
  end

  @spec valid_rna?(String.t) :: boolean
  defp valid_rna?(rna) do
    Enum.count(Regex.scan(~r/[AUCG]{3}/, rna)) == div(String.length(rna), 3)
  end

  @spec translate_rna(String.t) :: {[String.t]}
  defp translate_rna(rna) do
    rna
    |> String.split(~r/[AUCG]{3}/, include_captures: true, trim: true)
    |> Enum.reduce_while([], &update_proteins(of_codon!(&1), &2))
  end

  @spec update_proteins(String.t, [String.t]) :: {atom, [String.t]}
  defp update_proteins(protein, list) when protein == "STOP", do: {:halt, list}
  defp update_proteins(protein, list), do: {:cont, List.insert_at(list, -1, protein)}

  @spec of_codon!(String.t) :: String.t
  def of_codon!(codon) do
    elem(of_codon(codon), 1)
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t) :: {atom, String.t}
  def of_codon(codon) when codon in ["UAA", "UAG", "UGA"], do: {:ok, "STOP"}
  def of_codon(codon) when codon in ["UCU", "UCC", "UCA", "UCG"], do: {:ok, "Serine"}
  def of_codon(codon) when codon in ["UAU", "UAC"], do: {:ok, "Tyrosine"}
  def of_codon(codon) when codon in ["UGU", "UGC"], do: {:ok, "Cysteine"}
  def of_codon(codon) when codon in ["UUA", "UUG"], do: {:ok, "Leucine"}
  def of_codon(codon) when codon in ["UUC", "UUU"], do: {:ok, "Phenylalanine"}
  def of_codon(codon) when codon == "AUG", do: {:ok, "Methionine"}
  def of_codon(codon) when codon == "UGG", do: {:ok, "Tryptophan"}
  def of_codon(_), do: {:error, "invalid codon"}
end
