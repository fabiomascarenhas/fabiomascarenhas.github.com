# -*- coding: cp1252 -*-

import math
import random

# Listas têm elementos em comum?
# Ou: produto cartesiano das duas tem pares do mesmo elemento?
def comum(l1, l2):
    for x in l1:
        for y in l2:
            # (x,y) são os pares de l1 x l2
            if x == y:
                return True
    return False

# Intersecção de listas
def inter(l1, l2):
    res = []
    for x in l1:
        for y in l2:
            if x == y:
                list.append(res, x)
    return res

# Multiplicação de matriz por um escalar, "no lugar"
def mult_escalar(m, x):
    for i in range(len(m)): # len(m) é o número de linhas
        for j in range(len(m[0])): # len(m[0]) é o número de colunas
            # (i,j) são os pares linha,coluna da matriz
            # m[i][j] é um elemento da matriz
            m[i][j] = m[i][j] * x

# Matriz de números aleatórios
# Igual a matriz_zeros2 da aula de 25/11
def matriz_random(nlin, ncol, n):
    m = []
    for i in range(nlin):
        lin = []
        for j in range(ncol):
            list.append(lin, random.randint(0, n))
        list.append(m, lin)
    return m

# Matriz "triângulo"
# n deve ser ímpar
def triangulo(n):
    m = []
    n1s = 1
    n0s = (n-1) / 2
    while n1s <= n:
        # Preencher a linha e adicionar
        lin = []
        for _ in range(n0s):
            list.append(lin, 0)
        for _ in range(n1s):
            list.append(lin, 1)
        for _ in range(n0s):
            list.append(lin, 0)
        list.append(m, lin)
        n1s = n1s + 2
        n0s = n0s - 1
    return m

# Matriz "triângulo"
# n deve ser ímpar
def triangulo2(n):
    m = []
    n1s = 1
    n0s = (n-1) / 2
    while n1s <= n:
        # Preencher a linha e adicionar
        list.append(m, [0]*n0s + [1]*n1s + [0]*n0s)
        n1s = n1s + 2
        n0s = n0s - 1
    return m


# n deve ser ímpar
def triangulo3(n):
    m = []
    n1s = 1
    while n1s <= n:
        # Preencher a linha e adicionar
        lin = []
        for i in range(n):
            if n/2 - n1s/2 <= i <= n/2 + n1s/2:
                list.append(lin, 1)
            else:
                list.append(lin, 0)
        list.append(m, lin)
        n1s = n1s + 2
    return m

# Matriz de zeros com m linhas e n colunas:
def matriz_zeros(m, n):
    M = []
    for _ in range(m):
        lin = []
        for _ in range(n):
            list.append(lin, 0)
        list.append(M, lin)
    return M

# Matriz de pascal ordem n
def pascal(n):
    m = matriz_zeros(n, n)
    for i in range(n):
        for j in range(n):
            if i == 0 or j == 0:
                m[i][j] = 1
            else:
                m[i][j] = m[i-1][j] + m[i][j-1]
    return m

LISTA_ADJ = { 'Fulano': [ 'Cicrano', 'Beltrano' ],
              'Cicrano': [ 'Joao', 'Maria' ],
              'Beltrano':  [ 'Fulano', 'Cicrano', 'Maria' ],
              'Joao': [ 'Maria' ],
              'Maria': [ 'Joao' ] }

MEMBROS = { 'Fulano': 0, 'Cicrano': 1, 'Beltrano': 2, 'Joao': 3, 'Maria': 4 }
MATRIZ_ADJ = [ [ False, True , True , False, False ],
               [ False, False, False, True , True ],
               [ True , True , False, False, True ],
               [ False, False, False, False, True ],
               [ False, False, False, True , False ] ]

# Dicionário de membros a partir da lista de adjacência
def membros(lista_adj):
    dict = {}
    i = 0
    for membro in lista_adj:
        dict[membro] = i
        i = i + 1
    return dict

# Matriz quadrada de False de ordem n:
def matriz_falses(n):
    M = []
    for _ in range(n):
        lin = []
        for _ in range(n):
            list.append(lin, False)
        list.append(M, lin)
    return M

# matriz de adjacência a partir de dic. de membros e lista de adj.
def matriz_lista_aux(ms, lista_adj):
    mat = matriz_falses(len(ms))
    for membro in lista_adj:
        for rel in lista_adj[membro]:
            # pares (membro, rel) com os relacionamentos
            i = ms[membro]
            j = ms[rel]
            mat[i][j] = True
    return mat

# matriz de adjacência a partir de lista
def matriz_lista(lista_adj):
    return matriz_lista_aux(membros(lista_adj), lista_adj)

# Dicionário para lista
def lista_dict(dict):
    l = [None] * len(dict)
    for elem in dict:
        l[dict[elem]] = elem
    return l

# lista de adjacência a partir de matriz
def lista_matriz(membros, matriz_adj):
    ladj = {}
    lm = lista_dict(membros)
    for membro in membros:
        rels = []
        i = membros[membro]
        for j in range(len(matriz_adj)):
            if matriz_adj[i][j]: # j se relaciona com i
                list.append(rels, lm[j])
        ladj[membro] = rels
    return ladj

# "Amigos e amigos dos amigos"
def ada_ladj(membro, rede):
    res = []
    for x in rede[membro]:
        if x not in res:
            list.append(res, x)
        for y in rede[x]:
            if y not in res:
                list.append(res, y)
    return res

# "Amigos de amigos dos amigos"
def ada_madj(membro, membros, matriz):
    res = []
    i = membros[membro]
    lm = lista_dict(membros)
    for j in range(len(matriz)):
        if matriz[i][j]:
            rel = lm[j]
            if rel not in res:
                list.append(res, rel)
            for k in range(len(matriz)):
                if matriz[j][k]:
                    rel = lm[k]
                    if rel not in res:
                        list.append(res, rel)
    return res

# Amigos em comum
def ac_ladj(m1, m2, rede):
    res = []
    for rel1 in rede[m1]:
        for rel2 in rede[m2]:
            if rel1 == rel2:
                list.append(res, rel1)
    return res

# Amigos em comum
def ac_madj(m1, m2, membros, matriz):
    i = membros[m1]
    j = membros[m2]
    res = []
    lm = lista_dict(membros)
    for k in range(len(matriz)):
        if matriz[i][k] and matriz[j][k]:
            list.append(res, lm[k])
    return res

def mult_matriz(m1, m2):
    m3 = matriz_zeros(len(m1[0]), len(m2))
    for i in range(len(m3)): # para cada linha de m3
        for j in range(len(m3[0])): # para cada coluna de m3
            for k in range(len(m1[i])):
                m3[i][j] = m3[i][j] + m1[i][k]*m2[k][j]
    return m3

M1 = [[1, -1, 0],
      [0, 1, 0],
      [2, 0, 1]]
M2 = [[1, 1, 0],
      [0, 1, 0],
      [-2, -2, 1]]

