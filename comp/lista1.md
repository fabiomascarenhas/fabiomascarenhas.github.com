---
layout: default
title: Primeira Lista de Exercícios de Compiladores I
relpath: ..
---

Primeira Lista de Exercícios
----------------------------

1\. Construa um autômato finito para aceitar as palavras reservadas
**case**, **char**, **const** e **continue**.

2\. Considere os tokens:

* Números inteiros sem sinal
* Números reais sem sinal
* Operadores aritméticos: +, -, /, \*, (, )
* Operador de atribução: =
* Identificadores, onde são válidas apenas letras

Escreva regras usando expressões regulares e desenhe um
autômato finito para reconhecer os tokens acima.

3\. Numerais hexadecimais são usados em muitas linguagens de programação, e
são escritos com o prefixo 0x ou 0X seguido de dígitos hexadecimais, 0-9
e a-f ou A-F. Ex: 0x80, 0xDEADBEEF, 0X42acB, 0xF.

* Escreva a(s) regra(s) léxica(s) para numerais hexadecimais, usando expressões regulares.
* Escreva um autômato finito determinístico para numerais hexadecimais.

4\. Qual o problema causado por aninhamento de comentários em um analisador
léxico gerado a partir de expressões regulares?

5\. O seguinte trecho de código Java é responsável por ler e ignorar
comentários em um analisador léxico escrito à mão para a linguagem Pascal:

{% highlight java %}
      case '{':
        nextChar();
        while((char)lookAhead != '}' &&
              lookAhead != EOF)
          nextChar();
        if((char)lookAhead != '}')
          error("comentário não terminado");
        nextChar();
        continue;
{% endhighlight %}

Como você reescreveria esse trecho para permitir comentários aninhados?
Você pode definir métodos auxiliares. *Dica: pense em um analisador
sintático recursivo*.

6\. Escreva uma gramática sem ambiguidades que gere o conjunto de
cadeias de caracteres {s;, s;s;, s;s;s;, ...}.

7\. Dada a gramática (o caractere | separa as regras do mesmo não-terminal):

{% highlight ragel %}
      A -> A A | ( A ) | *vazio*
{% endhighlight %}

Descreva a linguagem que ela gera, e mostre que ela é ambígua.

8\. Dada a gramática:

{% highlight ragel %}
      E -> E + T | E - T | T
      T -> T * F | F
      F -> ( E ) | num
{% endhighlight %}

Escreva derivações e árvores sintáticas para as expressões a
seguir (assuma que os numerais são instâncias do terminal *num*):

* 3 + 4 \* 5 - 6
* 3 \* ( 4 - 5 + 6 )
* 3 - ( 4 + 5 \* 6 )

9\. Escreva uma gramática para expressões boolenas contendo as
constantes **true** e **false** e os operadores &&, || e !, além de
parênteses. O operador || tem precedência menor que &&, e este menor que
!. A gramática não pode ser ambígua.

10\. **Desafio!** Mostre que a seguinte tentativa de resolução da ambiguidade do else
ainda é ambígua:

{% highlight ragel %}
      CMD -> if ( exp ) CMD | CASAM-CMD
      CASAM-CMD -> if ( exp ) CASAM-CMD else CMD | outro
{% endhighlight %}

11\. Sinais de subtração unários podem ser acrescentados de diferentes
maneiras a uma gramática de expressões aritméticas. Modifique a gramática
da questão 8 de acordo com cada uma das especificações abaixo:

* No máximo um sinal unário permitido antes de qualquer termo, assim
  `-2--3` é legal (e igual a 1) mas `--2` e `-2---3` são ilegais.
* **Desafio**: no máximo um sinal unário de subtração permitido em cada expressão,
  e deve aparecer no início (`-2-3` é legal e igual a `-5`, `-2-(-3)` é
  legal, mas `-2--3` é ilegal).
* Uma quantidade arbitrária de sinais unários de subtração é permitida
  antes de qualquer termo, portanto todas as expressões acima são
  legais.

12\. Na gramática a seguir os não-terminais estão em maiúsculas e os
terminais em minúsculas, todos separados por espaços:

{% highlight ragel %}
    PROGRAMA -> begin LISTACMD end
    LISTACMD -> LISTACMD CMD 
               | CMD
    CMD      -> do id := num to num begin LISTACMD end
               | read id
               | write EXP
               | id := EXP
    EXP      -> EXP + EXP | EXP - EXP | num | id | ( EXP )
{% endhighlight %}

* Mostre a árvore sintática para o programa a seguir (pode abreviar os
  não-terminais assim: P, L, C, E, T):

{% highlight pascal %}
    begin
      read x
      do i := 1 to 100 begin
        x := x + i
      end
      write x
    end
{% endhighlight %}

* Qual a principal razão para essa gramática não ser LL(1)?
* Mostre que essa gramática é ambígua.
* Remova a ambiguidade dessa gramática.
* Reescreva a gramática para remover recursão à esquerda e fatorar prefixos comuns

13\. A gramática a seguir descreve um subconjunto da linguagem das expressões regulares (o
`|` do lado direito da primeira regra é o token do operador |):

{% highlight ragel %}
    RE -> RE | RE
    RE -> RE RE
    RE -> RE *
    RE -> ( RE )
    RE -> letra
{% endhighlight %}

* Use essa gramática para apresentar uma derivação da expressão regular `(ab|b)*`.
* Mostre que essa gramática é ambígua.
* Reescreva essa gramática para não ser mais ambígua, corrigindo as precedências dos operadores. Lembre-se que a concatenação tem precedência sobre o |, e a repetição (\*) tem precedência sobre esses dois. Faça a operação de concatenação ser associativa à **direita**.

14\. Dada a gramática `A -> ( A ) A | *vazio*`, escreva pseudocódigo para
analisá-la de forma recursiva com retrocesso local e sem retrocesso (LL(1)).

15\. Uma gramática LL(1) pode ser ambígua? Justifique.

16\. Uma gramática não ambígua precisa ser LL(1)? Justifique.

17\. Dadas as duas gramáticas a seguir:

{% highlight ragel %}
      LEXP -> ATOMO | LISTA
      ATOMO -> num | id
      LISTA -> ( LEXP-SEQ )
      LEXP-SEQ -> LEXP-SEQ LEXP | LEXP
{% endhighlight %}

{% highlight ragel %}
      DECL -> TIPO VAR-LISTA
      TIPO -> int | float
      VAR-LISTA -> id , VAR-LISTA | id
{% endhighlight %}

Remova a recursão esquerda, caso seja necessário, e 
escreva pseudo-código para um analisador recursivo para elas.

18\. Dada a gramática:

{% highlight ragel %}
    CMD -> ATRIB
    CMD -> CHAMADA
    CMD -> outro
    ATRIB -> id := exp
    CHAMADA -> id ( exp )
{% endhighlight %}

* Essa gramática é LL(1)? Justifique.
* Escreva o pseudocódigo para analisar essa gramática de forma recursiva sem retrocesso. Lembre-se de construir a árvore corretamente.

19\. Dada a gramática `A -> aAa | *vazio*`, demostre que essa gramática
não é LL(1), e mostre que o código a seguir não implementa corretamente
um analisador recursivo para essa gramática:

{% highlight java %}
    void A() {
      Tree res = new Tree("A");
      if(la().equals("a")) {
        res.child(match("a"));
        res.child(A());
        res.child(match("a"));
      } else if(!la().equals("<<EOF>>")) {
        error("erro de sintaxe!");
      }
      return res;
    }
{% endhighlight %}

20\. Considere a gramática a seguir, para um fragmento de Pascal:

{% highlight ragel %}
    LISTA -> LISTA ; CMD | CMD
    CMD -> id := EXP
    EXP -> id | id ( ) | num
{% endhighlight %}

Reescreva essa gramática para eliminar recursão à esquerda e prefixos comuns.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
