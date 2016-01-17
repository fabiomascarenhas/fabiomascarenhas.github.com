---
layout: default
title: Fabio Mascarenhas
relpath: ..
---

## Laboratório 1

Para cada questão abaixo, defina uma função em Python que calcule o 
que é pedido, e a teste no console com pelos menos três entradas diferentes.

Você é livre para dar os nomes que quiser para as funções, mas lembre de
tentar dar nomes que o ajudem a lembrar do que ela faz!

1\. Calcule a área de um retângulo dados seus dois lados. Teste pelo menos para os seguintes pares de entrada: 

    5 e 7; resposta esperada é 35
    15 e 2; resposta esperada é 30
    500 e 700; resposta esperada é 350000
    5 e 0; resposta esperada é 0

    # Área de um retângulo
    # número número -> número
    def area_ret(altura, largura):
        return altura * largura
    
2\. Calcule a área da coroa circular (anel) formada por dois círculos de raios `r1` e `r2`
(assuma que `r1` é sempre maior que `r2`), usando a definição de pi que está na biblioteca
`math`, `math.pi`.

    # Área de uma coroa circular
    # número número -> número
    def area_coroa(raio1, raio2):
        return math.pi * (raio1 ** 2 - raio2 ** 2)

3\. Calcule a ordenada de um polinômio de segundo grau dados os coeficientes `a`, `b`, `c` e a abscissa `x`.

    # Valor de um polinômio de segundo grau
    # número número número número -> número
    def polinomio(a, b, c, x) :
        return a * x * x + b * x + c

4\. Dado o valor da conta de um restaurante, calcule a gorjeta do garçom, considerando que o padrão
do restaurante é gorjeta de 10 por cento).

    # Gorjeta de um restaurante
    # número -> número
    def gorjeta(valor):
        return 0.10 * valor

5\. Calcule a média aritmética de dois números, sendo que o
resultado sempre tem que ser um número decimal. 

    # Média aritmética
    # número número -> float
    def media_arit(x, y):
        return (x + y) / 2.0

6\. Calcule a média ponderada de dois números e dois pesos, o resultado também tem que ser sempre decimal.

    # Média ponderada
    # número número número número -> float
    def media_pond(x, peso_x, y, peso_y):
        return (x * peso_x + y * peso_y) * 1.0 / (peso_x + peso_y)

7\. Calcule a distância que a correnteza arrasta um barco ao atravessar um rio dada a velocidade da correnteza,
a largura do rio e a velocidade do barco perpendicular à correnteza.

    # Arrasto da correnteza
    # número número número -> número
    def arrasto(vc, lr, vb):
        return (lr * 1.0 / vb) * vc

8\. Calcule o saldo final de uma conta dado o saldo inicial, o número de meses e a taxa de juros mensal,
considerando o uso de juros simples. O operador de exponenciação de Python é `**`.

    # Saldo final com correção
    # número int número -> número
    def saldo_final(inicial, meses, taxa):
        return inicial + (inicial * (taxa / 100.0) * meses)

9\. Calcule o erro entre o valor da soma de uma PG infinita começada com 1 (dada por `1/(1-q)`,
onde `q` é a razão com `0 <= q < 1`) e a soma dos 3 primeiros termos dessa PG.

    # Erro na soma de uma PG
    # float -> float
    def erro(q):
        return 1 / (1 - q) - (1 + q + q * q)  

10\. Dados a hora, minuto e segundo em que um corredor de uma maratona partiu, e dados a hora, minuto e segundos em que este mesmo corredor cruzou a linha de chegada, calcule o tempo total de prova deste corredor em segundos.

    # Tempo total de prova em segundos
    # int int int int int int -> int
    def tempo_prova(hp, mp, sp, hc, mc, sc):
        return (hc * 3600 + mc * 60 + sc) - (hp * 3600 + mp * 60 + sp)
