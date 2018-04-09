defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    chunks =
      rna
        |> String.codepoints
        |> Enum.chunk(3)
        |> Enum.map(&Enum.join/1)
    proteins = which_protein_from_rna(chunks, [])
    case proteins do
      "invalid RNA" -> {:error, "invalid RNA"}
      _ -> {:ok, proteins}
    end
  end

  defp which_protein_from_rna([], result) do
    result
  end

  defp which_protein_from_rna([head|tail], result) do
    protein = which_protein(head)
    case protein do
      "ERROR" -> which_protein_from_rna([], "invalid RNA")
      "STOP" -> which_protein_from_rna([], result)
      _ -> which_protein_from_rna(tail, result ++ [protein])
    end
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
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein = which_protein(codon)
    case protein do
      "ERROR" -> {:error, "invalid codon"}
      _ -> {:ok, protein}
    end
  end

  defp which_protein(codon) do
    case codon do
      "UGU" -> "Cysteine"
      "UGC" -> "Cysteine"
      "UUA" -> "Leucine"
      "UUG" -> "Leucine"
      "AUG" -> "Methionine"
      "UUU" -> "Phenylalanine"
      "UUC" -> "Phenylalanine"
      "UCU" -> "Serine"
      "UCC" -> "Serine"
      "UCA" -> "Serine"
      "UCG" -> "Serine"
      "UGG" -> "Tryptophan"
      "UAU" -> "Tyrosine"
      "UAC" -> "Tyrosine"
      "UAA" -> "STOP"
      "UAG" -> "STOP"
      "UGA" -> "STOP"
      _ -> "ERROR"
    end
  end
end
