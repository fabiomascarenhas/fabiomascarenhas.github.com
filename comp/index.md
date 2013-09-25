---
layout: default
title: MAB 471 - Compiladores I
relpath: ..
---

MAB 471 - Compiladores I
------------------------

### Apresentação

Está é a página da disciplina Compiladores I, MAB 471, do professor
Fabio Mascarenhas, para o semestre de *2013.2*. As aulas da disciplina são
às segundas e quartas, das 15 às 17 horas, na sala DCC.

### Avaliação

A avaliação será feita por provas e por pequenos trabalhos práticos. A
nota das provas corresponderá a 80% da nota final (8 pontos) e a dos
trabalhos a 20% (2 pontos). Serão três provas, uma na metade do período
e as outras duas no final, e será feita uma média aritmética das duas
maiores notas. Não haverá prova final ou segunda chamada. A média
final é 5,0. As datas das provas, assim como os detalhes dos trabalhos
práticos, serão definidos posteriormente.

### Datas das Provas

P1: 16/10/2013

P2: 11/12/2013

P3: 18/12/2013

As provas serão feitas ou na sala DCC, no mesmo horário da aula.

### Trabalhos Práticos

Os trabalhos práticos correspondem às diferentes fases de um
compilador de [TINYPy](tinypy.html). Os trabalhos podem ser feitos
individualmente ou em dupla. As mesmas duplas valerão para todos
os quatro trabalhos, exceto em casos de trancamento ou abandono, que serão
resolvidos caso a caso.

#### Analisador Léxico

Cada dupla deverá fazer a especificação de um analisador léxico para
a linguagem [TINYPy](tinypy.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](TINYPyLex.zip), e leia com atenção o arquivo
`tinypy.jpage`. 

A entrega do trabalho deverá ser feita até o dia 16/10/2013, uma
quarta-feira, em formato zip, usando [esse
formulário](http://form.jotformz.com/form/32666398519671).

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador léxico é só perguntar por email ou no
nosso grupo.

### Lista de Discussão

Temos um grupo no Facebook para perguntas e avisos sobre a matéria.
Acessem [aqui](http://www.facebook.com/groups/compiladoresI/).

### Livros

O livro texto da disciplina é o "Compiladores: princípios e práticas",
de Kenneth C. Louden. Ele está disponível na biblioteca do CCMN.

"Crafting a Compiler with C" de Charles Fischer também tem uma boa
cobertura dos aspectos práticos da construção de um compilador, e está
disponível na biblioteca do CT e do NCE.

Um excelente livro para quem quiser se aprofundar mais sobre o tema é a
segunda edição do "Engineering a Compiler", de Keith D. Cooper e Linda
Torczon. Infelizmente ele não está disponível em nenhuma das bibliotecas
da UFRJ.

Um bom livro que explica a construção de um compilador usando Java é o 
"Modern Compiler Implementation in Java", de Appel e Palsberg. É um 
bastante sintético, mas que também vai além do assunto coberto no curso.

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

### Notas de Aula

#### Slides

* [Introdução](01Introducao.pdf)
* [Análise Léxica - Expressões Regulares](02AnaliseLexica.pdf)
* [Análise Léxica - Autômatos Finitos](03Automatos.pdf)
* [Análise Léxica - JFlex](04JFlex.pdf)
* [Gramáticas, Derivações, Árvores e Ambiguidade](05Gramaticas.pdf) - atualizado 09/09/2013
* [Especificando Sintaxe e EBNF](06Sintaxe.pdf)
* [Análise Recursiva com Retrocesso](07Recursiva.pdf)
* [Análise Preditiva](08Preditiva.pdf)

#### Código fonte

* [Compilador de sequência de comandos simples](CmdSimp.zip)
* [Notas de aula executáveis para análise autômatos léxica](Lexico.zip) - atualizado em 28/08/2013
* [Analisador Léxico usando JFlex para comandos simples](CmdSimp_JFlex.zip)
* [Notas de aula executáveis para gramáticas e análise sintática](Parsing.zip)
* [Analisador Recursivo com Retrocesso para TINY](Tiny_Rec.zip)
* [Analisador Recursivo Preditivo para TINY](Tiny_Pred.zip)
* [Analisador Recursivo Preditivo com árvore recursiva à esquerda para TINY](Tiny_Pred_RecEsq.zip)

### Curiosidades

#### Embedded in Academia: 57 Small Programs that Crash Compilers

It’s not clear how many people enjoy looking at programs that make
compilers crash — but this post is for them (and me). Our paper on
producing reduced test cases for compiler bugs contained a large table
of results for crash bugs. Below are all of C-Reduce’s reduced programs
for those bugs. [Ler esse
artigo...](http://blog.regehr.org/archives/696)

#### Lexical Scanning in Go

Vídeo do Rob Pike mostrando como construir um analisador léxico
manualmente, usando a linguagem Go, e como isso é preferível em relação
a usar um gerador de analisadores léxicos.

<iframe width="560" height="315" src="http://www.youtube.com/embed/HxaD_trXwRE" frameborder="0" allowfullscreen="1">
dummy
</iframe>

### Contato

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
de alunos na minha sala, segundas e quartas de 17 às 18 horas. A sala é
responderei assim que possível. Também tenho um horário de atendimento
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
