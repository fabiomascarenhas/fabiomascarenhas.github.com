---
layout: default
title: Linguagens de Programação - Terceira Lista de Exercícios
relpath: ..
---

Terceira Lista de Exercícios
===========================

Introdução
----------

Baixe o [projeto da lista](Lista4.zip), importe ele no IntelliJ, e implemente as funções
correspondentes a cada questão do exercício. Depois envie um novo `Lista4.zip` com
as modificações até **19/02/2016**,
usando [esse link](https://www.dropbox.com/request/h39Sg6Tjw9zGTwY1nSHE).

Questão 1 - Sintaxe melhor para chamar funções locais
-----------------------------------------------------

No interpretador de *fun* (pacote `fun`), uma função definida localmente
com `let` ou `letrec` precisa ser chamada com parênteses em volta do seu nome, para que o
parser use um nó `Ap` ao invés de um nó `Ap1`. Um nó `Ap1` só pode chamar funções de
primeira ordem.

Modifique o interpretador para que isso não seja mais necessário. Para isso, o resultado da
substituição de um nó `Ap1` deve ser um nó `Ap` caso o nome da função esteja no mapa de
substituições. Teste sua modificação com o seguinte programa, que deve ter `NumV(120)` como
resultado:

    fun menor(x, y)
	  x < y
	end
	
	letrec fat = fun (x)
	  if menor(x, 2) then 1
	  else x * fat(x-1) end
	end
	in fat(5) end

Questão 2 - uma biblioteca padrão para *fun*
--------------------------------------------

Implemente os padrões de recursão em listas que usamos em Scala: `map`, `filter`,
`foldRight`, `foldLeft` e `flatMap` como funções de *fun* para trabalhar com listas
construídas com as funções abaixo:

    fun Cons(h, t)
      fun (v, c)
        (c)(h, t)
      end
    end
    
    fun Vazia()
      fun (v, c)
        (v)()
      end
    end
    
	fun tamanho(l)
	  (l)(fun () 0 end, fun (h, t) 1 + tamanho(t) end)
	end
	
    fun map(f, l)
      -- implementação de map
    end
    
    fun filter(p, l)
      -- implementação de filter
    end
    
    fun foldLeft(z, op, l)
      -- implementação de foldLeft
    end
    
    fun foldRight(z, op, l)
      -- implementação de foldRight
    end
    
    fun flatMap(f, l)
      -- implementação de flatMap
    end
	
Implemente as funções no arquivo `listas.sc`.
	
Questão 3 - while
-----------------

Embora possamos usar recursão para fazer laços, em uma linguagem imperativa o mais
natural é ter uma expressão específica para isso. Vamos acrescentar um laço `while`
a MicroC, com a sintaxe `while EXP do EXP end`. O parser de MicroC já foi modificado
para aceitar essa expressão e gerar um nó `While` com a estrutura abaixo:

    case class While(econd: Exp, corpo: Exp) extends Exp	

Acrescente casos a `eval`, `fvs` e `subst` para `While`.
	
Questão 4 - entrada e saída
---------------------------

Um tipo bem comum de efeito colateral é a entrada e saída, onde uma linguagem
de programação pode ler valores de algum dispositivo de entrada e escrever valores
para algum dispositivo de saída.

Podemos incorporar entrada e saída a MicroC modificando o tipo `Acao[T]` para receber
e produzir "dispositivos" de entrada e saída:

    type Acao[T] = (Stream[Valor], List[String], End, Mem) => (Talvez[T], Stream[Valor], List[String], End, Mem)

A entrada é um `Stream` de valores. Uma stream é uma lista potencialmente infinita: dada uma stream `s` lemos
o próximo elemento dela com `s.head`, e obtemos uma stream sem esse próximo elemento com `s.tail`. A saída
é a lista de strings impressas.
	
Podemos acrescentar duas ações primitivas, uma para ler um valor da entrada e outra
para imprimir uma string na saída:

    def levalor: Acao[Valor] = ???
	def imprime(s: String): Acao[Unit] = ???

Implemente a mudança no tipo `Acao[T]`, mudando as primitivas existentes para levar em
conta entrada/saída (em especial a `bind`), depois implemente as novas primitivas.
Preste atenção na linearidade da entrada/saída.

Para usar essas primitivas precisamos de novas expressões em MicroC. O parser de MicroC
já foi modificado para aceitar `read` e `print`, que correspondem aos casos abaixo:

    case class Read() extends Exp
	case class Print(args: List[Exp]) extends Exp

Implemente os casos de `Read` e `Print` nas funções `fvs`, `subst`, e `eval`. A
expressão `Read` avalia para o próximo valor na entrada (consumindo esse valor),
enquanto `Print` avalia sua lista de argumentos da esquerda pra direita e os
imprime como uma string, separados por tabs.	
		
Use a seguinte definição de `eval` para executar programas com entrada e saída:

    val sc = new java.util.Scanner("4 2 3 5 1 10 8 7")
    def input: Stream[Valor] = sc.nextInt #:: input

    def eval(p: Prog): (Talvez[Valor], Stream[Valor], List[String], End, Mem) = p match {
      case Prog(funs, corpo) => eval(funs)(corpo)(input, List(), 0, Map())
    }

O programa em `qsort.sc` exercita as novas primitivas de entrada e saída.
	
* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

