defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    digits = Integer.digits(code,2)
    build(digits,0,[])
  end

  defp build([],_,answer) do
    answer
  end

  defp build(digits,loop_count,answer) do
    last_num = List.last digits
    added_value =
      case {last_num, loop_count} do
        {0,_} -> []
        {1,0} -> ["wink"]
        {1,1} -> ["double blink"]
        {1,2} -> ["close your eyes"]
        {1,3} -> ["jump"]
        {1,4} -> "reverse"
        {1,5} -> "do nothing"
      end
    remaining_digits = Enum.drop(digits,-1)
    case added_value do
      "reverse"    -> build([],loop_count + 1,reverse(answer))
      "do nothing" -> build([],loop_count + 1,[])
      _            -> build(remaining_digits,loop_count + 1,answer ++ added_value)
    end
  end

  defp reverse(answer) do
    Enum.reverse answer
  end

end
