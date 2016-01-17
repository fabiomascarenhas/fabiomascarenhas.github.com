# -*- coding: cp1252 -*-
# O estado do jogo de forca é um dicionário com os campos (ou componentes):
# "palavra": palavra pra ser advinhada (uma str de tamanho 4)
# "mascara": quais foram os acertos (quádrupla de bools)
# "erros": quantos foram os erros (um int)
JOGO = { "palavra": "abra", "mascara": (False, False, False, False), "erros": 0 }

# "soma" duas quádruplas de booleanos fazendo o ou lógico de cada componente
# mascara mascara -> mascara
def soma_mascara(m1, m2):
    return (m1[0] or m2[0], m1[1] or m2[1], m1[2] or m2[2], m1[3] or m2[3])

# diz se a máscara está completa (todos os elementos True) ou não
# mascara -> bool
def mascara_completa(m):
    return m[0] and m[1] and m[2] and m[3]

# Em que posições a letra aparece na palavra
# str str -> mascara
def tentativa(palavra, letra):
    return (palavra[0] == letra, palavra[1] == letra, palavra[2] == letra, palavra[3] == letra)

# Uma rodada do jogo, ou atualiza a mascara ou o número de erros
# estado str -> estado
def rodada(estado, letra):
    m = tentativa(estado["palavra"], letra)
    nova_mascara = soma_mascara(estado["mascara"], m)
    if nova_mascara != estado["mascara"]:
        return { "palavra": estado["palavra"],
                 "mascara": nova_mascara,
                 "erros": estado["erros"] }
    else:
        return { "palavra": estado["palavra"],
                 "mascara": estado["mascara"],
                 "erros": estado["erros"] + 1 }

# Uma rodada do jogo, testando se acabou ou não
# estado str -> "GANHOU"
# estado str -> "PERDEU"
# estado str -> estado
def rodada_final(estado, letra):
    novo_estado = rodada(estado, letra)
    if mascara_completa(novo_estado["mascara"]):
        return "GANHOU"
    elif novo_estado["erros"] == 6:
        return "PERDEU"
    else:
        return novo_estado

# Uma rodada do jogo, modificando o estado atual em JOGO
# str -> "GANHOU" (efeito: atualizar JOGO)
# str -> "PERDEU" (efeito: atualizar JOGO)
# str -> int      (efeito: atualizar JOGO)
def tenta(letra):
    global JOGO
    JOGO = rodada(JOGO, letra)
    if mascara_completa(JOGO["mascara"]):
        return "GANHOU"
    elif JOGO["erros"] == 6:
        return "PERDEU"
    else:
        return 6 - JOGO["erros"], JOGO["mascara"]

# Volta o jogo ao estado inicial
# str -> (efeito: atualizar JOGO)
def reseta(palavra):
    global JOGO
    JOGO = { "palavra": palavra, "mascara": (False, False, False, False), "erros": 0 }


# Estado global do jogo de forca
PALAVRA = "abra"
MASCARA = (False, False, False, False)
ERROS = 0

# Uma rodada do jogo
# str -> (efeito: modificar MASCARA e ERROS)
def rodada_glob(letra):
    global MASCARA
    global ERROS
    nova_mascara = soma_mascara(MASCARA, tentativa(PALAVRA, letra))
    if nova_mascara != MASCARA:
        MASCARA = nova_mascara
    else:
        ERROS = ERROS + 1

# Uma rodada do jogo, modificando o estado atual em JOGO
# str -> "GANHOU" (efeito: atualizar MASCARA e ERROS)
# str -> "PERDEU" (efeito: atualizar MASCARA e ERROS)
# str -> int      (efeito: atualizar MASCARA e ERROS)
def tenta_glob(letra):
    rodada_glob(letra)
    if mascara_completa(MASCARA):
        return "GANHOU"
    elif ERROS == 6:
        return "PERDEU"
    else:
        return 6 - ERROS, MASCARA

# Volta o jogo ao estado inicial
# str -> (efeito: atualizar PALAVRA, MASCARA e ERROS)
def reseta_glob(palavra):
    global PALAVRA
    global MASCARA
    global ERROS
    PALAVRA = palavra
    MASCARA = (False, False, False, False)
    ERROS = 0

# Pilha da calculadora RPN
P0 = 0 # topo da pilha
P1 = 0
P2 = 0
P3 = 0

# Move o conteúdo da pilha para baixo
# -> (efeito: modificar P0, P1, P2 e P3)
def store():
    global P0, P1, P2, P3
    P3 = P2
    P2 = P1
    P1 = P0
    P0 = 0

# Soma P0 com P1, movendo o conteúdo da pilha para cima
# -> (efeito: modificar P0, P1, P2 e P3)
def soma():
    global P0, P1, P2, P3
    P0 = P0 + P1
    P1 = P2
    P2 = P3
    P3 = 0

# Subtrai P1 de P1, movendo o conteúdo da pilha para cima
# -> (efeito: modificar P0, P1, P2 e P3)
def sub():
    global P0, P1, P2, P3
    P0 = P0 - P1
    P1 = P2
    P2 = P3
    P3 = 0

# Multiplica P0 com P1, movendo o conteúdo da pilha para cima
# -> (efeito: modificar P0, P1, P2 e P3)
def mult():
    global P0, P1, P2, P3
    P0 = P0 * P1
    P1 = P2
    P2 = P3
    P3 = 0

# Divide P0 por P1, movendo o conteúdo da pilha para cima
# -> (efeito: modificar P0, P1, P2 e P3)
def div():
    global P0, P1, P2, P3
    P0 = P0 / P1
    P1 = P2
    P2 = P3
    P3 = 0

# Funções que entra um dígito, fazendo P0 = P0 * 10 + digito
# -> (efeito: modificar P0)
def digito(d):
    global P0
    P0 = P0 * 10 + d

def zero():
    digito(0)

def um():
    digito(1)

# Inverte o sinal de P0
# -> (efeito: modificar P0)
def menos():
    global P0
    P0 = -P0

# Memória da calculadora
M = 0

# Soma P0 com a memória
# -> (efeito: modificar M)
def soma_m():
    global M
    M = M + P0

# Subtrai P0 da memória
# -> (efeito: modificar M)
def sub_m():
    global M
    M = M - P0

# Zera a memória
# -> (efeito: modificar M)
def zera_m():
    global M
    M = 0

# Zera a calculadora
# -> (efeito: modificar P0, P1, P2, P3 e M)
def reseta_calc():
    global P0, P1, P2, P3, M
    P0, P1, P2, P3, M = 0, 0, 0, 0, 0
