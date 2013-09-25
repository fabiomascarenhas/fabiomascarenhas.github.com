---
layout: default
title: MAB 471 - Compiladores I - TINYPy
relpath: ..
---

A Linguagem TINYPy
==================

TINYPy é uma mistura da linguagem TINY do nosso livro texto com Python, juntando
a sintaxe baseada em identação de Python com a simplicidade de TINY, adicionando
tipos simples (inteiros e booleanos) e funções.

Um exemplo simples de TINYPy:

{% highlight python %}
{ Calcula o fatorial de um número lido da entrada }

int fat_rec(int n):
  if n < 2:
    fat_rec := 1
  else:
    fat_rec := n * fat_rec(n - 1)

int fat_loop(int n):
  fat_loop := 1
  while n > 1:
    fat_loop := fat_loop * n
    n := n - 1

void main():
  read x
  write fat_rec(x)
  write fat_loop(x)
{% endhighlight %}

Especificação Léxica
--------------------

TINYPy, ao contrário de Python e TINY, **não** faz diferença entre maiúsculas e minúsculas, seja
para palavras reservadas, seja para identificadores.

* Identação: espaços em branco (`[ ]`) no início de uma linha podem gerar tokens `BEGIN` ou `END`
* Espaços em branco ignorados: `[ \n\t\r\f]`
* Comentários: começam com `{` e terminam com `}`, sem aninhamento
* Palavras reservadas: `read`, `write`, `if`, `else`, `elif`, `while`, `int`, `bool`, `void`,
  `and`, `or`, `not`, `pass`, `true`, `false`
* Identificadores: uma letra, seguido de zero ou mais letras, dígitos ou `_`
* Numerais: apenas números inteiros
* Operadores e pontuação: `(`, `)`, `,`, `=`, `<`, `:=` (`ATRIB`), `+`, `-`, `*`, `/`, `:`
 
Sintaxe
-------

A sintaxe é dada usando EBNF. Meta-símbolos EBNF usados como tokens estão entre aspas simples. A
precedência entre os operadores está codificada na gramática.

{% highlight ragel %}
PROG   -> FUNC {FUNC}
FUNC   -> TIPO id '(' [PARAMS] ')' : begin CMDS end
PARAMS -> TIPO id {, TIPO id}
CMDS   -> CMD {CMD}
TIPO   -> int | bool | void
CMD    -> if EXP : begin CMDS end {elif EXP : begin CMDS end} [else : begin CMDS end]
        | while EXP : begin CMDS end
        | id := EXP
        | id '(' [EXPS] ')'
        | read id
        | write EXP
        | pass
EXP    -> EXP or LEXP
        | LEXP
LEXP   -> LEXP and REXP
        | REXP
REXP   -> REXP < AEXP
        | REXP = AEXP
        | AEXP
AEXP   -> AEXP + MEXP
        | AEXP - MEXP
        | MEXP
MEXP   -> MEXP * SEXP
        | MEXP / SEXP
        | SEXP
SEXP   -> not SEXP
        | - SEXP
        | true
        | false
        | num
        | id
        | id '(' [EXPS] ')'
        | '(' EXP ')'
EXPS   -> EXP {, EXP}
{% endhighlight %}

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
