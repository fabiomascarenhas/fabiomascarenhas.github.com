---
layout: default
title: Lab 5 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 5 - 19/03/2014
--------------------------

Esse laboratório é um aquecimento para trabalhar com o projeto do Editor Gráfico, e será
entregue junto com ele. O objetivo é usar o framework dado em sala para implementar a
interface gráfica de uma calculadora simples. O [projeto](Calculadora.zip) já inclui o
*modelo* da calculadora (classe `ModeloCalc`), um objeto que implementa a lógica interna,
e fornece os seguintes métodos públicos:

{% highlight java %}
    void digito(int i); // acrescenta um dígito de 0 a 9 ao display
    void soma();        // operação de soma (botão +)
    void sub();         // operação de subtração (botão -)
    void mult();        // operação de multiplicação (botão *)
    void div();         // operação de divisão (botão /)
    void igual();       // resultado da operação (botão =)
    void reset();       // limpa calculadora (botão C)
	// registra um objeto para ser avisado de mudanças no display
    void setObservador(ObservadorDisplay obs);
{% endhighlight %}

Vocês deverão implementar a parte da interface visível da calculadora, que deve
se comunicar com uma instância de `ModeloCalc`. A classe `Calculadora` é a classe
principal da aplicação, já está quase pronta: falta apenas instanciar o display,
os botões, e as ações de cada botão.

A janela da calculadora tem 400 pixels de largura por 500 de altura. Os primeiros
100 pixels são o *display*. Depois há uma fileira de botões a cada 100 pixels,
onde cada botão é um quadrado 100x100. A primeira fileira tem os botões `7`,
`8`, `9` e `*`. A segunda fileira tem os botões `4`, `5`, `6` e `/`. A terceira
fileira tem os botões `1`, `2`, `3` e `-`. A quarta e última fileira tem os
botões `C`, `0`, `=` e `+`.

A classe `Botao` é um botão clicável: um retângulo preto com uma borda branca de
2 pixels, e um texto branco centralizado. Para essa classe, falta implementar
o que está marcado com `TODO`. Um botão sempre tem associado uma instância da
interface `Acao`, que diz o que acontece quando o botão é clicado. São essas ações
que irão chamar os métodos `digito`, `soma`, etc. do modelo da calculadora.

Você precisa criar uma classe `Display`, que implementa `Componente`, para ser o
display. Essa classe também deve implementar a interface `ObservadorDisplay`,
para ser notificada de qualquer mudança no valor do display pelo modelo da
calculadora. Registre a instância de `Display` como observador do modelo com
o método `setObservador`.

**Não faça nenhuma alteração nas classes e interfaces fornecidas, exceto
nos métodos que estão marcados com `TODO`! Parte do exercício é justamente
aprender a programar respeitando limites impostos por código já existente.**

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
