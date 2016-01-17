---
layout: default
title: Lab 11 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 11 - 24/06/2015
--------------------------

Nesse laboratório vamos usar `numpy` para adicionar imagens e
filtros no editor de figuras que vimos em sala. Use como
base a versão Tkinter do editor, que está [nesse arquivo](lab11.py).

A classe `Tkinter.PhotoImage` representa uma imagem que pode ser
mostrada pelos controles do Tkinter (dentro de um canvas, por exemplo).
O construtor dela recebe um *nome* (uma string) e um dicionário de
opções, duas das quais são `"width"`, para a largura da imagem, e
`"height"`, para altura. Por exemplo `Tkinter.PhotoImage(None, {"width": 300, "height": 200})`
cria uma imagem em branco com 300 pixels de largura e 200 de altura.

O método `put` das instâncias de `PhotoImage` permite pintar os
pixels da imagem. O primeiro argumento é a cor (no formato das cores
do Tkinter) e o segundo é a coordenada (um par com a coordenada x e a y).
Por exemplo, `im1.put("#ff0000", (200, 100))` pinta o pixel na coordenada
`(200, 100)` de vermelho.

1\. Implemente uma classe derivada de `Tkinter.PhotoImage` chamada
`Imagem`. O construtor dela recebe uma imagem do `numpy` (uma matriz
*MxNx4*), usa *M* como largura da `PhotoImage`, *N* como altura
da `PhotoImage`, e pinta os pixels com as cores que estão na matriz
(use a função `cor_tkinter`). Lembre-se que se `m` é uma matriz
`numpy` então `m.shape[0]` é o número de linhas da matriz, `m.shape[1]`
é o número de colunas, e `m[i,j]` dá a quádrupla RGBA do pixel na
coordenada `(i,k)`.

2\. Para mostrar uma imagem em um canvas do Tkinter usamos o
método `create_image` do canvas. Ele recebe as coordenadas de
onde será o centro da imagem, e um dicionário com um atributo `"image"`
que diz qual instância de `PhotoImage` será mostrada:
`canvas.create_image(300, 200, { "image": im1 })`. Teste a
classe `Imagem` anterior fazendo o canvas do editor mostrar alguma
imagem qualquer em uma posição fixa.

3\. Adicone um método `imagem(x, y, matriz)` à classe `Canvas`
para desenhar uma imagem no canvas a partir de uma matriz `numpy`
com o conteúdo da imagem. As coordenadas são as do *canto superior
esquerdo* da imagem. Use a classe `Imagem` que você criou no
exercício 1, e o método `create_image` do canvas.

4\. Vamos agora acrescentar uma classe ao modelo do editor que represente
imagens. Crie uma classe `FiguraImagem` derivada de `FiguraPt`. Seu
construtor recebe as coordenadas do canto superior esquerdo da imagem,
e uma matriz `numpy` com o conteúdo da mesma. Implemente os métodos
`desenhar` e `dentro` para essa classe.

5\. Implemente a classe `ModoImagem` que representa o modo de desenhar
uma imagem no editor. O construtor de `ModoImagem` recebe o modelo 
do editor e uma matriz `numpy` com o conteúdo da imagem. Os outros
métodos são no molde dos métodos da classe `ModoPonto`.

6\. Adicione um botão "Imagem" na interface do editor. Quando
clicado, esse botão usa a função `tkFileDialog.askopenfilename()` para
pedir que o usuário selecione (essa função retorna o
nome do arquivo selecionado). Use a função `matplotlib.pyplot.imread(*nomedoarquivo*)`
para ler o arquivo para uma matriz `numpy`, e ponha o modelo do editor
no modo de desenho dessa imagem usando a classe `ModoImagem` do
exercício anterior. 

7\. Teste incluir, mover e apagar uma imagem. Se você fez todos
exercícios anteriores corretamente todas essas operações devem estar funcionando.

8\. Adicione um `Rotulo` e uma `CaixaEntrada` na interface do editor,
acima dos sliders de escolha de cor, para o usuário poder mudar o *gamma*
das imagens que são adicionadas. O valor inicial da caixa deve ser `1.0`.
O *gamma* é um expoente que é aplicado a todos os componentes da imagem:
um *gamma* entre 0 e 1 deixa a imagem mais clara (quanto mais perto de 0 mais
clara), um gama maior do que 1 deixa ela mais escura. Modifique a ação
do botão "Imagem" para levar em conta o valor atual do gamma na hora
de adicionar uma imagem.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

