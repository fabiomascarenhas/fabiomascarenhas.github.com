---
layout: default
title: Lab 5 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 5 - 03/12/2012
--------------------------

O objetivo deste laboratório é exercitar a criação de interfaces
e classes que as implementam. Vocês farão isso no contexto da
implementação de um *interpretador*, um programa que executa
programas.

As construções dos programas que vamos executar
serão modeladas como instâncias de classes, mas as construções
do programa se dividem em dois tipos mais abstratos, Expressões
e Comandos, que iremos modelar com interfaces. A implementação
dos métodos dessas interfaces se tornará a implementação do
interpretador.

MicroJava é uma linguagem de programação bem simples, mas
relativamente completa, onde pegamos um subconjunto de Java
contendo expressões aritméticas simples (soma, subtração,
multiplicação, divisão), variáveis e atribuição (mas sem declarações
e tipos; todas as variáveis são do tipo `double`), entrada e
saída simples através de comandos `readDouble` e `println`, testes
`if` e laços `while`. Por exemplo, o programa MicroJava
abaixo calcula o fatorial de um número pedido na entrada e o
mostra na saída:

{% highlight java %}
    x = readDouble(); 
    if(0 < x) {
      fact = 1;
      while(0 < x) { 
        fact = fact * x;
        x = x - 1;
      }
      println(fact);
    }
{% endhighlight %}

Reparem que não é necessário declarar as variávieis `x` e `fact`, muito
menos declarar classes e métodos, um programa MicroJava é simplesmente uma
sequência de comandos MicroJava.

Nesse laboratório vocês irão implementar classes que modelam a estrutura
de um programa MicroJava, e métodos para executar expressões e comandos MicroJava.
As estruturas de um programa MicroJava se dividem em dois grupos, expressões
e comandos, então comece definindo as interfaces `Expressao` e
`Comando`. As classes a seguir modelam expressões, e todas elas devem
implementar a interface `Expressao`:

`Num` modela um numeral, e contém o valor do mesmo (um `double`). No programa
acima, 0 e 1 são instâncias de `Num`.  

`Var` modela uma variável, e contém o nome da variável e seu valor atual
(também um `double`). O construtor dessa classe deve receber apenas o
nome, e inicializar o valor da variável como 0. No programa acima, `x` e `fact`
são instâncias de `Var`.

`Soma`, `Sub`, `Mul` e `Div` modelam as quatro operações aritméticas, e
contêm duas expressões, para o lado esquerdo e o lado direito da
operação. No programa acima, `fact * x` é uma instância de `Mul` e `x - 1`
é uma instância de `Sub`.

`Igual` e `Menor` modelam as operações de comparação, e também contêm
expressões para o lado esquerdo e direito da operação. No programa acima, 
`0 < x` e `0 < fact` são instâncias de `Menor`.

`LeNumero` modela uma expressão de entrada, e não contém nennum campo.
No programa acima a `readDouble()` é uma instância de `LeNumero`.

Implemente as classes para todos os tipos de expressão, com seus
respectivos construtores. Agora vocês irão adicionar um método
`double valor();` à interface `Expressao`, e implementar esse método para
todas as classes acima. Nas operações de comparação `valor()` deve
retornar 0 se a operação for falsa e 1 se for verdadeira, pois MicroJava
não possui booleanos.

As classes a seguir modelam os comandos, e todas elas implementam a
interface `Comando`:

`Imprime` modela um comando de escrita, e contém a expressão cujo valor
será escrito. No programa acima, `println(fact);` é uma instância de `Imprime`.

`Atrib` modela um comando de atribuição, e contém a variável a ser
atribuída e a expressão cujo valor será atribuído. No programa acima, 
`x = readDouble();`, `fact = 1;`, `fact = fact * x` e `x = x - 1` são todos
instâncias de `Atrib`.

`If` modela um comando `if/then/else`, e contém a expressão de teste e
dois comandos, um para a parte `then` e outro para a parte `else`. Tudo entre
a segunda e a última linhas no programa acima é uma instância de `If`.

`While` modela um comando `while`, e contém um comando para o
corpo do laço e uma expressão para a condição do laço. Tudo entre as linhas
4 e 7 do programa acima é uma instância de `While`.

`Bloco` modela uma sequência de comandos, e contém um vetor de comandos. O
construtor de `Bloco` deve poder receber um número arbitrário de comandos
(use `...`). Todo o programa acima é uma instância de `Bloco` com dois comandos,
uma atribuição e um `if`. O corpo do `If` é um bloco com três comandos, uma
atribuição, um `while` e um `println`, e o corpo do `while` é um bloco com
dois comandos, ambos de atribuição.

Implemente as classes para todos os tipos de comando, com seus
respectivos construtores. Agora adicionem um método `void executa()` à
interface `Comando`, e implementem esse método para todas as classes
acima. Usem a sua intuição e seus conhecimentos de programação para
pensar sobre como cada comando funciona..

****

Dica: o código abaixo irá te ajudar na implementação do método
`executa()` da classe `LeNumero`:

{% highlight java %}
      // Variável global para a entrada padrão
      static java.util.Scanner STDIN = new java.util.Scanner(System.in);

      // Função para ler um double da entrada padrão
      static double readDouble() {
        return STDIN.nextDouble();
      }
{% endhighlight %}

O trecho de código a seguir instancia um programa MicroJava com a estrutura
do programa fatorial acima. Note como é passado um bloco vazio para o lado `else` do
`if`. Copie-o para o scrapbook e execute para ver o resultado:

{% highlight java %}
    Var x = new Var("x");
    Var fat = new Var("fat");
    Comando prog = 
      new Bloco(new Atrib(x, new LeNumero()),
                new If(new Menor(new Num(0), x),
                       new Bloco(new Atrib(fat, new Num(1)),
                                 new While(new Menor(new Num(0), x),
                                           new Bloco(new Atrib(fat, new Mul(fat, x)),
                                                     new Atrib(x, new Sub(x, new Num(1))))),
                                 new Imprime(fat)),
                       new Bloco()));
    prog.executa();
{% endhighlight %}

O trecho de código a seguir calcula a média final das três provas pelas
nossas regras de avaliação:

{% highlight java %}
    /*
    * read p1;
    * read p2;
    * read p3;
    * if p1 < p2 then
    *   if p1 < p3 then
    *     write (p2 + p3) / 2
    *   else
    *     write (p1 + p2) / 2
    *   end
    * else
    *   if p2 < p3 then
    *     write (p1 + p3) / 2
    *   else
    *     write (p1 + p2) / 2
    *   end
    * end
    */
    Var p1 = new Var("p1");
    Var p2 = new Var("p2");
    Var p3 = new Var("p3");
    Comando prog = new Bloco(new Atrib(p1, new LeNumero()),
                             new Atrib(p2, new LeNumero()),
                             new Atrib(p3, new LeNumero()),
                             new If(new Menor(p1,p2),
                                    new If(new Menor(p1,p3),
                                           new Imprime(new Div(new Soma(p2,p3),
                                                               new Num(2))),
                                           new Imprime(new Div(new Soma(p1,p2),
                                                               new Num(2)))),
                                    new If(new Menor(p2,p3),
                                           new Imprime(new Div(new Soma(p1,p3),
                                                               new Num(2))),
                                           new Imprime(new Div(new Soma(p1,p2),
                                                               new Num(2))))));

    prog.executa();
{% endhighlight %}

Enviando
--------

Use o formulário abaixo para enviar o Laboratórios 5. O prazo para envio é sexta-feira, dia 14/12/2012.

<script type="text/javascript" src="http://form.jotformz.com/jsform/23365304916655">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
