---
layout: default
title: Lab 6 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 6 - 06/05/2015
--------------------------

Uma calculadora *RPN* é uma calculadora na qual entramos com as operações
*após* os operandos, e temos um comando que vai guardando operandos em uma
espécie de "pilha". Nesse laboratório vamos construir o *modelo* de uma
calculadora RPN, e usá-lo com a interface (visão+controlador) feita
no [laboratório 5](lab5.html).

Uma calculadora RPN tem as mesmas operações de uma calculadora padrão,
mas o funcionamento por trás é bem diferente. Ela funciona com uma *pilha* de operandos; 
toda que vez o botão `=` (chamada de *store* em uma calculadora RPN) é apertado
o valor do display é empilhado, e qualquer outro dígito após isso começa a entrada de
outro número. Por exemplo, se o display é `1234` e se faz `=` o número 1234 é
empilhado e o display continua mostrando `1234`. Se depois pressiona-se o número
`5` o valor do display passa a ser `5`, e pressionando o número `3` o valor do display
passa a ser `53`.

As operações aritméticas todas funcionam da mesma forma: o operando da esquerda é removido do topo da pilha
(ou é 0 se a pilha estiver vazia), e o operando da direita é o valor do display. A operação é feita,
e o resultado vira o novo valor do display. Qualquer outro dígito após isso começa a entrada de outro
número, do mesmo modo que em uma operação de store.

Um exemplo de uso: `2`, `=`, `3`, `=`, `5`, `*`, `+` faz a operação 2+(3\*5), deixando `17` no display e
a pilha vazia.

Chame a classe principal do modelo de `ModeloCalcRPN`.
Podemos representar uma calculadora RPN com espaço para quatro números
usando quatro campos: `P0`, `P1`, `P2` e `P3`.
O campo `P0` é o display, e os outros três campos são a pilha.
Os valores iniciais são todos `0`.

Como vamos usar esse modelo com a a interface gráfica feita no último laboratório,
esse modelo também precisa implementar os mesmos métodos do modelo da calculadora
que vocês usaram para o laboratório passado:

{% highlight python %}
    digito(self, i) # dígito de 0 a 9 pressionado
    soma(self)      # operação de soma (botão +)
    sub(self)       # operação de subtração (botão -)
    mult(self)      # operação de multiplicação (botão *)
    div(self)       # operação de divisão (botão /)
    igual(self)     # resultado da operação (botão =)
    reset(self)     # limpa calculadora (botão C)
    valor(self)     # retorna o valor atual do display como uma string
{% endhighlight %}

O que muda é o comportamento de cada operação acima:

1\. A operação `igual` move o valor que estava em `P2` para `P3`, o que estava em `P1` para `P2`,
o que estava em `P0` para `P1`,  e zera `P0`. 

2\. As operações `soma`, `sub`, `mult` e `div` respectivamente somam, subtraem, multiplicam e 
dividem o valor de `P0` pelo de `P1`, armazenando o resultado em `P0`, depois copiando o
valor de `P2` para `P1`, de `P3` para `P2`, zerando `P3`. 

3\. A operação `digito` corresponde à entrada de dígitos na calculadora,
multiplicando o valor atual de `P0` por 10 e somando o dígito correspondente.

4\. A operação `reset` volta a calculadora a seu estado inicial, com todas as variáveis de seu estado
iguais a 0. 

Depois de implementado o modelo da calculadora RPN, conecte ele com a interface gráfica feita no
laboratório passado e teste o resultado.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

