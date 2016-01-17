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

# lista de tamanhos a partir de lista de strings
def tamanhos(ls):
    ts = []
    for s in ls:
        list.append(ts, len(s))
    return ts

t = tamanhos(["foo", "x", "abcxyz", "ola mundo"])

# strings de * a partir de lista de inteiros
def estrelas(nums):
    le = []
    for n in nums:
        list.append(le, '*' * n)
    return le
    
es = estrelas([1, 2, 3, 4, 10])

# Retorna nova lista com strings em ls com tam maior que n
def filtra_maiores(ls, n):
    res = []
    for s in ls:
        if len(s) > n:
            list.append(res, s)
    return res

lm = filtra_maiores(["foo", "x", "abcxyz", "ola mundo"], 3)

# As funções tamanhos e estrela seguem um padrão chamado "mapeamento"
# Um mapeamento de uma sequência é pegar cada elemento da sequência,
# aplicar uma operação a ele, e insere o resultado em outra sequência

# A função filtra_maiores segue um padrão chamado "filtro"
# Um filtro de uma sequência pega cada elemento dela, e insere em
# outra sequência os elementos que passam por algum teste

# Retira da lista strings com tamanho menor ou igual a n
def filtra_maiores_nolugar(ls, n):
    for i in range(len(ls)-1, -1, -1):
        if len(ls[i]) <= n:
            del ls[i]

LS = ["foo", "x", "abcxyz", "ola mundo"]
filtra_maiores_nolugar(LS, 3)

def filtra_maiores_nolugar_errada(ls, n):
    res = []
    for s in ls:
        if len(s) > n:
            list.append(res, s)

LS2 = ["foo", "x", "abcxyz", "ola mundo"]
filtra_maiores_nolugar_errada(LS2, 3)

# Particiona uma lista em duas listas, uma com elementos <n e outra com >=n
def particao(ln, n):
    menores, maiores = [], []
    for num in ln:
        if num < n:
            list.append(menores, num)
        else:
            list.append(maiores, num)
    return menores, maiores

# substitui cada elemento da lista pela raiz quadrada ou None
def raiz_nolugar(ln):
    for i in range(len(ln)):
        if ln[i] < 0:
            ln[i] = math.sqrt(-ln[i]) * 1j
        else:
            ln[i] = math.sqrt(ln[i])


# Troca elementos em uma lista
def troca(l, p1, p2):
    tmp = l[p1]
    l[p1] = l[p2]
    l[p2] = tmp

# Faz o menor elemento da lista a partir de pos ocupar
# a posição pos. O elemento que estava em pos vai para
# a posição do menor elemento
def desce(nums, pos):
    pmenor = pos
    # A cada volta no laço, pmenor aponta para o menor
    # elemento no intervalo [pos, i)
    for i in range(pos+1, len(nums)):
        if nums[i] < nums[pmenor]:
            pmenor = i
    # Agora o menor elemento é o da posição pmenor
    troca(nums, pmenor, pos)
    
LNUMS = [1, 2, 5, 8, 4, 9]
desce(LNUMS, 2)

# Ordena a lista em ordem crescente
def ordena(l):
    for i in range(0, len(l) - 1):
        desce(l, i)
        
LNUMS2 = [3, 2, 5, 9, 4, 8]
ordena(LNUMS2)

# Dicionários são mutáveis
DICT = { 'abc': 4, 'xyz': 5 }
DICT['abc'] = 8

# Podemos remover um elemento de um dicionário com del
del DICT['abc']

# Podemos inserir um elemento em um dicionário
DICT['ola'] = 10

# {} cria um dicionário vazio
DICT2 = {}
DICT2['abc'] = 8
DICT2['ola'] = 10

# for percorre as chaves do dicionário
def chaves(d):
    l = []
    for c in d:
        list.append(l, c)
    return l

# histograma da string s (quantas vezes cada caractere aparece)
def hist(s):
    d = {}
    for c in s:
        if c in d:  # chave existe no dicionário?
            d[c] = d[c] + 1
        else:
            d[c] = 1
    return d

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
    d = 2
    while d <= n:
        if n % d == 0:
            list.append(divs, d)
        d = d + 1
    return divs

# Use um laço while quando a sequência se quer repetir um conjunto de
# operações, mas não há uma sequência a percorrer, ou os elementos da
# sequência não são conhecidos a priori















