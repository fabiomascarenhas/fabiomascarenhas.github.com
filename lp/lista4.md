---
layout: default
title: Linguagens de Programação - Quarta Lista de Exercícios
relpath: ..
---

Quarta Lista de Exercícios
==========================

Introduzimos o tipo `Acao` e suas primitivas para evitar introduzir bugs
desnecessariamente no interpretador. O trecho de código abaixo cuida das
atribuições em um interpretador hipotético de *MicroC* que não usa `Acao`, mas
cuja função `eval` manipula a memória diretamente (essa versão de MicroC não
tem o stack pointer nem tratadores de exceção em seu estado, apenas a memória,
e não usa continuações):  

    case Atrib(lval, rval) => lval match {
      case Var(n) => mem => {
	    val (rv, nmem) = rval.eval(funs)(env)(mem)
		(rv, mem + (env(n) -> rv))
      }
      case Deref(e) => mem => {
	    val (l, nmem1) = e.eval(funs)(env)(mem)
        val (rv, nmem2) = rval.eval(funs)(env)(mem)
        (rv, nmem1 + (l, rv))
      }
      case _ => sys.error("lado esquerdo inválido")
    }
	
1\. Quais os bugs do código acima? Mostre trechos de código MicroC que
evidenciam os bugs.

2\. Como você poderia consertar o código acima para corrigir os bugs
da questão 1?

3\. Qual a ordem de avaliação dos termos do caso `Deref` na sua resposta
à questão 2 (rval depois lval, lval depois rval)? Como ficaria o código
para inverter a ordem de avaliação?

Ainda continuando com o exemplo acima, suponha que queremos reescrever
nosso interpretador para usar continuações, mas novamente sem encapsular
as continuações e seus efeitos colaterais em um tipo `Acao`, mas manipulá-las
diretamente em `eval`.

4\. Como seria a assinatura de `eval`? Novamente, assuma que o estado do
interpretador é apenas a memória. Uma continuação desse interpretador recebe
um valor e retorna uma função que recebe uma memória e retorna um par de outro
valor e outra memória.

5\. Reescreva o código acima para usar as continuações, mantendo os mesmos bugs.

6\. Reescreva a resposta da questão 2 para usar as continuações,
mantendo a mesma ordem de avaliação.

7\. Reescreva a resposta da questão 3 para usar as continuações, mantendo a mesma
ordem de avaliação.

Para as questões abaixo, use os interpretadores de *fun* e *proto* que estão
no [projeto da Lista 4](lista4.zip).

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

8\. Escreva uma função `doubler` que recebe uma função "aberta" como a função
acima e retorna outra função aberta que chama a função passada e dobra o
resultado. Se substituirmos o corpo do `let` acima pela expressão abaixo o
resultado do programa deve ser 3840.

    let df = doubler(fat) in
	  (df)(df, 5)
	end

9\. Escreva `fat` e `double` como objetos em *proto*. Dica: confira o slide 6
da [aula 23](Aula23.pdf). O resultado de `doubler.make(fat).apply(5)` também
deve ser 3840.

10\. Qual o resultado de `(doubler.make(doubler.make(fat))).apply(5)`? É o mesmo
de `(df)(df, 5)` se trocarmos a definição de `df` acima por `doubler(doubler(fat))`?
Se não for o mesmo é porque sua implementação de `doubler` tem um bug, conserte!

Entrega da lista
----------------

Use o formulário abaixo para enviar a sua lista. Lembre de enviar apenas o arquivo `package.scala` que
você modificou. O prazo para envio é quarta-feira, dia 31/07/2013.

<script type="text/javascript" src="http://form.jotform.me/jsform/31909089649469">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

