---
layout: default
title: Primeira Lista de Exercícios de Compiladores I
relpath: ..
---

Segunda Lista de Exercícios
===========================

1\. Considere a gramática a seguir:

{% highlight ragel %}
      E -> ( L )
      E -> a
      L -> L , E
      L -> E
{% endhighlight %}

Construa o DFA de itens LR(0) para essa gramática. Ela é LR(0)? Se não
for, indentifique o conflito. Construa a tabela de análise sintática shift-reduce
LR(0) (se possível) ou SLR(1).

2\. Considere a gramática a seguir:

{% highlight ragel %}
      S -> S ( S )
      S ->
{% endhighlight %}

Construa o DFA de itens LR(0) para essa gramática. Ela é LR(0)? Se não
for, indentifique o conflito. Construa a tabela de análise sintática shift-reduce
LR(0) (se possível) ou SLR(1).

3\. Um analisador LR(0) pode efetuar mais ou menos reduções que um
analisador SLR(1) antes de declarar um erro? Justifique sua resposta.

4\. Suponha que sejam removidas as especificações de associatividade e
precedência dos operadores na especificação Jacc da gramática a seguir
(tornando, portanto, a gramática ambígua). Quais seriam a
associatividade e precedência dos operadores usando as regras de
eliminação de ambiguidade de Jacc (shift em caso de conflito shift-reduce,
reduce pela regra que vem primeiro em caso de conflito reduce-reduce)?

{% highlight ragel %}
    exp        : '(' exp ')'
               | NUM
               | ID
               | exp '<' exp
               | exp '=' exp
               | exp '+' exp
               | exp '-' exp
               | exp '*' exp
               | exp '/' exp
               ;
{% endhighlight %}

5\. Acrescente os operadores `^` (exponenciação) e `-` (menos unário) à especificação
JACC [exp.jacc](exp.jacc). A precedência da exponenciação é maior do que a dos outros operadores
binários, e ela é associativa à direita. A precedência do menos unário é maior que a dos operadores
binários.

6\. Considere a gramática a seguir para declarações simples em Pascal:

{% highlight ragel %}
      DECL -> VAR-LISTA : TIPO
      VAR-LISTA -> VAR-LISTA , id
      VAR-LISTA -> id
      TIPO -> integer
      TIPO -> real
{% endhighlight %}

Escreva a especificação de uma AST Java para termos dessa gramática, e
implemente a verificação de tipos nessa AST. Assuma que já existe a
implementação de uma tabela de símbolos nos moldes da que foi vista em
sala (como uma interface `Environment<T>`).

7\. Considere o seguinte programa MHTML:

{% highlight java %}
    local a: num = 0
    local b: num = 0
    local c: num = 0

    function f(y: num, z: num) -> num
      local a: num = y
      while a < z do
         local b: num = readnum()
         a = a + b   -- aqui
      end
      return a
    end

    print(f(0,10))
{% endhighlight %}

Desenhe o ambiente de verificação de tipos no ponto do programa marcado pelo
comentário. Lembre que o ambiente mapeia nomes de variável em tipos, e a função *f*
é parte do ambiente.

8\. Acrescente um comando `repeat-until` ao compilador MHTML. A sintaxe é

{% highlight ragel %}
       STAT -> repeat BLOCO until EXP
{% endhighlight %}

O comportamento de um comando repeat é executar `BLOCO` até que a expressão `EXP` seja verdade. Faça todo o trabalho: modificação do analisador léxico para incluir as palavras chave `repeat `e `until`, modificação do analisador sintático para gerar o nó apropriado, implementação da classe Java que representa esse nó, incluindo interpretação (método `run`), verificação de tipos (método `tcStat`), conversão de fecho (método `ccStat`) e geração de código (método `cgStat`).

9\. A geração de código para uma linguagem de máquina não é muito diferente da geração de código para uma linguagem de alto nível.

A JVM é uma máquina de pilha, ou seja, as instruções operam não sobre
registradores mas sobre valores em uma pilha. A instrução **ldc** *n*
empilha um número literal *n*, a instrução **iload** *n* empilha o valor
da *n*-ésima variável local (que deve ser inteira), a instrução
**istore** *n* desempilha o valor que está no topo da pilha e o guarda
na *n*-ésima variável local, as instruções **iadd**, **isub**, **idiv**
e **imul** desempilham dois valores e empilham o resultado da operação
correspondente (soma, subtração, multiplicação e divisão,
respectivamente), e a instrução **invokestatic** *f* desempilha quantos
parâmetros a função *f* tiver e chama *f* com esses argumentos,
empilhando o valor de retorno.

O trecho de código Java abaixo mostra o fragmento da AST de uma linguagem de programação
simples, sem aninhamento de funções:

{% highlight java %}
    interface Comando {
      void geraCodigo(Environment<Integer> env, Saida s);
    }

    class Atrib implements Comando {
      String lval;
      Expressao rval;
      ...
    }

    interface Expressao {
      void geraCodigo(Environment<Integer> env, Saida s);
    }

    class Num implements Expressao {
      int val;
      ...
    }

    class Mul implements Expressao {
      Expressao esq;
      Expressao dir;
      ...
    }

    class Var implements Expressao {
      String nome;
      ...
    }
     
    class Sub implements Expressao {
      Expressao esq;
      Expressao dir;
      ...
    }

    class ChamadaFuncao implements Expressao {
      String nomeFunc;
      Expressao[] args;
      ...
    }
{% endhighlight %}

Escreva o método void `geraCodigo(Environment<Integer> env, Saida s)`
para as classes `Atrib`, `Var`,
`Num`, `Sub`, `Mul` e `ChamadaFuncao`. Esse método deve gerar código JVM. Assuma
que o objeto do tipo Saida tem métodos void `ldc(int val)`, `void iload(int var)`,
`void istore(int var)`, `void isub()`, `void imul()` e `void invokestatic(String f)`, 
que emitem as instruções correspondentes. O parâmetro `env` mapeia nomes de variáveis
em números que as identificam na JVM. Funções são identificadas pelo próprio nome
(campo `nomeFunc` de `ChamadaFuncao`). A análise semântica já verificou
compatibilidade de tipos e de aridade de funções.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
