---
layout: default
title: Laboratório 8
relpath: ..
---

## Laboratório 8

No jogo *Asteroids* o jogador pilota uma nave e deve evitar destruir asteróides
que aparecem na tela, enquanto desvia deles. O motor da nave sempre a
acelera na direção na qual seu nariz está apontando, e sem aceleração a nave
sempre mantém sua velocidade atual. Asteróides grandes se quebram em asteróides
menores quando são atingidos:

<iframe width="420" height="315" src="//www.youtube.com/embed/WYSupJ5r2zo" frameborder="0" allowfullscreen="1">
dummy
</iframe>

Faça as questões 3 a 6 do [laboratório 7](lab7.html), depois continue com
o que é pedido abaixo.

Vamos desenhar a nave pegando os pontos `(5, 0)`,
`(-3, -4)` e `(-3, 4)`, fazendo sua rotação usando
o ângulo da direção da nave, depois somando os pontos
resultantes à posição da nave, e os três pontos dados
por essa soma dão os cantos do triângulo.

1\. Implemente a função `rotacao` que recebe um
ponteiro para um `struct Ponto` e um ângulo em radianos,
e modifica a estrutura para efetuar a rotação. O novo
ponto é dado por `(x * cos(dir) - y * sin(dir), y * cos(dir) + x * sin(dir))`,
onde `x` e `y` são as coordenadas originais do ponto.
A função não retornada nada.

2\. Implemente a função `translacao` que recebe dois
ponteiros para `struct Ponto` e soma as coordenadas
do segundo às coordenadas do primeiro, modificando
o primeiro ponto.

3\. Quando o jogador está apertando a seta para a esquerda (tecla `Left`)
a direção diminui de `PI` radianos por segundo, quando está apertando
a seta para a direita a direção aumenta em `PI` radianos por segundo. Quando ele
está apertando a tecla `Up` a velocidade aumenta em cem pixels por segundo
na direção para onde a nave está apontando (o seno da direção 
dá o quanto o componente vertical muda e o conseno da direção quanto o componente
vertical muda). Implemente o código para desenhar e animar a nave. Do mesmo
modo que um asteróide, quando a nave sai da tela ela aparece no canto oposto.
Use as funções `rotacao` e `translacao` implementadas acima para achar os
pontos para desenhar a nave.

4\. Defina um vetor dinâmico para armazenar os tiros. Um tiro é descrito
apenas pela sua posição. Quando um tiro é criado, sua posição é a do
"nariz" da nave, o componente horizontal de sua velocidade é de `100*cos(dir)`
mais a velocidade horizontal da nave, e o componente vertical de sua
velocidade é de `100*sin(dir)` mais a velocidade vertical da nave. Um novo
tiro é disparado toda vez que o jogador solta a tecla `Space`. Implemente
o código para disparar, animar e desenhar os tiros. Um tiro é um círculo
de raio 1.

5\. Um tiro colidiu com um asteróide se a distância entre seu centro e o
centro do asteróide é menor que o raio do asteróide. Quando um tiro colide
com um asteróide de tamanho 1 ou 2 o asteróide é destruído, quando colide
com um asteróide de tamanho 3 ele se quebra em dois asteróides de tamanho 1
que voam em direções opostas, quando colide com um asteróide de tamanho
4 ele se quebra em um asteróide de tamanho 2 e um de tamanho 1. O tiro
sempre é destruído. Implemente a verificação e os efeitos da colisão entre
tiros e asteróides, como parte da função `tique`.

6\. A nave colide com um asteróide quando a distância entre a posição
da nave e o centro do asteróide é menor que o raio do asteróide mais cinco.
A colisão da nave com o asteróide destrói a nave.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

