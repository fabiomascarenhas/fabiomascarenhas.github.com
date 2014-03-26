---
layout: default
title: Lab 1 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 1 - 12/02/2014
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

2\. Converta o programa C abaixo para um programa Java que faz a mesma
coisa, nos moldes do programa `IniVetor` visto na última aula:

{% highlight java %}
#include  <stdio.h>

int main (void)
{
	int vetor[5], i; 
	int trocou = 0;
	int fim = 5;
	int temp;

	printf("Entre com um vetor de %d elementos\n", 5);
	for (i = 0; i < 5; i++)
	{
		printf("Elemento %d ", i);
		scanf("%d", &vetor[i]);
	}

	do {
		trocou = 0;
		for (i=0; i < fim-1; i++)
		{
			if (vetor[i] > vetor[i+1])
			{
				temp = vetor[i];
				vetor[i] = vetor[i+1];
				vetor[i+1] = temp;
				trocou = 1;
			}
		}
		fim--;
	} while (trocou);

	for (i=0; i < 5; i++) printf("%d\n", vetor[i]);

	return 0;
}

{% endhighlight %}

3\. Um programa de uma loja de carros precisa das seguintes informações
sobre cada carro: o modelo, o preço, o consumo médio de combustível e se
o carro é novo ou usado. Escreva uma classe `Carro` que agrupe essas
informações: seus atributos e seu construtor, depois crie e inspecione
algumas instâncias de `Carro` no *scrapbook*. Dica: use a operação
`File->New->Class` no menu do Eclipse.

4\. Um programa para um agente imobiliário precisa guardar para cada
imóvel a sua metragem, o número de quartos, o número de vagas de
garagem, seu endereço, e os dados do proprietário atual. O endereço
consiste do logradouro, do número, de um complemento e do bairro. Os
dados do proprietário são seu nome e telefone. Modele esse problema como
um conjunto de três classes, `Imovel`, `Endereco` e `Proprietario`.
Escreva as classes, seus campos e seus construtores.

5\. A loja de carros do exercício 3 agora precisa que
os carros também tenham informações sobre seus donos.
Para isso crie uma classe `Dono` com os campos nome e idade, e
adicione um campo dono à classe `Carro`. Ela também precisa que os carros tenham um 
ano de fabricação (um campo `ano` do tipo `int`) *ao invés de* um campo que diz se
ele é novo ou usado. Faça essas alterações na classe `Carro`.
Não esqueça de corrigir o construtor de `Carro` para inicializar os novos campos!

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
