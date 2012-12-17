---
layout: default
title: Lab 6 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 6 - 17/12/2012
--------------------------

1\. Um programa editor gráfico usa a seguinte interface para representar
formas geométricas, que dá as ações que o usuário pode fazer para
manipular as formas no editor:

{% highlight java %}
      interface Forma {
        // Mover a forma, dado o deslocamento
        void mover(int dx, int dy);
        // Redimensiona a forma por um fator de escala
        void redimensionar(float escala);
        // Rotaciona a forma em tantos graus
        void rotacionar(int graus);
      }
{% endhighlight %}

Um dos requisitos do editor é oferecer *undo* (desfazer) e *redo*
(refazer) de vários níveis para o usuário, onde ele pode desfazer as
últimas ações tomadas, ou refazer ações desfeitas. Um jeito de fazer
isso é representar as ações do usuário como objetos que implementam a
seguinte interface:

{% highlight java %}
      interface Acao {
        void fazer();
        void desfazer();    
      }
{% endhighlight %}

1\.1\. Defina classes para cada uma das três ações que o usuário pode fazer com
uma forma: mover, redimensionar, rotacionar.

1\.2\. Complete o fragmento classe Editor abaixo (implementando os métodos
marcados com TODO), que implementa parte do recurso desfazer/refazer do
editor gráfico:

{% highlight java %}
      import java.util.Stack;

      class Editor {
        // Ações feitas
        Stack<Acao> feitas = new Stack<Acao>();
        // Ações desfeitas
        Stack<Acao> desfeitas = new Stack<Acao>();;

        void fazer(Acao a) {
          // TODO: faz uma ação nova
        }

        void desfazer() {
          // TODO: desfaz última ação,
          // caso possível
        }

        void refazer() {
          // TODO: refaz última ação,
          // caso possível
        }
      }
{% endhighlight %}

Toda vez que o usuário faz uma ação ela deve entrar na pilha de ações
feitas. Para desfazer uma ação remove-se a ação que está no topo dessa
pilha depois move-se ela para a pilha de ações desfeitas. Para refazer
uma ação remove-se a ação que está no topo de pilha de ações desfeitas
e move-se ela para a pilha de ações feitas. Não se esqueça de chamar
os métodos `fazer()` e `desfazer()` das ações!

2\. O padrão *enumerador* é uma maneira de se percorrer uma sequência de
elementos. Um objeto enumerador possui dois métodos, um produz os
elementos da sequência um por um, dando um erro se já produziu o último
elemento, e o outro diz se já se chegou ao final da sequência ou não.
Enumeradores para sequências de inteiros podem ser modelados pela
seguinte interface:

{% highlight java %}
    interface Enumerador {
      int proximo();
      boolean fim(); 
    }
{% endhighlight %}

2\.1\. Defina a classe `EnumVetor`, que implementa Enumerador e representa um
enumerador para um vetor de inteiros passado no construtor. O trecho a
seguir mostra um uso desse enumerador:

{% highlight java %}
    Enumerador e = new EnumVetor(new int[] { 1, 3, 5 });
    System.out.println(e.proximo()); // imprime 1
    System.out.println(e.fim()); // imprime false
    System.out.println(e.proximo()); // imprime 2
    System.out.println(e.proximo()); // imprime 3
    System.out.println(e.fim()); // imprime true
{% endhighlight %}

2\.2\. Escreva o corpo da função abaixo, que recebe um enumerador e retorna uma
lista com todos os elementos que ele pode produzir:

{% highlight java %}
    static java.util.List<Integer> listaDeEnum(Enumerador e) {
      // corpo
    }
{% endhighlight %}

* * * * *

Se você quiser testar o código que escreveu para a questão 1 pode usar a implementação teste de `Forma` abaixo:

{% highlight java %}
public class FormaParaTeste implements Forma {
  public FormaParaTeste() { }

  public void mover(int dx, int dy) {
    System.out.println("MOVER: " + dx + ", " + dy);
  }

  public void redimensionar(float escala) {
    System.out.println("REDIMENSIONAR: " + escala);
  }
  
  public void rotacionar(int graus) {
    System.out.println("ROTACIONAR: " + graus);
  }
}
{% endhighlight %}


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
