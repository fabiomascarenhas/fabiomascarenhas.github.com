---
layout: default
title: Linguagens de Programação - Terceira Lista de Exercícios
relpath: ..
---

Terceira Lista de Exercícios
============================

Introdução
----------

Baixe o [projeto da lista](lista3.zip), que está preparado para funcionar tanto com o SBT quanto
com o eclipse, para funcionar como base para implementar o que for necessário.

Faça as questões extendendo o interpretador de MicroC que está no pacote `microc` do projeto.
Questões que não são de codificação devem ser respondidas dentro do arquivo `README.md` do projeto.

Para rodar o interpretador, veja o screencast (ligue a visualização em full screen):

<iframe width="640" height="360"
 src="http://www.youtube.com/embed/KNDWLPu0BxU?feature=player_detailpage" frameborder="0" allowfullscreen="1">
dummy
</iframe>

Questão 1 - entrada e saída
---------------------------

Um tipo bem comum de efeito colateral é a entrada e saída, onde uma linguagem
de programação pode ler valores de algum dispositivo de entrada e escrever valores
para algum dispositivo de saída.

Podemos incorporar entrada e saída a MicroC modificando o tipo `Acao` para receber
e produzir um "dispositivo" de entrada/saída:

    trait ES {
       def levalor: (Valor, ES);
   	   def imprime(s: String): ES;
	}
    type Acao = (ES, End, Mem) => (Talvez, ES, End, Mem)

Podemos acrescentar duas ações primitivas, uma para ler um valor da entrada e outra
para imprimir uma string na saída:

    def levalor: Acao = ???
	def imprime(s: String): Acao = ???

Implemente a mudança no tipo `Acao`, mudando as primitivas existentes para levar em
conta entrada/saída (em especial a `bind`), depois implemente as novas primitivas.
Preste atenção na linearidade da entrada/saída.

Modifique os casos na função eval dos termos `Read` e `Print` para usar as ações de
entrada/saída ao invés da entrada/saída de Scala. Lembre que `Read` avalia para o
próximo valor da entrada (consumindo um item da entrada), enquanto `Print`
avalia e imprime os valores das	expressões de suas subexpressões separados por tabs,
ao final imprimindo uma quebra de linha.
	
Use o seguinte driver para executar programas com entrada e saída:

    object driver extends App {
      val sc = new java.util.Scanner(System.in)
	  val es = new ES {
        def levalor: (Valor, ES) = (sc.nextInt, this)
	    def imprime(s: String) = {
		  print(s)
		  this
		}
	  }
	  val (v, _, sp, mem) = (parser.parseFile(args(0)).eval)(es, 0, Map())
	  println("====================")
	  println("Valor: " + v)
	  println("Sp: " + sp)
	  println("Mem: " + mem)
    }

O programa `qsort.mc` exercita as novas primitivas de entrada e saída.

Questão 2 - finally
-------------------

Um bloco `finally` dentro de um bloco `try` contém código que deve ser sempre executado
ao final do bloco `try`, tendo ocorrido uma exceção ou não. O valor do bloco finally é
descartado, ele é executado apenas pelos seus efeitos colaterais.

Podemos ter um bloco `finally` tanto sozinho com um `try` (termo `TryFinally`) ou junto
com um bloco `catch` (termo `TryCatchFinally`):

    case class TryFinally(et: Exp, ef: Exp) extends Exp
    case class TryCatchFinally(et: Exp, n: String, ec: Exp, ef: Exp) extends Exp

1) Um bloco `TryCatchFinally` é açúcar sintático para um bloco `TryFinally` combinado
com um bloco `TryCatch`. Implemente essa transformação na função `desugar`.

2) Implemente a primitiva `tryfinally`, que sequencia as duas ações segundo a maneira
de funcionar do bloco `try-finally`:

    def tryfinally(a1: Acao, a2: Acao): Acao = ???

O programa `finally.mc` exercita o uso de `finally`. Ele também usa as primitivas de
entrada e saída da questão 1.

Entrega da lista
----------------

Use o formulário abaixo para enviar a sua lista. Lembre de enviar apenas o arquivo `package.scala` que
você modificou. O prazo para envio é quarta-feira, dia 15/07/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/31684548072661">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

