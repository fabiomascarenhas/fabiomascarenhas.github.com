---
layout: default
title: MAB 471 - Compiladores I - MHTML
relpath: ..
---

A Linguagem MHTML
=================

MHTML (*M*acro *H*yper*T*ext *M*arkup *L*anguage) é a junção de uma versão simples de HTML com
uma linguagem de script, permitindo aumentar o conjunto de tags definindo como as novas
tags devem ser processadas. Um documento MHTML primeiro é *macroexpandido* usando o interpretador
da linguagem de script, de modo a obter um documento que usa somente o conjunto de tags base.
Esse documento então pode ser interpretado por um web browser.

Um exemplo simples de MHTML:

{% highlight html %}
<html>
<body>
<%
  function hello(params, texto)
    if params.lang == "pt" then
      return "<p>Olá " .. texto .. "!</p>"
    else
      return "<p>Hello " .. texto .. "!</p>"
    end
  end
%>
<hello lang = "pt">Fulano</hello>
<hello lang = "en">Beltrano</hello>
</body>
</html>
{% endhighlight %}

O interpretador MHTML transforma isso no HTML abaixo (a menos de espaçamento):

{% highlight html %}
<html>
<body>
<p>Olá Fulano!</p>
<p>Hello Beltrano!</p>
</body>
</html>
{% endhighlight %}

A linguagem de script também pode definir funções auxiliares, que não são
usadas em tags:

{% highlight html %}
<html>
<body>
<%
  function fat(n)
    if n == 0 then
      return 1
    else
      return n * fat(n-1)
    end
  end

  function fatorial(params)
    return tostring(fat(tonumber(params.n)))
  end
%>
<p>O fatorial de 5 é: <fatorial n = "5"/></p>
</body>
</html>
{% endhighlight %}

O resultado é:

{% highlight html %}
<html>
<body>
<p>O fatorial de 5 é: 120</p>
</body>
</html>
{% endhighlight %}

MHTML também permite avaliar expressões na linguagem de script, com o resultado sendo incorporado no
HTML gerado. O exemplo anterior poderia ser escrito assim:

{% highlight html %}
<html>
<body>
<%
  function fat(n)
    if n == 0 then
      return 1
    else
      return n * fat(n-1)
    end
  end
%>
<p>O fatorial de 5 é: <%= fat(5) %></p>
</body>
</html>
{% endhighlight %}

Especificação Léxica
--------------------

MHTML possui na verdade três conjuntos de especificações léxicas: um para MHTML propriamente
dito (o programa "principal"), outro para o interior das tags (nome da tag e atributos), e um terceiro
para os trechos da linguagem de script entre `<%` e `%>`.

### MHTML

* Espaços em branco: `[ \n\t\r]`
* Comentários: começa com `<!--`, termina com `-->`, sem aninhamento
* Abertura de tags: `<`, `</`
* Palavras: um ou mais de qualquer coisa que não seja um espaço ou os caracteres `<` e `>`
* Abertura de script: `<%` e `<%=`

### MHTML tags

* Espaços em branco: `[ \n\t\r]`
* Fechamento de tags: `>`, `/>`
* Identificadores (convertidos para minúsculas): uma letra seguido de zero ou mais letras, dígitos ou `_`
* Definição de atributo: `=`
* Strings: qualquer sequência de caracteres entre aspas duplas (inclusive quebras de linha!)

### MHTML script

* Espaços em branco: `[ \n\t\r]`
* Comentários: começa com `--`, vai até o final da linha
* Palavras reservadas: `function`, `end`, `while`, `local`, `true`, `false`,
  `and`, `else`, `if`, `elseif`, `not`, `nil`, `or`, `return`, `then`, `do`
* Identificadores: uma letra ou `_`, seguido de zero ou mais letras, dígitos ou `_`. Um único `_` é um identificador válido.
* Numerais: inteiros e decimais, dígitos à direita ou à esquerda do ponto decimal são opcionais (`123.` e `.4` são numerais, mas `.` não é)
* Strings: qualquer sequência de caracteres entre aspas duplas (inclusive quebras de linha!)
* Operadores: `+`, `-`, `*`, `/`, `==`, `~=`, `<`, `=`, `(`, `)`, `{`, `}`,
  `.`, `,`, `..`
* Fechamento de script: `%>`

Sintaxe
-------

### MHTML

<pre>
MHTML -> ELEM

ELEM  -> ATAG CORPO FTAG
ELEM  -> <% SCRIPT %>
ELEM  -> <%= EXP %>
ELEM  -> AFTAG

CORPO -> {ELEM | word}

ATAG  -> < id {ATRIB} >

FTAG  -> </ id >

AFTAG -> < id {ATRIB} />

ATRIB -> id = string
</pre>

### MHTML Script

<pre>
SCRIPT -> BLOCO

BLOCO  -> {STAT} [RET]

STAT   -> do BLOCO end
STAT   -> while EXP do BLOCO end
STAT   -> function id ( [IDS] ) BLOCO end
STAT   -> if exp then BLOCO {elseif exp then BLOCO} [else BLOCO] end
STAT   -> local id [= EXP]
STAT   -> LVAL = EXP
STAT   -> PEXP ( [EXPS] )

RET    -> return EXP

LVAL   -> id
LVAL   -> PEXP . id

IDS    -> id {, id}

EXPS   -> EXP {, EXP}

EXP    -> EXP or LEXP
EXP    -> LEXP

LEXP   -> LEXP and REXP
LEXP   -> REXP

REXP   -> REXP &lt; CEXP
REXP   -> REXP == CEXP
REXP   -> REXP ~= CEXP
REXP   -> CEXP

CEXP   -> CEXP .. AEXP
CEXP   -> AEXP

AEXP   -> AEXP + MEXP
AEXP   -> AEXP - MEXP
AEXP   -> MEXP

MEXP   -> MEXP * PEXP
MEXP   -> MEXP / PEXP
MEXP   -> SEXP

SEXP   -> - SEXP
SEXP   -> not SEXP
SEXP   -> nil
SEXP   -> false
SEXP   -> true
SEXP   -> num
SEXP   -> string
SEXP   -> { }
SEXP   -> function ( [IDS] ) BLOCO end
SEXP   -> PEXP

PEXP   -> PEXP ( [EXPS] )
PEXP   -> PEXP . id 
PEXP   -> ( EXP )
PEXP   -> id
</pre>


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
