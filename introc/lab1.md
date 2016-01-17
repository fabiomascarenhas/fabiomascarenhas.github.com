---
layout: default
title: Fabio Mascarenhas
relpath: ..
---

## Laboratório 1

Para cada questão abaixo, defina uma função em C que calcule o 
que é pedido, e a teste na função principal com pelo menos três entradas diferentes.

1\. João quer comprar o maior número de bombons possível com o dinheiro que tem. Faça funções para:

    I. Calcular o número de bombons e o troco, dados o dinheiro e o preço do bombom.
    II. Calcular quanto Joãozinho terá que pedir para sua mãe para comprar um bombom a mais, usando a função anterior.

2\. Faça uma função que calcule a hipotenusa de um triângulo retângulo dados os seus catetos (inclua
a biblioteca `math.h` com a diretiva `#include` e use a função `sqrt`),
depois faça outra função que usa a primeira para calcular o perímetro do triângulo, dados seus catetos.

3\. Faça uma função que calcule a distância entre dois pontos, dadas as suas coordenadas, usando a função
`hipotenusa` da questão 2.

4\. Faça uma função para calcular a(s) raízes reais de uma equação de segundo grau, dados seus coeficientes. A
função deve retornar o número de raízes que a equação tem (0, 1 ou 2) mais a(s) raíze(s), se existirem.

5\. Calcule a soma de uma progressão aritmética dados o valor inicial, o valor final e a razão. Decomponha
o problema em três funções, uma para calcular o número de termos dados os valores inicial e final e a razão,
outra para calcular a soma dados os valores inicial e final e o número de termos, e a função pedida.

6\. Defina a função matemática a seguir. Qual o número mínimo de casos de teste para garantir que todas
as linhas do programa são executadas? Crie casos de teste para
os pontos de inflexão da função (as fronteiras entre cada parte).

![Função em partes](lab1_func.png)

7\. Faça uma função que receba três valores e os retorne em ordem crescente. Faça outra função que receba três
valores e retorne o terceiro deles. Faça uma terceira função que compõe as duas anteriores para fazer
uma função que recebe três valores e retorna o maior deles.

8\. Podemos representar uma cor usando uma três números decimais no intervalo `[0,1]`,
com cada número correspondendo à intensidade de uma das cores primárias (vermelho,
verde e azul). Defina as seguintes funções:

    I. `complemento`, que recebe uma cor e retorna seu complemento
    II. `soma`, que recebe duas cores e retorna sua "soma" (cada componente do resultado
    é o máximo entre os valores correspondentes nas duas cores dadas)
    III. `media`, que recebe duas cores e retorna uma cor em que cada componente é
    a média entre os valores correspondentes

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
