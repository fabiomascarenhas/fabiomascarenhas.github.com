---
layout: default
title: Laboratório 7
relpath: ..
---

## Laboratório 7

1\. Considere uma estrutura (struct) para representar um ponto na tela e
implemente uma função que indique se um dado ponto `p` está dentro
ou fora de um círculo. O círculo é definido pelo seu centro `c` (outro
ponto) e seu raio `r`. A função retorna `1` se o ponto estiver dentro
do círculo e `0` caso contrário.

2\. Considere a estrutura a seguir que representa as notas de um aluno
dessa disciplina. Implemente uma função que calcula a média final do aluno,
seguindo o critério que está em nossa página. Implemente outra função que
recebe um vetor de alunos, e imprime uma tabela com o nome de cada um, a
matrícula, e a média final.

{% highlight java %}
struct Aluno {
    char nome[81];
    char matricula[8];
    double p1;
    double p2;
    double p2;
};
{% endhighlight %}

No jogo *Asteroids* o jogador pilota uma nave e deve evitar destruir asteróides
que aparecem na tela, enquanto desvia deles. O motor da nave sempre a
acelera na direção na qual seu nariz está apontando, e sem aceleração a nave
sempre mantém sua velocidade atual. Asteróides grandes se quebram em asteróides
menores quando são atingidos:

<iframe width="420" height="315" src="//www.youtube.com/embed/WYSupJ5r2zo" frameborder="0" allowfullscreen="1">
dummy
</iframe>

3\. Crie o projeto do jogo, usando o template de Aplicação GUI (instale ele seguindo
as intruções [na página principal](index.html)), e defina a janela para o jogo
com 800 pixels de largura e 600 de altura.

4\. Defina uma estrutura para representar um asteróide. Essa estrutura deve ter
as coordenadas do asteróide, seu tamanho (1, 2, 3 ou 4), sua cor e os componentes
horizontal e vertical de sua velocidade. Defina um vetor dinâmico para os
asteróides.

5\. O jogo começa com 6 asteróides com tamanhos, cores, posições e velocidades
aleatórias. Cada asteróide é desenhado por um círculo com diâmetro de dez pixels
para cada unidade de tamanho. Quando um asteróide sai da tela ele aparece no canto
oposto, mantendo a mesma velocidade. Implemente o código para desenhar e animar
os asteróides.

6\. Defina uma estrutura para representar a nave, com a posição, os componentes
horizontal e vertical de sua velocidade, e sua direção em radianos, no sentido
horário. A nave começa no centro da tela, com velocidade 0, e apontando para cima.

7\. Quando o jogador está apertando a seta para a esquerda (tecla `Left`)
a direção diminui de `PI` radianos por segundo, quando está apertando
a seta para a direita a direção aumenta em `PI` radianos por segundo. Quando ele
está apertando a tecla `Space` a velocidade aumenta em cem pixels por segundo
na direção para onde a nave está apontando (o seno da direção 
dá o quanto o componente vertical muda e o conseno da direção quanto o componente
vertical muda). Implemente o código para desenhar e animar a nave. Do mesmo
modo que um asteróide, quando a nave sai da tela ela aparece no canto oposto.

No próximo laboratório, veremos como implementar os tiros, e a lógica de colisão
da nave e dos tiros com os asteróides.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

