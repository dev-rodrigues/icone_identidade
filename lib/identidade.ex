defmodule Identidade do
  @moduledoc """
  Documentation for Identidade.
  """

  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identidade.Imagem{hex: hex}
  end

  def criar_cor(%Identidade.Imagem{hex: [r,g,b | _tail]} = imagem) do
    %Identidade.Imagem{imagem | color: {r,g,b} }
  end

  def criar_tabela(%Identidade.Imagem{hex: hex} = imagem) do
    hex
    |> Enum.chunk(3)
  end

  def espelhar(linha) do
    
  end
end
