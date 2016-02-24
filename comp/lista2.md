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

4\. Considere a gramática a seguir:

{% highlight ragel %}
S -> E
E -> E + E | E - E | E * E | ( E ) | id | num
{% endhighlight %}

a) Dê *duas* sequência de ações (shift, reduce, accept) do analisador LR para o termo `num + num * num`.
Não é preciso dar o número dos estados nas ações de shift. Mostre como essas duas
sequências de ações provam que a gramática é ambígua.

b) Dê o estado inicial do autômato LR(0) dessa gramática, as transições que saem desse estado, e os estados alvo dessas transições.

c) Escreva a implementação em Java de uma AST e verificador de tipos para termos
dessa gramática. Os nós da AST devem implementar a interface abaixo:

{% highlight ragel %}
interface Exp {
  String tipo(TabSimb<String> vars);
}
{% endhighlight %}

Você deve implementar os método `tipo` acima para cada nó da AST.
Ele faz a verificação de tipos: um numeral literal tem
tipo `int`, as operações aritméticas têm tipo `int` se
suas partes tiverem tipo `int`, caso contrário temos um erro.
O tipo dos identificadores é dado pela tabela de símbolos.

5\. Um analisador LR(0) pode efetuar mais ou menos reduções que um
analisador SLR(1) antes de declarar um erro? Justifique sua resposta.

6\. Suponha que sejam removidas as especificações de associatividade e
precedência dos operadores na especificação Jacc da gramática a seguir
(tornando, portanto, a gramática ambígua). Quais seriam a
associatividade e precedência dos operadores usando as regras de
eliminação de ambiguidade de Jacc (shift em caso de conflito shift-reduce,
reduce pela regra que vem primeiro em caso de conflito reduce-reduce)?

{% highlight ragel %}
exp  : '(' exp ')'
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

7\. Acrescente os operadores `^` (exponenciação) e `-` (menos unário) à especificação
de [TINY](tiny.jacc). A precedência da exponenciação é maior do que a dos outros operadores
binários, e ela é associativa à direita. A precedência do menos unário é maior que a dos operadores
binários.

8\. Considere a gramática a seguir para declarações simples em Pascal:

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

9\. Considere o seguinte programa TINY:

{% highlight python %}
procedure soma(x, y: int): int
  soma := x + y  { aqui }
end;
    
procedure f(int y, int z): int
  a := y;
  if a < z then
    b := 10;
    a := soma(a, b)
  end;
  f := a
end;

var a, b, c: int;
a := 0;
b := 0;
c := 10;
write f(b, c)
{% endhighlight %}

Desenhe a pilha (e seu conteúdo) para esse programa no momento
em que a linha comentada é executada, a partir do registro de ativação de main,
e marque na pilha a localização de cada registro de ativação. Marque também para qual posição
na pilha o registrador EBP está apontando.

10\. Considere o seguinte programa TINY:

{% highlight python %}
procedure f(x: int): int
  a := 0;
  if 0 < x then
    b := 2;
    c := 3;
    a := b + c;
  end;
  if 0 < a then
    d := 4;
    a := a - d   { aqui }
  end;
  f := a
end;
    
write f(5)
{% endhighlight %}

Desenhe a pilha (e seu conteúdo) para esse programa no momento
em que a linha comentada é executada, a partir do registro de ativação de main,
e marque na pilha a localização de cada registro de ativação. Marque também para qual posição
na pilha o registrador EBP está apontando.

11\. Vetores são um tipo de dado bastante comum
em linguagems de programação. Eles são um tipo *estrutural*:
se `t` é um tipo qualquer da linguagem, `t[]` é um
vetor em que cada elemento tem tipo `t`. A operação
principal em um vetor é a *indexação*, que pode ser
para leitura ou escrita. 

{% highlight java %}
class TipoVetor implements Tipo {
  Tipo tipoElem;
}
{% endhighlight %}

Na indexação de leitura, uma
expressão que deve ter o tipo `t[]` é indexada por uma
expressão de tipo inteiro, e o resultado é um valor do
tipo `t` (assumindo que o índice está dentro dos limites do
vetor), o elemento correspondente ao índice.

{% highlight java %}
interface Exp {
  Tipo tipo(TabSimb<Tipo> vars);
  void codigoVal(Contexto c, TabSimb<Tipo> vars);
}

class IndexaLe implements Exp {
  Exp vetor;
  Exp indice;
}
{% endhighlight %}

Na indexação de escrita, uma expressão que deve ter tipo `t[]`
e indexada por uma expressão de tipo inteiro está do lado esquerdo
de uma atribuição, e uma expressão do tipo `t` deve estar do
lado direito. O resultado é substituir o elemento na posição
dada pelo índice pelo resultado do lado direito da atribuição.

{% highlight java %}
interface Cmd {
  void tipos(TabSimb<Tipo> vars);
  void codigo(Contetxo c, TabSimb<Tipo> vars);
}

class IndexaEscreve implements Cmd {
  Exp vetor;
  Exp indice;
  Exp ldir;
}
{% endhighlight %}

a) Implemente a verificação de tipos para as operações
de indexação de vetores, dados os fragmentos da AST acima. Assuma que um tipo inteiro é instância
da classe `Inteiro`.

b) Implemente a geração de código para as operações de
indexação de vetores, dados os fragmentos de AST acima. Assuma
que o objeto `Contexto` tem duas operações com vetores:
`iloadv()` retira da pilha um vetor e um índice, e empilha
o elemento que está naquele índice, enquanto `istorev()`
retira da pilha um vetor, um índice e outro valor e guarda
esse valor no vetor, na posição dada pelo índice.

12\. Acrescente um comando `for` ao compilador TINY. A sintaxe é

{% highlight ragel %}
CMD -> for ID := exp TO exp BEGIN cmds END
{% endhighlight %}

O comportamento de um comando `for` é executar o bloco até que a variável de controle
ultrapasse o valor da segunda expressão dada. O valor inicial é dado pela primeira
expressão, e a cada iteração o valor é incrementado em `1`. Se o valor inicial for
maior que o final o `for` não executa nenhuma vez. A variável de controle é local
ao `for`, estando no escopo do bloco de comandos dele. As duas expressões devem
ter tipo inteiro, e esse é o tipo da variável de controle também.
Faça todo o trabalho: modificação do analisador léxico para incluir as palavras chave `for` e `to`,
modificação do analisador sintático para gerar o nó apropriado, e implementação da classe Java que
representa esse nó, com sua análise de escopos, tipo e geração de código.

12\. O curto-circuito de expressões booleanas é um recurso
bastante comum em linguagens de programação. No curto circuito, uma
expressão `e1 and e2` (*e* lógico) não precisa avaliar
`e2` se `e1` já for falsa, e uma expressão `e1 or e2`
(*ou* lógico) não precisa avaliar `e2` se `e1` já for
verdadeira.

Em um gerador de código para expressões booleanas, geralmente geramos
código que salta para determinado rótulo se a expressão for
*falsa*. Essa é a função do método `void saltoF(Contexto c,
TabSimb<Endereco> escopo, int rotulo)` em `Expressao`, abaixo.

Faça a geração de código para as expressões `LogE`, correspondente a
`and`, e `LogOu`, correspondente a `or`, implementando seus
métodos `saltoF`. Assuma que a classe `Contexto` é a mesma
que usamos para TINY.

{% highlight java %}
interface Expressao {
  void saltoF(Contexto c, TabSimb<Endereco> vars, int rotulo);
}

class LogE implements Expressao {
  Expressao esq;
  Expressao dir;
  public void saltoF(Contexto c, int rotulo) {
    // implemente esse método
  }
}

class LogOu implements Expressao {
  Expressao esq;
  Expressao dir;
  public void saltoF(Contexto c, int rotulo) {
    // implemente esse método
  }
}
{% endhighlight %}

13\. As classes abaixo modelam o sistema de tipos de uma linguagem
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
