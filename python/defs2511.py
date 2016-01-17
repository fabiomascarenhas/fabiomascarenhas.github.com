# -*- coding: cp1252 -*-

import math

# Laço for
#
# for <var controle> in <seq>:
#   <cmd1>
#   ...
#   <cmdn>
#
# Executa o bloco para cada elemento em <seq>, atribuindo
# cada elemento à variável <var controle>

# <seq> pode ser uma string, uma tupla, um intervalo (range), uma lista

# divisores de n maiores que 1
def divisores(n):
    divs = []
    for d in range(2,n):
        if n % d == 0:
            list.append(divs, d)
    list.append(divs, n)
    return divs

d20 = divisores(20)

# Laço while
#
# while <condição>:
#   <cmd1>
#   ...
#   <cmdn>
#
# o laço while executa o bloco de comandos dele enquanto a condição for
# verdadeira; a cada volta no laço a condição é testada novamente, então
# é comum usar variáveis que mudam dentro do laço na condição
#

# Exemplo de laco while simples, que simula um laço for
# divisores de n maiores que 1
def divisores_while(n):
    divs = []
    d = 2  # variável de controle
    while d <= n:
        if n % d == 0:
            list.append(divs, d)
        d = d + 1 # avança para próximo item da sequência
    return divs

d20w = divisores_while(20)

# Use um laço while quando a sequência se quer repetir um conjunto de
# operações, mas não há uma sequência a percorrer, ou os elementos da
# sequência não são conhecidos a priori


UNIDADES = { 0: '', 1: 'I', 2: 'II', 3: 'III', 4: 'IV', 5: 'V', 6: 'VI', 7: 'VII', 8: 'VIII', 9: 'IX' }
DEZENAS = { 0: '', 1: 'X', 2: 'XX', 3: 'XXX', 4: 'XL', 5: 'L', 6: 'LX', 7: 'LXX', 8: 'LXXX', 9: 'XC' }
CENTENAS = { 0: '', 2: 'C', 2: 'CC', 3: 'CCC', 4: 'CD', 5: 'D', 6: 'DC', 7: 'DCC', 8: 'DCCC', 9:'CM' }

ALGARISMOS = { 1: UNIDADES, 10: DEZENAS, 100: CENTENAS }

# Conversão de inteiros entre 0 e 999 para algarismos romanos
def romanos(n):
    res = ""
    d = 100
    while n > 0:
        res = res + (ALGARISMOS[d])[n/d]
        n = n % d
        d = d / 10
    return res

# Algoritmo de Euclides para o MDC
def mdc(a, b):
    while a % b != 0:
        a, b = b, a % b
    return b

def mdc_literal(a, b):
    dividendo = a
    divisor = b
    if b > a:
        dividendo = b
        divisor = a
    while dividendo % divisor != 0:
        c = dividendo % divisor
        dividendo = divisor
        divisor = c
    return divisor

def mdc_for(a, b):
    for i in range(1000):
        if a % b == 0:
            return b
        a, b = b, a % b

# Junta duas listas ordenadas, mantendo a ordem crescente
def junta(l1, l2):
    l = []
    i = 0
    j = 0
    for _ in range(len(l1) + len(l2)):
        if j >= len(l2) or (i < len(l1) and l1[i] < l2[j]):
            list.append(l, l1[i])
            i = i + 1
        else:
            list.append(l, l2[j])
            j = j + 1
    return l

def junta_while(l1, l2):
    l = []
    i = 0
    j = 0
    while i < len(l1) or j < len(l2):
        if j == len(l2) or (i < len(l1) and l1[i] < l2[j]):
            list.append(l, l1[i])
            i = i + 1
        else:
            list.append(l, l2[j])
            j = j + 1
    return l
    
# Busca do dicionário em uma lista de pares (chave, valor), ordenado
# pela chave
def busca(lista, chave):
    a = 0
    b = len(lista)
    while a < b:
        meio = (a + b) / 2
        c, v = lista[meio]
        if chave == c:
            return v  # achei!
        if chave < c:
            b = meio
        else:
            a =  meio + 1
    return None

# Faz um "zipper" com duas listas de mesmo tamanho
def zip(l1, l2):
    l = []
    for i in range(len(l1)):
        list.append(l, (l1[i], l2[i]) )
    return l

# Laços aninhados

# Quem é a função f
def f(l1, l2):
    l = []
    for y in l2:
        for x in l1:
            # Percorre o "produto cartesiano" de l1 e l2
            list.append(l, (x, y) )
    return l

# A = { 1, 2, 3 }
# B = { 4, 5 }
# A x B = { (1, 4), (1, 5), (2, 4), (2, 5), (3, 4), (3, 5) }

# Matrizes

# Listas de listas onde cada lista tem o mesmo número de elementos,
# e corresponde a uma *linha* da matriz

M1 = [ [ 1, 2, 3 ],
       [ 4, 5, 6 ],
       [ 7, 8, 9 ] ]
    
# Soma todos os elementos de uma matriz
def soma_matriz(m):
    soma = 0
    for i in range(len(m)):  # len(m) é o no. de linhas
        for j in range(len(m[i])): # len(m[i]) é o no. de colunas
            # Produto cartesiano de [0, nlinhas) e [0, ncols)
            soma = soma + m[i][j]
    return soma

M1[1][1] = 0

# Matriz de zeros com m linhas e n colunas:
def matriz_zeros(m, n):
    M = []
    for i in range(m):
        list.append(M, [])
        for j in range(n):
            list.append(M[i], 0)
    return M

# Matriz de zeros com m linhas e n colunas:
def matriz_zeros2(m, n):
    M = []
    for _ in range(m):
        lin = []
        for _ in range(n):
            list.append(lin, 0)
        list.append(M, lin)
    return M

# Matriz de zeros com m linhas e n colunas:
def matriz_zeros3(m, n):
    M = []
    for _ in range(m):
        list.append(M, [0] * n)
    return M

# Matriz de zeros com m linhas e n colunas (errado):
def matriz_zeros4(m, n):
    return [[0] * n] * m

# Matriz de zeros com m linhas e n colunas (errado):
def matriz_zeros5(m, n):
    M = []
    linha = [0] * n
    for _ in range(m):
        list.append(M, linha)
    return M

