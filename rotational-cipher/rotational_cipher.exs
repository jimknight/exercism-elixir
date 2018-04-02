defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text_array = String.split(text,"",trim: true)
    next_letter(text_array,shift,"")
  end

  defp next_letter([],_,answer) do
    answer
  end

  defp next_letter([head|tail],shift,answer) do
    lower_case = String.downcase(head)
    alphabet = for n <- ?a..?z, do: << n :: utf8 >>
    letter_index = Enum.find_index(alphabet, fn(x) -> x == lower_case end)
    if letter_index == nil do
      next_letter(tail,shift,answer <> head)
    else
      cond do
        letter_index + shift < 26 ->
          cipher_letter = Enum.at(alphabet, letter_index + shift)
        letter_index + shift >= 26 ->
          cipher_letter = Enum.at(alphabet, letter_index + shift - 26)
      end
      case lower_case == head do
        true ->
          next_letter(tail,shift,answer <> cipher_letter)
        false ->
          next_letter(tail,shift,answer <> String.upcase(cipher_letter))
      end
    end
  end
end
