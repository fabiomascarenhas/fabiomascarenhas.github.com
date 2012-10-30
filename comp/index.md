---
layout: default
title: MAB 471 - Compiladores I
---

MAB 471 - Compiladores I
========================

Apresentação
------------

**Atenção! As aulas de Compiladores I para o semestre de 2012.2
começarão apenas na segunda-feira dia 22/10/2012.**

Está é a página da disciplina Compiladores I, MAB 471, do professor
Fabio Mascarenhas, para o semestre de 2012.2. As aulas da disciplina são
às segundas e quartas, das 15 às 17 horas, no LAB I do DCC.

Avaliação
---------

A avaliação será feita por provas e por pequenos trabalhos práticos. A
nota das provas corresponderá a 80% da nota final (8 pontos) e a dos
trabalhos a 20% (2 pontos). Serão três provas, uma na metade do período
e as outras duas no final, e será feita uma média aritmética das duas
maiores notas. Não haverá prova final ou segunda chamada. Ainda não
estabeleci a quantidade nem a natureza dos trabalhos práticos. A média
final é 5,0.

Datas das Provas
----------------

P1: 19/12/2012

P2: 27/02/2013

P3: 06/03/2013

Todas as provas caem na quarta-feira, e serão feitas no mesmo horário e
local das aulas (LAB I, 15-17).

Lista de Discussão
------------------

Temos um grupo no Facebook para perguntas e avisos sobre a matéria.
Acessem [aqui](http://www.facebook.com/groups/compiladoresI/).

Livros
------

O livro texto da disciplina é o "Compiladores: princípios e práticas",
de Kenneth C. Louden. Ele está disponível na biblioteca do CCMN.

"Crafting a Compiler with C" de Charles Fischer também tem uma boa
cobertura dos aspectos práticos da construção de um compilador, e está
disponível na biblioteca do CT e do NCE.

Um excelente livro para quem quiser se aprofundar mais sobre o tema é a
segunda edição do "Engineering a Compiler", de Keith D. Cooper e Linda
Torczon. Infelizmente ele não está disponível em nenhuma das bibliotecas
da UFRJ.

Existe farto material online sobre construção de compiladores, incluindo
livros completos. Um bem sintético e com ênfase em construção manual de
scanners e parsers recursivos é o livro "Compiler Construction" de
Niklaus Wirth, disponível [em PDF
aqui](http://www.ethoberon.ethz.ch/WirthPubl/CBEAll.pdf). Outro livro,
mais detalhista, é o "Basics of Compiler Design" de Torben Mogensen,
disponível [nessa
página](http://www.diku.dk/hjemmesider/ansatte/torbenm/Basics/).

Se conhecer algum outro livro e/ou material e quiser saber quanto à sua
aplicabilidade venha conversar comigo, poderei ajudá-lo.

Notas de Aula e Material Adicional
----------------------------------

### Compilador de expressões aritméticas

Os fontes para o compilador de expressões aritméticas mostrado nas aulas
de 22 e 24/10/2012 estão [aqui](SimpleExp.zip). O arquivo `LEIAME.txt`
tem uma descrição breve das classes do compilador, e `scrapbook.jpage`
tem código que exercita as classes.

### Notas de Aula

As notas da aula de 29/10/2012 estão [aqui](Lexico.zip).

Curiosidades
------------

### Lexical Scanning in Go

Vídeo do Rob Pike mostrando como construir um analisador léxico
manualmente, usando a linguagem Go, e como isso é preferível em relação
a usar um gerador de analisadores léxicos.

<iframe width="560" height="315" src="http://www.youtube.com/embed/HxaD_trXwRE" frameborder="0" allowfullscreen="1">
dummy
</iframe>

### Embedded in Academia: 57 Small Programs that Crash Compilers

It’s not clear how many people enjoy looking at programs that make
compilers crash — but this post is for them (and me). Our paper on
producing reduced test cases for compiler bugs contained a large table
of results for crash bugs. Below are all of C-Reduce’s reduced programs
for those bugs. [Ler esse
artigo...](http://blog.regehr.org/archives/696)

Contato
-------

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
responderei assim que possível. Também tenho um horário de atendimento
de alunos na minha sala, segundas e quartas de 17 às 18 horas. A sala é
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
