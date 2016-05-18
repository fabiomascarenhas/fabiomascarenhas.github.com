---
layout: default
title: Linguagens de Programação - Quinta Lista de Exercícios
relpath: ..
---

Quinta Lista de Exercícios
==========================

Introdução
----------

Baixe o [projeto da lista](Lista5.zip), importe ele no IntelliJ, e implemente as funções
correspondentes a cada questão do exercício. Depois envie um novo `Lista5.zip` com
as modificações até **16/03/2016**,
usando [esse link](https://www.dropbox.com/request/555kA1Qi3Xn1a24Ks31q).

Questão 1 - Ambientes e escopo
------------------------------

O tipo algébrico abaixo dá a sintaxe abstrata de uma linguagem funcional (chamada *dyn*) que tem variáveis
 com escopo estático e variáveis com escopo dinâmico, onde variáveis introduzidas por `Let`
 e parâmetros têm escopo estático
e variáveis introduzias por `LetDyn` têm escopo dinâmico. 
Os valores da linguagem são números inteiros e closures, dados por um tipo algébrico `Valor`.
A linguagem não tem efeitos colaterais.

    trait Exp
    case class Num(n: Int) extends Exp
    case class Soma(e1: Exp, e2: Exp) extends Exp
    case class Mult(e1: Exp, e2: Exp) extends Exp
    // Testa se a condição é igual a 0
    case class If(cond: Exp, ethen: Exp, eelse: Exp) extends Exp
	// Funções têm apenas um parâmetro
    case class Fun(param: String, corpo: Exp) extends Exp
    case class Var(nome: String) extends Exp
    case class Ap(fun: Exp, arg: Exp) extends Exp
    case class Let(nome: String, exp: Exp, corpo: Exp) extends Exp
    case class LetDyn(nome: String, exp: Exp, corpo: Exp) extends Exp

a) Implemente o tipo algébrico `Valor`.

b) Implemente a função `eval` dessa linguagem, usando uma semântica de ambientes.
Um nó `Var` é uma variável com escopo estático caso exista uma em escopo, senão é uma
variável com escopo dinâmico (em outras palavras, variáveis estáticas ocultam variáveis dinâmicas).

c) Nessa linguagem, uma expressão `letrec` ainda seria necessária para definir
funções recursivas? E recursão mútua? Justifique.

Questão 2 - Continuações
------------------------

Corotinas simétricas são corotinas em que só existe a operação `resume`, rebatizada de `transfer`.
Essa operação suspende a corotina atual e começa a executar a outra corotina a partir do
ponto onde ela chamou `transfer` pela última vez (ou do início). Uma corotina chegar ao final
sem transferir o controle para outra corotina encerra o programa, e o resultado dessa corotina
é o resultado do programa todo.

Faça as modificações necessárias em *MicroC* para implementar corotinas simétricas ao invés
dos geradores atuais. A primitiva `coro` ainda instancia uma nova corotina a partir de uma
função que dá o "corpo" dessa corotina. Uma nova primitiva `transfer e` avalia a expressão
`e`, e transfere o controle para a corotina referenciada pelo resultado. A corotina principal
do programa tem a referência `0`. 

Questão 3 - Objetos
-------------------

Objetos e funções de primeira classe são dois lados da mesma moeda. Mesmo a
*recursão aberta* dos objetos pode ser simulada com funções de primeira classe.
Por exemplo, o código abaixo mostra uma versão "aberta" da função fatorial, em *fun*:

    let fat = fun (f, n)
                if n < 2 then
                  1
                else
                  n * (f)(f, n-1)
                end
              end
    in
      (fat)(fat, 5)
    end

a) Escreva uma função `doubler` que recebe uma função "aberta" como a função
acima e retorna outra função aberta que chama a função passada e dobra o
resultado. Se substituirmos o corpo do `let` acima pela expressão abaixo o
resultado do programa deve ser 3840.

    let df = doubler(fat) in
      (df)(df, 5)
    end

b) Escreva `doubler` como uma função de objetos para objetos em *proto*.
Assuma que a função que `doubler` recebe é um objeto com um método `apply`.

c) Escreva a implementação recursiva tradicional da função `fib(n)` que
calcula o n-ésimo número de Fibonacci como uma função "aberta" de *fun* e como
um objeto de *proto*. Teste que ela dá os mesmos resultados nas duas linguagens,
tanto aplicada normalmente quanto usada com `doubler`.

	
* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

