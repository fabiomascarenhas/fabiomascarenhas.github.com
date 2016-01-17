---
layout: default
title: Lab 9 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 9 - 30/04/2014
--------------------------

O último projeto que vocês irão desenvolver será uma calculadora Android
que funciona em dois modos: o modo tradicional e o modo RPN (como as
calculadoras financeiras e científicas da HP). Nesse laboratório,
vocês irão adicionar memória ao modelo da calculadora, com uma
nova fileira de botões, e implementar o modelo da calculadora RPN.

1\. Baixe o [projeto da calculadora](CalcAndroid.zip). 
Você deve adicionar quatro novas funções à calculadora,
em uma nova fileira de botões acima da primeira: `M+`, que adiciona o valor do display a uma memória interna
da calculadora (resetar a calculadora **não** zera a memória), `MR`, que copia o valor da memória para o display,
`MC`, que zera a memória, e `+-`, que troca o sinal do valor do display.
Lembre de continuar seguindo a estrutura básica do padrão MVC que o projeto da Calculadora já segue,
e não se esqueça de tratar corretamente a gravação e recuperação do estado da calculadora para
incluir os novos dados do modelo.

2\. Renomeie a classe `ModeloCalc` para `ModeloPadrao`, e crie uma nova interface `ModeloCalc`
com os métodos que são chamados pelo controlador. Faça a aplicação ter uam referência para
a interface `ModeloCalc` ao invés da classe `ModeloPadrao`.

3\. Implemente a calculadora RPN como uma nova classe `ModeloRPN` derivada da interface
`ModeloCalc`. As operações da calculadora RPN tem as mesmas operações da calculadora padrão,
mas o funcionamento por trás é bem diferente. Ela funciona com uma *pilha* de operandos; 
toda vez uma operação `igual` (chamada de *store*, ou `STO` em uma calculadora RPN) é executada
o valor do display é empilhado, e qualquer outro dígito após isso começa a entrada de
outro número. Por exemplo, se o display é `1234` e se faz `STO` o número 1234 é
empilhado e o display continua mostrando `1234`. Se depois pressiona-se o número
`5` o valor do display passa a ser `5`, e pressionando o número `3` o valor do display
passa a ser `53`.

As operações aritméticas todas funcionam da mesma forma: o operando da esquerda é removido do topo da pilha
(ou é 0 se a pilha estiver vazia), e o operando da direita é o valor do display. A operação é feita,
e o resultado vira o novo valor do display. Qualquer outro dígito após isso começa a entrada de outro
número, do mesmo modo que em uma operação de store.

Um exemplo de uso: `2`, `STO`, `3`, `STO`, `5`, `*`, `+` faz a operação 2+(3\*5), deixando `17` no display e a
pilha vazia.

A calculadora inicia com o display e a memória zerados, e a pilha vazia. Reset volta
a calculadora para sua configuração inicial. As outras operações (`M+`, `MR`, `MC`, `+-`) funcionam do mesmo
jeito que na calculadora normal, pois só afetam o display.

*Esse é um modelo bastante simplificado do funcionamento de uma calculadora RPN, para deixar o exercício
mais simples. Se tiver curiosidade de ver como funcionava uma calculadora RPN de verdade veja [aqui](http://www.hpmuseum.org/rpn.htm).*

4\. Teste seu modelo da calculadora RPN, fazendo a aplicação Android instanciar um `ModeloRPN` ao
invés de um `ModeloPadrao`.

Enviando
--------

As instruções para envio, assim como o prazo, serão dadas no próximo laboratório, junto com as
tarefas restantes.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
