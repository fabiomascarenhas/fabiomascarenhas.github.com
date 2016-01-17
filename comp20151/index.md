---
layout: default
title: MAB 471 - Compiladores I
relpath: ..
---

MAB 471 - Compiladores I
------------------------

### Apresentação

Está é a página da disciplina Compiladores I, MAB 471, do professor
Fabio Mascarenhas, para o semestre de *2015.1*. As aulas da disciplina são
às segundas e quartas, das 10 às 12 horas, na sala 29 do bloco F2 do CCMN.

### Avaliação

A avaliação será feita por provas e por pequenos trabalhos práticos. A
nota das provas corresponderá a 80% da nota final (8 pontos) e a dos
trabalhos a 20% (2 pontos). Serão três provas, uma na metade do período
e as outras duas no final, e será feita uma média aritmética das duas
maiores notas. Não haverá prova final ou segunda chamada. A média
final é 5,0. As datas das provas, assim como os detalhes dos trabalhos
práticos, serão definidos posteriormente.

### Datas das Provas

P1: 13/05/2015

P2: 08/07/2015

P3: 15/07/2015

Todas as provas serão feitas no mesmo horário e local das aulas, e sempre às quartas-feiras.

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

A entrega do trabalho deverá ser feita até as 23:59 do dia 25/05/2015, usando [esse
email](mailto:fabio44vial@emailitin.com). Mande apenas o arquivo .jflex como anexo.
Inclua os nomes da dupla no assunto do email e no nome do arquivo (por exemplo,
se o trabalho foi feito pelo João e pela Maria, o assunto deve ser "Analisador Léxico de João e Maria"
e o arquivo anexado deve ser "minijava_joao_maria.jflex").

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador léxico é só perguntar por email ou no
nosso grupo.

### Analisador Sintático

Cada dupla deverá fazer a especificação de um analisador sintático para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](MiniJavaParse.zip), e leia com atenção o arquivo
`minijava.jpage`.

Cada dupla deverá fazer a especificação de um analisador sintático para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab2/MiniJavaParse.zip), e leia com atenção o arquivo
`minijava.jpage`.

A entrega do trabalho deverá ser feita até o dia 10/06/2015, uma
quarta-feira, usando [esse
email](mailto:fabio44vial@emailitin.com). Mande apenas o arquivo .jacc como anexo.
Inclua os nomes da dupla no assunto do email e no nome do arquivo (por exemplo,
se o trabalho foi feito pelo João e pela Maria, o assunto deve ser "Analisador Sintático de João e Maria"
e o arquivo anexado deve ser "minijava_joao_maria.jacc").

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador sintático é só perguntar por email ou no
nosso grupo.

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador sintático é só perguntar por email ou no
nosso grupo.

### Analisador de Tipos

Cada dupla deverá terminar a implementação da análise de tipos para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](MiniJavaType.zip), e leia com atenção o arquivo
`minijava.jpage`.

A entrega do trabalho deverá ser feita até o dia **01/07/2015**, uma
quarta-feira, [esse
email](mailto:fabio44vial@emailitin.com). Mande apenas um arquivo `.zip` com
os arquivos `.java` que você modificou ou criou como anexo.
Inclua os nomes da dupla no assunto do email e no nome do arquivo (por exemplo,
se o trabalho foi feito pelo João e pela Maria, o assunto deve ser "Analisador de Tipos de João e Maria"
e o arquivo anexado deve ser "minijava_joao_maria.zip").

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador de tipos é só perguntar por email ou no
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
da UFRJ. Há uma edição em português com o título "Construindo Compiladores",
mas ainda não tive acesso a ela para verificar a qualidade da tradução.

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

Publicarei slides e notas de aula nessa seção no decorrer do curso.

#### 16/03 - [Slides](01Introducao.pdf), [compilador de comandos simples](CmdSimp.zip)
#### 18/03 - [Slides](02AnaliseLexica.pdf), [notas de aula executáveis](Lexico.zip), [compilador de comandos simples com analisador de expressões regulares](CmdSimpRE.zip)
#### 23/03 - [Slides](03Automatos.pdf), [notas de aula executáveis](Lexico.zip)
#### 25/03 - [Slides](04JFlex.pdf), [notas de aula executáveis](Lexico.zip), [compilador de comandos simples com analisador JFlex](CmdSimpJF.zip), [JFlex](jflex.zip)
#### 30/03 - [Slides](05Gramaticas.pdf), [notas de aula executáveis](Parsing.zip)
#### 01/04 - [Slides](06Sintaxe.pdf), [reconhecedor recursivo para TINY](TINYRec.zip)
#### 06/04 - [Slides](07Recursiva.pdf), [analisador recursivo para TINY que gera árvore](TINYRecTree.zip)
#### 08/04 - [Slides Análise Preditiva](08Preditiva.pdf), [slides LL(1)](09LL1.pdf) [analisador preditivo para TINY](TINYPred.zip)
#### 13/04 - [Slides](09LL1.pdf), [analisador LL(1) de tabela para TINY](TINYLL1.zip)
#### 27/04 e 29/04 - [Slides](10Ascendente.pdf), [notas de aula executáveis](Parsing.zip)
#### 04/05 - [Slides](11SLR.pdf), [notas de aula executáveis](Parsing.zip)
#### 06/05 - [Slides](12ActionGoto.pdf), [notas de aula executáveis](Parsing.zip), [analisador SLR para TINY](TINYSLR.zip)
#### 11/05 - Revisão para a P1: [Slides](RevisaoP1.pdf), [notas](RevisaoP1.zip)
#### 20/05 - [Slides](13JACC.pdf), [analisador JACC para TINY](TINYJACC.zip)
#### 25/05 e 27/05 - [Slides](14Semantica.pdf), [TINY com variáveis locais](TINYEscopo.zip), [TINY com procedimentos](TINYEscopoProc.zip)
#### 03/06 e 08/06 - [Slides](15Tipos.pdf), [TINY com tipos em variáveis](TINYTiposVar.zip), [TINY com tipos em procedimentos](TINYTiposProc.zip)
#### 10/06 e 15/06 - [Slides](16Ambiente.pdf)
#### 17/06 e 22/06 - [Slides](17Codigo.pdf), [Gerador de código para TINY com procedimentos](TINYCodigo.zip)
#### 24/06 - [Slides](18Registros.pdf), [TINY com registros com subtipagem estrutural](TINYRegistros.zip)
#### 29/06 - [Slides](19Variantes.pdf), [TINY com variantes e registros com subtipagem nominal](TINYVariantes.zip)
#### 01/07 - [Slides](20Classes.pdf), [TINY com classes, herança simples e métodos virtuais](TINYClasses.zip)
#### 06/07 - Revisão para a P2: [notas](RevisaoP2.pdf)

### Listas de Exercício

#### [Primeira lista](lista1.html) - exercícios cobrindo o assunto da P1
#### [Segunda lista](lista2.html) - exercícios cobrindo o assunto da P2

### Provas

#### [Primeira prova](p1.pdf) - [gabarito](gabaritop1.pdf)

### Contato

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
de alunos na minha sala, segundas e quartas de 17 às 18 horas. A sala é
responderei assim que possível. Também tenho um horário de atendimento
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
