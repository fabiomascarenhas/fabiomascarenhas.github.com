---
layout: default
title: Fabio Mascarenhas
relpath: ..
---

## Laboratório 2

1\. João quer comprar o maior número de bombons possível com o dinheiro que tem. Faça funções para:

    I. calcular o número de bombons e o troco, dados o dinheiro e o preço do bombom.
    II. calcular quanto Joãozinho terá que pedir para sua mãe para comprar um bombom a mais, usando a função anterior.

{% highlight python %}
# Calcula quantos bombons e troco
# float float -> int float
def bombons(dinheiro, preco):
    return int(dinheiro / preco), dinheiro % preco
    
# Calcula quanto falta para mais um bombom
# float float -> float
def falta(dinheiro, preco):
    n, troco = bombons(dinheiro, preco)
    return preco - troco
{% endhighlight %}    

2\. Faça uma função que calcule a hipotenusa de um triângulo retângulo dados os seus catetos (use `math.sqrt`),
depois faça outra função que usa a primeira para calcular o perímetro do triângulo, dados seus catetos.

{% highlight python %}
# Hipotenusa dados os catetos
# num num -> num
def hipotenusa(b, c):
    return math.sqrt(b * b + c * c)

# Perímetro dados os catetos
# num num -> num
def perimetro(b, c):
    return hipotenusa(b, c) + b + c    
{% endhighlight %}    

3\. Faça uma função que calcule a distância entre dois pontos, dadas as suas coordenadas, usando a função
`hipotenusa` da questão 2.

{% highlight python %}
# Distância entre pontos
# num num num num -> num
def distancia(x1, y1, x2, y2):
    return hipotenusa(x2 - x1, y2 - y1)    
{% endhighlight %}    

4\. Faça uma função que calcule a soma do quadrado do seno com o quadrado do cosseno de um ângulo dado (use as
funções `math.sin` e `math.cos`).

{% highlight python %}
# Soma do quadrado do seno com quadrado do conseno
# num -> num
def soma_sincos(angulo):
    return math.sin(angulo) ** 2 + math.cos(angulo) ** 2
{% endhighlight %}    

5\. Calcule a distância que um barco percorreu ao atravessar um rio dadas a largura do rio, a velocidade do
barco perpendicular à correnteza e a velocidade da correnteza. Use na resposta duas funções que você já tem
(lembre-se das funções do [laboratório 1](lab1.html)).

{% highlight python %}
# Distância percorrida por barco
# num num num -> num
def distancia_barco(lr, vb, vc):
    return hipotenusa(lr, arrasto(vc, lr, vb))
{% endhighlight %}    

6\. Faça uma função para calcular a(s) raízes reais de uma equação de segundo grau, dados seus coeficientes. A
função deve retornar o número de raízes que a equação tem (0, 1 ou 2) seguido da(s) raíze(s), se existirem.

{% highlight python %}
# Raízes reais de uma eq. de 2o. grau
# num num num -> 0
# num num num -> 1 num
# num num num -> 2 num num
def raizes(a, b, c):
    delta = b * b - 4 * a * c
    if delta < 0:
        return 0
    elif delta == 0:
        return 1, (-b) / (2 * a)
    else:
        rdelta = math.sqrt(delta)
        return 2, (-b + rdelta) / (2 * a), (-b - rdelta) / (2 * a)
{% endhighlight %}    

7\. A distância que uma bala de canhão percorre é função do tempo de vôo e do componente horizontal de
sua velocidade. Faça funções para calcular a distância percorrida pela bala do canhão dado o ângulo de tiro e a velocidade da bala.

{% highlight python %}
# Gravidade
G = 9.8

# Tempo de vôo de uma bala de canhão
# num num -> num
def tempo_voo(angulo, vbala):
    vy = vbala * math.sin(angulo)
    return (vy / G) * 2

# Distância percorrida pela bala de um canhão
# num num -> num
def distancia_canhao(angulo, vbala):
    vx = vbala * math.cos(angulo)
    return vx * tempo_voo(angulo, vbala)
{% endhighlight %}    

8\. Calcule a soma de uma progressão aritmética dados o valor inicial, o valor final e a razão. Decomponha
o problema em três funções, uma para calcular o número de termos dados os valores inicial e final e a razão,
outra para calcular a soma dados os valores inicial e final e o número de termos, e a função pedida.

{% highlight python %}    
# Número de termos de uma PA
# num num num -> num
def ntermos(vi, vf, razao):
    return (vf - vi) / razao
    
# Soma de PA dados inicial e final e número de termos
# num num num -> num
def soma_pa1(vi, vf, nt):
    return (nt * (vi + vf)) / 2

# Soma de uma PA
# num num num -> num
def soma_pa2(vi, vf, r):
    return soma_pa1(vi, vf, ntermos(vi, vf, r))
{% endhighlight %}    

9\. Defina a função matemática a seguir. Qual o número mínimo de casos de teste para garantir que todas
as linhas do programa são executadas? Crie casos de teste para
os pontos de inflexão da função (as fronteiras entre cada parte).

![Função em partes](lab2_func.png)

{% highlight python %}
# Função em partes
# num -> num
def f(x):
    if x <= 2:
        return x
    elif x > 2 and x <= 3.5:
        return 2
    elif x > 3.5 and x <= 5:
        return 3
    else:
        return x * x - 10 * x + 28

# Precisamos de sete casos de teste, um para cada ponto de mudança entre as funções
# (2, 3.5, 5) e um interno para cada parte dela (por ex.: 1, 3, 4, 6)
{% endhighlight %}    

10\. Faça uma função que receba três valores e os retorne em ordem crescente. Faça uma função que receba três
valores e retorne o terceiro deles. Faça uma terceira função que compõe as duas anteriores para fazer
uma função que recebe três valores e retorna o maior deles.

{% highlight python %}
# Ordena três valores
# val val val -> val val val
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

# Retorna o terceiro de três valores
def terceiro(a, b, c):
    return c
    
# Retorna o maior de três valores
def max3(a, b, c):
    return terceiro(*ordena3(a, b, c))
{% endhighlight %}    
