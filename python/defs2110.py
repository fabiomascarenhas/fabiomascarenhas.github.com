# -*- coding: cp1252 -*-
# Iteração (loops ou laços)

# Laço for
#
# for <var controle> in <seq>:
#   <cmd1>
#   ...
#   <cmdn>
#
# Executa o bloco para cada elemento em <seq>, atribuindo
# cada elemento à variável <var controle>

# O caractere c está dentro da string s?
def contem(s, c):
    # Para cada caractere de s
    for car in s:
        if car == c:
            return True
    return False

# Laços com acumulador

# Quantas vezes c aparece em s?
def quantas_vezes(s, c):
    # acumulador
    a = 0
    for car in s:
        if car == c:
            a = a + 1
    return a

# Reimplementa str.find
# Acha a posição da primeira ocorrência de c em s (se não achar retorna -1)
def strfind(s, c):
    # onde estou
    pos = -1
    for car in s:
        pos = pos + 1
        if car == c:
            # achei e está em pos
            return pos
    # não achei
    return -1    

# Acha a posição da ultima ocorrência de c em s (se não achar retorna -1)
def ultima(s, c):
    # onde estou
    pos = -1
    # posição da última ocorrência
    res = -1
    for car in s:
        pos = pos + 1
        if car == c:
            res = pos
    return res

# Função construtora de sequências numéricas: range
# range(n): 0, 1, ..., n-1 (intervalo [0,n))
def ultima2(s, c):
    # posição da última ocorrência
    res = -1
    for pos in range(len(s)):
        if s[pos] == c:
            res = pos
    return res

# range(n1, n2): n1, n1+1, ..., n2-1 (intervalo [n1,n2))
# acha primeira ocorrência de c em s começando a partir do elemento n:
def strfind2(s, c, n):
    for pos in range(n, len(s)):
        if s[pos] == c:
            return pos
    return -1

def strfind3(s, c, n):
    pos = n    
    for car in s[n:len(s)]:
        if car == c:
            return pos
        pos = pos + 1
    return -1

# range(n1, n2, n3): n1, n1 + n3, ...,
#       (último número que não ultrapassa ou iguala a n2)
# range(0, n, 1) é o mesmo que range(n)
# range(n1, n2, 1) é o mesmo que range(n1, n2)

# Soma dos números ímpares menores que n:
def somaimp(n):
    soma = 0
    for x in range(1, n, 2):
        soma = soma + x
    return soma

def ultima3(s, c):
    for pos in range(len(s)-1, -1, -1):
        if s[pos] == c:
            return pos
    return -1

# Listas
# Sequências de elementos onde podemos acrescentar e remover elementos
# Em geral listas são homogêneas: os elementos têm o mesmo tipo
# Constrói-se uma lista de várias maneiras
# A mais simples é construir do mesmo modo que uma tupla, mas usando []
# ao invés de ()

L1 = [3, 9, 0, 4, 5, 7]
L2 = ["foo", "abc", "abracadabra", "ola mundo"]
# Lista heterogênea
L3 = [42, True, "foo", (4, 5)]

# Operações
# Tamanho
# len(L1) == 6
# len(L2) == 4
# Indexaçao
# L1[3] == 4
# L2[0] == "foo"
# L3[-1] == (4, 5)
# Fatiar
L4 = L1[2:5]
# L4 == [0, 4, 5]

# Soma uma lista de números
def soma(l):
    s = 0
    for x in l:
        s = s + x
    return s

# As funções range retornam listas!

# Números ímpares menores que n
def impares(n):
    return range(1, n, 2)

def somaimp2(n):
    return soma(impares(n))
