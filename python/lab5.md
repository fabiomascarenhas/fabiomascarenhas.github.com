---
layout: default
title: Laboratório 5
relpath: ..
---

## Laboratório 5

1\. Escreva uma função `dormindo` que recebe dois parâmetros booleanos, `diasemana` e `ferias`,
e retorna `True` se `diasemana` for falso ou `ferias` for verdadeiro, e `False` caso contrário.
Tente escrever a função sem usar `if` e `==`.

{% highlight python %}
# Estou dormindo?
# bool bool -> bool
def dormindo(diasemana, ferias):
    return (not diasemana) or ferias
{% endhighlight %}

2\. Escreva uma função `remove` que recebe como parâmetro uma string e uma posição nessa string
e retorna a string sem o caractere daquela posição (`remove('abrir', 3) == 'abrr'`).

{% highlight python %}
# Remove um caractere de uma string
# str int -> str
def remove(s, i):
    return s[0:i] + s[i+1:len(s)]
{% endhighlight %}

3\. Escreva uma função `nao` que adiciona a palavra `não` ao início de uma string, exceto se
ela já começar com a palavra `não` (`nao('quero') == 'não quero', nao('não quero') == 'não quero'`).

{% highlight python %}
# Nega uma sentença se já não estiver negada
# str -> str
def nao(s):
    if s[0:4] != "não ":
        return "não " + s
    else:
        return s
{% endhighlight %}

4\. Escreva uma função `envolve` que recebe duas strings como parâmetro, sendo que a primeira
sempre tem um número par de caracteres, e retorna uma nova string onde a segunda está no meio da primeira
(`envolve('<>', 'foo') == '<foo>', envolve('[[]]', 'bar') == '[[bar]]'`).

{% highlight python %}
# Envolve a segunda string na primeira
# str str -> str
def envolve(s1, s2):
    meio = len(s1) / 2
    return s1[0:meio] + s2 + s1[meio:len(s1)]
{% endhighlight %}

5\. Escreva uma função `tag` que recebe duas strings e cria uma "tag" HTML a partir delas
(`tag('i', 'texto') == '<i>texto</i>', tag('title', 'minha página') == '<title>minha página</title>'`).

{% highlight python %}
# Tageia uma string
# str str -> str
def tag(t, s):
    return '<' + t + '>' + s + '</' + t + '>'
{% endhighlight %}

6\. Escreva uma função que recebe uma tupla e retorna `True` se o primeiro elemento for igual ao
último elemento da tupla.

{% highlight python %}
# Início da tupla é igual ao final?
# tupla -> bool
def igual_if(tup):
    return t[0] == t[-1]
{% endhighlight %}

7\. Escreva uma função `inverte` que recebe uma tupla de três elementos e retorna uma nova tupla com os
elementos na ordem reversa.

{% highlight python %}
# Inverte elementos da tupla
# tup3 -> tup3
def inverte(tup):
    return tup[2], tup[1], tup[0]
{% endhighlight %}

8\. Escreva uma função `intercala` que recebe duas tuplas de três elementos cada e retorna uma
tupla de seis elementos intercalando as duas tuplas.

{% highlight python %}
# Intercala as duas tuplas
# tup3 tup3 -> tup6
def intercala(t1, t2):
    return t1[0], t2[0], t1[1], t2[1], t1[2], t2[2]
{% endhighlight %}

9\. Escreva uma função `opera` que recebe uma tupla com uma string e dois números; se a string
for `SOMA`, retorna a soma dos dois números, se for `MULT`, retorna a multiplicação, se for `DIV`,
retorna a divisão, se for `SUB`, retorna a subtração, se não for nenhuma das anteriores retorna `None`.

{% highlight python %}
# Faz uma operação descrita pela tupla
# tup3 -> num
def opera(tup):
    op, x, y = tup
    if op == 'SOMA':
        return x + y
    elif op == 'MULT':
        return x * y
    elif op == 'SUB':
        return x - y
    elif op == 'DIV':
        return x / y
    else:
        return None
{% endhighlight %}

10\. Escreva uma função que recebe uma string com o nome de um arquivo, e, se a extensão
dele for `.jpeg`, reescreve a string para que a extensão seja `.jpg`. Por exemplo, `arq.jpeg`
vira `arq.jpg`.

{% highlight python %}
# Reescreve .jpeg para .jpg
# str -> str
def jpeg2jpg(arq):
    if arq[-5:len(arq)] == '.jpeg':
        return arq[0:-5] + '.jpg'
    else:
        return arq
{% endhighlight %}

11\. Escreva uma função como a anterior, mas que, ao invés de reescrever apenas a extensão
`.jpeg` para `.jpg`, recebe como segundo parâmetro um dicionário que associa extensões a
novas extensões (por exemplo, `{ '.jpeg': '.jpg', '.texto': '.txt' }`.

{% highlight python %}
# Quebra uma string em duas partes, incluindo o caractere na segunda
# str str -> str str
def quebra_str(s, c):
    n = str.find(s, c) 
    return s[0:n], s[n:len(s)]

# Reescreve extensões
# str dict -> str
def rext(arq, exts):
    nome, ext = quebra_str(arq, '.')
    return nome + exts[ext]
{% endhighlight %}

12\. Um leilão pode ser descrito por um dicionário com quatro campos: `item`, uma string com o
nome do item, `vencedor`, uma string com o nome de quem deu o maior lance do leilão, `lance`, um float
com o valor do maior lance, e `encerrado`, um booleano dizendo se o leilão está encerrado ou não.
Escreva duas funções: a função `lance` recebe um leilão, um nome e um valor e, caso o leilão não esteja
encerrado e o valor seja maior que o valor do maior lance, retorna um novo leilão com o nome e valor
do maior lance atualizados, caso contrário simplesmente retorna o leilão; a função `encerra` recebe um
leilão e retorna um novo leilão com os dados do original, mas encerrado.

{% highlight python %}
# Leilão
LEILAO = { 'item': 'Nome do Item',
           'vencedor': 'Fulano',
           'lance': 123.50,
           'encerrado': False }

# Faz um novo lance no leilão
# leilao str float -> leilao
def lance(leilao, nome, valor):
    if not leilao['encerrado'] and leilao['lance'] < valor:
        return { 'item': leilao['item'],
                 'vencedor': nome,
                 'lance': valor,
                 'encerrado': False }
    else:
        return leilao
        
# Encerra o leilão
# leilao -> leilao
def encerra(leilao):
    return { 'item': leilao['item'], 'vencedor': leilao['vencedor'],
             'lance': leilao['lance'], 'encerrado': True }
{% endhighlight %}

13\. Um documento é um dicionário com um campo `tipo`, e outros campos que dependem do valor de `tipo`:
se `tipo` for a string `'carta'`, os campos são `destinatario`, `data` e `assinatura`;
se `tipo` for `'memo'`, os campos são `remetente`, `destinatario`,  `data` e `assunto`;
se `tipo` for `'cv'`, os campos são `nome` e `data`. Escreva a função `autor`, que recebe um documento
e retorna seu autor (quem assinou a carta, o remetente de um memo, ou o nome de um cv).

{% highlight python %}
# Uma carta
CARTA = { 'tipo': 'carta', 'destinatario': 'Fulano',
          'data', '10/10/2013', 'assinatura': 'Beltrano' }
# Um memorando
MEMO = { 'tipo': 'memo', 'remetente': 'Fulano',
         'destinatario': 'Beltrano', 'data': '10/10/2013',
         'assunto': 'Lab 5' }
# Um CV
CV = { 'tipo': 'cv', 'nome': 'Cicrano', 'data': '10/10/2013' }

# Autor de um documento
# doc -> str
def autor(doc):
   tipo = doc['tipo']
   if tipo == 'carta':
       return doc['assinatura']
   elif tipo == 'memo':
       return doc['remetente']
   else:
       return doc['nome']
{% endhighlight %}

14\. Um sólido pode ser descrito por um dicionário com um campo `tipo` (uma string), e outros campos de que dependem
do valor de `tipo`: se `tipo` for `cubo`, esse campo é `lado`; se `tipo` for `paralelepipedo`, os campos são
`comprimento`, `largura` e `altura`; se `tipo` for `esfera`, esse campo é `raio`. Escreva a função
`volume`, que calcula o volume de um sólido.

{% highlight python %}
# Volume de um sólido
# solido -> float
def volume(solido):
    tipo = solido['tipo']
    if tipo == 'cubo':
        return solido['lado'] ** 3
    elif tipo == 'esfera':
        return (4.0/3.0) * math.pi * (solido['raio'] ** 3)
    else:
        return solido['comprimento'] * solido['largura'] * solido['altura']
{% endhighlight %}

15\. Refaça a questão 12, mas com o estado do leilão armazenado em quatro variáveis globais, correspondendo
aos quatro campos do dicionário. A função `lance` agora recebe apenas um nome e um valor, e a função
`encerra` não recebe nenhum parâmetro. As duas funções atualizam o estado global, se necessário.

{% highlight python %}
# Estado do leilão
ITEM = 'Nome do Item'
VENCEDOR = 'Fulano'
LANCE = 123.50
ENCERRADO = False

# Novo lance no leilão
# str float -> (atualiza VENCEDOR e LANCE)
def lance(nome, valor):
    global VENCEDOR
    global LANCE
    if not ENCERRADO and LANCE < valor:
        VENCEDOR = nome
        LANCE = valor

# Encerra o leilão
# -> (atualiza ENCERRADO)
def encerra():
    global ENCERRADO
    ENCERRADO = True
{% endhighlight %}

16\. O estado de um robô é dado por um por um par de coordenadas guardadas em duas variáveis globais, `X` e `Y`,
inicialmente iguais a `0`, e por uma variável global `DIR` que indica para onde ele está virado (uma string
indicando norte, sul, leste ou oeste). Escreva três funções que controlam o movimento do robô: `move` recebe
um número inteiro e move o robô na direção atual, `esquerda` gira ele noventa graus para a esquerda e `direita`
gira ele noventa graus para a direita. As coordenadas do robô não podem ser menores que 0 nem maiores que 10.

{% highlight python %}
# Estado do robô
X = 0
Y = 0
DIR = 'N'

# Move o robô n casas
# int -> (altera X ou Y)
def move(n):
    global X, Y
    if DIR == 'N':
        Y = Y + n
        if Y > 10:
           Y = 10
    elif DIR == 'S':
        Y = Y - n
        if Y < 0:
            Y = 0
    elif DIR == 'L':
        X = X + n
        if X > 10:
           X = 10
    else:
        X = X - n
        if X < 0:
           X = 0

# Para onde o robô vai se girado pra esquerda
GIRA_ESQ = { 'N': 'O', 'O': 'S', 'S': 'L', 'L': 'N' }
# Para onde o robô vai se girado pra direita
GIRA_DIR = { 'N': 'L', 'L': 'S', 'S': 'O', 'O': 'N' }
        
# Gira o robô para a esquerda
# -> (altera DIR)
def esquerda():
    global DIR
    DIR = GIRA_ESQ[DIR]

# Gira o robô para a esquerda
# -> (altera DIR)
def direita():
    global DIR
    DIR = GIRA_DIR[DIR]
{% endhighlight %}
