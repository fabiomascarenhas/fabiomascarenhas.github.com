---
layout: default
title: Lab 7 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 7 - 27/05/2015
--------------------------

A classe `Botao` que vocês usaram no [laboratório 5](lab5.html) e no [laboratório 6](lab6.html)
recebe no seu construtor um objeto com a ação que deve ser executada quando um
determinado botão é clicado.

Uma outra forma comum de definir a ação associada a um botão em uma interface gráfica é
através de herança. A classe `Botao` abaixo é uma classe abstrata, e o método abstrato
`executa` é responsável por executar a ação associada ao clique do botão.

{% highlight python %}
class Componente:
    def __init__(self, x, y, larg, alt):
        self.x1 = x
        self.y1 = y
        self.x2 = x + larg
        self.y2 = y + alt
        
    def desenhar(self, tela):
        raise NotImplementedError()

    def clicou(self, x, y):
        pass

    def apertou(self, x, y):
        pass

    def soltou(self, x, y):
        pass

    def arrastou(self, x, y):
        pass

class Botao(Componente):
    def __init__(self, x, y, larg, alt, texto):
        Componente.__init__(self, x, y, larg, alt)
        self.texto = texto
        self.cor_texto = (1, 1, 1)
        self.cor_fundo = (0, 0, 0)

    def executar(self):
        raise NotImplementedError()
        
    def apertou(self, x, y):
        self.cor_texto = (0, 0, 0)
        self.cor_fundo = (1, 1, 1)

    def soltou(self, x, y):
        self.cor_texto = (1, 1, 1)
        self.cor_fundo = (0, 0, 0)

    def clicou(self, x, y):
        self.executar()

    def desenhar(self, tela):
        tela.retangulo(self.x1, self.y1, self.x2 - self.x1,
                       self.y2 - self.y1, (1, 1, 1))
        tela.retangulo(self.x1 + 3, self.y1 + 3,
                       self.x2 - self.x1 - 6,
                       self.y2 - self.y1 - 6, self.cor_fundo)
        larg, alt = gui.tamanho_texto(self.texto)
        tela.texto(self.x1 + 50 - larg/2, self.y1 + 25 - alt/2, self.texto, self.cor_texto)
{% endhighlight %}

1\. Reescreva a aplicação da calculadora que você programou anteriormente (pode ser tanto a calculadora normal ou a 
RPN, tanto faz) para usar essa classe `Botao` ao invés da anterior. Não mude nada no código das duas
classes acima.

2\. Modifique a classe `Display` que você criou para herdar de `Componente` do mesmo modo que a classe `Botao`
acima. Também faça a classe `Display` ser abstrata, obtendo o texto a ser exibido de um método abstrato em seu
corpo, ao invés do método `valor` de um objeto passado no seu construtor. Faça as modificações na calculadora
para usar essa nova classe `Display`.

3\. Todas as expressões binárias do interpretador do [laboratório 4](lab4.html) (`Soma`, `Sub`, `Mul`, `Div`,
`Igual` e `Menor`) possuem uma estrutura muito parecida. Extraia essa estrutura em comum para uma classe abstrata
`ExpBin`. Essa classe deve ter um método abstrato `calcula(self, valor_esq, valor_dir)` que, nas classes concretas
que herdam de `ExpBin`, deve fazer o cálculo específico para aquele tipo de expressão. Por exemplo, a classe `Soma`
poderá ficar com a seguinte definição:

{% highlight python %}
class Soma(ExpBin):
    def calcula(self, valor_esq, valor_dir):
        return valor_esq + valor_dir
{% endhighlight %}

4\. Reescreva todas as classes de expressões binárias do [laboratório 4](lab4.html) para herdarem de sua classe `ExpBin`.

5\. Defina métodos `__repr__` para todas as classes do interpretador do [laboratório 4](lab4.html). A representação de uma
objeto do interpretador deve ser igual ao código necessário para reinstanciar aquele objeto. Por exemplo, uma instância de
`Num` cujo valor é `4` tem a representação `"Num(4)"`, enquanto um instância de `Soma` em que o lado esquerdo é uma
variável de nome `x` e o lado direito uma multiplicação entre um numeral `5` e um numeral `2` tem a representação
`"Soma(Var('x'),Mul(Num(5),Num(2)))"`. Use recursão estrutural para implementar `__repr__`.

6\. Defina métodos `__eq__` e `__ne__` para as classes do interpretador, de modo que duas instâncias sejam iguais se
tiverem a mesma estrutura (têm o mesmo tipo, e os valores de seus campos são iguais).

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

