---
layout: default
title: Laboratório 9
relpath: ..
---

## Laboratório 9

Uma lista é uma estrutura recursiva bem simples, e que pode ser usada
para representar uma coleção com um número arbitrário de elementos.
Uma lista possui dois campos: a *cabeça* da lista é valor do primeiro
elemento, e o *resto* é uma lista contendo os elementos restantes.

{% highlight c %}
struct Lista {
   int primeiro;
   struct Lista *resto;
};
{% endhighlight %}

Usamos o valor `0` para ser um ponteiro para uma lista vazia
(sem elementos).

1\. Implemente a função com a assinatura abaixo, que cria uma
nova lista dado o primeiro elemento e o resto.

{% highlight c %}
struct Lista *cria_lista(int primeiro, struct Lista *resto);
{% endhighlight %}

2\. Implemente a função `tamanho`, que recebe um ponteiro
para uma lista e retorna o número de elementos que a lista
tem.

3\. Implemente a função `soma`, que recebe um ponteiro para
uma lista e retorna a soma de todos os elementos da lista.

4\. Implemente a função `contem`, que recebe um ponteiro
para uma lista e um número, e retorna `0` se o número não
está na lista e `1` se ele está.

5\. Implemente a função `elemento`, que recebe um ponteiro
para uma lista e um índice inteiro, e retorna o elemento
que está naquele índice: 0 é o primeiro elemento, 1 o segundo
(o primeiro elemento do resto da lista), etc.

6\. Implemente a função `concatena`, que recebe dois ponteiros
para listas, e retorna uma nova lista contendo os elementos
das duas listas.

7\. Implemente a função `inverte`, que recebe um ponteiro para
uma lista e retorna uma nova lista com a ordem invertida: o primeiro
elemento passa a ser o último, o segundo o penúltimo, etc.

8\. Implemente a função com a assinatura abaixo, que recebe
duas listas nas quais os elementos estão em ordem crescente,
e retorna uma nova lista com os elementos de ambas as listas,
também em ordem crescente.

{% highlight c %}
struct Lista *merge(struct Lista *lord1, struct Lista *lord2);
{% endhighlight %}

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

