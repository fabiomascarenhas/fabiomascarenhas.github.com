---
layout: default
title: Lab I de MAB 240
---

MAB 240 - Computação II
=======================

Laboratório 1 - 29/10/2012
--------------------------

1\. Crie um projeto Eclipse chamado Lab1, e dentro da pasta `src` desse
projeto crie um arquivo `Ola.java` e digite o seguinte código Java nele:

{% highlight java %}
public class Ola {

    public static int soma(int a, int b) {
        return a + b;
    }

    public static void main(String[] args) {
        System.out.println("A soma de 2 e 3 é: " + soma(2,3));
    }

}
{% endhighlight %}

Execute o projeto e veja o resultado. Crie um *scrapbook* para esse
projeto (um arquivo chamado **`scrapbook.jpage`** e inspecione o
resultado de algumas expressões. Escreva os seguintes trechos de código
Java, selecione-os com o mouse e escolha "Inspect" no menu que aparece
no clique do botão direito:

{% highlight java %}
2 + 3

new Ola()

Ola.soma(2,3)

System.out.println(Ola.soma(2,3));

String a = "Olá";
String b = " Mundo";
return a + b;
{% endhighlight %}

Use esse mesmo projeto Eclipse para o resto dos exercícios desse
laboratório.

2\. Um programa de uma loja de carros precisa das seguintes informações
sobre cada carro: o modelo, o preço, o consumo médio de combustível e se
o carro é novo ou usado. Escreva uma classe `Carro` que agrupe essas
informações: seus atributos e seu construtor, depois crie e inspecione
algumas instâncias de `Carro` no *scrapbook*. Dica: use a operação
`File->New->Class` no menu do Eclipse.

3\. Um programa para um agente imobiliário precisa guardar para cada
imóvel a sua metragem, o número de quartos, o número de vagas de
garagem, seu endereço, e os dados do proprietário atual. O endereço
consiste do logradouro, do número, de um complemento e do bairro. Os
dados do proprietário são seu nome e telefone. Modele esse problema como
um conjunto de três classes, `Imovel`, `Endereco` e `Proprietario`.
Escreva as classes, seus campos e seus construtores.

4\. *[Frogger](http://www.jogos-viciantes.com/frogger/)* era outro jogo
da época do Atari em que um sapo tinha que atravessar uma auto-estrada
sem ser atropelado pelos carros, depois atravessar um rio saltando em
troncos e tartarugas que passavam sem se afogar. O jogador tinha um
tempo determinado para fazer as travessias.

![](http://www.atariage.com/2600/screenshots/s_Frogger_1.png)

Modele as classes `Sapo` e `Carro` de uma versão simplificada de Frogger
em que só existe a travessia da estrada com os carros. O sapo vai ser
representado por um círculo e os carros por retângulos com tamanhos
diferentes, e que podem se mover em direções diferentes e com
velocidades diferentes. O sapo também tem um número de vidas.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M }}
