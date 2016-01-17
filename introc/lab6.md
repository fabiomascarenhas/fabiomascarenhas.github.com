---
layout: default
title: Laboratório 6
relpath: ..
---

## Laboratório 6

Vocês devem continuar a construir o jogo Breakout, 
pedido no [Laboratório 4](lab4.html) e [Laboratório 5](lab5.html).
Uma vez que já tenha feito tudo o que foi pedido nesses laboratórios,
continue com os exercícios abaixo.

1\. Modifique o jogo para o número de tijolos ser dado pelo usuário.
Na função `gui_init`, você deve perguntar ao usuário (no console, usando
`printf` e `scanf`) quantas fileiras de tijolos ele quer, e quantos
tijolos em cada fileira. Os vetores com as informações dos tijolos devem
ser então alocados dinamicamente, com o uso de `malloc`. Lembre que
para usar `malloc` os vetores precisam ser declarados como ponteiros
para o primeiro elemento do vetor.

2\. Implemente um modo de pausa no jogo, ativado pela barra de espaço
(tecla `Space`). Quando pausado, nem a bola em a raquete se movem, e o
jogador pode remover tijolos clicando em cima deles.


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

