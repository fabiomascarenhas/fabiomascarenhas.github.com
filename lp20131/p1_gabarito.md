---
layout: default
title: Linguagens de Programação - Gabarito da P1
relpath: ..
---

Gabarito P1
===========

1\. No interpretador de substituição, uma variável
está livre se não foi substituída por nenhum valor
ou expressão antes do momento de seu uso.

2\.

a) Os passos de avaliação, separados por uma linha em branco:

    let x = 4 in
      let f = fun (y) x + y end in
        let x = 5 in
	      (f)(10)
	    end
      end
    end  
    
    let f = fun (y) 4 + y end in
      let x = 5 in
	    (f)(10)
      end
    end
    
    let x = 5 in
      (fun (y) 4 + y end)(10)
    end
    
    (fun (y) 4 + y end)(10)
    
    4 + 10
    
    14

b) O valor é 15. No escopo dinâmico, as variáveis livres da função
`f` têm seu valor dado pelo ambiente no momento da *aplicação*
da função. Em `f`, `x` está livre, e o valor dado pelo
ambiente no ponto `(f)(10)` é 5. O valor de y é dado pelo
argumento para a aplicação, então é 10. Logo, `x + y` = 15.

3\.

a) Definição do tipo algébrico `Valor`:

    trait Valor
    case class NumV(n: Int) extends Valor
    case class FunV(env: Map[String, Valor],
                    param: String,
		    		corpo: Exp) extends Valor

b) Assinatura de `eval`:

    def eval(senv: Map[String, Valor],
             denv: Map[String, Valor]): Valor

c) Existem várias maneiras diferentes de escrever a mesma coisa.

    case Ap(fun, arg) => {
      val vf = fun.eval(senv, denv)
      vf match {
        case FunV(env, param, corpo) => {
          val va = arg.eval(senv, denv)
	      corpo.eval(env + (param -> va), denv)   
	    }
	    case _ => sys.error("lado esquerdo não é função")
      }
    }

O importante é a utilização do ambiente da FunV como
ambiente estático para avaliação do corpo da função,
junto com a associação do parâmetro com o argumento,
e do ambiente dinâmico passado para eval como ambiente
dinâmico para avaliação do corpo da função.

d) O importante aqui é a ordem de procura nos ambientes:

    case Var(nome) => senv.get(nome) match {
      case Some(v) => v
      case None => denv.get(nome) match {
        case Some(v) => v
	    case None => sys.error("variável livre")
      }
    }

4\.

a) Usando recursão direta:

    case FunM(lp, corpo) => lp match {
      case List() => Fun("$", corpo.desugar)
      case List(p) => Fun(p, corpo.desugar)
      case h :: t => Fun(h, FunM(t, corpo).desugar)
    }

Usando foldRight:
  
    case FunM(lp, corpo) => lp match {
      case List() => Fun("$", corpo.desugar)
      case _ => lp.foldRight(corpo.desugar, (p, e) => Fun(p, e))
    }

Usando tailrec:

    case FunM(lp, corpo) => lp match {
      case List() => Fun("$", corpo.desugar)
      case _ => {
        @tailrec
        def loop(e: Exp, lp: List[String]): Exp = lp match {
	      case List() => e
	      case h :: t => loop(Fun(h, e), t)
        }
        loop(corpo.desugar, lp.reverse)
      }
    }

b) Usando recursão direta:

    case ApM(fun, args) => args match {
      case List() => Ap(fun.desugar, Num(0))
      case List(arg) => Ap(fun.desugar, arg.desugar)
      case a :: as => ApM(Ap(fun.desugar, a.desugar), as).desugar
    }

Usando foldLeft:

    case ApM(fun, args) => args match {
      case List() => Ap(fun.desugar, Num(0))
      case _ => args.foldLeft(fun.desugar) 
                             ((f, a) => Ap(f, a.desugar))
    }

Usando tailrec:

    case ApM(fun, args) => args match {
      case List() => Ap(fun.desugar, Num(0))
      case _ => {
        @tailrec
	    def loop(e: Exp, args: List[Exp]): Exp = args match {
	      case List() => e
	      case a :: as => loop(Ap(e, a.desugar), as)
	    }
	    loop(fun.desugar, args)
      }
    }
