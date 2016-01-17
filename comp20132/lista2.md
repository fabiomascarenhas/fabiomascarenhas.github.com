---
layout: default
title: Segunda Lista de Exercícios de Compiladores I
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

3\. Considere a gramática a seguir, para um fragmento de TINY:

{% highlight ragel %}
      LISTA -> CMD ; LISTA | CMD
      CMD -> id := EXP
      EXP -> id | id ( ) | num
{% endhighlight %}

a) Dê a sequência de ações (shift, reduce, accept) do analisador LR para o termo `id := num ; id := id ()`.

b) Construa o DFA de itens LR(0) dessa gramática. 

4\. Um analisador LR(0) pode efetuar mais ou menos reduções que um
analisador SLR(1) antes de declarar um erro? Justifique sua resposta.

5\. Suponha que sejam removidas as especificações de associatividade e
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

6\. Acrescente os operadores `^` (exponenciação) e `-` (menos unário) à especificação
de [TINY](tiny.jacc). A precedência da exponenciação é maior do que a dos outros operadores
binários, e ela é associativa à direita. A precedência do menos unário é maior que a dos operadores
binários.

7\. Considere a gramática a seguir para declarações simples em Pascal:

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
sala (como uma classe `TabSimb<T>`).

8\. Considere o seguinte programa TINYPy:

{% highlight python %}
    void main():
	  a := 0
	  b := 0
	  c := 10
	  write f(b, c)
	
	int soma(int x, int y):
	  soma := x + y  { aqui }
	
	int f(int y, int z):
	  a := y
	  if a < z:
	    b := 10
		a := soma(a, b)
      f := a
{% endhighlight %}

Desenhe a pilha (e seu conteúdo) para esse programa no momento
em que a linha comentada é executada, a partir do registro de ativação de main,
e marque na pilha a localização de cada registro de ativação. Marque também para qual posição
na pilha o registrador EBP está apontando.

9\. Considere o seguinte programa TINYPy:

{% highlight python %}
    void main():
	  write f(5)
	
	int f(int x):
	  a := 0
	  if 0 < x:
	    b := 2
		c := 3
		a := b + c
	  if 0 < a:
	    d := 4
		a := a - d   { aqui }
	  f := a
		
{% endhighlight %}

Desenhe a pilha (e seu conteúdo) para esse programa no momento
em que a linha comentada é executada, a partir do registro de ativação de main,
e marque na pilha a localização de cada registro de ativação. Marque também para qual posição
na pilha o registrador EBP está apontando.

10\. Acrescente um comando `repeat-until` ao compilador TINYPy. A sintaxe é

{% highlight ragel %}
       CMD -> repeat BEGIN cmds END until EXP
{% endhighlight %}

O comportamento de um comando repeat é executar o bloco até que a expressão `EXP` seja verdade. Faça todo o trabalho: modificação do analisador léxico para incluir as palavras chave `repeat` e `until` (lembre
que TINYPy não faz distinção entre maiúsculas e minúsculas), modificação do analisador sintático para gerar o nó apropriado, e implementação da classe Java que representa esse nó. A expressão do `until`
está no mesmo escopo do bloco de comandos.

11\. O curto-circuito de expressões booleanas é um recurso
bastante comum em linguagens de programação. No curto circuito, uma
expressão `e1 and e2` (*e* lógico) não precisa avaliar
`e2` se `e1` já for falsa, e uma expressão `e1 or e2`
(*ou* lógico) não precisa avaliar `e2` se `e1` já for
verdadeira.

Em um gerador de código para expressões booleanas, geralmente geramos
código que salta para determinado rótulo se a expressão for
*falsa*. Essa é a função do método `void codigoSaltoF(Contexto c,
TabSimb<Endereco> escopo, String rotulo)` em `Expressao`, abaixo.

Faça a geração de código para as expressões `LogE`, correspondente a
`and`, e `LogOu`, correspondente a `or`, implementando seus
métodos `codigoSaltoF`. Assuma que a classe `Contexto` é a mesma
que usamos para TINY.

{% highlight java %}
interface Expressao {
  void codigoSaltoF(Contexto c, TabSimb<Endereco>, String rotulo);
}

class LogE implements Expressao {
  Expressao esq;
  Expressao dir;
  public void codigoSaltoF(Contexto c, String rotulo) {
    // implement esse método
  }
}

class LogOu implements Expressao {
  Expressao esq;
  Expressao dir;
  public void codigoSaltoF(Contexto c, String rotulo) {
    // implement esse método
  }
}
{% endhighlight %}

12\. As classes abaixo modelam o sistema de tipos de uma linguagem
orientada a objetos simples, que não tem tipos primitivos, membros
estáticos, interfaces ou herança múltipla:

{% highlight java %}
class Classe {
  Classe superClasse;
  Map<String, Metodo> metodos;
  Map<String, Classe> campos;

  boolean subClasseDe(Classe sup) {
    ...
  }
}

class Metodo {
  Classe tipoRet;
  List<String> nomeParams;
  List<Classe> tipoParams;
  List<Exp> corpo;

  void checaTipo(Classe tipoThis) {
   ...
  }
}

interface Exp {
  Classe tipoExp(TabSimb<Classe> tenv);
}
{% endhighlight %}

O método `subClasseDe`  diz se uma classe é subclasse da outra,
direta ou indiretamente. Uma classe sempre é subclasse dela mesma.

Para verificar se um método está corretamente tipado, o sistema de
tipos deve criar uma tabela de símbolos para tipar o método, 
associar o nome `this` à classe do método, cada parâmetro a seu tipo, e
tipar cada expressão do corpo nesse ambiente. A última expressão do corpo deve
ter um tipo que é subclasse do tipo de retorno do método.

Já a classe Java abaixo modela o fragmento da AST da linguagem
responsável pelas chamadas de métodos:

{% highlight java %}
class ChamadaMetodo implements Exp {
  Exp objeto;
  String metodo;
  List<Exp> args;

  Classe tipoExp(TabSimb<Classe> tenv) {
    ...
  }
}
{% endhighlight %}

Para tipar uma chamada de método, o sistema de tipos primeiro tipa o
objeto da chamada, para buscar os dados do método sendo
chamado. Depois verifica se o número de argumentos bate com o número
de parâmetros do método, e se cada argumento é subclasse do tipo de
cada parâmetro. O tipo da chamada então é o tipo de retorno do método.

Um erro de tipagem pode ser sinalizado com uma `RuntimeException`
simples, contendo a mensagem *"erro de tipagem"*.

a) Implemente o método `subClasseDe`.

b) Implemente o método `tipoExp` de `ChamadaMetodo`.

c) Implemente o método `checaTipo` de `Metodo`.


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
