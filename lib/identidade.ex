defmodule Identidade do
  @moduledoc """
  Documentation for Identidade.
  """

  def main(input) do
    input
    |> hash_input
    |> criar_cor
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identidade.Imagem{hex: hex}
  end

  def criar_cor(imagem) do
    %Identidade.Imagem{hex: hex_list} = imagem
    [r,g,b | _tail] = hex_list
    [r,g,b]
  end
end
