---
layout: default
title: Linguagens de Programação - Segunda Lista de Exercícios
relpath: ..
---

Segunda Lista de Exercícios
===========================

Introdução
----------

Baixe o [projeto da lista](lista2.zip), importe ele na Scala IDE (Eclipse), e implemente as funções
correspondentes a cada questão do exercício. Depois envie
apenas o arquivo `package.scala` com os fontes da sua implementação até **02/12/2015**,
usando [esse link](https://www.dropbox.com/request/tTURRVoQuiRxvW4vKYtQ).

Questão 1 - Conjuntos usando funções de primeira classe
-------------------------------------------------------

Uma representação para conjuntos é pela sua *função característica*, uma função
que diz se um elemento pertence ao conjunto ou não. Em Scala, um conjunto de
elementos de um tipo `T` pode ser então dado pelo tipo de funções de `T` para
booleanos:

    type Conjunto[T] = T => Boolean

Por exemplo, o conjunto dos inteiros pares pode ser dado por `(x: Int) => x % 2 == 0`.
Dada essa definição para conjuntos, a definição de uma função que verifica se um
conjunto contém ou não um elemento é trivial:

    def contem[T](conj: Conjunto[T], elem: T) = conj(elem)

a) Defina uma função `unitario` que cria um conjunto unitário:

    def unitario[T](elem: T): Conjunto[T] = ???
    
b) Defina as funções `uniao`, `intesercao` e `diferenca`, que fazem a união,
interseção e diferença de dois conjuntos:

    def uniao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 	
    def intersecao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 	
    def diferenca[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 
    
c) Defina a função `filtro` que retorna um conjunto contendo apenas os elementos do
conjunto que passam pelo filtro:

    def filtro[T](c: Conjunto[T], f: T => Boolean): Conjunto[T] = ???	
    
d) Defina a função `map` que transforma um conjunto de elementos de tipo `T` em um
conjunto de elementos de tipo `U`, dada uma função de mapeamento `U => T`:

    def map[T, U](c: Conjunto[T], f: U => T): Conjunto[U] = ???	
    
e) Por que a função de mapeamento para conjuntos tem os tipos trocados em relação à sua
equivalente no `map` de listas? Responda em um comentário acima de sua implementação de `map`.
	
Questão 2 - Conjuntos como um tipo algébrico
--------------------------------------------

Uma outra representação para conjuntos é como uma árvore binária de busca, que em
Scala pode ser dada pelo tipo algébrico a seguir (para simplificar o problema,
vamos tratar apenas de conjuntos de números inteiros):

    trait ConjInt {
      def contem(x: Int): Boolean = ???
      def insere(x: Int): ConjInt = ???
      def uniao(outro: ConjInt): ConjInt = ???

      def filter(p: Int => Boolean): ConjInt = ???
      def map(f: Int => Int): ConjInt = ???
      def flatMap(f: Int => ConjInt): ConjInt = ???
    }
    case class ConjVazio() extends ConjInt
    case class ConjCons(elem: Int, esq: ConjInt, dir: ConjInt) extends ConjInt

Implemente os métodos que estão definidos no tipo `ConjInt`. Dica: a maneira mais
fácil de filtrar um conjunto é ir construindo um novo conjunto adicionando os elementos
que passam pelo predicado um a um.

Com as funções `filter`, `map` e `flatMap` é possível usar a notação `for` com geradores
do tipo `ConjInt`. Implemente a função `intersecao(c1: ConjInt, c2: ConjInt): ConjInt`
usando a notação `for` para filtrar o produto cartesiano dos dois conjuntos. 
	
* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

