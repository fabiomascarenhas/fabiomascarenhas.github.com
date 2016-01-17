---
layout: default
title: Laboratório 7
relpath: ..
---

## Laboratório 7

1\. Faça uma função que recebe um número inteiro e retorna a lista dos seus divisores maiores que 1.

2\. Faça uma função que recebe uma lista de strings e retorna uma nova lista com os tamanhos de cada string.

3\. Faça uma função que recebe uma lista de inteiros e retorna uma nova lista de strings em que cada string tem
tantos `*` quantos forem o inteiro correspondente (`estrela([1, 2, 3]) == ["*", "**", "***"]`). Dica: use o operador
de multiplicação para criar as strings de `*`.

4\. Faça uma função que recebe uma lista de strings e um inteiro e retorna uma nova lista com todas as strings
com tamanho maior que esse inteiro.

5\. Faça uma função como a anterior mas que, ao invés de retornar uma nova lista, apaga da lista original as strings
com tamanho menor ou igual que o segundo parâmetro.

6\. Faça uma função que recebe uma lista de inteiros e um número inteiro e retorna duas novas listas, a primeira
com todos os elementos da lista menores que esse número e a segunda com todos os elementos maiores ou iguais que esse
número.

7\. Faça uma função que recebe uma lista de números e modifica a lista substituindo cada número maior ou igual a zero
pela sua raiz quadrada e cada número menor que 0 por `None`.

8\. Faça uma função que recebe uma lista de elementos e uma posição na lista e modifica a lista de modo que o menor elemento
da lista a partir daquela posição esteja naquela posição, e o elemento que estava naquela posição
vai para a posição do menor elemento. Ex. `desce([1, 2, 5, 8, 4, 9], 2) == [1, 2, 4, 8, 5, 9]`.

9\. Faça uma função que recebe uma lista de elementos e a coloca em ordem crescente, *usando a função acima*.

10\. Desafio: faça uma função que recebe duas listas de elementos em ordem crescente e retorna uma nova lista que junta os
elementos da primeira lista com os elementos da segunda lista, *mantendo a ordem!*. 
Ex: `junta([2, 5, 8], [1, 3, 7, 10]) == [1, 2, 3, 5, 7, 10]`. Dica: faça seu laço ser sobre `range(0, len(l1 + l2))`.

