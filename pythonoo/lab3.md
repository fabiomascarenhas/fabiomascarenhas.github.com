---
layout: default
title: Lab 3 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 3 - 01/04/2015
--------------------------

Esse laboratório é uma continuação do [laboratório 2](lab2.html) da semana
passada, então faça uma revisão do que foi pedido no laboratório 2, e comece
terminando de implementar o que foi pedido lá. Depois prossiga para o que
está abaixo.

Nesse laboratório o objetivo é implementar o movimento do sapo (respondendo aos comandos
do teclado), assim como a colisão entre os sapos e os carros.

O movimento do sapo pode ser para cima, para baixo, para a esquerda, ou para a direita, usando
as setas. Quando uma das setas é pressionada o motor de jogo chama o método `tecla` da classe
`Frogger`, passando "up", "down", "left", ou "right", a depender se a tecla foi seta para cima, para baixo,
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

A colisão deve ser verificada no método `tique` do jogo, após todo o movimento
ter sido feito. Uma colisão do sapo com um dos carros faz o contador de vidas diminuir
em 1, e o sapo deve retornar para a posição inicial. Use a classe Hitbox dada em sala para
detectar as colisões. 

Se o contador de vidas chegar em 0 o jogo termina: deve ser exibida uma mensagem de "GAME OVER"
no centro da tela, e o sapo some (os carros continuam se movendo).

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
