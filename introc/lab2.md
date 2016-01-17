---
layout: default
title: Laboratório 2
relpath: ..
---

## Laboratório 2

Uma calculadora *RPN* é uma calculadora na qual entramos com as operações
*após* os operandos, e temos um comando que vai guardando operandos em uma
espécie de "pilha". Nesse laboratório vamos construir um programa
que implementa uma calculadora RPN para números **inteiros**.

Podemos representar a pilha da calculadora RPN com variáveis globais. Uma pilha
com espaço para quatro números pode usar quatro variáveis: `P0`, `P1`, `P2` e `P3`.
A variável `P0` é o *topo* da pilha, e é o que aparece no "display" da calculadora.
Os valores iniciais das variáveis são todos `0`.

A calculadora RPN completa será uma aplicação GUI, mas comece implementando
as funções abaixo em uma aplicação do console, testando elas dentro da função
`main`.

1\. A operação `store` move o valor que estava em `P2` para `P3`, o que estava em `P1` para `P2`,
o que estava em `P0` para `P1`,  e zera `P0`. **Implemente uma função
auxiliar `store` que efetua essa operação. Escreva em um comentário qual o *efeito*
dessa função.**

2\. As operações `soma`, `sub`, `mult` e `div` respectivamente somam, subtraem, multiplicam e 
dividem o valor de `P0` pelo de `P1`, armazenando o resultado em `P0`, depois copiando o
valor de `P2` para `P1`, de `P3` para `P2`, zerando `P3`. **Implemente uma
função para cada operação. Escreva em um comentário para cada função o *efeito*
dessa função.**

3\. As operações `um`, `dois`, ..., `nove` e `zero` correspondem à entrada de dígitos na calculadora,
multiplicando o valor atual de `P0` por 10 e somando o dígito correspondente. **Implemente uma
função `digito` que recebe um dígito de 0 a 9 e entra ele em `P0`, depois implemente as funções
`zero`, `um`, `dois`, ..., `nove` usando `digito`. Escreva em um comentário para cada função o *efeito*
dessa função.**

4\. A operação `menos` inverte o valor que está em `P0`. **Implemente a função `menos`.
Escreva em um comentário qual o *efeito* dessa função.**

5\. Podemos adicionar uma "memória" à calculadora com uma variável `M` e operações
`soma_m`, `sub_m` e `zera_m` que respectivamente somam `M` com `P0` e guardam o resultado em
`M`, subtraem `P0` de `M` e guardam o resultado em `M`, e zeram `M`. **Implemente as funções
`soma_m`, `sub_m` e `zera_m`. Escreva em um comentário para cada função o *efeito*
dessa função.**

6\. A operação `reset` volta a calculadora a seu estado inicial, com todas as variáveis de seu estado
iguais a 0. **Implemente a função `reset`. Escreva em um comentário qual o *efeito* dessa função.**

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

