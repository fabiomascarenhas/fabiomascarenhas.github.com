---
layout: default
title: Linguagens de Programação - Segunda Lista de Exercícios
relpath: ..
---

Segunda Lista de Exercícios
===========================

Introdução
----------

Baixe o [projeto da lista](lista2.zip), que está preparado para funcionar tanto com o SBT quanto
com o eclipse, para funcionar como base para implementar o que for necessário.

Algumas das questões pedem para extender os interpretadores vistos em sala, para isso use o [código
fonte dos interpretadores](aulas.zip), copiando a pasta correspondente para dentro do projeto
da lista.

Questões que não são de codificação devem ser respondidas dentro do arquivo `README.md` do projeto.

Questão 1 - Conjuntos usando funções de primeira classe
-------------------------------------------------------

Uma representação para conjuntos é pela sua *função característica*, uma função
que diz se um elemento pertence ao conjunto ou não. Em Scala, um conjunto de
elementos de um tipo `T` pode ser então dado pelo tipo de funções de `T` para
booleanos:

    type Conjunto[T] = T => Boolean

Por exemplo, o conjunto dos inteiros pares pode ser dado por `(x: Int) => x % 2 == 0`.
Dada essa definição para conjuntos, a definição de uma função que verifica se um
conjunto contém ou não um elemento é trivial:

    def contem[T](conj: Conjunto[T], elem: T) = conj(elem)

a) Defina uma função `unitario` que cria um conjunto unitário:

    def unitario[T](elem: T): Conjunto[T] = ???

b) Defina as funções `uniao`, `intesercao` e `diferenca`, que faz a união,
interseção e diferença de dois conjuntos:

    def uniao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 	
    def intersecao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 	
    def diferenca[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 

c) Defina a função `filtro` que retorna um conjunto contendo apenas os elementos do
conjunto que passam pelo filtro:

    def filtro[T](c: Conjunto[T], f: T => Boolean): Conjunto[T] = ???	

d) Defina a função `map` que transforma um conjunto de elementos de tipo `T` em um
conjunto de elementos de tipo `U`, dada uma função de mapeamento `U => T`:

    def map[T, U](c: Conjunto[T], f: U => T): Conjunto[U] = ???	

e) Por que a função de mapeamento para conjuntos tem os tipos trocados em relação à sua
equivalente no `map` de listas?
	
Questão 2 - Sintaxe melhor para chamar funções locais
-----------------------------------------------------

No intrepretador de fun da aula 10 (pacote `br.ufrj.aula10`), uma função definida localmente
com `let` ou `letrec` precisa ser chamada com parênteses em volta do seu nome, para que o
parser use um nó `Ap` ao invés de um nó `Ap1`, que só pode chamar funções globais.

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
	in fat(5) end

Questão 3 - Let como açúcar sintático
-------------------------------------

Retire o caso do nó `Let` da função `eval`, e implemente o `let` como açúcar sintático 
para uma chamada de função anônima na função `desugar` (veja o segundo slide da [aula de 15/05](Aula11.pdf)).

Questão 4 - Cálculo lambda
--------------------------

O *cálculo lambda* é um modelo de computação bastante que é uma das bases da programação
funcional, e pode ser visto como uma linguagem de programação bastante simples.

Uma expressão do cálculo lambda pode ser uma variável (um nome), uma aplicação (um par de expressões),
ou uma *abstração* (um par de um nome, o *parâmetro* da abstração, e uma expressão, o seu *corpo*).
As abstrações também são os valores da linguagem.

a) Defina um tipo algébrico para expressões no cálculo lambda, usando um trait `CL` e três construtores
`Var`, `Ap`, e `Abs`.

A semântica do cálculo lambda call-by-value é dada por substituição: o valor de uma variável é um 
erro; o valor de uma abstração é ela mesma; para obter o valor de uma aplicação obtemos o valor do seu
lado esquerdo (que será uma abstração) e seu lado direito, substituímos o parâmetro do lado esquerdo pelo
valor do lado direito no corpo do lado esquerdo, e achamos o valor do resultado.

Para evitar capturas, um valor sendo substituído com variáveis livres também é um erro.

b) Escreva o interpretador `eval`, a substituição `subst` e a função que dá as variáveis
livres para o cálculo lambda call-by-value:

    def eval: Abs = {
      ???
	}	
    
	def subst(nome: String, val: Abs): LC = {
      ???
	}
	
	def fvs: Set[String] = {
	  ???
	}

c) Escreva agora as três funções acima para o interpretador call-by-name do cálculo lambda:

    def eval: Abs = {
      ???
	}
    
	def subst(nome: String, val: LC): LC = {
      ???
	}
	
	def fvs: Set[String] = {
	  ???
	}

Questão 5 - uma biblioteca padrão para *fun*
--------------------------------------------

Implemente os padrões de recursão em listas que usamos em Scala: `map`, `filter`,
`foldRight`, `foldLeft` e `flatMap` como funções de *fun* definidas usando o método
do slide 19 da [aula de 15/05](Aula11.pdf)

Questão 6 - Coleta de lixo nos ambientes
----------------------------------------

O ambiente base das funções anônimas de *fun* com ambientes não precisa ter todas
as entradas do ambiente em que a função anônima foi definida, mas apenas as entradas para
variáveis livres no corpo da função. Implemente essa otimização no interpretador.

Questão 7 - Ambientes e escopo
---------------------------------------

a) Em *fun* com ambientes e escopo dinâmico a expressão `letrec` ainda é necessária
para definir funções recursivas locais? E recursão mútua? Justifique.

b) Seria possível definir uma linguagem que mistura variáveis com escopo léxico e
variávieis com escopo dinâmico? Justifique dando um esboço de sintaxe abstrata e
estratégia de avaliação para essa linguagem.

c) Implemente uma mudança equivalente à da questão 2 no interpretador de *fun* com ambientes e escopo
estático.

Entrega da lista
----------------

Use o formulário abaixo para enviar a sua lista. Lembre de enviar apenas o arquivo `package.scala` que
você modificou. O prazo para envio é domingo, dia 02/06/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/31336195797667">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

