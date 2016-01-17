---
layout: default
title: MAB 471 - Compiladores I
relpath: ..
---

MAB 471 - Compiladores I
------------------------

### Apresentação

Está é a página da disciplina Compiladores I, MAB 471, do professor
Fabio Mascarenhas, para o semestre de *2015.2*. As aulas da disciplina são
às segundas e quartas, das 10 às 12 horas, na sala 29 do bloco F2 do CCMN.

### Avaliação

A avaliação será feita por provas e por pequenos trabalhos práticos. A
nota das provas corresponderá a 80% da nota final (8 pontos) e a dos
trabalhos a 20% (2 pontos). Serão três provas, uma na metade do período
e as outras duas no final, e será feita uma média aritmética das duas
maiores notas. Não haverá prova final ou segunda chamada. A média
final é 5,0. 

### Datas das Provas

P1: **14/12/2015**

P2: 02/03/2016

P3: 09/03/2016

Todas as provas serão feitas no mesmo horário e local das aulas.

### Trabalhos Práticos

Os trabalhos práticos correspondem às diferentes fases de um
compilador de [MiniJava](minijava.html). Os trabalhos podem ser feitos
individualmente ou em dupla. As mesmas duplas valerão para todos
os quatro trabalhos, exceto em casos de trancamento ou abandono, que serão
resolvidos caso a caso.

#### Analisador Léxico

Cada dupla deverá fazer a especificação de um analisador léxico para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](MiniJavaLex.zip), e leia com atenção o arquivo
`minijava.jpage`. O arquivo .zip do projeto já inclui uma cópia do JFlex,
com um arquivo .bat para executá-lo.

A entrega do trabalho deverá ser feita até as 23:59 do dia 20/11/2015, usando [esse
formulário](https://www.dropbox.com/request/Yc5W5jnrS1QlrcCpclbO). Mande apenas o arquivo .jflex como anexo.
Inclua os nomes da dupla no nome do arquivo (por exemplo,
se o trabalho foi feito pelo João e pela Maria, o arquivo anexado deve ser "minijava_joao_maria.jflex").

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador léxico é só perguntar por email ou no
nosso grupo.

#### Analisador Sintático

Cada dupla deverá completar a especificação de um analisador sintático para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](MiniJavaParse.zip), e leia com atenção o arquivo
`minijava.jpage`. O arquivo .zip do projeto já inclui uma cópia do JACC,
com um arquivo .bat para executá-lo.

A entrega do trabalho deverá ser feita até as 23:59 do dia 03/02/2016, usando [esse
formulário](https://www.dropbox.com/request/yviKYBMv5RvZwPvTCh7A). Mande apenas o arquivo .jacc como anexo.
Inclua os nomes da dupla no nome do arquivo (por exemplo,
se o trabalho foi feito pelo João e pela Maria, o arquivo anexado deve ser "minijava_joao_maria.jacc").

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador sintático é só perguntar por email ou no
nosso grupo.

### Lista de Discussão

Temos um grupo no Facebook para perguntas e avisos sobre a matéria.
Acessem [aqui](http://www.facebook.com/groups/compiladoresI/).

### Livros

O livro texto da disciplina é o "Compiladores: princípios e práticas",
de Kenneth C. Louden. Ele está disponível na biblioteca do CCMN.

Um excelente livro para quem quiser se aprofundar mais sobre o tema é a
segunda edição do "Engineering a Compiler", de Keith D. Cooper e Linda
Torczon. Infelizmente ele não está disponível em nenhuma das bibliotecas
da UFRJ. Há uma edição em português com o título "Construindo Compiladores",
mas ainda não tive acesso a ela para verificar a qualidade da tradução.

Um bom livro que explica a construção de um compilador usando Java é o
"Modern Compiler Implementation in Java", de Appel e Palsberg. É um
bastante sintético, mas que também vai além do assunto coberto no curso.

"Crafting a Compiler with C" de Charles Fischer também tem uma boa
cobertura dos aspectos práticos da construção de um compilador, e está
disponível na biblioteca do CT e do NCE.

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

Publicarei slides e notas de aula nessa seção no decorrer do curso.

#### 14/10 - [Slides](01Introducao.pdf), [compilador de comandos simples](CmdSimp.zip)
#### 19/10 - [Slides](02AnaliseLexica.pdf), [notas de aula executáveis](Lexico.zip), [compilador de comandos simples](CmdSimpRE.zip)
#### 21/10 - [Slides](03Automatos.pdf)
#### 04/11 - [Slides](04JFlex.pdf), [compilador de comandos simples](CmdSimpJF.zip)
#### 09/11 - [Slides](05GramaticasPt1.pdf)
#### 16/11 - [Slides - Gramáticas](05GramaticasPt2.pdf), [Slides - Especificando Sintaxe](06Sintaxe.pdf), [notas de aula executáveis](Parsing.zip)
#### 18/11 - [Slides](07RecursivaPt1.pdf), [analisador de TINY](TINYRec.zip)
#### 23/11 - [Slides](07Recursiva.pdf), [analisador de TINY](TINYRecArv.zip)
#### 25/11 - [Slides Análise Preditiva](08Preditiva.pdf), [Slides LL(1)](09LL1.pdf), [analisador de TINY](TINYPred.zip)
#### 30/11 - [Slides](10AscendentePt1.pdf), [analisador de TINY](TINYLL1.zip)
#### 02/12 - [Slides](10AscendentePt2.pdf), [notas de aula executáveis](Parsing.zip)
#### 09/12 - [Slides](RevisaoP1.pdf), [notas de aula executáveis](RevisaoP1.zip)
#### 04/01 - [Slides](11SLRPt1.pdf)
#### 06/01 - [Slides SLR](11SLRPt2.pdf), [Slides Tabela Action/Goto](12ActionGotoPt1.pdf)
#### 11/01 - [Slides Tabela Action/Goto](12ActionGotoPt2.pdf), [Slides JACC](13JACC.pdf), [analisador de TINY SLR](TINYSLR.zip), [analisador de TINY JACC](TINYJACC.zip), [notas de aula executáveis](Parsing.zip)
#### 13/01 - [Slides](14SemanticaPt1.pdf), [AST para TINY](TINYAST.zip)
#### 18/01 - [Slides](14SemanticaPt2.pdf), [análise de escopo para TINY com variáveis](TINYEscopo.zip), [análise de escopo para TINY com procedimentos](TINYEscopoProc.zip)

### Listas de Exercício

#### [Lista 1](lista1.html) - Cobrindo os assuntos da P1

### Provas

#### [Primeira Prova](p1.pdf) e [gabarito](gabarito_p1.pdf)

### Contato

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
responderei assim que possível. Também tenho um horário de atendimento
de alunos na minha sala, segundas e quartas de 15 às 16 horas. A sala é
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
