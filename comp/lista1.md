---
layout: default
title: Primeira Lista de Exercícios de Compiladores I
relpath: ..
---

Primeira Lista de Exercícios
============================

1\. Descreva as tarefas efetuadas pelos seguintes programas, e explique
como eles se assemelham ou se relacionam a compiladores:

* Um pré-processador C
* Um *pretty-printer* (formatador de programas)
* Um colorizador de programas de um editor de texto
* Um montador
* Um linkeditor do sistema operacional

2\. Explique qual a relação e para que servem expressões regulares,
autômatos finitos, tokens e lexemas.

3\. Construa um autômato finito para aceitar as palavras reservadas
**case**, **char**, **const** e **continue**.

4\. Considere os tokens:

* Números inteiros sem sinal
* Números reais sem sinal
* Operadores aritméticos: +, -, /, \*, (, )
* Operador de atribução: =
* Identificadores, onde são válidas apenas letras

Escreva regras usando expressões regulares e desenhe um
autômato finito para reconhecer os tokens acima.

5\. Escreva uma gramática sem ambiguidades que gere o conjunto de
cadeias de caracteres {s;, s;s;, s;s;s;, ...}.

6\. Qual o problema causado por aninhamento de comentários em um analisador
léxico gerado a partir de expressões regulares?

7\. O seguinte trecho de código Java é responsável por ler e ignorar
comentários em um analisador léxico de Pascal escrito à mão:

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

8\. Dada a gramática (o caractere | separa as regras do mesmo não-terminal):

{% highlight ragel %}
      A -> AA | (A) | *vazio*
{% endhighlight %}

Descreva a linguagem que ela gera, e mostre que ela é ambígua.

9\. Dada a gramática:

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

10\. Escreva uma gramática para expressões boolenas contendo as
constantes **true** e **false** e os operadores &&, || e !, além de
parênteses. O operador || tem precedência menor que &&, e este menor que
!. A gramática não pode ser ambígua.

11\. Mostre que a seguinte tentativa de resolução da ambiguidade do else
ainda é ambígua:

{% highlight ragel %}
      CMD -> if ( exp ) CMD | CASAM-CMD
      CASAM-CMD -> if ( exp ) CASAM-CMD else CMD | outro
{% endhighlight %}

12\. Sinais de subtração unários podem ser acrescentados de diferentes
maneiras a uma gramática de expressões aritméticas. Modifique a gramática
da questão 9 de acordo com cada uma das especificações abaixo:

* No máximo um sinal unário de subtração permitido em cada expressão,
  e deve aparecer no início (-2-3 é legal e igual a -5, -2-(-3) é
  legal, mas -2--3 é ilegal).
* No máximo um sinal unário permitiod antes de qualquer termo, assim
  -2--3 é legal (e igual a -1) mas --2 e -2---3 são ilegais.
* Uma quantidade arbitrária de sinais unários de subtração é permitida
  antes de qualquer termo, portanto todas as expressões acima são
  legais.

13\. Na gramática a seguir os não-terminais estão em maiúsculas e os
terminais em minúsculas, todos separados por espaços (estilo BNF):

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

Mostre a árvore sintática para o programa a seguir (pode abreviar os
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

14\. Dada a gramática `A -> (A)A | *vazio*`, escreva pseudocódigo para
analisá-la de forma recursiva.

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

18\. Da a gramática `A -> aAa | *vazio*`, demostre que essa gramática
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

19\. Considere a gramática a seguir, para um fragmento de Pascal:

{% highlight ragel %}
    LISTA -> LISTA ; CMD | CMD
    CMD -> id := EXP
    EXP -> id | id ( ) | num
{% endhighlight %}

Reescreva essa gramática para eliminar recursão à esquerda e prefixos comuns.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
