---
layout: default
title: Linguagens de Programação
relpath: ..
---

Linguagens de Programação
=========================

Apresentação
------------

Está é a página da disciplina Linguagens de Programação, do professor
Fabio Mascarenhas, para o semestre de 2013.1. As aulas da disciplina são
às segundas e quartas, das 10 às 12 horas.

O objetivo dessa disciplina é expor os alunos aos diferentes paradigmas
de programação, mostrando a eles o que está "atrás da cortina" desses
paradigmas. Os alunos aprenderão como a maneira de funcionamento das 
linguagens com as quais eles já estão familizarizados é apenas uma possibilidade
em um grande espaço de linguagens possíveis. Para isso faremos tanto o
estudo de "linguagens símbolo" dos diferentes paradigmas, quanto a construção
e estudo de pequenos interpretadores para linguagens que são exemplos estilizados
dos mesmos paradigmas.

Os alunos precisam ter uma boa desenvoltura com programação, em especial com
estruturas de dados e funções recursivas. Não é necessário conhecimento da teoria
de linguagens formais, ou de técnicas de compilação; o enfoque desse curso é o 
comportamento das linguagens e não análise sintática ou geração de código.

Ementa
------

Introdução à programação funcional pura; programação funcional com
*Scala*: funções como valores, case classes, pattern matching; padrões de programação
funcional: listas, mapas e folds; o interpretador de *fun*, uma mini-linguagem funcional;
regras de escopo de seu efeito em funções de primeira classe; acrescentando tipos
a fun; o familiar revisitado: *microC*, uma linguagem imperativa com ponteiros
e funções de primeira ordem; lvalues vs. rvalues; programação OO destilada: a linguagem
*Smalltalk*; classes e metaclasses; um interpretador para Smalltalk.

Avaliação
---------

A avaliação será feita por provas e por pequenos trabalhos práticos. A
nota das provas corresponderá a 60% da nota final (6 pontos) e a dos
trabalhos a 40% (4 pontos). Serão três provas, uma na metade do período
e as outras duas no final, e será feita uma média aritmética das duas
maiores notas. Não haverá prova final ou segunda chamada. A média
final é 5,0.

Datas das Provas
----------------

P1: 03/06/2013

P2: 05/08/2013

P3: 07/08/2013

As provas serão feitas ou na sala DLC ou na sala DCC, a depender da disponibilidade,
no mesmo horário da aula.

Lista de Discussão
------------------

Temos um grupo no Facebook para perguntas e avisos sobre a matéria.
Acessem [aqui](https://www.facebook.com/groups/lpufrj).

Livros
------

Uma boa referência para os assuntos das nossas primeiras aulas, sobre programação funcional,
é o capítulo 1 do
[Structure of Interpretation of Computer Programs](http://mitpress.mit.edu/sicp/full-text/book/book.html),
de Abelson e Sussman. Algumas seções do resto do livro têm informações
sobre outros assuntos que vamos ver durante o curso, que irei passando aqui
à medida que forem sendo cobertos.

Não existe um livro texto único para essa disciplina. O que mais se aproxima disso é
o [Programming Languages: Application and Interpretation](http://cs.brown.edu/~sk/Publications/Books/ProgLangs/),
de Shriram Krishnamurthi, por adotar a estratégia de explicar conceitos de linguagens
de programação através do estudo de pequenos interpretadores. Outro livro que adota
a mesma estratégia é o [Essentials of Programming Languages](http://www.eopl3.com/), de
Friedman e Wand. 

Os livros acima usam [Racket](http://racket-lang.org/) como linguagem
de implementação dos seus interpretadores, enquanto vamos usar [Scala](http://www.scala-lang.org/),
que tem uma sintaxe mais familiar para programadores C e Java. O curso de
[programação funcional com Scala](https://www.coursera.org/course/progfun) do criador
da linguagem, Martin Odersky, é um bom tutorial para o subconjunto de Scala que
vamos usar.

Provavelmente o melhor livro para uma visão de alto nível dos conceitos de linguagens de
programação é o [Programming Language Pragmatics](http://www.cs.rochester.edu/~scott/pragmatics/), de
Michael Scott. É uma boa referência para resumos de vários temas que serão cobertos em sala.

Exercícios e Trabalhos
----------------------

* [Primeira lista](lista1.html) - prazo de entrega: **26/04/2013**, [respostas](Lista1Res.zip)
* [Segunda lista](lista2.html) - prazo de entrega: **02/06/2013**, respostas na página
* [Terceira lista](lista3.html) - prazo de entrega: **15/07/2013**
* [Quarta lista](lista4.html) - prazo de entrega: **02/08/2013**, respostas na página

Provas
------

* [P1](p1.pdf) e [gabarito](p1_gabarito.html)
* [P2](p2.pdf) e [gabarito](p2_gabarito.html)

Notas de Aula
-------------

### Slides

* [01/04/2013](Aula1.pdf)
* [03/04/2013](Aula2.pdf)
* [08/04/2013](Aula3.pdf)
* [10/04/2013](Aula4.pdf)
* [15/04/2013](Aula5.pdf)
* [17/04/2013](Aula6.pdf)
* [29/04/2013](Aula7.pdf)
* [06/05/2013](Aula8.pdf)
* [08/05/2013](Aula9.pdf)
* [13/05/2013](Aula10.pdf)
* [15/05/2013](Aula11.pdf)
* [20/05/2013](Aula12.pdf)
* [22/05/2013](Aula13.pdf)
* [27/05/2013](Aula14.pdf)
* 29/05/2013 - revisão para P1
* [05/06/2013](Aula15.pdf)
* [10/06/2013](Aula16.pdf)
* [12/06/2013](Aula17.pdf)
* [17/06/2013](Aula18.pdf)
* [19/06/2013](Aula19.pdf)
* [24/06/2013](Aula20.pdf)
* [26/06/2013](Aula21.pdf)
* [01/07/2013](Aula22.pdf) - **slides novos**
* [03/07/2013](Aula23.pdf) - **slides novos**
* [31/07/2013](aula3107.html) - revisão para P2

### Logs do console

* [03/04/2013](aula2_log.txt)

### Projetos Eclipse

* [Código das aulas](aulas.zip) - **atualizado a cada aula**

Instalando Scala
----------------

As instruções completas para instalação da distribuição de Scala estão em
 [Typesafe Stack Download](http://typesafe.com/stack/download-agreed). A
 IDE Scala para Eclipse está [aqui](http://www.typesafe.com/stack/downloads/scala-ide).

Se quiser um links diretso para Windows, baixe o instalador do `sbt`
 [aqui](http://downloads.typesafe.com/typesafe-stack/2.0.2/typesafe-stack-2.0.2.exe), e 
 a IDE Scala
 [aqui](http://downloads.typesafe.com/scalaide-pack/3.0.0.vfinal-210-20130326/scala-SDK-3.0.0-vfinal-2.10-win32.win32.x86.zip).

Contato
-------

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
responderei assim que possível. Também tenho um horário de atendimento
de alunos na minha sala, segundas e quartas de 17 às 18 horas. A sala é
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
