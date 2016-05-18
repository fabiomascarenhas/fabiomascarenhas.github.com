---
layout: default
title: Lab 4 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 4 - 18/05/2016
--------------------------

No jogo *Asteroids* o jogador pilota uma nave e deve evitar destruir asteróides
que aparecem na tela, enquanto desvia deles. O motor da nave sempre a
acelera na direção na qual seu nariz está apontando, e sem aceleração a nave
sempre mantém sua velocidade atual. Asteróides grandes se quebram em asteróides
menores quando são atingidos:

<iframe width="420" height="315" src="http://www.youtube.com/embed/WYSupJ5r2zo" frameborder="0" allowfullscreen="1">
dummy
</iframe>

1\. Crie um novo projeto, no Eclipse ou BlueJ, para o jogo, depois feche
o Eclipse ou BlueJ. Baixe os [arquivos .java](Asteroids.zip) do motor de jogo e
copie eles para a pasta do seu projeto (no Eclipse ela pode ser uma pasta `src` dentro da pasta do projeto, a
depender de como ele foi criado).  Reabra o Eclipse ou BlueJ, os arquivos do projeto
devem estar lá. Crie uma classe principal que implementa a interface `Jogo`.

2\. Defina uma classe para representar um asteróide. Essa classe deve ter
as coordenadas do asteróide, seu tamanho (1, 2, 3 ou 4), sua cor e os componentes
horizontal e vertical de sua velocidade. 

3\. O jogo começa com 6 asteróides com tamanhos, cores, posições e velocidades
aleatórias. Cada asteróide é desenhado por um círculo com diâmetro de dez pixels
para cada unidade de tamanho. Quando um asteróide sai da tela ele aparece no canto
oposto, mantendo a mesma velocidade. Implemente o código para desenhar e animar
os asteróides.

4\. Defina uma classe para representar a nave, com a posição, os componentes
horizontal e vertical de sua velocidade, e o ângulo de sua direção no sentido
horário (em radianos). A nave começa no centro da tela, com velocidade 0 e 
direção 0.

Vamos desenhar a nave pegando os pontos `(5, 0)`,
`(-3, -4)` e `(-3, 4)`, fazendo sua rotação usando
o ângulo da direção da nave, e depois somando os pontos
resultantes à posição da nave: os três pontos dados
por essa soma dão os cantos do triângulo.

5\. Defina uma classe `Ponto` para representar um ponto dadas
suas coordenadas `x` e `y` (de tipo `double`).
Implemente um método `rotacao` que faz a rotação desse ponto
dado um ângulo `dir` em radianos. A nova coordenada `x` é
`x * Math.cos(dir) - y * Math.sin(dir)`, e a nova coordenada `y`
é `y * Math.cos(dir) + x * Math.sin(dir)`. Use essa classe para poder
implementar o método `desenhar` da nave.

6\. Quando o jogador está apertando a seta para a esquerda (tecla `left`)
a direção diminui em `Math.PI` radianos por segundo, quando está apertando
a seta para a direita (tecla `right`) a direção aumenta em `Math.PI` radianos por segundo.
Quando ele está apertando a seta para cima (tecla `up`) a velocidade aumenta em cem pixels por segundo
na direção para onde a nave está apontando (o seno da direção 
dá o quanto o componente vertical muda e o conseno da direção quanto o componente
vertical muda). Implemente o código para animar a nave. Do mesmo
modo que um asteróide, quando a nave sai da tela ela aparece no canto oposto.

7\. Defina um classe para representar um tiro. Ele é descrito apenas pela
sua posição e velocidade, e desenhado como um círculo de raio 1. Quando um tiro é criado,
sua posição é a do "nariz" da nave, o componente horizontal de sua velocidade é
de `100*Math.cos(dir)` mais a velocidade horizontal da nave, e o componente vertical de sua
velocidade é de `100*Math.sin(dir)` mais a velocidade vertical da nave. Um novo
tiro é disparado toda vez que o jogador solta a tecla de espaço. Implemente
o código para disparar, animar e desenhar os tiros.

8\. Um tiro colidiu com um asteróide se a distância entre seu centro e o
centro do asteróide é menor que o raio do asteróide. Quando um tiro colide
com um asteróide de tamanho 1 ou 2 o asteróide é destruído. Quando um tiro colide
com um asteróide de tamanho 3 o asteróide se quebra em dois asteróides de tamanho 1
que voam em direções opostas. Quando um tiro colide com um asteróide de tamanho
4 o asteróide se quebra em um asteróide de tamanho 2 e um de tamanho 1. O tiro
sempre é destruído nessa colisão. Implemente a verificação e os efeitos da colisão entre
tiros e asteróides.

9\. A nave colide com um asteróide quando a distância entre a posição
da nave e o centro do asteróide é menor que o raio do asteróide mais 5.
A colisão da nave com o asteróide destrói a nave e o asteróide.

10\. O jogador começa com 3 vidas. Quando a nave é destruída, se o contador de vidas
já chegou a zero o jogo termina, mostrando a mensagem "GAME OVER" e mantendo os asteróides
se movendo. Se o contador não chegou a zero ele diminui em 1 e uma nova nave aparece no
centro da tela, com velocidade e direção 0.

Enviando
--------

Use [esse link](https://www.dropbox.com/request/P1Jwkl6hZbBNsopyioS8)
 para enviar o Laboratório 4. O prazo para envio é quarta-feira, dia **02/06/2016**.


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
