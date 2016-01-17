---
layout: default
title: Laboratório 3
relpath: ..
---

## Laboratório 3

Hoje vocês irão terminar a calculadora RPN que começaram a fazer no
[laboratório 2](lab2.html), com o desenho da interface da calculadora.

Crie uma nova "Aplicação GUI", depois de instalar a biblioteca de 
interface gráfica baixando os arquivos e seguindo as instruções
em [nossa página](index.html).

A janela da calculadora tem 200 pixels de largura, para caber fileiras
de quatro botões de 50 pixels cada, e 300 pixels de largura, para
caber o display e mais cinco fileiras de botões, cada uma com 50 pixels
de altura.

O display tem espaço para sete dígitos, e deve ser preenchido com
zeros à esquerda: se o valor de `P0` é `52`, o display deve
mostrar `0000052`. O primeiro caractere do display é o sinal
de menos, para mostrar um número negativo, ou um espaço em branco.

Cada botão tem uma "borda" branca de 3 pixels de largura. Você pode
desenhar um botão com essa borda desenhando um quadrado branco, depois um quadrado
preto por cima, e finalmente o texto do botão.

A primeira fileira tem os botões `M+`, `M-`, `MC` e `C`, que
correspondem às operações `soma_m`, `sub_m`, `zera_m` e `reset`.

A segunda fileira tem os botões `7`, `8`, `9` e `/`. A teceira
fileira tem `4`, `5`, `6` e `*`. A quarta tem `1`, `2`, `3` e `-`.
A quinta e última fileira de botões tem `+-`, `0`, `ST` e `+`.
O botão `+-` corresponde à operação `menos`, e `ST` à operação
`store`.

O usuário pode interagir com a calculadora pelo pelo mouse.
Quando o usuário aperta o mouse dentro dos limites de um botão
(`cliques == 0`), o botão deve aperecer "revertido", com corpo
branco e texto preto. Quando o usuário solta o mouse (`cliques > 0`),
o botão volta à aparência normal, e a operação correspondente é efetuada.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

