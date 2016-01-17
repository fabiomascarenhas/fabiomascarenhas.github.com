---
layout: default
title: Fabio Mascarenhas
relpath: ..
---

## Laboratório 3

1\. Escreva uma função `quebra_strn` que recebe uma cadeia de caracteres `s` e um número
inteiro `n` e retorna as subcadeias de `s` com os caracteres nos intervalos `[0,n)` e 
`(n, len(s))`.

{% highlight python %}
# Quebra uma string em duas partes
# str int -> str str
def quebra_strn(s, n):
    return s[0:n], s[n+1:len(s)]
{% endhighlight %}

2\. Escreva uma função `quebra_strc` que recebe uma cadeia de caracteres `s` e um
caractere `c` e retorna as subcadeias de `s` com os caracteres do início até a primeira
ocorrência de `c` (sem incluir `c`) e da primeira ocorrência de `c` até o final
(novamente sem incluir `c`). Dica: use `str.find(s, c)` e a resposta da questão 1.

{% highlight python %}
# Quebra uma string em duas partes
# str str -> str str
def quebra_strc(s, c):
    n = str.find(s, c) 
    return quebra_strn(s, n)
{% endhighlight %}

3\. Escreva uma função `quebra_str` que recebe uma cadeia de caracteres `s` e ou
um inteiro ou um caractere; caso o segundo parâmetro seja um número inteiro, ela
deve agir como `parte_strn` e caso ele seja um caractere ela deve agir como
`parte_strc`. Dica: use `type(v)` para ver se o segundo parâmetro é `int` ou `str`,
e as respostas das questões anteriores.

{% highlight python %}
# Quebra uma string em duas partes
# str int -> str str
# str str -> str str
def quebra_str(s, x):
    if type(x) == int:
        return quebra_strn(s, x)
    else: # x é uma str
        return quebra_strc(s, x)
{% endhighlight %}

4\. Escreva uma função `quebra_strci` que funciona como `parte_strc`, mas não faz
diferença entre letras maiúsculas e minúsculas. Dica: use `str.upper(s)`.

{% highlight python %}
# Quebra uma string em duas partes
# str str -> str str
def quebra_stri(s, c):
    n = str.find(str.upper(s), str.upper(c))
    return quebra_strn(s, n)
{% endhighlight %}

5\. Escreva uma função `escape` que recebe uma cadeia de caracteres `s` e retorna
uma nova cadeia substituindo todas as ocorrências do caractere `<` em `s` por `&lt;`,
e todas as ocorrências de `>` por `&gt;`. Dica: use a função `str.replace(s, de, por)`.

{% highlight python %}
# Substitui < por &lt; r > por &gt; na cadeia
# str -> str
def escape(s):
    s1 = str.replace(s, ">", "&gt;")
    s2 = str.replace(s1, "<", "&lt;")
    return s2
{% endhighlight %}

6\. Podemos representar uma cor usando uma tripla de números decimais no intervalo `[0,1]`,
cada elemento da tripla correspondendo à intensidade de uma das cores primárias (vermelho,
verde e azul). Defina as seguintes funções:

    I. `complemento`, que recebe uma cor e retorna seu complemento
    II. `soma`, que recebe duas cores e retorna sua "soma" (cada componente do resultado
    é o máximo entre os valores correspondentes nas duas cores dadas)
    III. `media`, que recebe duas cores e retorna uma cor em que cada componente é
    a média entre os valores correspondentes

{% highlight python %}
# Uma cor é uma tripla de valores float no intervalo [0.0,1.0]
BRANCO = (1.0, 1.0, 1.0)
PRETO = (0.0, 0.0, 0.0)
VERMELHO = (1.0, 0.0, 0.0)
VERDE = (0.0, 1.0, 0.0)
AZUL = (0.0, 0.0, 1.0)

# Complemento de uma cor
# cor -> cor
def complemento(cor):
    return (1.0 - cor[0], 1.0 - cor[1], 1.0 - cor[2])

# Máximo entre dois números
# num num -> num
def max(n1, n2):
    if n1 > n2:
        return n1
    else:
        return n2

# Soma de cores (máximo de cada compomente)
# cor cor -> cor
def soma(c1, c2):
    return (max(c1[0], c2[0]), max(c1[1], c2[1]), max(c1[2], c2[2]))

# Média aritmética entre dois números
# num num -> float
def median(n1, n2):
    return (n1 + n2) / 2.0

# Média de cores (média de cada componente)
# cor cor -> cor
def media(c1, c2):
    return (median(c1[0], c2[0]), median(c1[1], c2[1]), median(c1[2], c2[2]))
{% endhighlight %}

7\. O registro de um aluno do curso pode ser representado por um dicionário com
os seguintes campos: `nome` (cadeia de caracteres), `dre` (cadeia de caracteres),
`notas` (uma tripla de floats) e `faltas` (um número inteiro).

    I. Uma função que recebe três floats e retorna os dois maiores
    II. Uma função que recebe três floats a calcula a média aritmética dos dois
    maiores
    III. Uma função que recebe um aluno e retorna "AP" se ele foi aprovado, "RM" se
    foi reprovado apenas por ter média abaixo de 5, "RF" se foi reprovado apenas por
    ter mais do que sete faltas, e "RFM" se foi reprovado por ter média abaixo de 5 *e*
    mais do que sete faltas.
    IV. Uma função que recebe um aluno e retorna outro dicionário que associa o DRE do
    aluno a um par contendo o nome do aluno e a cadeia retornada pela função anterior.

{% highlight python %}
# Registro de um aluno é um dicionário com três componentes (ou campos)
# "nome" -> nome do aluno (uma str)
# "dre" -> DRE do aluno (uma str)
# "notas" -> tripla de notas (uma tripla de floats)
# "faltas" -> quantas faltas (um int)
JOAO = { "nome": "João", "dre": "123456789", "notas": (5.0, 3.5, 8.3), "faltas": 4 }
MARIA = { "nome": "Maria", "dre": "234567890", "notas": (5.0, 3.5, 4.0), "faltas": 4 }
FABIO = { "nome": "João", "dre": "345678901", "notas": (4.0, 3.5, 3.7), "faltas": 10 }
ZENOBIO = { "nome": "João", "dre": "456789012", "notas": (4.0, 3.5, 10.0), "faltas": 10 }

# Ordenação de três valores
# Funciona com qualquer tipo de valor que eu possa comparar!
def ordena3(a, b, c):
    if a < b:
        if b < c: # a < b < c
            return a, b, c
        else:
            if a < c: # a < c < b
                return a, c, b
            else: # c < a < b
                return c, a, b
    else:
        if c < b: # c < b < a.
            return c, b, a
        else:
            if a < c: # b < a < c
                return b, a, c
            else: # b < c < a
                return b, c, a

# Dá os dois maiores de três floats
# float float float -> float float
def dois_maiores(f1, f2, f3):
    min, med, max = ordena3(f1, f2, f3)
    return max, med

# Média aritmética dois dois maiores de três floats
# float float float -> float
def media_maiores(f1, f2, f3):
    return median(*dois_maiores(f1, f2, f3))

# Aluno aprovado ou não, e de que jeito
# aluno -> str
def aprovado(aluno):
    media = media_maiores(*aluno["notas"])
    faltas = aluno["faltas"]
    if media >= 5.0 and faltas <= 7:
        return "AP"
    elif media < 5.0 and faltas > 7:
        return "RFM"
    elif media < 5.0:
        return "RM"
    else:
        return "RF"

# Um registro de aprovação é um dicionário com um único componente
# O nome desse componente é o DRE de algum aluno, e seu valor uma dupla
# com o nome do aluno e sua condição de aprovação (uma dupla de str)

# A partir do aluno retorna um dicionário com seu registro
# de aprovação
# aluno -> ra
def ra(aluno):
    return { aluno["dre"]: (aluno["nome"], aprovado(aluno)) }
{% endhighlight %}

8\. Podemos representar o estado de um jogo simples de forca (restrito a palavras de
quatro letras) usando um dicionário com três campos: `palavra`, com a palavra que
precisa ser advinhada, `mascara`, uma quádrupla com quatro booleanos indicando quais
letras da palavra já foram acertadas (ou seja, `(False,False,False,False)` no início
do jogo e `(True,True,True,True)` se o jogo foi ganho), e `erros`, um inteiro com o número
de erros já cometido. Defina as seguintes funções:

    I. Uma função que recebe duas quádruplas de booleanos e retorna uma quádrupla
    com de booleanos em que cada elemento é ou lógico dos seus correspondentes.
    II. Uma função que recebe uma quádrupla de booleanos e retorna `True` se todos
    eles são `True` ou `False` se algum deles for `False`.
    III. Uma função que recebe uma palavra de quatro letras e uma letra, e retorna
    a máscara correspondente.
    IV. Uma função que recebe um estado de jogo e uma letra, e retorna um novo
    estado que contém uma máscara atualizada ou uma falha a mais.
    V. Uma função que recebe um estado de jogo e uma letra, chama a função anterior e
    retorna "GANHOU" se todos os elementos da máscara são `True`, "PERDEU" se o número
    de falhas é igual a 6, ou o novo estado caso não valha nenhuma das duas alternativas
    anteriores.

{% highlight python %}
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
{% endhighlight %}

