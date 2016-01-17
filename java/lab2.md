---
layout: default
title: Lab 2 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 2 - 19/02/2014
--------------------------

*[Frogger](http://www.jogos-viciantes.com/frogger/)* era outro jogo
da época do Atari em que um sapo tinha que atravessar uma auto-estrada
sem ser atropelado pelos carros, depois atravessar um rio saltando em
troncos e tartarugas que passavam sem se afogar. O jogador tinha um
tempo determinado para fazer as travessias.

![](http://www.atariage.com/2600/screenshots/s_Frogger_1.png)

Vocês deverão modelar as classes de uma versão simplificada de Frogger
em que só existe a travessia da estrada com os carros. O sapo vai ser
representado por um círculo e os carros por retângulos com tamanhos
diferentes, e que podem se mover em direções diferentes e com
velocidades diferentes. O sapo também tem um número de vidas.
Os carros se movem de um canto a outro da tela.
Quando eles "saem" da tela eles aprecem de volta vindo do lado oposto.

Vocês usarão as mesmas classes `Motor`, `Tela` e `Cor` que estamos usando
em sala de aula, mas a classe `Jogo` implementará a mecânica do Frogger.
Comecem baixando e abrindo no Eclipse o [esqueleto do Frogger](Frogger.zip). O Eclipse não tem
uma opção "Open Project..." no menu "File", portanto vocês têm que abrir a opção "Import..." do
menu "File", e na caixa de diálogo que aparece abrir a opção "General" clicando na seta ao lado
dela, depois clicar na opção "Existing Projects into Workspace" para selecioná-la e clicar no
botão "Next". Na tela seguinte, clique para selecionar a opção "Select archive file", depois
clique no botão "Browse..." dela e procure o arquivo "Frogger.zip" que você baixou. Finalmente,
clique no botão "Finish". O projeto "Frogger" deve aparecer na aba "Package Explorer" do Eclipse.

Nesse laboratório vocês implementarão a lógica necessária para exibição do tabuleiro do jogo
na tela, e do movimento dos carros. O movimento do sapo e a lógica do "atropelamento" ficará para
o próximo laboratório. O tabuleiro do jogo consiste de:

* Dois retângulos de 800 pixels por 100 pixels, marcando as duas "calçadas". Não precisam ser
  objetos, já que são elementos estacionários do jogo;
* Quatro faixas de carros; a primeira faixa tem 2 carros com 100 pixels de comprimento, e
  que atravessam a tela em 5 segundos, a segunda faixa tem 1 carro com 150 pixels de comprimento
  e que atravessa e tela em 2 segundos, a terceira faixa tem 3 carros com 60 pixels de comprimento
  e que atravessem a tela em 8 segundos, e a quarta faixa tem 3 carros com 60 pixels de
  comprimento e que atravessam a tela em 6 segundos. Todos os carros são instâncias de uma
  classe `Carro` e têm 100 pixels de altura, e cores aleatórias;
* O sapo, uma instância da classe `Sapo`, com 90 pixels de diâmetro e cor verde,
  começa no centro da calçada de baixo;
* O contador de vidas do sapo, no canto inferior direito, com tamanho 60.

A distância entre uma faixa de carros e a outra é de 100 pixels. O vídeo abaixo mostra
uma disposição e o movimento dos carros:

<iframe width="640" height="390" src="http://www.youtube.com/embed/hHehXLhHOc0" frameborder="0" allowfullscreen="1">
dummy
</iframe>

Enviando
--------

O envio do Laboratório 2 será junto com o Laboratório 3. As instruções serão dadas na
próxima semana, e o prazo de entrega para os dois laboratórios será 12/03/2014.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
