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
de uma `ListaCons` produz o primeiro elemento, depois "vira" o elemento do resto da lista.

3\. Implemente a classe `ListaConcat`, que também implementa `Lista`, e possui dois campos, lista1
e lista2, ambos do tipo `Lista`. `ListaConcat` representa a concatenação dessas duas listas. Pense
em como implementar um enumerador para essa lista.

4\. Implemente a classe `ListaPG`, que também implementa `Lista` e representa uma progressão geométrica.
`ListaPG` tem três campos, a0, do tipo `int`, que é o elemento inicial, `q`, a razão da progressão, e n, também
do tipo `int`, o número de termos. Novamente, também implemente um enumerador
para essa lista.

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
que implementam `Lista`.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
