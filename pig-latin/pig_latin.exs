defmodule PigLatin do
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    words = String.split(phrase, " ")
    process_words(words, [])
  end

  defp process([], result) do
    List.to_string(result ++ ["a","y"])
  end

  defp process([head|tail], result) do
    vowels = String.codepoints("aeiou")
    cond do
      (head == "x" || head == "y") && Enum.member?(vowels, List.first(tail)) == false ->
        process([], [head|tail])
      head == "u" && List.last(result) == "q" ->
        process(tail, result ++ [head])
      Enum.member?(vowels, head) == false && List.last(result) == "y" ->
        process(tail, result ++ [head])
      true ->
        case Enum.member?(vowels, head) do
          true  -> process([], [head|tail] ++ result)
          false -> process(tail, result ++ [head])
        end
    end
  end

  defp process_words([], final_result) do
    Enum.join(final_result, " ")
  end

  defp process_words([first_word|rest_of_words], final_result) do
    [head|tail] = String.codepoints(first_word)
    result = process([head|tail], [])
    process_words(rest_of_words, final_result ++ [result])
  end
end
