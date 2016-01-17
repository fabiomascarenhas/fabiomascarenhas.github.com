# -*- coding: cp1252 -*-

# Questao 1

"""
>>> d1 = { "foo": 5, "bar": 2 }
>>> d2 = { "foo": 5, "bar": 2 }
>>> d3 = d2
>>> d2["foo"] = 3
>>> d1["foo"]
5
>>> d2["foo"]
3
>>> d3["foo"]
3
>>> 
"""

# Questão 2

X = 1.0
Y = 1.0
VX = 0.0
VY = 0.0
T = 0.0
G = 9.8

# Letra a
def reset(vx, vy):
    global VX, VY, X, Y, T
    VX = vx
    VY = vy
    X = 1.0
    Y = 1.0
    T = 0.0

# Letra b
def step():
    global X, Y, T, VY
    dt = 0.001
    if Y > 0.0:
        T = T + dt
        VY = VY - G * dt
        Y = Y + VY * dt
        X = X + VX * 0.001

# Questão 3

def disjuntos(lret):
    for r1 in lret:
        for r2 in lret:
            if r1 != r2 and intersecao(r1, r2):
                return False
    return True

def intersecao(r1, r2):
    r1se, r1id = r1
    r1ie = (r1se[0], r1id[1])
    r1sd = (r1id[0], r1se[1])
    return dentro(r1se, r2) or dentro(r1id, r2) or dentro(r1sd, r2) or dentro(r1se, r2)

def dentro(p, r):
    return (r[0][0] <= p[0] <= r[1][0]) and (r[1][1] <= p[1] <= r[0][1])

# Questão 4

def matriz(m, n):
    M = []
    for _ in range(m):
        list.append(M, [0] * n)
    return M

# Letra a
def transpoe(m):
    mt = matriz(len(m[0]), len(m))
    for i in range(len(m)):
        for j in range(len(m[0])):
            mt[j][i] = m[i][j]
    return mt

# Letra b
def transpoe_nolugar(m):
    for i in range(len(m)):
        for j in range(i):   # abaixo da diagonal principal
            temp = m[i][j]
            m[i][j] = m[j][i]
            m[j][i] = temp
    return m
