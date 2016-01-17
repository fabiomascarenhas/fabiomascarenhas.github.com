---
layout: default
title: Laboratório 5
relpath: ..
---

## Laboratório 5

Vocês devem continuar a construir o jogo Breakout, 
pedido no [Laboratório 4](lab4.html). Você já deve ter percebido que o item
7 é mais difícil do que parece! Verificar se a bola colidiu com o tijolo é simples,
basta checar se o centro da bola está dentro dos limites do tijolo. Mas
determinar em qual parede ela rebateu, para poder mudar a sua direção, é
bem mais complicado.

Uma maneira de verificar onde a bola rebateu é traçar a linha correspondente
ao movimento da bola, e então checar as interseções dela com os lados do tijolo.
A direção do movimento dá quais lados temos que checar: se a bola está indo para
a cima (`vy < 0`), checamos a interseção com o fundo; se a bola está indo para
baixo (`vy > 0`), checamos a interseção com o topo; se a bola está indo para a
direita (`vx > 0`), checamos a interseção com a lateral esquerda; finalmente,
se a bola está indo para a esquerda (`vx < 0`), checamos a interseção com a
lateral direita.

Para verificar a interseção, basta lembrar que uma reta é descrita pela
equação `y = ax + b`, onde `a` é a inclinação da reta, no nosso caso dada
por `vy/vx`.

{% highlight java %}
/* Verifica se a bola na posição (bx, by) com velocidades vx e vy
colidiu com o retângulo de canto superior esquerdo (rx, ry) e largura
e altura dadas. Retorna 0 se não houve colisão, 1 para colisão apenas com
o fundo, 2 para colisão apenas com o topo, 4 para colisão apenas com a lateral
esquerda, 8 para colisão apenas com a lateral direita, 5 para colisão com
o fundo e a lateral esquerda, 9 para colisão com o fundo e a lateral
direita, 6 para colisão com o topo e a lateral esquerda e 10 para
colisão com o topo e lateral direita. */
static int colidiu(double bx, double by, double vx, double vy,
                   double rx, double rx, double largura, double altura) {
    int colisao = 0;
    double a = vx/vy;
    double b = linha_b(a, bx, by);
    if(vy < 0) {
        int ix = linha_x(a, b, ry + altura);
        if(ix >= rx && ix <= rx + largura) {
            colisao = colisao + 1;
        }
    } else {
        int ix = linha_x(a, b, ry);
        if(ix >= rx && ix <= rx + largura) {
            colisao = colisao + 2;
        }
    }
    if(vx > 0) {
        int iy = linha_y(a, b, rx);
        if(iy >= ry && iy <= ry + altura) {
            colisao = colisao + 4;
        }
    } else {
        int iy = linha_y(a, b, rx + largura);
        if(iy >= ry && iy <= ry + altura) {
            colisao = colisao + 8;
        }
    }
    return colisao;
}
{% endhighlight %}

1\. Implemente as funções auxiliares `linha_b`, `linha_x` e
`linha_y`, que, para uma reta `y = ax+b`, calculam respectivamente
o parâmetro `b` dados `a`, `x` e `y`, o valor de `x` dados
`a`, `b` e `y`, e o valor de `y` dados `a`, `b` e `x`.

2\. Use a função `colidiu` acima para implementar a colisão do jogo
breakout. Após a colisão, a bola deve ser movida para o ponto de
interseção dela com o tijolo, ou no próximo quadro do jogo ela ainda
vai estar colidindo, e pode ficar "presa" dentro do tijolo.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

