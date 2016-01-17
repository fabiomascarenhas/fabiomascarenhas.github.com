---
layout: default
title: Lab 2 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 2 - 25/03/2015
--------------------------

Para poder fazer esse laboratório vocês devem baixar e instalar a biblioteca PyGame nas máquinas
do laboratório. Para isso, baixe [esse arquivo](pygame_lab.zip). Dentro dele você irá encontrar uma
pasta `pygame`, que você deve copiar para dentro da pasta `c:\Python27\Lib` do computador.

Depois de instalar o PyGame, baixe o [motor de jogo](motor.py), que você deve copiar para dentro
da pasta `c:\Python27`. Baixe também um [exemplo](jogo.py) de uso desse motor de jogo.

Esse laboratório é uma continuação do [laboratório 1](lab1.html) da semana
passada, então faça uma revisão do que foi pedido no laboratório 2, e comece
terminando de implementar o que foi pedido lá. Depois prossiga para o que
está abaixo.

Nesse laboratório vocês implementarão a lógica necessária para o movimento dos carros
e do sapo. Relembrando: os carros da primeira faixa atravessam a tela em 5 segundos,
os da segunda faixa em 2 segundos, os dao terceira faixa em 8 segundos, e os da
quarta faixa em 6 segundos.

O vídeo abaixo mostra o movimento dos carros:

<iframe width="640" height="390" src="http://www.youtube.com/embed/hHehXLhHOc0" frameborder="0" allowfullscreen="1">
dummy
</iframe>

O movimento do sapo pode ser para cima, para baixo, para a esquerda, ou para a direita, usando
as setas. Quando uma das setas é pressionada o motor de jogo chama o método `tecla` da classe
`Breakout`, passando "up", "down", "left", ou "right", a depender se a tecla foi seta para cima, para baixo,
para a esquerda ou para a direita.

O sapo se move em "saltos" de 100 pixels, mas o salto não é instantâneo:
ele leva cerca de *1/3* de segundo para completar. Uma maneira simples de implementar isso
é fazer o sapo ter dois conjuntos de posições, uma onde ele está agora e outra indicando
onde ele deve estar. Qualquer uma das teclas de salto atualiza a posição onde ele deve
estar, e em cada tique o sapo se move na direção da posição onde
deve estar com uma velocidade de 300 pixels por segundo em cada eixo.
Se as duas posições são idênticas então o sapo simplesmente fica imóvel.

Caso o sapo salte além dos cantos esquerdo ou direito da tela ele deve aparecer do outro lado, do mesmo
modo que os carros. A solução para esse problema não é difícil, mas é sutil. Pensem bem a respeito. O modo
mais fácil é implementar essa lógica no método que faz o sapo se mover em direção à sua "meta". Se o sapo já
chegou na calçada superior um salto para cima não deve fazer ele se mover mais para cima. O mesmo em relação
à calçada inferior e saltos para baixo.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
