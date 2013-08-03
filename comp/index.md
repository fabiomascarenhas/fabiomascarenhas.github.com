---
layout: default
title: MAB 471 - Compiladores I
relpath: ..
---

MAB 471 - Compiladores I
========================

Apresentação
------------

Está é a página da disciplina Compiladores I, MAB 471, do professor
Fabio Mascarenhas, para o semestre de *2013.1*. As aulas da disciplina são
às segundas e quartas, das 15 às 17 horas, no LAB 2 do DCC.

Avaliação
---------

A avaliação será feita por provas e por pequenos trabalhos práticos. A
nota das provas corresponderá a 80% da nota final (8 pontos) e a dos
trabalhos a 20% (2 pontos). Serão três provas, uma na metade do período
e as outras duas no final, e será feita uma média aritmética das duas
maiores notas. Não haverá prova final ou segunda chamada. A média
final é 5,0. As datas das provas, assim como os detalhes dos trabalhos
práticos, serão definidos posteriormente.

Datas das Provas
----------------

P1: 27/05/2013

P2: 31/07/2013

P3: 07/08/2013

As provas serão feitas ou na sala DLC ou na sala DCC, a depender da disponibilidade,
no mesmo horário da aula.

Trabalhos Práticos
------------------

Os trabalhos práticos correspondem às diferentes fases de um
compilador de [MiniJava](minijava.html). Os trabalhos podem ser feitos
individualmente ou em dupla. As mesmas duplas valerão para todos
os quatro trabalhos, exceto em casos de trancamento ou abandono, que serão
resolvidos caso a caso.

### Analisador Léxico

Cada dupla deverá fazer a especificação de um analisador léxico para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab1/MiniJavaLex.zip), e leia com atenção o arquivo
`minijava.jpage`. 

A entrega do trabalho deverá ser feita até o dia 22/05/2013, uma
quarta-feira, em formato zip, usando [esse
formulário](http://form.jotformz.com/form/31195169709664).

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador léxico é só perguntar por email ou no
nosso grupo.

### Analisador Sintático

Cada dupla deverá fazer a especificação de um analisador sintático para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab2/MiniJavaParse.zip), e leia com atenção o arquivo
`minijava.jpage`. 

A entrega do trabalho deverá ser feita até o dia 26/06/2013, uma
quarta-feira, em formato zip, usando [esse
formulário](http://form.jotformz.com/form/31595194036659).

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador sintático é só perguntar por email ou no
nosso grupo.

### Analisador de Tipos

Cada dupla deverá terminar a implementação da análise de tipos para
a linguagem [MiniJava](minijava.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab3/MiniJavaType.zip), e leia com atenção o arquivo
`minijava.jpage`. 

A entrega do trabalho deverá ser feita até o dia **15/07/2013**, uma
segunda-feira, em formato zip, usando [esse
formulário](http://form.jotformz.com/form/31795773652668).

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador sintático é só perguntar por email ou no
nosso grupo.

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

Notas de Aula
-------------

### Slides

* [Introdução](01Introducao.pdf)
* [Análise Léxica - Expressões Regulares](02AnaliseLexica.pdf)
* [Análise Léxica - Autômatos](03Automatos.pdf)
* [Análise Léxica - JFlex](04JFlex.pdf)
* [Análise Sintática - Gramáticas](05Gramaticas.pdf)
* [Análise Sintática - Especificação e Analisador Recursivo](06Sintaxe.pdf)
* [Análise Sintática - Analisador Preditivo](07Preditiva.pdf)
* [Análise Sintática - Análise LL(1)](08LL1.pdf)
* [Análise Sintática - Análise Ascendente](09Ascendente.pdf)
* [Análise Sintática - Análise SLR](10SLR.pdf) - **atualizado 22/05/2013**
* [Análise Sintática - JACC](11JACC.pdf)
* [Análise Semântica - ASTs e Escopo](12Semantica.pdf)
* [Análise Semântica - Tipos](13Tipos.pdf)
* [Geração de Código - Ativações, Organização da Memória e Introdução](14Codigo.pdf)

### Código fonte

* 03/04/2013 - [Compilador de sequência de comandos simples](CmdSimp.zip)
* 10/04/2013 - [Análise Léxica](Lexico.zip) - **atualizado 15/04/2013**
* 15/04/2013 - [Compilador de sequência de comandos simples com scanner usando JFlex](CmdSimp_JFlex.zip)
* 29/04/2013 - [Analisador sintático recursivo para Tiny](Tiny_Rec.zip)
* 08/05/2013 - [Analisador sintático recursivo preditivo para Tiny](Tiny_Pred.zip)
* 08/05/2013 - [Análise Sintática](Parsing.zip) - **atualizado 22/05/2013**
* 22/05/2013 - [Analisador sintático SLR para Tiny](Tiny_SLR.zip)
* 29/05/2013 - [Analisador sintático JACC para Tiny](Tiny_JACC.zip)
* 05/06/2013 - [Análise de escopo para Tiny com variáveis e procedimentos](Tiny_Escopo.zip)
* 10/06/2013 - [Análise de tipos para Tiny com variáveis e procedimentos](Tiny_Tipos.zip)
* 24/06/2013 - [Geração de código para Tiny com variáveis e procedimentos - apenas inteiros e bools](Tiny_Codigo.zip)
* 01/07/2013 - [Geração de código para Tiny com variáveis e procedimentos - parâmetros e retorno](Tiny_Proc.zip)

Exercícios e Provas
-------------------

### Listas de Exercício

* [Lista 1](lista1.html)

### Provas

* [P1](p1.pdf) e [gabarito](p1_gabarito.pdf)
* [P2](p2.pdf) e [gabarito](p2_gabarito.pdf)

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

### Não use expressões regulares para análise sintática!

Resposta a uma pergunta no [Stack Overflow](http://stackoverflow.com/a/1732454):

<div class = "well">
<p>
You can't parse [X]HTML with regex. Because HTML can't be parsed by regex. Regex is not a tool that can be used to correctly parse HTML. As I have answered in HTML-and-regex questions here so many times before, the use of regex will not allow you to consume HTML. Regular expressions are a tool that is insufficiently sophisticated to understand the constructs employed by HTML. HTML is not a regular language and hence cannot be parsed by regular expressions. Regex queries are not equipped to break down HTML into its meaningful parts. so many times but it is not getting to me. Even enhanced irregular regular expressions as used by Perl are not up to the task of parsing HTML. You will never make me crack. HTML is a language of sufficient complexity that it cannot be parsed by regular expressions. Even Jon Skeet cannot parse HTML using regular expressions. Every time you attempt to parse HTML with regular expressions, the unholy child weeps the blood of virgins, and Russian hackers pwn your webapp. Parsing HTML with regex summons tainted souls into the realm of the living. HTML and regex go together like love, marriage, and ritual infanticide. The &lt;center&gt; cannot hold it is too late. The force of regex and HTML together in the same conceptual space will destroy your mind like so much watery putty. If you parse HTML with regex you are giving in to Them and their blasphemous ways which doom us all to inhuman toil for the One whose Name cannot be expressed in the Basic Multilingual Plane, he comes. HTML-plus-regexp will liquify the n​erves of the sentient whilst you observe, your psyche withering in the onslaught of horror. Rege̿̔̉x-based HTML parsers are the cancer that is killing StackOverflow it is too late it is too late we cannot be saved the trangession of a chi͡ld ensures regex will consume all living tissue (except for HTML which it cannot, as previously prophesied) dear lord help us how can anyone survive this scourge using regex to parse HTML has doomed humanity to an eternity of dread torture and security holes using regex as a tool to process HTML establishes a breach between this world and the dread realm of c͒ͪo͛ͫrrupt entities (like SGML entities, but more corrupt) a mere glimpse of the world of reg​ex parsers for HTML will ins​tantly transport a programmer's consciousness into a world of ceaseless screaming, he comes, the pestilent slithy regex-infection wil​l devour your HT​ML parser, application and existence for all time like Visual Basic only worse he comes he comes do not fi​ght he com̡e̶s, ̕h̵i​s un̨ho͞ly radiańcé destro҉ying all enli̍̈́̂̈́ghtenment, HTML tags lea͠ki̧n͘g fr̶ǫm ̡yo​͟ur eye͢s̸ ̛l̕ik͏e liq​uid pain, the song of re̸gular exp​ression parsing will exti​nguish the voices of mor​tal man from the sp​here I can see it can you see ̲͚̖͔̙î̩́t̲͎̩̱͔́̋̀ it is beautiful t​he final snuffing of the lie​s of Man ALL IS LOŚ͖̩͇̗̪̏̈́T ALL I​S LOST the pon̷y he comes he c̶̮omes he comes the ich​or permeates all MY FACE MY FACE ᵒh god no NO NOO̼O​O NΘ stop the an​*̶͑̾̾​̅ͫ͏̙̤g͇̫͛͆̾ͫ̑͆l͖͉̗̩̳̟̍ͫͥͨe̠̅s ͎a̧͈͖r̽̾̈́͒͑e n​ot rè̑ͧ̌aͨl̘̝̙̃ͤ͂̾̆ ZA̡͊͠͝LGΌ ISͮ̂҉̯͈͕̹̘̱ TO͇̹̺ͅƝ̴ȳ̳ TH̘Ë͖́̉ ͠P̯͍̭O̚​N̐Y̡ H̸̡̪̯ͨ͊̽̅̾̎Ȩ̬̩̾͛ͪ̈́̀́͘ ̶̧̨̱̹̭̯ͧ̾ͬC̷̙̲̝͖ͭ̏ͥͮ͟Oͮ͏̮̪̝͍M̲̖͊̒ͪͩͬ̚̚͜Ȇ̴̟̟͙̞ͩ͌͝S̨̥̫͎̭ͯ̿̔̀ͅ

</p>
</div>



Contato
-------

Podem entrar em contato pelo meu [email](mailto:mascarenhas@ufrj.br) que
responderei assim que possível. Também tenho um horário de atendimento
de alunos na minha sala, segundas e quartas de 17 às 18 horas. A sala é
a E-2013 do DCC.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
