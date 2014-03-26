---
layout: default
title: Lab 11 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 11 - 04/02/2013
---------------------------

1\. Baixe o [projeto da calculadora](Calculadora.zip). Você deve adicionar quatro novas funções à calculadora,
em uma nova fileira de botões acima da primeira: `M+`, que adiciona o valor do display a uma memória interna
da calculadora (resetar a calculadora **não** zera a memória), `MR`, que copia o valor da memória para o display,
`MC`, que zera a memória, e `+-`, que troca o sinal do valor do display.
Lembre de continuar seguindo a estrutura básica do padrão MVC que o projeto da Calculadora já segue.

2\. Implemente uma *calculadora RPN* como um novo projeto. A interface da calculadora RPN é quase idêntica
à da calculadora normal, mas o botão `=` é substituído por um botão `STO` (de `store`). O modelo por trás é bem
diferente, entretanto. A calculadora RPN funciona com uma *pilha* de operandos; toda vez uma operação
`store` é executada o valor do display é empilhado, e qualquer outro dígito após isso começa a entrada de
outro número. Por exemplo, se o display é `1234` e se faz `STO` e depois `5` e `3` o número 1234 é empilhado e o
valor do display passa a ser `53`.

As operações aritméticas todas funcionam da mesma forma: o operando da esquerda é removido do topo da pilha
(ou é 0 se a pilha estiver vazia), e o operando da direita é o valor do display. A operação é feita, e o resultado
vira o novo valor do display. Qualquer outro dígito após isso começa a entrada de outro número, do mesmo modo que
em uma operação de store.

Um exemplo de uso: `2`, `STO`, `3`, `STO`, `5`, `*`, `+` faz a operação 2+(3\*5), deixando `17` no display e a
pilha vazia.

A calculadora inicia com o display e a memória zerados, e a pilha vazia. Reset volta
a calculadora para sua configuração inicial. As outras operações (`M+`, `MR`, `MC`, `+-`) funcionam do mesmo
jeito que na calculadora normal, pois só afetam o display.

*Esse é um modelo bastante simplificado do funcionamento de uma calculadora RPN, para deixar o exercício
mais simples. Se tiver curiosidade de ver como funcionava uma calculadora RPN de verdade veja [aqui](http://www.hpmuseum.org/rpn.htm).*

Enviando
--------

Use o formulário abaixo para enviar o Laboratório 11. O prazo para envio é segunda-feira, dia 18/02/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/30333459659663">dummy</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
