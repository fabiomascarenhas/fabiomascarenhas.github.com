---
layout: default
title: Lab 10 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 10 - 07/05/2014
---------------------------

Hoje iremos continuar o projeto da calculadora, que começamos no 
[laboratório passado](lab9.html). Colocaremos uma funcionalidade de
*histórico* na calculadora, mudando primeiro o modelo e depois
a visão.

1\. O histórico da calculadora mostra algumas operações que o
usuário fez. Toda vez que ele clica os botões `+`, `-`, `*`, `/`,
`C` ou `=` uma nova entrada é adicionada no histórico. Crie uma classe
`Operacao` para representar uma entrada no histórico, contendo um
operando (um inteiro), um operador (uma string) e um resultado (um inteiro).
Defina um construtor para essa classe.

2\. Adicione uma lista de operações ao modelo. Toda vez que uma das
quatro operações aritméticas, a operação `reset` ou a operação `igual`
for feita você deve adicionar uma nova operação à lista; o operando é
o número que estava no display no momento da operação, o operador é o
botão correspondente, e o resultado é o número que está no display depois
da operação ser feita.

3\. Adicione um método `limpa` ao modelo que apaga todas as entradas do
histórico de operações.

4\. Mude o layout da calculadora para incluir espaço para o histórico.
A tela ficará dividida em duas metades: na metade da esquerda ficará a
interface atual da calculadora, na metade da direita ficará uma `ListView`
com as entradas do histórico.

5\. Implemente uma classe derivada de `BaseAdapter` para mostrar o histórico
na `ListView`. Use uma `TextView` com uma fonte monoespaçacada 
(veja o atributo `Typeface` da `TextView`) para cada linha, e alinhe o
texto à direita. Se a operação é uma das quatro operações, a linha tem
o operando, com espaços à esquerda para completar nove caracteres, um
espaço, o operador e dez espaços. Se a operação for
reset, ela tem oito espaços, `0 C`, e mais dez espaços. Se a operação for igual,
ela tem o operando com espaços à esquerda para completar nove caracteres,
um espaço, "=", outro espaço, e o resultado com espaços à esquerda para
completar nove caracteres.

Enviando
--------

O prazo de envio será **21/05**. As instruções para envio serão dadas no próximo laboratório, junto com as
tarefas restantes.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
