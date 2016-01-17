---
layout: default
title: Linguagens de Programação - Gabarito da P3
relpath: ..
---

Gabarito P3
===========

1\. Resposta:

    case Let(n, e1, e2) => Ap(Fun(n, e2.desugar), e1.desugar)

2\. Resposta:

    case Let(ns, es, ec) => Ap(Fun(ns, ec.desugar), es.map(e => e.desugar))

3\. Os primeiro bug é o uso de `env` ao invés de `fenv` como ambiente base para
a avaliação do corpo da função, e o segundo é o uso de `fenv` ao invés de `env`
como ambiente de avaliação do argumento. O primeiro bug faz as funções terem
escopo dinâmico, enquanto o segundo faz os argumentos da chamada de uma função
serem avaliados no que deveria ser o escopo léxico da função. Resumindo, os dois
bugs trocam os escopos de avaliação do argumento com o do corpo da função. O
trecho de código abaixo exercita ambos os bugs:

    let a = 2 in
      let f = fun (x)
                x - a
              end in
        let a = 5 in
          (f)(a)
        end
      end
    end

O resultado correto para o código acima é 3 (5-2), mas os bugs fazem ele
ser -3 (2-5), pois o `a` no argumento da chamada `(f)(a)` é avaliado em um
ambiente em que `a` é 2, enquanto o `a` no corpo de `f` é avaliado em um
ambiente que que `a` é 5.

A correção do bug é simples:

    case Ap(fun, arg) => fun.eval(env) match {
      case FunV(fenv, param, corpo) =>
        corpo.eval(fenv + (param -> arg.eval(env))
      case _ => sys.error("não é uma função")
    }

4\. Aqui o bug consiste em "esquecer" os efeitos colaterais do lado
esquerdo da soma, usando novamente `mem` na execução do lado direito. O
trecho abaixo exercita o bug:

    let a = 1 in
      (a = 2) + a
    end

O resultado correto do programa é 4, pois o lado esquerdo muda o valor de
`a`, mas com o bug o resultado será 3. A correção é simples:

    case Soma(e1, e2) => mem => {
      val (v1, mem1) = e1.eval(funs)(env)(mem)
      val (v2, mem2) = e2.eval(funs)(env)(mem1)
      (v1, v2) match {
        case (NumV(n1), NumV(n2)) => (NumV(n1 + n2), mem2)
        case _ => sys.error("soma precisa de dois números")
      }
    }
