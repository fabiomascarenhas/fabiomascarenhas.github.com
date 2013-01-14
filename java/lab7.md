---
layout: default
title: Lab 7 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 7 - 07/01/2013
--------------------------

Vamos lembrar da interface `Enumerador` do [laboratório 6](lab6.html):

{% highlight java %}
public interface Enumerador {
  int proximo();  // próximo elemento
  boolean fim();  // acabaram os elementos?
}
{% endhighlight %}

Imagine que temos a seguinte interface `Lista` para listas de inteiros:

{% highlight java %}
public interface Lista {
  int quantos();     // quantos elementos a lista tem
  int soma();        // soma dos elementos da lista
  Enumerador enumerador(); // um enumerador para essa lista
}
{% endhighlight %}

1\. Implemente a classe `ListaVazia`, que implementa `Lista` e representa uma lista sem elementos. Você vai
precisar de uma implementação para `Enumerador`, experimente usar tanto a própria classe
`ListaVazia` quanto uma classe auxiliar. O enumerador de uma lista vazia já começa com `fim()` retornando
`true`.

2\. Implemente a classe `ListaCons`, que também implementa `Lista`. Essa classe deve ter dois campos:
o campo primeiro, de tipo `int`, que é o primeiro elemento da lista, e o campo resto, de tipo `Lista`, 
que é o resto da lista. Novamente, você também vai precisar implementar `Enumerador`. O enumerador
de uma `ListaCons` produz o primeiro elemento, depois "vira" o enumerador do resto da lista (passa
a delegar `proximo()` e `fim()` para esse enumerador).

Não é estritamente necessário dar nome para uma nova classe para implementar o enumerador de `ListaCons`, 
você pode usar uma classe anônima:

{% highlight java %}
  public Enumerador enumerador() {
    return new Enumerador() {
      // campos

      public int proximo() {
        // implementação de proximo
      }

      public boolean fim() {
        // implementação de fim
      }
    };
  }
{% endhighlight %}

Um exemplo de uso de `ListaCons` e `ListaVazia`, para representar a lista 1, 3, 5:

{% highlight java %}
Lista l = new ListaCons(1, new ListaCons(3, new ListaCons(5, new ListaVazia())));
System.out.println(l.soma()); // 9
System.out.println(l.quantos()); // 3
Enumerador e = l.enumerador();
System.out.println(e.fim()) // false
System.out.println(e.proximo()); // 1
System.out.println(e.fim()) // false
System.out.println(e.proximo()); // 3
System.out.println(e.fim()) // false
System.out.println(e.proximo()); // 5
System.out.println(e.fim()) // true
{% endhighlight %}

3\. Implemente a classe `ListaConcat`, que também implementa `Lista`, e possui dois campos, lista1
e lista2, ambos do tipo `Lista`. `ListaConcat` representa a concatenação dessas duas listas. Pense
em como implementar um enumerador para essa lista.

{% highlight java %}
Lista l1 = new ListaCons(1, new ListaCons(3, new ListaCons(5, new ListaVazia())));
Lista l2 = new ListaCons(2, new ListaCons(4, new ListaCons(6, new ListaVazia())));
Lista l3 = new ListaConcat(l1, l2);
System.out.println(l3.quantos()); // 6
System.out.println(l3.soma()); // 21
Enumerador e3 = l3.enumerador();
while(!e3.fim()) System.out.println(e3.proximo()); // 1 3 5 2 4 6
{% endhighlight %}

4\. Implemente a classe `ListaPG`, que também implementa `Lista` e representa uma progressão geométrica.
`ListaPG` tem três campos, a0, do tipo `int`, que é o elemento inicial, `q`, a razão da progressão, e n, também
do tipo `int`, o número de termos. Novamente, também implemente um enumerador
para essa lista.

{% highlight java %}
Lista l1 = new ListaPG(2,4,5);
System.out.println(l1.quantos()); // 5
System.out.println(l1.soma()); // 682
Enumerador e1 = l1.enumerador();
while(!e1.fim()) System.out.println(e1.proximo()); // 2 8 32 128 512
{% endhighlight %}

5\. Um *fold à direita* (right fold) é uma construção em que pegamos uma operação binária `op`, uma lista
de elementos l1, l2, ..., ln, e um elemento *zero* z e fazemos o seguinte:

{% highlight java %}
l1 op l2 op ... ln op z 
{% endhighlight %}

Associamos `op` à direita, ou seja, fazemos primeiro `ln op z` e depois caminhamos da direita para a
esquerda. Se a operação é soma e a lista é 1, 2, 4, 6, 8 e o zero é 0 o fold à direita é `1 + (2 + (4 + (6 + (8 + 0))))`.

Suponha que temos a seguinte interface para operações binárias com inteiros:

{% highlight java %}
public interface OpBin {
  int op(int a, int b);  // faz a operação binária
}
{% endhighlight %}

Adicione o método `int foldr(OpBin op, int z)` à interface `Lista`. Esse método deve fazer um fold à direita
na lista, usando `op` como a operação e `z` como o zero. Implemente `foldr` nas classes que você implementou
que implementam `Lista`. Dica: o fold à direita de `ListaCons` e `ListaConcat` são facilmente descritos
através do fold de suas sublistas; para o fold à direita de `ListaPG` faz mais sentido caminhar na lista "de trás para frente",
começando pelo último elemento.

{% highlight java %}
OpBin soma = new OpBin() { public int op(int a, int b) { return a + b; } };
OpBin prod = new OpBin() { public int op(int a, int b) { return a * b; } };
Lista l1 = new ListaCons(1, new ListaCons(3, new ListaCons(5, new ListaVazia())));
System.out.println(l1.foldr(soma, 0)) // 9
System.out.println(l1.foldr(prod, 1)) // 15
Lista l2 = new ListaCons(2, new ListaCons(4, new ListaCons(6, new ListaVazia())));
System.out.println(l2.foldr(soma, 0)) // 12
System.out.println(l2.foldr(prod, 1)) // 48
Lista l3 = new ListaConcat(l1, l2);
System.out.println(l3.foldr(soma, 0)) // 21
System.out.println(l3.foldr(prod, 1)) // 720
Lista l4 = new ListaPG(2,4,5);
System.out.println(l4.foldr(soma, 0)) // 682
System.out.println(l4.foldr(prod, 1)) // 33554432
{% endhighlight %}

Enviando
--------

Use o formulário abaixo para enviar o Laboratório 7. O prazo para envio é segunda-feira, dia 14/01/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/30063133820642">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
