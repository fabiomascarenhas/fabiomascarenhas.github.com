# -*- coding: cp1252 -*-

# Questao 1

"""
>>> l1 = [1,2,3]
>>> l2 = [1,2,3]
>>> l3 = l2
>>> l2[1] = 5
>>> l1
[1, 2, 3]
>>> l2
[1, 5, 3]
>>> l3
[1, 5, 3]
>>> 
"""

# Questao 2

# Letra a

# Elemento 0 tem o grau do polinônio
# Elemento 1 tem o grau - 1
# ...
# Elemento len(poli)-1 tem grau 0

def valor(poli, x):
    val = 0
    for i in range(len(poli)):
        grau = len(poli) - 1 - i
        val = val + poli[i] * (x ** grau) 
    return val

def valor2(poli, x):
    val = 0
    grau = len(poli) - 1
    for coef in poli:
        val = val + coef * (x ** grau)
        grau = grau - 1
    return val

# Letra b

def derivada(poli):
    res = []
    for i in range(len(poli)-1):
        grau = len(poli) - 1 - i
        list.append(res, poli[i] * grau)
    return res

def derivada2(poli):
    res = []
    grau = len(poli) - 1
    for coef in poli:
        if grau > 0:
            list.append(res, coef * grau)
        grau = grau - 1
    return res

# Letra c

def somapoli(l):
    tam = 0
    for poli in l:
        if len(l) > tam:
            tam = len(l)
    res = [0] * tam
    for poli in l:
        for i in range(len(poli)):
            grau = len(poli) - 1 - i
            ir = grau + len(res) - 1
            res[ir] = res[ir] + poli[i]
    return res

def somapoli2(l):
    res = []
    for poli in l:
        if len(poli) > len(res):
            for _ in range(len(poli) - len(res)):
                list.insert(res, 0, 0)
        for i in range(len(poli)):
            grau = len(poli) - 1 - i
            ir = grau + len(res) - 1
            res[ir] = res[ir] + poli[i]
    return res

def somapoli3(l):
    res = []
    for poli in l:
        if len(poli) > len(res):
            for _ in range(len(poli) - len(res)):
                list.insert(res, 0, 0)
        for i in range(len(poli)):
            ir = i + len(res) - len(poli)
            res[ir] = res[ir] + poli[i]
    return res

# Questao 3

def triangular(m):
    for i in range(len(m)):
        for j in range(len(m[i])):
            if i > j and m[i][j] != 0:
                return False
    return True

# Questao 4

def checasol(sist, xs):
    for eq in sist:
        val = 0
        for i in range(len(eq)-1):
            val = val + eq[i] * xs[i]
        if val != eq[-1]:
            return False
    return True



