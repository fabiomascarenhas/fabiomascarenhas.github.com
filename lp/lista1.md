---
layout: default
title: Linguagens de Programação - Primeira Lista de Exercícios
relpath: ..
---

Primeira Lista de Exercícios
============================

Introdução
----------

Baixe o [projeto da lista](lista1.zip), importe ele na Scala IDE (Eclipse), e implemente as funções
correspondentes a cada questão do exercício. Depois envie
apenas o arquivo `package.scala` com os fontes da sua implementação até **03/11/2015**,
usando [esse link](https://www.dropbox.com/request/nHXVKjfu7KIAFIgLmhQk).

Questão 1 - Triângulo de Pascal
-------------------------------

O *triângulo de Pascal* é uma representação gráfica dos coeficientes dos binômios `(x+y)^n`.
Cada linha do triângulo lista os coeficientes do seu respectivo binônio (contado a partir de 0).

![Triângulo de Pascal](http://upload.wikimedia.org/math/6/8/7/68716cad06e288afb1ed5266c711b66b.png)

Os números nos lados do triângulo são sempre 1, e cada número do interior do triângulo é a soma dos dois
números acima dele. Implemente uma função em Scala que calcula coeficientes do triângulo de Pascal, dada
sua posição no triângulo, contada a partir de 0:

    def pascal(col: Int, lin: Int): Int = ???

Questão 2 - Parênteses Balanceados
----------------------------------

Escreva uma função que verifica se os parênteses presentes em uma lista de caracteres estão balanceados. Note que
não basta contar o número de `(` e `)`, pois listas como `List(')','(')` e `List('(',')',')','(')` não são
balanceadas.

    def balanceado(l: List[Char]): Boolean = ???

Para facilitar o teste use a função `toList` de Scala, que converte uma string em uma lista de caracteres:

    > balanceado("so (um (teste) (da funcao) ) ".toList)
    res0: Boolean = true

Use recursão final na sua resposta.

Questão 3 - Quicksort
---------------------

A ideia do algoritmo de ordenação *quicksort* é bem simples: escolhemos um elemento *pivô* de uma lista
(o primeiro elemento, por exemplo), e *particionamos* a lista usando esse pivô em duas listas. A primeira
lista tem todos os elementos menores ou iguais ao pivô, e a segunda lista todos os elementos maiores que
o pivô. Então basta ordenar essas duas listas e concatenar o resultado.

Escreva a função `particao` que particiona uma lista dado um elemento pivô:

    def particao(l: List[Int], pivo: Int): (List[Int], List[Int]) = ???

Escreva a função `quicksort` para ordenar uma lista, usando a função de partição que você escreveu:

    def quicksort(l: List[Int]): List[Int] = ???

Questão 4 - CR acumulado
------------------------

Podemos representar as notas de um aluno da UFRJ em dado semestre como uma lista de pares
*(nota,creditos)*:

    > val sem1 = List((9.5,3),(7.3,4),(5.0,3),(4.0,4))
    sem1: List[(Double, Int)] = List((9.5,3), (7.3,4), (5.0,3), (4.0,4))

O coeficiente de rendimento (CR) de um aluno em determinado semestre é a média ponderada
de suas notas, com o peso de cada uma sendo o número de créditos da matéria.

Escreva a função `crSemestre` que recebe as notas do aluno no semestre e retorna seu
CR para aquele semestre e o número de créditos que o aluno cursou:

    def crSemestre(notas: List[(Double, Int)]): (Double, Int) = ???

As notas do aluno durante o curso podem ser representadas como uma lista de listas de notas
para cada semestre. O *CR acumulado* de um aluno em determinado momento do curso é uma média
ponderada dos CRs de cada semestre, com o peso sendo o número de créditos cursado naquele
semestre.

Escreva a função `crsAcumulados` que recebe a lista de listas de notas para cada semestre e
retorna uma lista com o CR acumulado para o aluno após cada semestre (o CR acumulado
após o primero semestre é o CR do primeiro semestre), assim como o total de créditos cursados
até aquele momento.

    def crsAcumulados(semestres: List[List[(Double, Int)]]): (List[Double], Int) = ???

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

