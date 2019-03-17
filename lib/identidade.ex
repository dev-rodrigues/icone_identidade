defmodule Identidade do
  @moduledoc """
  Módulo para criar um icone de identidade, ao passar uma `String qualquer`
  """
 
  @doc """
    Ao passar um valor para `input` gera uma imagem e retorna `:ok`
    ##Exemplo
    iex> Identidade.main("Gerar imagem")
    :ok
  """
  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
    |> remover_impar
    |> constroi_pixel
    |> desenhar
    |> salvar(input)
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
    grid = hex
    |> Enum.chunk(3)
    |> Enum.map(&espelhar/1)
    |> List.flatten
    |> Enum.with_index
    %Identidade.Imagem{imagem | grid: grid}
  end

  def remover_impar(%Identidade.Imagem{grid: grid} = imagem)  do
    new_grid = Enum.filter grid, fn{valor, _indice} -> 
      rem(valor, 2) == 0
    end
    %Identidade.Imagem{imagem | grid: new_grid}
  end

  def constroi_pixel(%Identidade.Imagem{grid: grid} = imagem) do
    pixel_map = Enum.map grid, fn{_valor, indice} -> 
      h = rem(indice, 5) * 50
      v = div(indice, 5) * 50
      top_esquerda = {h, v}
      inf_direita = {h + 50, v + 50}
      {top_esquerda, inf_direita}
    end
    %Identidade.Imagem{imagem | pixel_map: pixel_map}
  end

  def desenhar(%Identidade.Imagem{color: cor, pixel_map: pixel_map}) do
    imagem = :egd.create(250, 250)
    preencha = :egd.color(cor)
    
    Enum.each pixel_map, fn{start, stop} -> 
      :egd.filledRectangle(imagem, start, stop, preencha)
    end
    :egd.render(imagem)
  end

  def salvar(imagem, input) do
    File.write("#{input}.png", imagem)
  end

  def espelhar(linha) do
    [pri, sec, _tail] = linha
    linha ++ [sec, pri]
  end
end
