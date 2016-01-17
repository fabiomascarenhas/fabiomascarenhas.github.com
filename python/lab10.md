---
layout: default
title: Laboratório 10
relpath: ..
---

## Laboratório 10

1\. Um retângulo pode ser representado por um par de pontos, onde cada
ponto é um par de coordenadas. Faça uma função que verifica se há intersecção
entre dois retângulos passados como parâmetros, retornando `True` se há intersecção
e `False` se não há.

2\. Um sólido pode ser descrito por um dicionário com um campo `tipo` (uma string), e outros campos de que dependem do valor de `tipo`: se `tipo` for `cubo`, esse campo é `lado`; se `tipo` for `paralelepipedo`, os campos são `comprimento`, `largura` e `altura`; se `tipo` for `esfera`, esse campo é `raio`. Escreva a função
`dentro`, que recebe um sólido e um ponto (uma tripla de números reais) e retorna `True` se ele está dentro
do sólido e `False` se estiver fora. Dica: separe o problema em quatro funções, três fazem a verificação
para cada tipo de sólido, e a quarta checa o campo `tipo` e despacha para a função apropriada.

3\. Um simulador da interação do efeito da gravidade em uma massa tem cinco variáveis
em seu estado global: `X` e `Y` são as coordenadas da massa (em metros), inicialmente 1.0, e sempre
positivos; `VX` e `VY` são os componentes horizontal e vertical de sua velocidade (em metros por segundo),
com valores iniciais reais positivos quaisquer; `T` é quantos segundos (e frações) se passaram desde o início da
simulação (inicialmente 0.0). Escreva duas funções que controlam o simulador: `reset` recebe dois
números reais como parâmetros e atualiza `VX` e `VY`, zerando as outras três variáveis; `step`
não recebe parâmetros, e caso `Y` seja maior que 0.0, avança a simulação em 0.001 segundo (atualizando `T`), 
recalculando `VY` com o efeito da gravidade, depois recalculando `Y` e `X` com os efeitos da
velocidade.

4\. Escreva uma função `intercala` que recebe duas listas e retorna uma nova lista
intercalando elementos de cada uma das listas (primeiro elemento é o primeiro da
lista 1, segundo é o primeiro da lista 2, terceiro é o segundo da lista 1,
assim por diante). As duas listas podem ter tamanhos diferentes.

5\. O [método Babilônico](http://pt.wikipedia.org/wiki/Raiz_quadrada#M.C3.A9todo_babil.C3.B4nico)
para achar a raiz quadrada de um número consiste em fazer aproximações sucessivas, em que
a próxima aproximação da raiz é a média aritmética entre a aproximação atual e o número
dividio pela aproximação. Fazemos isso até chegar perto o suficiente da raiz real (podemos ver
quão perto estamos elevando ao quadrado nossa aproximação e comparando com o número). Escreva
uma função `raiz` que recebe um número e calcula sua raiz quadrada (a menos de um erro de 0.001)
pelo método Babilônico. Use 1.0 como aproximação inicial.

6\. Escreva uma função que recebe uma string e retorna um *histograma* da string. Um histograma
é um dicionário que associa cada caractere que aparece na string ao número de vezes em que
ele aparece. Ignore a diferença entre maiúsculas e minúsculas.

7\. Escreva uma função que recebe uma string e retorna uma *permutação* da string, ou seja,
uma string com os caracteres da string original embaralhados aleatoriamente. Use a função
`random.randint(a, b)`, que gera números inteiros aleatórios no intervalo `[a,b]`.

8\. A *convolução* é uma operação com matrizes bastante usada em processamento de imagens.
Ela usa um matriz de entrada bidimensional com tamanho qualquer, e uma matriz *kernel* 3x3.
Uma nova matriz com o mesmo tamanho da matriz de entrada é criada, e cada elemento dessa
nova matriz é obtido multiplicando seu correspondente e seus vizinhos na matriz de entrada
pelos elementos do kernel e somando os resultados. Por exemplo, o elemento `s_5_3` da linha
5 coluna 3 da matriz de saída é `e_4_2*k_0_0 + e_4_3*k_0_1 + e_4_4*k_0_2 + e_5_2*k_1_0 +
e_5_3*k_1_1 + e_5_4*k_1_2 + e_6_2*k_2_0 + e_6_3*k_2_1 + e_6_4*k_2_2`, onde os elementos `e`
vêm da matriz de entrada e os elementos `k` da matriz kernel. Escreva uma função `conv`
que recebe uma matriz e um kernel e faz a convolução da matriz, escrevendo o resultado de volta
na matriz de entrada. Verifique o que acontece com o kernel `[[1,0,0],[0,0,0],[0,0,0]]` e uma
matriz qualquer (use a resposta da questão 2 do laboratório anterior para gerar matrizes de teste).
