---
layout: default
title: Lab 7 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 7 - 09/04/2014
--------------------------

No laboratório de hoje você fará novas extensões ao projeto do Editor Gráfico,
continuando as do [laboratório 6](lab6.html). As extensões pedidas abaixo são
cumulativas. Lembre-se que as classes e interfaces que fazem parte do framework
(`Motor`, `Cor`, `Tela`, `Jogo` e `App`) **não** devem ser modificadas.

1\. Mude o tamanho da janela do editor para 1024 pixels de largura e 768
pixels de altura, ao invés de 800 e 600. Não se esqueça de ajustar o 
tamanho da área de desenho. Deixe uma área de 160 pixels à direita
da área de desenho livre, para posicionar os sliders de cor e a caixa
de cor.

2\. Os vários estados do modelo do editor possuem várias partes em comum.
Transforme a interface `Estado` em uma classe abstrata, e passe as partes
em comum para essa interface.

3\. Adicione cor ao modelo do editor, e às figuras, usando três
atributos de tipo `double`, um para cada componente (**não** use a
classe `Cor`). A cor do modelo é cor usada para desenhar uma nova figura.
Adicione um método ao modelo para mudar a cor atual.

4\. Crie um novo componente para representar um *slider*. Visualmente, um
slider é um retângulo com no mínimo 100 pixels de altura,
com uma borda de determinada cor e um fundo preto,
com outro retângulo dentro, da cor da borda, com mesma largura do slider
e 30 pixels de altura. O slider tem um *valor* associado, um número
entre 0 e 1 (inclusive). O valor do slider dá a posição do retângulo dentro
dele. Se for 0, o retângulo está no topo do slider, se for 1, está no
fundo, qualquer outro valor deve ser interpolado entre essas duas posições.
O construtor do slider permite passar a sua cor, e um valor inicial.
Inicialmente crie apenas o necessário para instanciar um slider, e desenhá-lo
na tela. Instancie três sliders, um vermelho, um verde, e um azul, e os
adicione ao editor, do lado direito da área de desenho.

5\. Agora você irá fazer o slider responder ao mouse. O slider permite
arrastar o retângulo interno para mudar o seu valor. Para isso, implemente
o método `arrasto` do slider, fazendo o cálculo inverso do feito para
posicionar o retângulo dado o valor. Lembre que o retângulo interno não pode ser
arrastado para fora dos limites do slider.

6\. Agora você irá conectar cada slider ao resto do sistema associando um
*observador* a um slider. Um observador do slider é um objeto que implementa
a interface abaixo, e deve ser passado no construtor do slider. Toda vez
que o valor do slider muda, o observador é avisado.

{% highlight java %}
    interface ObservadorSlider {
	    void sliderMudou(double valor);
	}
{% endhighlight %}

7\. Finalmente, conecte os sliders ao modelo no controlador, associando um
observador a cada um deles que muda avisa o modelo de que a cor mudou.

8\. Agora que temos uma maneira de mudar a cor de desenho, precisamos de uma
maneira mais fácil do usuário ver qual a cor atual. Crie um componente
para representar uma caixa de cor, e adicione-o ao editor,
abaixo dos sliders. Esse componente é apenas um retângulo
sólido de determinada cor. O componente implementa a interface abaixo, que
permite mudar a cor que ele mostra:

{% highlight java %}
    interface ObservadorCor {
	    void corMudou(double r, double g, double b);
	}
{% endhighlight %}

9\. Conecte a caixa de cor ao modelo, passando um `ObservadorCor` ao construtor
do modelo. Toda vez que a cor desenho for mudada, o modelo deve avisar esse
objeto. Assim, mexer em um dos sliders altera a cor do modelo, que altera
a cor da caixa de cor, fechando o ciclo.

10\. Para encerrar, adicione um novo modo ao editor, para mudar a cor de
uma figura da cor dela para a cor de desenho atual. Lembre-se de integrar
esse modo ao mecanismo de desfazer/refazer.

Enviando
--------

Use o formulário abaixo para enviar os Laboratórios 6 e 7. O prazo para envio é quarta-feira,
dia 30/04/2014.

<script type="text/javascript" src="http://form.jotformz.com/jsform/40975826949676">
dummy
</script>


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

