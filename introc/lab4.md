---
layout: default
title: Laboratório 4
relpath: ..
---

## Laboratório 4

Vocês devem construir uma versão simples do jogo Breakout, mostrado abaixo na
sua versão para o videogame Atari 2600:

<iframe width="420" height="315" src="//www.youtube.com/embed/O6wGqV8Etaw" frameborder="0" allowfullscreen="1">
dummy
</iframe>

No Breakout, o jogador controla uma "raquete" retangular na parte inferior da tela com o
teclado, movendo ela para a direita e para esquerda, tentanto rebater uma bola. O objetivo
é destruir todos os tijolos que estão dispostos em seis fileiras de quatorze tijolos
cada. Cada vez que a bola bate em um tijolo ela é rebatida, e o tijolo some. 

A bola também é rebatida pelas paredes laterais, e pelo teto, mas se ela chegar ao fundo
da tela ela volta para a posição inicial e o jogador perde uma vida se ele perder todas
as quatro vidas o jogo termina e ele perde. Se ele destruir todos os tijolos o jogo também
termina. Cada tijolo destruído vale um ponto.

Vocês irão fazer o jogo em partes. A janela do jogo deve ter 800 pixels de largura e 600
de altura.

1\. Crie o projeto do jogo, usando o template de Aplicação GUI (instale ele seguindo
as intruções [na página principal](index.html)), e escreva o código que desenha
as paredes, o teto, e a raquete em sua posição inicial. A raquete tem 25 pixels
de altura e 100 de largura. As paredes e o teto têm 50 pixels de largura.

2\. Desenhe todos os 84 tijolos. Cada tijolo tem 50 pixels de largura e 30 de
altura. Faça cada tijolo ter uma cor aleatória, incluindo a biblioteca
`stdlib.h` e usando a expressão `rand() * 1.0 / RAND_MAX` para cada componente
da cor.

3\. Faça o jogador poder mover a raquete usando o teclado. A ideia é observar os eventos
`gui_tecla` para as teclas `Left` e `Right`. Quando uma dessas teclas você deve dar o valor
`1` a uma variável global correspondente, e quando ela é solta o valor `0`. No evento
`gui_tique`, se a variável correspondente à tecla `Left` for `1` a raquete deve se
mover para a esquerda um número de pixels igual a `100` vezes o tempo. Se a variável
correspondente à tecla `Right` for `1` a raquete se move para a direita desse mesmo jeito.

4\. Ponha a bola em jogo, desenhando um círculo com cinco pixels de raio. Para o movimento
da bola, você deve ter duas velocidades, correspondendo aos componentes horizontal e
vertical do movimento. Faça ela se mover, e teste diferentes velocidades.

5\. Faça a bola rebater nas paredes e na raquete, usando o centro da bola
para testar sua colisão com os elementos do jogo. Quando a bola rebate na parede esquerda
e está se movendo para a esquerda, ela passa a se mover para a direita (invertendo o componente
horizontal de sua velocidade). Quando a bola rebate na parede direita
e está se movendo para a direita, ela passa se mover para a esquerda. Quando a bola
rebate no teto e está se movendo para cima, ela passa a se mover para baixo. Quando
a bola rebate na raquete e está se movendo para baixo, ela passa a se mover para cima.

6\. Implemente o contador de vidas, fazendo ele diminuir em `1` toda vez que a bola chegar
à parte de baixo da tela, pondo a bola de volta em jogo na sua posição inicial. Se o
contador de vidas chegar a `0` a bola não volta, e você deve exibir uma mensagem `GAME OVER`
no centro da tela.

7\. Implemente a colisão da bola com os tijolos. Se a bola colidir com a parte de baixo
do tijolo, ela deve ser rebatida como se fosse com o teto. Se ela colidir com a lateral
esquerda, deve ser rebatida como se fosse a parede direita. Se ela colidir com a lateral
direita, deve ser rebatida como se fosse a parede esquerda. Se ela colidir com a parte
de cima, deve ser rebatida como se fosse a raquete. Em todos os casos esse tijolo "sai"
do jogo, e não é mais exibido ou examinado para a colisão da bola. Para isso faça um
vetor de números, um para cada tijolo, onde `0` indica que o tijolo está fora do jogo
e `1` que ele está no jogo.

8\. Falta só o score, que é fácil: cada tijolo que sai do jogo aumenta o score em 1 ponto.
Parabéns, você conseguiu!

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

