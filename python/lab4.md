---
layout: default
title: Fabio Mascarenhas
relpath: ..
---

## Laboratório 4

1\. Quais os valores de `a` e `b` depois de executar o programa abaixo? Verifique
sua resposta no interpretador

{% highlight python %}
a = 3
b = 5
a = b
{% endhighlight %}

2\. Qual o valor de `c` depois de executar o programa abaixo? Verifique
sua resposta no interpretador

{% highlight python %}
a = 3
b = 5
c = (a + b) / 2
b = 1
{% endhighlight %}

3\. Seja o seguinte programa simples em Python:

{% highlight python %}
a = 1

def inc():
    global a
    a = a + 1
    return a

def dec():
    global a
    a = a - 1
    return a
{% endhighlight %}

Qual o resultado de `inc() + dec()`? E de `dec() + inc()`? Tente
responder você mesmo antes de perguntar ao interpretador. O que 
os resultados dessas duas somas dizem sobre a ordem
na qual Python está avaliando os lados da soma?
    
4\. Seja o programa em Python abaixo:

{% highlight python %}
x = 0
y = 1

def muda3(z):
    global y
    y = 3
    return z
{% endhighlight %}

Qual o valor retornado por `muda3(x)`? Qual o seu *efeito* sobre as variáveis globais?
Pense a respeito primeiro antes de usar o interpretador.

5\. Para o jogo de forca do [laboratório 3](lab3.html), dado pelas funções
feitas na [aula de 23/09](defs2309.py), assuma que o estado do jogo é mantido
em uma variável global JOGO, e escreva uma função `tenta` que recebe uma letra,
atualiza o estado do jogo para refletir essa jogada, e retorna "GANHOU" se o jogo
terminou com vitória, "PERDEU" se terminou com derrota, ou quantas tentativas o
jogador ainda tem. Escreva também uma função `reseta` que retorna o jogo ao estado
inicial.

6\. Reescreva o jogo de forca do [laboratório 3](lab3.html) para
manter as partes do estado do jogo em três variáveis globais `palavra`, `mascara`
e `erros`, escrevendo novas versões das funções `rodada` e `rodada_final` que
atualizem essas variáveis ao invés de retornar um dicionário. Também escreva
novas versões de `tenta` e `reseta` , da questão anterior.

7\. Uma *calculadora* RPN é uma calculadora na qual entramos com as operações
*após* os operandos, e temos um comando que vai guardando operandos em uma
espécie de "pilha".

Podemos representar a pilha da calculadora RPN com variáveis globais, uma pilha
com espaço para quatro números pode usar quatro variáveis: `P0`, `P1`, `P2` e `P3`.
A variável `P0` é o *topo* da pilha, e é o que aparece no "display" da calculadora.
Os valores iniciais das variáveis são todos `0`.

A operação `store` move o valor que estava em `P2` para `P3`, o que estava em `P1` para `P2`,
o que estava em `P0` para `P1`,  e zera `P0`. **Implemente uma função
`store` que efetua essa operação.**

As operações `soma`, `sub`, `mult` e `div` respectivamente somam, subtraem, multiplicam e 
dividem o valor de `P0` pelo de `P1`, armazenando o resultado em `P0`, depois copiando o
valor de `P2` para `P1`, de `P3` para `P2`, zerando `P3`. **Implemente uma
função para cada operação.**

As operações `um`, `dois`, ..., `nove` e `zero` correspondem à entrada de dígitos na calculadora,
multiplicando o valor atual de `P0` por 10 e somando o dígito correspondente. **Implemente uma
função `digito` que recebe um dígito de 0 a 9 e entra ele em `P0`, depois implemente as funções
`zero`, `um`, `dois`, ..., `nove` usando `digito`.**

A operação `menos` inverte o valor que está em `P0`. **Implemente a função `menos`.**

Finalmente, podemos adicionar uma "memória" à calculadora com uma variável `M` e operações
`soma_m`, `sub_m` e `zera_m` que respectivamente somam `M` com `P0` e guardam o resultado em
`M`, subtraem `P0` de `M` e guardam o resultado em `M`, e zeram `M`. **Implemente as funções
`soma_m`, `sub_m` e `zera_m`.**

Finalmente, a operação `reset` volta a calculadora a seu estado inicial, com todas as variáveis de seu estado
iguais a 0. **Implemente a função `reset`.**
