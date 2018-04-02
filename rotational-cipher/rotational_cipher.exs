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
    alphabet = for n <- ?a..?z, do: << n :: utf8 >>
    letter_index = Enum.find_index(alphabet, fn(x) -> x == head end)
    total_count = letter_index + shift
    cond do
      total_count < 26 ->
        cipher_letter = Enum.at(alphabet, total_count)
      total_count == 26 ->
        cipher_letter = head
    end
    next_letter(tail,shift,answer <> cipher_letter)
  end
end
