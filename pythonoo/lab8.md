---
layout: default
title: Lab 8 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 8 - 03/06/2015
--------------------------

Nesse laboratório vamos exercitar o uso de botões e labels no Tkinter. [Esse arquivo](lab8.py)
contém as classes criadas em sala de aula para encapsular as janelas, botões e labels Tkinter
em uma interface mais parecida com o que temos usado. Essas classes serão usadas nos exercícios
desse laboratório.

1\. Podemos mudar a fonte e o tamanho de fonte do texto de botões e labels no Tkinter atribuindo
ao atributo `"font"` uma string contendo o nome da fonte e o tamanho: `botao["font"] = "Arial 20"`.
Modifique as classes `Botao` e `Rotulo` para receber o tamanho da fonte (um número inteiro) como
um parâmetro no construtor, e use esse tamanho para mudar a fonte do botão para Arial e o tamanho
passado.

2\. O arquivo [lab8.py](lab8.py) desse laboratório também inclui as classes do modelo da calculadora padrão.
Para usar esse modelo com uma interface Tkinter, ele precisa ser modificado para ter um observador
para o valor atual do display, e esse observador tem que ser notificado (através do seu método
`mudou(self, valor)`) toda vez que o valor do display muda. Faça essas mudanças.

3\. Crie uma interface para a calculadora usando o Tkinter e o modelo que você modificou na questão 2.
Use um rótulo para o display.

4\. Modifique o modelo da calculadora RPN que você construiu no [laboratório 6](lab6.html) do modo
feito no exercício 2, e conecte ele com a interface que você construiu no exercício 3. Faça o tipo
da calculadora (padrão ou RPN) ser uma opção passada no construtor da classe principal do programa.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

