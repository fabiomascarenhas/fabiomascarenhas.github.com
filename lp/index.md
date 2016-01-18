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
Fabio Mascarenhas, para o semestre de *2015.2*. As aulas da disciplina são
às segundas e quartas, das 13 às 15 horas.

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
e funções de primeira ordem; lvalues vs. rvalues; a essência da programação em objetos.

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

P1: 16/12/2015

P2: 02/03/2016

P3: 09/03/2016

As provas serão feitas no mesmo horário da aula.

Lista de Discussão
------------------

Temos um grupo no Facebook para perguntas e avisos sobre a matéria.
Acessem [aqui](https://www.facebook.com/groups/lpufrj).

Livros
------

Uma boa referência para os assuntos das nossas primeiras aulas, sobre programação funcional,
é o capítulo 1 do
[Structure of Interpretation of Computer Programs](http://mitpress.mit.edu/sicp/full-text/book/book.html),
de Abelson e Sussman. 

Não existe um livro texto único para essa disciplina. O que mais se aproxima disso é
a segunda parte (do capítulo 15 em diante) do livro [Programming and Programming Languages](http://papl.cs.brown.edu/2015),
de Shriram Krishnamurthi, por adotar a estratégia de explicar conceitos de linguagens
de programação através do estudo de pequenos interpretadores. Outro livro que adota
a mesma estratégia é o [Essentials of Programming Languages](http://www.eopl3.com/), de
Friedman e Wand. 

Os livros acima usam respectivamente [Pyret](http://www.pyret.org) e [Racket](http://racket-lang.org/) como linguagens
de implementação dos seus interpretadores, enquanto vamos usar [Scala](http://www.scala-lang.org/),
que tem uma sintaxe mais familiar para programadores C e Java que Racket, e ferramentas mais robustas
do que Pyret. O curso de [programação funcional com Scala](https://www.coursera.org/course/progfun) do criador
da linguagem, Martin Odersky, é um bom tutorial para o subconjunto de Scala que
vamos usar.

Provavelmente o melhor livro para uma visão de alto nível dos conceitos de linguagens de
programação é o [Programming Language Pragmatics](http://www.cs.rochester.edu/~scott/pragmatics/), de
Michael Scott. É uma boa referência para resumos de vários temas que serão cobertos em sala.

Notas de Aula
-------------

As notas de aula serão publicadas aqui no decorrer do semestre.

#### 14/10 - [Slides](Aula01.pdf), [projeto Eclipse](Aula01.zip)
#### 19/10 - [Slides](Aula02.pdf), [projeto Eclipse](Aula02.zip)
#### 21/10 - [Slides](Aula03.pdf), [projeto Eclipse](Aula03.zip)
#### 04/11 - [Slides](Aula04.pdf), [projeto Eclipse](Aula04.zip)
#### 11/11 - [Slides](Aula05.pdf), [projeto Eclipse](Aula05.zip)
#### 16/11 - [Slides](Aula06.pdf), [projeto Eclipse](Aula06.zip)
#### 23/11 - [Slides](Aula07.pdf), [projeto Eclipse](Aula07.zip)
#### 25/11 - [Slides](Aula08.pdf), [projeto Eclipse](Aula08.zip)
#### 30/11 - [Slides](Aula09.pdf), [projeto Eclipse](Aula09.zip)
#### 02/12 - [Slides](Aula10.pdf), [projeto Eclipse](Aula10.zip)
#### 07/12 - [Slides](Aula11.pdf), [projeto Eclipse](Aula11.zip)
#### 09/12 e 14/12 - Revisão para a P1
#### 04/01 - [Slides](Aula12.pdf), [projeto Eclipse](Aula12.zip)
#### 06/01 - [Slides](Aula13.pdf), [projeto Eclipse](Aula13.zip), SML/NJ (smlnj.msi)
#### 11/01 - [Slides](Aula14.pdf), [projeto Eclipse](Aula14.zip)
#### 13/01 - [Slides](Aula15.pdf), [projeto Eclipse](Aula15.zip)
#### 18/01 - [Slides](Aula16.pdf), [projeto Eclipse](Aula16.zip)

Listas de Exercício
-------------------

As listas de exercício são sempre individuais, a não ser que seja dito
o contrário para alguma lista.

#### 24/10/2015 - [Primeira Lista](lista1.html), entrega até **03/11/2015**, [respostas](lista1_respostas.zip)
#### 18/11/2015 - [Segunda Lista](lista2.html), entrega até **02/12/2015**, [respostas](lista2_respostas.zip)
#### 04/12/2015 - [Terceira Lista](lista3.html), entrega até **18/12/2015**

### Provas

#### [Primeira Prova](p1.pdf) e [gabarito](p1_gabarito.pdf)

Instalando Scala
----------------

Recomendo o download da IDE (ambiente integrado de desenvolvimento) para Scala baseado
em Eclipse, a [Scala IDE](http://scala-ide.org), que é o que usarei em sala. O
código fonte que acompanha as notas de aula será fornecido como projetos que poderão
ser importados diretamente na IDE.

Contato
-------

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
responderei assim que possível. Também tenho um horário de atendimento
de alunos na minha sala, segundas e quartas de 15 às 16 horas. A sala é
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
