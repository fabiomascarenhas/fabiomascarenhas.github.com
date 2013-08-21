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

Algumas das questões pedem para extender os interpretadores vistos em sala, para isso use o 
código que está nos pacotes `subst`, para o interpretador de substituição, e `env`,
para o interpretador de ambientes.

Questões que não são de codificação devem ser respondidas dentro do arquivo `README.md` do projeto.

Para rodar os interpretadores, veja o screencast (ligue a visualização em full screen):

<iframe width="640" height="360"
 src="http://www.youtube.com/embed/KNDWLPu0BxU?feature=player_detailpage" frameborder="0" allowfullscreen="1">
dummy
</iframe>

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

> Resposta:

    def unitario[T](elem: T): Conjunto[T] = x => x == elem    
    
b) Defina as funções `uniao`, `intesercao` e `diferenca`, que faz a união,
interseção e diferença de dois conjuntos:

    def uniao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 	
    def intersecao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 	
    def diferenca[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = ??? 

> Resposta:

    def uniao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = x => c1(x) || c2(x) 	
    def intersecao[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = x => c1(x) && c2(x) 	
    def diferenca[T](c1: Conjunto[T], c2: Conjunto[T]): Conjunto[T] = x => c1(x) && !c2(x) 
    
c) Defina a função `filtro` que retorna um conjunto contendo apenas os elementos do
conjunto que passam pelo filtro:

    def filtro[T](c: Conjunto[T], f: T => Boolean): Conjunto[T] = ???	

> Resposta:

    def filtro[T](c: Conjunto[T], f: T => Boolean): Conjunto[T] = x => c(x) && f(x)	

> Note que o filtro `f` na verdade também é um conjunto, pela nossa definição!
> Estamos fazendo a interseção desses dois conjuntos.
    
d) Defina a função `map` que transforma um conjunto de elementos de tipo `T` em um
conjunto de elementos de tipo `U`, dada uma função de mapeamento `U => T`:

    def map[T, U](c: Conjunto[T], f: U => T): Conjunto[U] = ???	

> Resposta:

    def map[T, U](c: Conjunto[T], f: U => T): Conjunto[U] = x => c(f(x))	
    
e) Por que a função de mapeamento para conjuntos tem os tipos trocados em relação à sua
equivalente no `map` de listas?

> Porque uma lista é um "produtor" de elementos, e um conjunto é um "consumidor",
> então a função de mapeamento pega os elementos produzidos pela lista e os mapeia
> em outros, enquanto a função de mapeamento precisa mapear elementos para serem
> fornecidos com conjunto.
	
Questão 2 - Sintaxe melhor para chamar funções locais
-----------------------------------------------------

No intrepretador de fun da aula 11 (pacote `subst`), uma função definida localmente
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
	end
	in fat(5) end

> Resposta:

      case Ap1(n, as) => m.get(n) match {
        case Some(f) => Ap(f.subst(m), as.map(e => e.subst(m))) 
        case None => Ap1(n, as.map(e => e.subst(m)))
      }
    
Questão 3 - Let como açúcar sintático
-------------------------------------

Retire o caso do nó `Let` da função `eval`, e implemente o `let` como açúcar sintático 
para uma chamada de função anônima na função `desugar` (veja o segundo slide da [aula de 15/05](Aula11.pdf)).
Você pode fazer essa mudança tanto no interpretador que está no pacote `subst` quanto no que
está no pacote `env`, mas indique onde está sua resposta.

> Resposta abaixo. Note que precisamos mexer em `LetM` também:

      case Let(n, e, c) => Ap(Fun(List(n), c.desugar), List(e.desugar))
      case LetM(es, c) => Ap(Fun(es.map({ case (n, _) => n }), c.desugar),
                             es.map({ case (_, e) => e.desugar }))


Questão 4 - Cálculo lambda
--------------------------

O *cálculo lambda* é um modelo de computação que é uma das bases da programação
funcional, e pode ser visto como uma linguagem de programação bastante simples.

Uma expressão do cálculo lambda pode ser uma variável (um nome), uma aplicação (um par de expressões),
ou uma *abstração* (um par de um nome, o *parâmetro* da abstração, e uma expressão, o seu *corpo*).
As abstrações também são os valores da linguagem.

a) Defina um tipo algébrico para expressões no cálculo lambda, usando um trait `CL` e três construtores
`Var`, `Ap`, e `Abs`.

> Resposta:

    trait CL
    case class Var(nome: String) extends CL
    case class Ap(exp1: CL, exp2: CL) extends CL
    case class Abs(param: String, corpo: CL) extends CL

A semântica do cálculo lambda call-by-value é dada por substituição: o valor de uma variável é um 
erro; o valor de uma abstração é ela mesma; para obter o valor de uma aplicação obtemos o valor do seu
lado esquerdo (que será uma abstração) e seu lado direito, substituímos o parâmetro do lado esquerdo pelo
valor do lado direito no corpo do lado esquerdo, e achamos o valor do resultado.

Para evitar capturas, um valor sendo substituído com variáveis livres também é um erro.

b) Escreva o interpretador `eval`, a substituição `subst` e a função que dá as variáveis
livres para o cálculo lambda call-by-value:

> Respostas:

    def eval: Abs = {
      case Var(n) => sys.error("variável livre")
      case Ap(e1, e2) => e1.eval match {
        case Abs(p, c) => c.subst(p, e2.eval).eval
      }
      case Abs(p, c) => Abs(p, c)
	}	
    
	def subst(nome: String, valor: Abs): LC = {
      case Var(n) => if (n == nome) valor else Var(n)
      case Ap(e1, e2) => Ap(e1.subst(nome, valor), e2.subst(nome, valor))
      case Abs(p, c) => if (p == nome) Abs(p, c) else Abs(p, c.subst(nome, valor))
	}
	
	def fvs: Set[String] = {
	  case Var(n) => Set(n)
      case Ap(e1, e2) => e1.fvs ++ e2.fvs
      case Abs(p, c) => c.fvs - p
	}

c) Escreva agora as três funções acima para o interpretador call-by-name do cálculo lambda:

> Respostas:

    def eval: Abs = {
      case Var(n) => sys.error("variável livre")
      case Ap(e1, e2) => e1.eval match {
        case Abs(p, c) => c.subst(p, e2).eval
      }
      case Abs(p, c) => Abs(p, c)
    }
    
	def subst(nome: String, valor: LC): LC = {
      case Var(n) => if (n == nome) 
                       if (!valor.fvs.isEmpty)
                         sys.error("expressão com variáveis livres: " + e + ", fvs: " + e.fvs)
                       else valor
                     else Var(n)
      case Ap(e1, e2) => Ap(e1.subst(nome, valor), e2.subst(nome, valor))
      case Abs(p, c) => if (p == nome) Abs(p, c) else Abs(p, c.subst(nome, valor))
	}
	
	def fvs: Set[String] = {
	  case Var(n) => Set(n)
      case Ap(e1, e2) => e1.fvs ++ e2.fvs
      case Abs(p, c) => c.fvs - p
	}

Questão 5 - uma biblioteca padrão para *fun*
--------------------------------------------

Implemente os padrões de recursão em listas que usamos em Scala: `map`, `filter`,
`foldRight`, `foldLeft` e `flatMap` como funções de *fun* definidas usando o método
do slide 19 da [aula de 15/05](Aula11.pdf)

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
    
    fun map(f, l)
      (l)(fun () Vazia() end,
          fun (h, t) Cons((f)(h), map(f, t)) end)
    end
    
    fun filter(p, l)
      (l)(fun () Vazia() end,
          fun (h, t) 
            if (p)(h) then
              Cons(h, filter(f, t))
            else
              filter(f, t)
            end
          end)
    end
    
    fun foldLeft(z, op, l)
      (l)(fun () z end,
          fun (h, t)
            foldLeft(op(z, h), op, t)
          end)
    end
    
    fun foldRight(z, op, l)
      (l)(fun () z end,
          fun (h, t)
            op(h, foldRight(z, op, t))
          end)
    end

    fun append(l1, l2)
      foldRight(l2, fun (a, b) Cons(a, b) end, l1)
    end
    
    fun flatMap(f, l)
      (l)(fun () Vazia() end,
          fun (h, t)
            append((f)(h), flatMap(f, t))
          end)
    end

Questão 6 - Coleta de lixo nos ambientes
----------------------------------------

O ambiente base das funções anônimas de *fun* com ambientes não precisa ter todas
as entradas do ambiente em que a função anônima foi definida, mas apenas as entradas para
variáveis livres no corpo da função. Implemente essa otimização no interpretador que está
no pacote `env`.

> Reposta:

      case Fun(params, corpo) => {
        val fvs = this.fvs
        FunV(env.filter({ case (n, _) => fvs.contains(n) }), params, corpo)
      }

Questão 7 - Ambientes e escopo
---------------------------------------

a) Em *fun* com ambientes e escopo dinâmico a expressão `letrec` ainda é necessária
para definir funções recursivas locais? E recursão mútua? Justifique.

> Não, pois quando chamamos a função recursiva a sua definição vai estar no
> ambiente usado na chamada de função, pois no escopo dinâmico o ambiente
> do corpo da função é uma extensão do ambiente do ponto onde ela foi
> chamada, e não do ambiente onde foi definida.

b) Seria possível definir uma linguagem que mistura variáveis com escopo léxico e
variávieis com escopo dinâmico? Justifique dando um esboço de sintaxe abstrata e
estratégia de avaliação para essa linguagem.

> Sim, para isso precisamos de dois ambientes, um ambiente estático e um
> ambiente dinâmico, e um "let dinâmico" que introduz variáveis dinâmicas.
> A primeira prova (e seu gabarito) tem um esboço mais completo do que seria necessário.

c) Implemente uma mudança equivalente à da questão 2 no interpretador de *fun* com ambientes e escopo
estático (pacote `env`).

> A modificação caso `Ap1` de `eval` é relaticamente simples:

      case Ap1(func, args) => 
        funs.filter({ 
          case Fun1(nome, _, _) => nome == func
        }).headOption match {
          case Some(f) => f.apply(funs, args)
          case None => sys.error("função " + func + " não existe ")
        }

> Mas ela interage com a otimização da questão 6, então também precisamos mudar `fvs`:

      case Ap1(n, es) => es.foldRight[Set[String]](Set())(
        (e, s) => e.fvs ++ s)

Entrega da lista
----------------

Use o formulário abaixo para enviar a sua lista. Lembre de enviar apenas o arquivo `package.scala` que
você modificou. O prazo para envio é domingo, dia 02/06/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/31336195797667">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

