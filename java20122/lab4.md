---
layout: default
title: Lab 4 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 4 - 26/11/2012
--------------------------

Nesse laboratório vocês irão implementar mais uma parte da mecânica do jogo *Frogger*. Para isso
irão continuar usando o código que vocês fizeram para o Laboratório 3 (quem ainda não terminou
o Laboratório 3 pode aproveitar a chance para terminá-lo).

No último laboratório vocês implementaram a lógica para mostrar o tabuleiro do jogo e mover
os carros. Nesse laboratório o objetivo é implementar o movimento do sapo (respondendo aos comandos
do teclado), assim como a colisão entre os sapos e os carros.

O movimento do sapo pode ser para cima, para baixo, para a esquerda, ou para a direita, usando
as setas. Quando uma das setas é pressionada o motor de jogo chama o método `tecla(String s)` da classe
`Jogo`, passando "up", "down", "left", ou "right", a depender se a tecla foi seta para cima, para baixo,
para a esquerda ou para a direita.

O sapo se move em "saltos" de 100 pixels, mas o salto não é instantâneo, ele leva cerca de *1/3* de segundo
para completar. Uma maneira simples de implementar isso é fazer o sapo ter
 dois conjuntos de posições, uma onde ele está agora e outra indicando onde ele deve estar. Qualquer uma das teclas de salto atualiza
a posição onde ele deve estar, e em cada atualização do quadro o sapo se move na direção da posição onde
deve estar com uma velocidade de 300 pixels por segundo em cada componente. Se as duas posições são
idênticas então o sapo simplesmente fica imóvel.

Caso o sapo salte além dos cantos esquerdo ou direito da tela ele deve aparecer do outro lado, do mesmo
modo que os carros. A solução para esse problema não é difícil, mas é sutil. Pensem bem a respeito. O modo
mais fácil é implementar essa lógica no método que faz o sapo se mover em direção à sua "meta". Se o sapo já
chegou na calçada superior um salto para cima não deve fazer ele se mover mais para cima. O mesmo em relação
à calçada inferior e saltos para baixo.

A colisão deve ser verificada no método de atualização do jogo, após todo o movimento daquele
quadro ter sido feito. Uma colisão do sapo com um dos carros
faz o contador de vidas diminuir em 1 e o sapo deve retornar para a posição inicial. Se o contador estiver em
0 no momento da colisão deve ser exibida uma mensagem de "GAME OVER" no centro da tela, e o sapo some (os
carros continuam se movendo).

Enviando
--------

Use o formulário abaixo para enviar o Laboratório 4. O prazo para envio é sexta-feira, dia 07/12/2012.

<script type="text/javascript" src="http://form.jotformz.com/jsform/23295337160654">
dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
