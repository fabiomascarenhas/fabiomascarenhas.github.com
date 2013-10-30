import math

# Questao 1

def producao(hora, nops):
    if hora < 10:
        return 2 * nops
    elif hora >= 10 and hora < 14:
        return 4 * nops
    else:
        return 3 * nops


# Questao 2

def dentro(coord, raio):
    x, y = coord
    return math.sqrt(x * x + y * y) <= raio


# Questao 3

def compra(conta, valor):
    saldo = conta['saldo']
    transacoes = conta['transacoes']
    media = conta['media']
    return { 'saldo': saldo + valor,
             'transacoes': transacoes + 1,
             'media': (transacoes * media + valor) / (transacoes + 1) }


# Questao 4

# Letra a

def gira(angulo):
    global DIR
    DIR = (DIR + angulo) % 360
    if DIR < 0:
        DIR = 360 + DIR

# Letra b

def radianos(angulo):
    return (angulo / 360.0) * 2 * math.pi

# Letra c

def anda(dist):
    global X, Y
    drad = radianos(DIR)
    X = X + math.cos(drad) * dist
    Y = Y + math.sin(drad) * dist
