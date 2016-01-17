---
layout: default
title: Laboratório 8
relpath: ..
---

## Laboratório 8

1\. Escreva uma função que transforma uma lista de tuplas em um dicionário que
associa o primeiro componente de cada tupla ao segundo.

2\. Escreva a inversa da função da questão anterior, que transforma um dicionário
em uma lista de tuplas.

3\. Escreva uma versão da função da questão 2 em que as tuplas estão ordenadas pelo
primeiro componente. Lembre-se de `list.sort`, ou da função `ordena` do último laboratório.

4\. Escreva uma função que recebe uma lista e retorna uma nova lista sem elementos duplicados. Lembre que
os elementos duplicados não precisam aparecer em posições consecutivas. Dica: use um dicionário.

5\. Escreva uma versão da função anterior que modifica a lista passada para remover os elementos
duplicados.

6\. Escreva uma função que recebe uma frase e retorna a lista de palavras da frase, sendo que as palavras
estão separadas por espaços simples. Passe cada palavra para minúsculas com `str.lower` antes de incluir
ela na lista.

7\. Escreva uma função que converte números inteiros entre 1 e 999 para algarismos
romanos. Não converta o número para uma string, e use um laço `while`. Use os três dicionários abaixo:

{% highlight python %}
UNIDADES = { 0: '', 1: 'I', 2: 'II', 3: 'III', 4: 'IV', 5: 'V', 6: 'VI', 7: 'VII', 8: 'VIII', 9: 'IX' }
DEZENAS = { 0: '', 1: 'X', 2: 'XX', 3: 'XXX', 4: 'XL', 5: 'L', 6: 'LX', 7: 'LXX', 8: 'LXXX', 9: 'XC' }
CENTENAS = { 0: '', 1: 'C', 2: 'CC', 3: 'CCC', 4: 'CD', 5: 'D', 6: 'DC', 7: 'DCC', 8: 'DCCC', 9:'CM' }
{% endhighlight %}

8\. Escreva uma função para calcular o máximo divisor comum de dois números inteiros, usando o
algoritmo de Euclides. O pseudo-código abaixo descreve o funcionamento do algoritmo:

{% highlight pascal %}
AlgoritmoDeEuclides(a: inteiro; b: inteiro): inteiro
variáveis
   divisor: inteiro
   dividendo: inteiro
   c: inteiro
início
   
   se b > a então
   início
     dividendo = b
     divisor = a
   senão
     dividendo = a
     divisor = b
   fim-se
   
   enquanto resto(dividendo/divisor) ≠ 0
   início
      c = resto(dividendo/divisor)
      dividendo = divisor
      divisor = c
   fim-enquanto
   
   AlgoritmoDeEuclides = divisor
fim-função
{% endhighlight %}

9\. Faça a questão 10 do [laboratório 7](lab7.html), mas usando um laço `while` ao invés de um
laço `for`, e sem usar uma variávei de controle adicional além das duas variáveis usadas para
"caminhar" nas duas listas.

A busca do dicionário é uma forma de procurar rapidamente um elemento em uma sequência ordenada.
A ideia é, se eu quero procurar um elemento `x` no intervalo `[a, b)`, eu vejo se ele está no índice
`(a+b)/2`. Se ele não está eu mudo o meu intervalo para `[a,(a+b)/2)` se `x` for menor que o elemento
naquela posição, ou `[(a+b)/2+1,b)` se `x` for maior, e tento de novo. Se o intervalo for vazio (`a>=b`)
eu não encontrei o elemento.

10\. Faça uma função que recebe uma lista de pares em que o primeiro componente é uma string e o segundo
é um valor qualquer; os pares estão ordenados pelo primeiro componente. A função recebe uma string como
segundo parâmetro, e faz uma busca do dicionário na lista, olhando os primeiros componentes. Se a string
for encontrada, a função retorna o valor que está no segundo componente da tupla, caso contrário retorna
`None`. **Use um laço `while`**.
