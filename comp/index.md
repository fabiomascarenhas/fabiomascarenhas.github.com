---
layout: default
title: MAB 471 - Compiladores I
relpath: ..
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
maiores notas. Não haverá prova final ou segunda chamada. A média
final é 5,0.

Datas das Provas
----------------

P1: 19/12/2012

P2: 11/03/2013

P3: 13/03/2013

As provas serão feitas ou na sala DLC ou na sala DCC, a depender da disponibilidade,
no mesmo horário da aula.

Trabalhos Práticos
------------------

Os trabalhos práticos correspondem às diferentes fases de um
compilador de [MHTML](mhtml.html) para HTML:

1. Analisador léxico da linguagem, usando [JFlex](http://jflex.de/)
2. Analisador sintático recursivo
3. Interpretador para MHTML script
4. Macroexpansor (gerador de HTML a partir de MHTML)

Os trabalhos serão feitos em dupla. As mesmas duplas valerão para todos
os quatro trabalhos, exceto em casos de trancamento ou abandono, que serão
resolvidos caso a caso.

### Analisador Léxico

Cada dupla deverá fazer a especificação de um analisador léxico para
a linguagem [MHTML](mhtml.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab1/MHTML.zip), e leia com atenção o arquivo
`mhtml.jpage`. 

A entrega do trabalho deverá ser feita até o dia 28/11/2012, uma
quarta-feira, em formato zip, usando [esse
formulário](http://form.jotformz.com/form/23113756377658).

Se tiver qualquer dúvida sobre a especificação da linguagem ou o
funcionamento do analisador léxico é só perguntar e terei o prazer
em esclarecer.

### Analisador Sintático

Cada dupla deverá completar a implementação de um analisador sintático para
a linguagem [MHTML](mhtml.html). Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab2/MHTML.zip), e leia com atenção o arquivo
`mhtml.jpage`. 

A entrega do trabalho deverá ser feita até o dia 30/01/2013, uma
quarta-feira, em formato zip, usando [esse
formulário](http://form.jotformz.com/form/30086060522645).

Se tiverem quaisquer dúvidas sobre a especificação da linguagem ou o
funcionamento do analisador sintático é só perguntarem.

### Interpretador para MHTML Script

Cada dupla deverá completar a implementação da especificação de [MHTML Script](mhtml.html).
Baixe o esqueleto do projeto Eclipse
para o trabalho [aqui](trab3/MHTMLScript.zip), e leia com atenção o arquivo
`mhtml.jpage`. 

A entrega do trabalho deverá ser feita até o dia 06/03/2013, uma quarta-feira,
em formato zip, usando [esse formulário](http://form.jotformz.com/form/30363980245656).

Se tiverem quaisquer dúvidas sobre a especificação da linguagem é só perguntarem.

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

* [29/10/2012](Lexico_29102012.zip) - Análise Léxica: expressões regulares
* [31/10/2012](Lexico_31102012.zip) - Análise Léxica: autômatos
* [05/11/2012](Lexico_05112012.zip) - Análise Léxica: autômatos e JFlex
* [07/11/2012](Lexico_07112012.zip) - Análise Léxica: limitações
* [11/11/2012](Parsing_11112012.zip) - Análise Sintática: gramáticas e árvores de parse
* [26/11/2012 e 28/11/2012](Parsing_28112012.zip) - Análise Sintática: revisão, ambiguidade, padrões
* [03/12/2012](Parsing_03122012.zip) - Análise Sintática Top-Down: analisador LL(1) genérico
* [05/12/2012](Parsing_05122012.zip) - Análise Sintática Top-Down: fatoração à esquerda e eliminação de recursão à esquerda
* [10/12/2012 e 12/12/2012](Parsing_12122012.zip) - Análise Sintática Top-Down: analisador recursivo
* [17/12/2012](Parsing_17122012.zip) - Análise Sintática Top-Down: notas de aula mais completas
* [07/01/2013](Parsing_07012013.zip) - Análise Sintática Bottom-Up: introdução ao analisador shift-reduce
* [09/01/2013](Parsing_09012013.zip) - Análise Sintática Bottom-Up: reduções e derivações à direita, handles
* [14/01/2013 e 16/01/2013](Parsing_09012013.zip) - Análise Sintática Bottom-Up: autômato LR(0), analisador SLR, ACTION e GOTO, conflitos SLR e tratamento de associatividade e precedência
* [21/01/2013](Semantic_21012013.zip) - Árvores Sintáticas Abstratas: expressões aritméticas
* [23/01/2013](Semantic_23012013.zip) - Árvores Sintáticas Abstratas: variáveis e comandos
* [28/01/2013](Semantic_28012013.zip) - Árvores Sintáticas Abstratas: escopo e funções
* [30/01/2013](Semantic_30012013.zip) - Árvores Sintáticas Abstratas: funções anônimas, Tipagem Estática
* 04/02/2013 - [Tipagem estática com inferência](Semantic_04022013_inference.zip), [inferência de tipos genéricos](Semantic_04022013_generics.zip)
* [06/02/2013](Semantic_06022013.zip) - Tipagem estática com inferência: sobrecarga e recursão nos tipos

A seção 6.5.4 da 2a. edição do livro "Compiladores: Princípios, Técnicas e Ferramentas", de Aho, 
Sethi, Ullman e Lam, fazem um resumo da técnica de inferência de tipos dada nos dias 04 e 06/02/2013.
A seção 6.5.5 dá uma outra versão do algoritmo de unificação de tipos. O algoritmo implementado nos projetos
acima é uma adaptação do algoritmo de Luca Cardelli em [Basic Polymorphic Typechecking](http://web.cecs.pdx.edu/~antoy/Courses/TPFLP/lectures/TYPE/BasicTypechecking.pdf).

* 18/02/2013 - [Tipagem explícita](Semantic_18022013.zip), [Geração de código: conversão de fechos](Codegen_18022013.zip)

Uma exposição didática do problema de conversão de fecho está [nessa página](http://matt.might.net/articles/closure-conversion/). Conversão de fecho é uma variante do problema de [lambda lifting](http://en.wikipedia.org/wiki/Lambda_lifting)
para linguagens com funções de primeira classe, onde o lifting puro não é suficiente. Uma exposição mais detalhada
está [nessa página](http://matt.might.net/articles/compiling-scheme-to-c/). A [versão para Java](http://matt.might.net/articles/compiling-to-java/) do compilador dessa última referência não faz conversão de fecho, delegando a maior parte
do trabalho para o compilador Java.

* [20/02/2013](Codegen_20022013.zip) - Geração de código: geração sem código sem if/while

### Listas de Exercício

* [Lista 1](lista1.html)

* [Lista 2](lista2.html)

### Provas

* 19/12/2012 - [P1](p1.pdf) e [gabarito](Prova1.zip)

### Artigos

* [Top-down Syntax Analysis](knuth_topdown.pdf) - artigo tutorial de Donald Knuth sobre análise sintática top-down.
Didático, mas bem detalhado, inclusive com teoremas e provas. Para quem quiser se aprofundar mais no assunto.

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
