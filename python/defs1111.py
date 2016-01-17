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

# primeiro divisor de n
def divisor(n):
    for d in range(2,n):
        if n % d == 0:
            return d
    # nenhum divisor entre 2 e n-1
    return n

# primeiro divisor de n
def primo(n):
    for d in range(2,n):
        if n % d == 0:
            return False
    # nenhum divisor entre 2 e n-1
    return True

# s é um palíndromo
def palindromo(s):
    for i in range(len(s)/2):
        if s[i] != s[len(s)-i-1]:
            return False
    return True

# extrai digitos de uma string s
def digitos(s):
    resp = ""
    for c in s:
        if "0" <= c <= "9":
            resp = resp + c
    return int(resp)

# concatena strings de uma lista
def concat(ls):
    resp = ""
    for s in ls:
        resp = resp + s
    return resp

# números >=0 e <0
def classifica(ln):
    pos = 0
    neg = 0
    for n in ln:
        if n >= 0:
            pos = pos + 1
        else:
            neg = neg + 1
    return pos, neg

def ou_lista(lb):
    for b in lb:
        if b == True:
            return True
    return False

# Verifica se números da lista estão no intervalo
# par lista -> bool
def no_intervalo(inter, ln):
    a, b = inter
    for n in ln:
        if n < a or n > b: # n não está no intervalo
            return False
    return True

def replace(s, de, por):
    resp = ""
    for c in s:
        if c == de:
            resp = resp + por
        else:
            resp = resp + c
    return resp

# Fatorando replace em duas funções
def troca(c, de, por):
    if c == de:
        return por
    else:
        return c

def replace2(s, de, por):
    resp = ""
    for c in s:
        resp = resp + troca(c, de, por)
    return resp

# Fatorando digitos

def e_digito(c):
    if "0" <= c <= "9":
        return c
    else:
        return ""

def sdigitos(s):
    resp = ""
    for c in s:
        resp = resp + e_digito(c)
    return resp

def digitos2(s):
    return int(sdigitos(s))

# Distânca entre dois pontos
def dist(p1, p2):
    x1, y1 = p1
    x2, y2 = p2
    return math.sqrt((x2 - x1)**2 + (y2 - y1)**2)

# Perímetro de um polígono dado por lista de pares
def perimetro(pontos):
    soma = 0
    for i in range(1, len(pontos)):
        soma = soma + dist(pontos[i-1], pontos[i])
    soma = soma + dist(pontos[-1], pontos[0])
    return soma

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

# A diferença entre listas e outras sequências que vimos (strings e tuplas)
# é que listas são MUTÁVEIS

# Troco o elemento 3 de L1 por 10
L1[3] = 10

# Dobra os elementos de uma lista
# lista -> (efeito: modifica l)
def dobra(l):
    for i in range(len(l)):
        l[i] = l[i] + l[i]

# Função list.append
# list.append(lista, elem) => efeito: adiciona elem ao final da lista

# Função list.insert
# list.insert(lista, pos, elem) => efeito: adiciona elem à posição pos
#   "empurra" os elementos pra frente

# Operação del
# del lista[pos] => efeito: remove elemento da posição pos
#   "puxa" os elementos pra trás

# Dobra os elementos de uma lista, criando uma nova
# lista -> lista
def dobra2(l):
    resp = []
    for x in l:
        list.append(resp, x + x)
    return resp

# Retorna uma lista com elementos do intervalo
def intervalo(a, b, passo):
    resp = []
    for i in range(a, b, passo):
        list.append(resp, i)
    return resp

# Replace de listas
def replista(l, de, por):
    resp = []
    for x in l:
        if x == de:
            list.append(resp, por)
        else:
            list.append(resp, x)
    return resp

# Replace de listas "in-place" (modificando a lista)
def replista2(l, de, por):
    for i in range(len(l)):
        if l[i] == de:
            l[i] = por

# Função list.pop()
# retorna o último elemento da lista, e o remove como efeito colateral

# Função list.remove(lista, elem)
# Remove a primeira ocorrência de elem da lista

# Função list.index(lista, elem)
# Retorna o índice da primeira ocorrência de elem da lista

# Função list.count(lista, elem)
# Conta quantas vezes elem aparece na lista e retorna

# Função list.reverse(lista) - vira a lista do avesso como efeito colateral

# Função list.sort(lista) - põe os elementos em ordem crescente como
# efeito colateral






