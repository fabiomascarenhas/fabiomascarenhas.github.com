---
layout: default
title: Lab 5 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 5 - 29/04/2015
--------------------------

Esse laboratório é um aquecimento para trabalhar com o projeto do Editor Gráfico. 
O objetivo é usar o framework dado em sala para implementar a
interface gráfica de uma calculadora simples. O [projeto](calc.zip) já inclui o
*modelo* da calculadora (classe `ModeloCalc`), um objeto que implementa a lógica interna,
e fornece os seguintes métodos:

{% highlight python %}
    digito(self, i) # dígito de 0 a 9 pressionado
    soma(self)      # operação de soma (botão +)
    sub(self)       # operação de subtração (botão -)
    mult(self)      # operação de multiplicação (botão *)
    div(self)       # operação de divisão (botão /)
    igual(self)     # resultado da operação (botão =)
    reset(self)     # limpa calculadora (botão C)
    valor(self)     # retorna o valor atual do display como uma string
{% endhighlight %}

Os métodos não retornam nenhum valor, apenas afetam o estado interno da calculadora.
Vocês deverão implementar a parte da interface visível da calculadora, que deve
se comunicar com uma instância de `ModeloCalc`. A classe `Calculadora` é a classe
principal da aplicação, e já está quase pronta: falta apenas instanciar o display,
os botões, e as ações de cada botão.

A janela da calculadora tem 400 pixels de largura por 500 de altura. Os primeiros
100 pixels são o *display*. Depois há uma fileira de botões a cada 100 pixels,
onde cada botão é um quadrado 100x100. A primeira fileira tem os botões `7`,
`8`, `9` e `*`. A segunda fileira tem os botões `4`, `5`, `6` e `/`. A terceira
fileira tem os botões `1`, `2`, `3` e `-`. A quarta e última fileira tem os
botões `C`, `0`, `=` e `+`.

Você precisa criar uma classe `Display` para ser o
display. Essa classe é um componente, e precisa ter os seguintes atributos:

{% highlight python %}
    x1, y1 # campos contendo as coordenadas do canto superior esquerdo do display
    x2, y2 # campos contendo as coordendas do canto inferior direito do display
    desenhar(self, tela) # desenha o componente na tela
    clicou(self, x, y)   # avisa que um clique do mouse aconteceu
    apertou(self, x, y)   # avisa que o botão do mouse foi apertado
    soltou(self, x, y)    # avisa que o botão do mouse foi solto
    arrastou(self, x, y)  # avisa que o botão do mouse está sendo arrastado
{% endhighlight %}

O display tem uma borda branca de 3 pixels, como um botão, e obtém o texto a mostrar
do método `valor` de um objeto passado em seu construtor. Ele ignora todos os eventos
do mouse. O texto deve ser centralizado na vertical, e justificado à direita na horizontal.

A classe `Botao` é um botão clicável: um retângulo preto com uma borda branca de
3 pixels, e um texto branco centralizado. Um botão sempre tem associado a ele uma ação, que
é uma instância de uma classe com um método `executa(self)`, que tem a função
de executar a ação que deve ocorrer quando o botão é clicado. São essas ações
que irão chamar os métodos `digito`, `soma`, etc. do modelo da calculadora.

**Não faça nenhuma alteração nas classes fornecidas, exceto
nos métodos que estão marcados com `TODO`! Parte do exercício é justamente
aprender a programar respeitando limites impostos por código já existente.**

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
