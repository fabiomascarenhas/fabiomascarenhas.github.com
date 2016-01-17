---
layout: default
title: Linguagens de Programação - Gabarito da P2
relpath: ..
---

Gabarito P2
===========

1\.

(a) Pode-se considerar os tipos `Env` e `Mem` como abstratos, ou usar `Map`, tanto faz:

    def eval(funs: Env[Fun1])(env: Env[Int]): (Int, Mem) => (Int, Int, Mem) 

(b) Claro que vários trechos podem ser apresentados, contanto que combinem `let` com
atribuição na expressão do `let`:

    let a = 1 in
      let b = (a = 2) in
        print(a)
      end
    end
      
O programa acima imprime `2` em um interpretador correto, e `1` em um interpretador
errado.

(c) O uso de `sp1` três vezes no código abaixo não é uma falha de linearidade, pois só
estamos realmente usando `sp1` quando passamos seu valor para o resultado de um `eval`:

    case Let(nome, exp, corpo) => (sp, mem) => {
      val (ve, sp1, mem1) = exp.eval(funs)(env)(sp, mem)
      val (vc, sp2, mem2) = corpo.eval(funs)(env + (nome -> sp1))(sp1 + 1, mem1 + (sp1 -> ve))
      (vc, sp2 - 1, mem2 - (sp2 - 1))
    } 

2\. A memória na resposta pode ficar implícita ou explícita. Com memória implícita:

    case Soma(e1, e2) => k =>
      e1.eval(funs)(env)(v1 =>
        e2.eval(funs)(env)(v2 =>
          (v1, v2) match {
            case (NumV(n1), NumV(n2)) => k(NumV(n1 + n2))
            case _ => sys.error("soma precisa de dois números")
          }))

E com memória explícita:

    case Soma(e1, e2) => k => mem =>
      e1.eval(funs)(env)(v1 => mem1 =>
        e2.eval(funs)(env)(v2 => mem2 =>
          (v1, v2) match {
            case (NumV(n1), NumV(n2)) => k(NumV(n1 + n2))(mem2)
            case _ => sys.error("soma precisa de dois números")
          })
        (mem1))
      (mem)

3\. Quase todas as funções apenas passam seu resultado para a continuação,
só com `func` temos que trabalhar mais:

    fun dois(k)
      k(2)
    end
    
    fun dobra(x, k)
      k(x * 2)
    end
    
    fun soma(a, b)
      k(a + b)
    end
    
    fun func(k)
      dois(fun (a)
             dobra(a, fun (b)
                        soma(a, b, k)
                      end))
    end

Note como a continuação recebida por `func` é apenas passada pra `soma`,
pois é ela que tem que receber o resultado de `func`.
