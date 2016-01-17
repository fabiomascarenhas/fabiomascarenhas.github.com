---
layout: default
title: Compiladores II
relpath: ..
---

Compiladores II
---------------

### Apresentação

Está é a página da disciplina Compiladores II do professor
Fabio Mascarenhas, para o semestre de *2014.2*. As aulas da disciplina são
às terças e quintas, das 10 às 12 horas, na sala DCC.

### Objetivo e Ementa

O objetivo do curso é estudar alguns tópicos mais avançados em cada uma das quatro fases
de um compilador:

* Métodos generalizados de análise sintática (GLR, GLL, SGLR, PEGs)
* Inferência de tipos em linguagens funcionais, polimorfismo
paramétrico em linguagens OO (generics), e tipagem gradual em
linguagens de script
* Representação intermediária com Static Single Assignment (SSA) e
otimizações usando a forma SSA.
* Ambientes de execução gerenciados: máquinas virtuais, coleta de
lixo e compilação Just-In-Time.

### Avaliação

A presença é obrigatória em pelo menos 75% das aulas, ou o aluno será reprovado
por falta. 

A avaliação se dará por um seminário em que cada aluno fará uma apresentação
oral de 30 minutos sobre um artigo escolhido pelo aluno dentre um pool de
artigos dado pelo professor. Os artigos são os seguintes:

[OMeta: an Object-Oriented Language for Pattern Matching](http://www.tinlizzie.org/~awarth/papers/dls07.pdf) - uma ferramenta que generaliza o uso de PEGs para uso em dados estruturados ao invés de sequências, junto com recursos que permitem o reuso e extensão de gramáticas

[Making the future safe for the past: Adding Genericity to the Java Programming Language](http://homepages.inf.ed.ac.uk/wadler/gj/Documents/gj-oopsla.pdf) - uma descrição da proposta do que acabou sendo a implementação de tipos genéricos ou parametrizados para a linguagem Java

[Virtual-Machine Abstraction and Optimization Techniques](http://www.dsi.fceia.unr.edu.ar/downloads/informatica/info_iii/articulos%202010/Virtual-Machine%20Abstraction-2009.pdf) - discussão de alto nível de várias técnicas para otimização de interpretadores, em especial em como técnicas mais antigas se comportam no hardware moderno

### Lista de Discussão

Estaremos reusando o grupo no Facebook de Compiladores I para perguntas
e avisos sobre essa matéria.
Acessem [aqui](http://www.facebook.com/groups/compiladoresI/).

### Bibliografia

Os artigos abaixo cobrem alguns dos assuntos que estamos abordando no curso, embora
eu muitas vezes modifique a ordem na qual os assuntos são apresentados:

[Monadic Parsing in Haskell](http://www.cs.nott.ac.uk/~gmh/pearl.pdf) - combinadores de parsing "clássicos"

[Parsec: Direct Style Monadic Parser Combinators For The Real World](http://research.microsoft.com/en-us/um/people/daan/download/papers/parsec-paper.pdf) - combinadores
de parsing determinísticos

[Parsing Expression Grammars: A Recognition-based Syntactic Foundation](http://bford.info/pub/lang/peg.pdf) -
o artigo que introduz PEGs

[On the Relation between Context-Free Grammars and
Parsing Expression Grammars](http://arxiv.org/pdf/1304.3177v2.pdf) - uma formulação alternativa de PEGs, mais
próxima de CFGs

[A Text Pattern-Matching
Tool based on Parsing
Expression Grammars](http://www.inf.puc-rio.br/~roberto/docs/peg.pdf) - PEGs para casamento de padrões,
com a noção de capturas que vimos

[Error Reporting in Parsing Expression Grammars](http://arxiv.org/pdf/1405.6646.pdf) - estratégias de detecção de erros em PEGs e combinadores de parsing
determinísticos

[Basic Polymorphic Typechecking](http://lucacardelli.name/Papers/BasicTypechecking.pdf) - polimorfismo
paramétrico e inferência de tipos, com uma implementação imperativa

Os três livros abaixo dão uma visão mais aprofundada de cada uma das grandes etapas de um
compilador: análise sintática, verificação de tipos, otimização de código.

["Parsing Techniques: A Practical Guide"](http://dickgrune.com/Books/PTAPG_2nd_Edition/), 2a. edição, de Dick Grune e Ceriel
Jacobs.

["Types and Programming Languages"](http://www.cis.upenn.edu/~bcpierce/tapl/), de Benjamin Pierce.

["Engineering a Compiler"](http://www.elsevier.com/books/engineering-a-compiler/cooper/978-0-12-088478-0#description), 2a. edição, de Keith D. Cooper e Linda
Torczon.

Finalmente, o livro abaixo dá uma série de dicas pragmáticas voltadas para a implementação de
interpretadores para linguagens simples, voltado para quem não tem nenhum treinamento formal
em construção de compiladores e linguagens de programação.

["Language Implementation Patterns"](http://pragprog.com/book/tpdsl/language-implementation-patterns), 
de Terence Parr.

### Notas de Aula

#### 12/08 - [Introdução](01Introducao.pdf), [código Lua](aula1.lua)
#### 19/08 - [Lua (tabelas)](02Tabelas.pdf), [código Lua](aula2.lua)
#### 21/08 - [Lua (erros, módulos, closures)](03ErrModClos.pdf), [código Lua](scripts_2108.zip)
#### 26/08 - [Lua (iteradores)](04Iteradores.pdf), [código Lua](aula4.lua)
#### 28/08 - [Lua (metatabelas e OO)](05OO.pdf), [código Lua](scripts_2808.zip)
#### 02/09 - [sequências](seq.lua), [scanner "genérico"](scannergen.lua)
#### 04/09 - [Combinadores de parsing](06Monadic.pdf), [código](parser.lua)
#### 09/09 - [Combinadores de parsing (2)](07Parsing.pdf), [código](scripts_0909.zip)
#### 11/09 - [Parsers determinísticos, PEGs](08Parsec.pdf), [código](scripts_1109.zip)
#### 18/09 - [PEGs - sintaxe e ações semânticas](09PEGs.pdf), [código](scripts_1809.zip)
#### 23/09 - [PEGs - capturas](10Caps.pdf), [código](scripts_2309.zip)
#### 25/09 - [Erros em parsers determinísticos e PEGs](11Erros.pdf), [código](scripts_2509.zip)
#### 30/09 - [SmallLua - sintaxe](12SmallLua.pdf), [código](scripts_3009.zip)
#### 09/10 - [Funções por casos](13Casefunc.pdf), [código](scripts_0910.zip)
#### 14/10 - [Verificação de tipos - tipos simples](14Tipos.pdf)
#### 16/10 - [Verificação de tipos - sequências](15TiposCont.pdf), [código](scripts_1610.zip)
#### 30/10 - [Verificação de tipos - sequências](16Sequencias.pdf), [código](scripts_3010.zip)
#### 04/11 - [Verificação de tipos - polimorfismo](17Polimorfismo.pdf), [código](scripts_0411.zip)
#### 06/11 - [Verificação de tipos - unificação](18Unificacao.pdf), [código](scripts_0611.zip)
#### 13/11 - [Verificação de tipos - inferência](19Inferencia.pdf), [código](scripts_1311.zip)
#### 18/11 - [Verificação de tipos - sobrecarga](20Sobrecarga.pdf), [código](scripts_1811.zip)

### Lua

Vários algoritmos vistos no curso serão apresentados em [Lua](http://www.lua.org), uma
linguagem de script simples e muito fácil de aprender. [Essa página](http://learnxinyminutes.com/docs/lua/)
faz um resumo da linguagem que é útil para quem já tem boa desenvoltura em programação
(especialmente em outra linguagem de script como Python, Ruby ou JavaScript).
As [notas de aula](http://www.dcc.ufrj.br/~fabiom/lua) de um curso de Lua dão um material
mais detalhado, e [manual de referência](http://http://www.lua.org/manual/5.2/manual.html)
([versão para impressão](lua52-refman.pdf))
e o livro [Programming in Lua](http://store.feistyduck.com/products/programming-in-lua)
vão mais a fundo.

Se você está em Windows, pode baixar um interpretador Lua
(um executável, uma DLL, e uma bibilioteca para linkar com código C)
[aqui](lua52_win32.zip). Descompacte e chame `lua.exe` no prompt
de comando. Todas as distribuições Linux têm interpretadores Lua
disponíveis nos seus gerenciadores de pacotes.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
