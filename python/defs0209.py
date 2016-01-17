# -*- coding: cp1252 -*-

import math

# Quantos bombons posso comprar
# número número -> int
def qtd_bombons_dec(dinheiro, preco):
    return int(dinheiro / preco)

# Qual o troco da compra
# número númer -> número
def troco_bombons_dec(dinheiro, preco):
    return dinheiro % preco

# Quantos bombons e qual o troco
# número número -> int número
def bombons_dec(dinheiro, preco):
    return qtd_bombons_dec(dinheiro, preco), troco_bombons_dec(dinheiro, preco)

# Quantos bombons posso comprar
# int int -> int
def qtd_bombons_int(dinheiro, preco):
    return dinheiro / preco

def troco_bombons_dec(dinheiro, preco):
    return dinheiro % preco

# Quantos bombons e qual o troco
# Valores em reais
# número número -> int número
def bombons_int(dinheiro, preco):
    dinheiro_cent = int(dinheiro * 100)
    preco_cent = int(preco * 100)
    return qtd_bombons_int(dinheiro, preco), troco_bombons_int(dinheiro, preco) / 100.0

# Hipotenusa dados os catetos
# número número -> float
def hipotenusa(b, c):
    return math.sqrt(b * b + c * c)

# Perimetro dados os catetos
# número número -> float
def perimetro(b, c):
    return b + c + hipotenusa(b, c)

# Soluções reais de uma eq. de 2o. grau
# Entrada: coeficientes
# Saida: número de soluções e soluções
# número número número -> 2 float float
# número número número -> 1 float
# número número número -> 0
def raizes(a, b, c):
    delta = b * b - 4 * a * c
    if delta < 0:
        return 0
    elif delta == 0:
        return 1, -b / (2.0 * a)
    else:
        rdelta = math.sqrt(delta)
        doisa = 2.0 * a
        menosb = -b
        return 2, (menosb + rdelta) / doisa, (menosb - rdelta) / doisa 
