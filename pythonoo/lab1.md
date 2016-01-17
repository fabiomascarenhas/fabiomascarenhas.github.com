---
layout: default
title: Lab 1 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 1 - 18/03/2015
--------------------------

1\. Um programa de uma loja de carros precisa das seguintes informações
sobre cada carro: o modelo, o preço, o consumo médio de combustível e se
o carro é novo ou usado. Escreva uma classe `Carro` que agrupe essas
informações, incluindo seu construtor, depois crie e inspecione
algumas instâncias de `Carro` no console do IDLE.

2\. Um programa para um agente imobiliário precisa guardar para cada
imóvel a sua metragem, o número de quartos, o número de vagas de
garagem, seu endereço, e os dados do proprietário atual. O endereço
consiste do logradouro, do número, de um complemento e do bairro. Os
dados do proprietário são seu nome e telefone. Modele esse problema como
um conjunto de três classes, `Imovel`, `Endereco` e `Proprietario`.
Escreva as classes e seus construtores.

3\. A loja de carros do exercício 3 agora precisa que
os carros também tenham informações sobre seus donos.
Para isso crie uma classe `Dono` com os campos nome e idade, e
adicione um campo dono à classe `Carro`. Ela também precisa que os carros tenham um 
ano de fabricação (um campo `ano` do tipo `int`) *ao invés de* um campo que diz se
ele é novo ou usado. Faça essas alterações na classe `Carro`.
Não esqueça de corrigir o construtor de `Carro` para inicializar os novos campos!

4\. *[Frogger](http://www.jogos-viciantes.com/frogger/)* era outro jogo
da época do Atari em que um sapo tinha que atravessar uma auto-estrada
sem ser atropelado pelos carros, depois atravessar um rio saltando em
troncos e tartarugas que passavam sem se afogar. O jogador tinha um
tempo determinado para fazer as travessias.

![](http://www.8-bitcentral.com/images/reviews/atari2600/frogger2600Screen.jpg)

Vocês deverão modelar as classes de uma versão simplificada de Frogger
em que só existe a travessia da estrada com os carros. O sapo vai ser
representado por um círculo e os carros por retângulos com tamanhos
diferentes, e que podem se mover em direções diferentes e com
velocidades diferentes. O sapo também tem um número de vidas.
Os carros se movem de um canto a outro da tela.
Quando eles "saem" da tela eles aprecem de volta vindo do lado oposto.

A classe `Frogger` irá implementar a mecânica do Frogger, e o estado do jogo.
No próximo laboratório veremos como desenhar o jogo, e começar a animá-lo.
O tabuleiro do jogo consiste de:

* Dois retângulos de 800 pixels por 100 pixels, marcando as duas "calçadas". Não precisam ser
  objetos, já que são elementos estacionários do jogo;
* Quatro faixas de carros; a primeira faixa tem 2 carros com 100 pixels de comprimento, e
  que atravessam a tela em 5 segundos, a segunda faixa tem 1 carro com 150 pixels de comprimento
  e que atravessa e tela em 2 segundos, a terceira faixa tem 3 carros com 60 pixels de comprimento
  e que atravessem a tela em 8 segundos, e a quarta faixa tem 3 carros com 60 pixels de
  comprimento e que atravessam a tela em 6 segundos. Todos os carros são instâncias de uma
  classe `Carro` e têm 100 pixels de altura, e cores aleatórias;
* O sapo, uma instância da classe `Sapo`, com 90 pixels de diâmetro e cor verde,
  começa no centro da calçada de baixo;
* O contador de vidas do sapo, no canto inferior direito, com tamanho 60.

A distância entre uma faixa de carros e a outra é de 100 pixels. O vídeo abaixo mostra
uma disposição dos carros:

<iframe width="640" height="390" src="http://www.youtube.com/embed/hHehXLhHOc0" frameborder="0" allowfullscreen="1">
dummy
</iframe>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
