---
layout: default
title: Lab 4 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 4 - 08/04/2015
--------------------------

O objetivo deste laboratório é exercitar a criação de
várias classes que implementam a mesma interface e fazem
uso extenso de polimorfismo. Vocês farão isso no contexto da
implementação de um *interpretador*, um programa que executa
programas.

As construções dos programas que vamos executar
serão modeladas como instâncias de classes. Essas classes
irão representar expressões e comandos. A implementação
dos métodos para avaliar uma expressão e executar um comando
formarão a implementação do interpretador.

MicroPython é uma linguagem de programação bem simples, mas
relativamente completa, onde pegamos um subconjunto de Python
contendo expressões aritméticas simples (soma, subtração,
multiplicação, divisão), variáveis e atribuição 
(mas variáveis podem guardar apenas números), entrada e
saída simples através dos comandos `input` e `print`, testes
`if` e laços `while`. Por exemplo, o programa MicroPython
abaixo calcula o fatorial de um número pedido na entrada e o
mostra na saída:

{% highlight python %}
    x = input() 
    if 0 < x: 
      fact = 1
      while 0 < x: 
        fact = fact * x
        x = x - 1
      print fact
{% endhighlight %}

Nesse laboratório vocês irão implementar classes que modelam a estrutura
de um programa MicroPython, e métodos para executar expressões e comandos.

Comecem implementando as classes que modelam expressões.
Os campos de cada classe estão implícitos
na sua descrição. Não se esqueça de implementar um construtor também. As
classes são:

`Num` modela um numeral, e contém o valor do mesmo. No programa
acima, 0 e 1 são instâncias de `Num`.  

`Var` modela uma variável, e contém o nome da variável. No programa acima, `x` e `fact`
são instâncias de `Var`.

`Soma`, `Sub`, `Mul` e `Div` modelam as quatro operações aritméticas, e
contêm duas expressões, para o lado esquerdo e o lado direito da
operação. No programa acima, `fact * x` é uma instância de `Mul` e `x - 1`
é uma instância de `Sub`.

`Igual` e `Menor` modelam as operações de comparação, e também contêm
expressões para o lado esquerdo e direito da operação. No programa acima, 
`0 < x` e `0 < fact` são instâncias de `Menor`.

`LeNumero` modela uma expressão de entrada, e não contém nennum campo.
No programa acima `input()` é uma instância de `LeNumero`.

Agora vocês irão adicionar um método `valor(self, vars)` às classes acima,
dando a sua implementação. Assuma que `vars` é um dicionário que associa
nomes de variáveis a seus valores atuais. Nas operações de comparação 
`valor` deve retornar 0 se a operação for falsa e 1 se for verdadeira,
pois MicroPython não possui valores booleanos. Lembrando que lemos
um o valor associado a um nome em um dicionário usando uma operação
de indexação: `vars["x"]` lê o valor associado a `x`.

As classes a seguir modelam os comandos. Implemente as classes, declarando seus campos
e seu construtor:

`Imprime` modela um comando de escrita, e contém a expressão cujo valor
será escrito. No programa acima, `print fact` é uma instância de `Imprime`.

`Atrib` modela um comando de atribuição, e contém o **nome** da variável a ser
atribuída e a expressão cujo valor será atribuído. No programa acima, 
`x = input()`, `fact = 1`, `fact = fact * x` e `x = x - 1` são todos
instâncias de `Atrib`.

`If` modela um comando `if/then/else`, e contém a expressão de teste e
dois comandos, um para a parte `then` e outro para a parte `else`. Tudo entre
a segunda e a última linhas no programa acima é uma instância de `If`.

`While` modela um comando `while`, e contém um comando para o
corpo do laço e uma expressão para a condição do laço. Tudo entre as linhas
4 e 6 do programa acima é uma instância de `While`.

`Bloco` modela uma sequência de comandos, e contém uma lista de comandos. 

O programa exemplo mostrado no início dessa página é uma instância de `Bloco`
com dois comandos,
uma atribuição e um `if`. O corpo do `If` é um bloco com três comandos, uma
atribuição, um `While` e um `Imprime`, e o corpo do `While` é um bloco com
dois comandos, ambos de atribuição.

Finalmente, adicionem um método `executa(vars)` às classes dos comandos.
Esse método também recebe um dicionário que associa variáveis a seus valores
atuais. Usem sua intuição e conhecimento de programação para deduzir como
cada comando deve funcionar.

****

O trecho de código a seguir instancia um programa MicroPython com a estrutura
do programa fatorial acima. Note como é passado um bloco vazio para o lado `else` do
`if`.

{% highlight python %}
    prog = Bloco([Atrib("x", LeNumero()),
                  If(Menor(Num(0), Var("x")),
                     Bloco([Atrib("fat", Num(1)),
                            While(Menor(Num(0), Var("x")),
                                  Bloco([Atrib("fat", Mul(Var("fat"), Var("x"))),     
                                         Atrib("x", Sub(Var("x"), Num(1)))])),
                            Imprime(Var("fat"))]),
                     Bloco([]))])
    prog.executa({})
{% endhighlight %}

O trecho de código a seguir calcula a média final das três provas pelas
nossas regras de avaliação:

{% highlight python %}
    # p1 = input()
    # p2 = input()
    # p3 = input()
    # if p1 < p2:
    #   if p1 < p3:
    #     print (p2 + p3) / 2
    #   else:
    #     print (p1 + p2) / 2
    # else:
    #   if p2 < p3:
    #     print (p1 + p3) / 2
    #   else:
    #     print (p1 + p2) / 2
    prog = Bloco([Atrib("p1", LeNumero()),
                  Atrib("p2", LeNumero()),
                  Atrib("p3", LeNumero()),
                  If(Menor(Var("p1"), Var("p2")),
                     If(Menor(Var("p1"), Var("p3")),
                        Imprime(Div(Soma(Var("p2"), Var("p3")), Num(2))),
                        Imprime(Div(Soma(Var("p1"), Var("p2")), Num(2)))),
                     If(Menor(Var("p2"), Var("p3")),
                        Imprime(Div(Soma(Var("p1"), Var("p3")), Num(2))),
                        Imprime(Div(Soma(Var("p1"), Var("p2")), Num(2)))))])
    prog.executa({});
{% endhighlight %}

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
