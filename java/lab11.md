---
layout: default
title: Lab 11 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 11 - 14/05/2014
---------------------------

Hoje iremos continuar o projeto da calculadora, que começamos no 
[laboratório 9](lab9.html). 

1\. Acresente uma opção de menu para mudar o modo da calculadora entre
padrão e RPN. Se a calculadora estiver no modo padrão, o texto da
opção é "RPN", se a calculadora estiver no modo RPN o texto da opção é
"Padrão". Quando a calculadora muda de modo, ela deve "lembrar" todo
o estado que ela tinha no modo anterior, inclusive o histórico
de operações. A exceção é a memória, que
sobrevive à mudança de modo (assim o usuário pode guardar um valor na
memória, mudar de modo, e resgatar esse valor no novo modo).

2\. Acrescente uma opção de menu para limpar o histórico de operações.

3\. Mude a lista de operações para usar um layout XML como visão ao
invés de um simples `TextView`, inflando esse layout. O layout deve
ter três componentes `TextView` lado a lado, o primeiro com o operando,
alinhado à direita, o segundo com a operação, centralizada, e o terceiro
com o resultado, também alinhado à direita. O primeiro deve ocupar
cerca de quarenta e cinco por cento largura horizontal, o segundo cerca
de dez por cento, e o terceiro os quarenta e cinco por cento restantes.

4\. Faça a calculadora ter dois layouts, o atual para se ela estiver sendo
usada em modo paisagem, e outro em que o histórico de operações fica na
metade de baixo da tela, se ela estiver sendo usada em modo retrato.

Enviando
--------

Use o formulário abaixo para enviar os Laboratórios 9, 10 e 11. O prazo para envio é quarta-feira,
dia 21/05/2014.

<script type="text/javascript" src="http://form.jotformz.com/jsform/41326570449658">
dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
