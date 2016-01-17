---
layout: default
title: Laboratório 9
relpath: ..
---

## Laboratório 9

1\. Escreva uma função que recebe duas listas e retorna `True` se elas
possuem algum elemento em comum, e `False` caso contrário. Use o laço
`for` aninhado.

2\. Escreva uma função que cria uma matriz de números aleatórios,
dados quantas linhas e quantas colunas a matriz deve ter. Use a função
`random.random()` para gerar os números aleatórios.

3\. Escreva uma função que recebe um número ímpar `n` e cria uma matriz com
`n` colunas onde a primeira linha tem um `1` no centro com `0s` em volta,
a segunda linha tem três `1` no centro com `0s` em volta, a terceira linha tem
cinco `1`, assim por diante (os `1` formaram um triângulo), até a última linha ser 
composta apenas por `1`.

4\. Escreva uma função que recebe um número inteiro `n` e retorna a [matriz de
Pascal simétrica](http://wiki.ued.ipleiria.pt/wikiEngenharia/index.php/Matriz_de_pascal)
de ordem `n`.

Os relacionamentos em uma rede social podem ser *simétricos* (amizade no Facebook)
ou *assimétricos* (seguidores no Twitter). Duas formas bem comuns de representar
os relacionamentos de uma rede social em um computador são as *listas de adjacência*,
onde usamos um dicionário em que cada entrada associa uma pessoa a sua lista de
relacionamentos (amigos, ou quem ela está seguindo), e as *matrizes de adjacência*,
onde associamos um número inteiro a cada pessoa, e a célula na linha `i` coluna `j`
de uma matriz quadrada é `True` se `i` se relaciona com `j` ou `False` se `i` não
se relaciona com `j`. Mantemos um dicionário separado que associa cada nome ao
índice nessa matriz.

5\. Escreva uma função que recebe uma rede social na forma de lista de adjacência
e retorna um dicionário que associa cada nome a um número inteiro no intervalo `[0,n)`,
onde *n* é o número de pessoas na rede.

6\. Escreva uma função que recebe uma rede social na forma de lista de adjacência,
e retorna o dicionário de nomes e índices e a matriz de adjacência correspondente.

7\. Escreva uma função que recebe uma rede social na forma de matriz de adjacência (o
primeiro parâmetro é o dicionário de nomes e índices, o segundo a matriz propriamente dita)
e retorna a lista de adjacência correspondente.

8\. Escreva uma função que recebe um participante da rede e retorna a lista de "amigos e amigos
dos amigos" desse participante. Faça duas versões da função, uma que trabalha com a rede
na forma de lista de adjacência, uma que trabalha com a rede na forma de matriz de adjacência.

9\. Escreva uma função que recebe dois participantes da rede e retorna a lista de "amigos em
comum" desses participantes. Novamente faça duas versões, uma para a rede em forma de lista de
adjacência, outra para rede na forma de matriz de adjacência.

10\. Escreva uma função que recebe duas matrizes, uma com `m` linhas e `n` colunas, outra com
`n` linhas e `k` colunas, e multiplica das duas, retornando uma matriz com `m` linhas e `k` colunas.
Lembre que cada elemento `ij` da matriz resultante é calculado pegando a i-ésima linha da
primeira matriz e a j-ésima coluna da segunda matriz, multiplicando os seus elementos dois a dois,
e somando. Dica: você vai precisar de *três* loops aninhados.
