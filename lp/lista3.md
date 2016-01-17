---
layout: default
title: Linguagens de Programação - Terceira Lista de Exercícios
relpath: ..
---

Terceira Lista de Exercícios
===========================

Introdução
----------

Baixe o [projeto da lista](lista3.zip), importe ele na Scala IDE (Eclipse), e implemente as funções
correspondentes a cada questão do exercício. Depois envie
apenas o arquivo `package.scala` com os fontes da sua implementação até **18/12/2015**,
usando [esse link](https://www.dropbox.com/request/F0mo6BuKkfrUy3ispA4B).

Cálculo Lambda
--------------

O *cálculo lambda* é um modelo de computação que é uma das bases da programação
funcional, e pode ser visto como uma linguagem de programação bastante simples.

Uma expressão do cálculo lambda pode ser uma variável (um nome), uma aplicação (um par de expressões),
ou uma *abstração* (um par de um nome, chamado de *parâmetro* da abstração, e uma expressão, chamada de seu *corpo*).
As abstrações também são os únicos valores da linguagem (isso mesmo, o cálculo lambda não tem números ou booleanos).

### Questão 1

Defina um tipo algébrico para expressões no cálculo lambda, usando um trait `CL` e três construtores
`Var`, `Ap`, e `Abs`.

### Questão 2

Defina um *parser* para o cálculo lambda que transforma a seguinte sintaxe concreta
em uma expressão do tipo `CL` (justaposição é aplicação, e associa à esquerda,
identificadores são variáveis, e `\<nome>.<exp>` é uma abstração):

    EXP  -> AEXP {AEXP} 
	AEXP -> id | '\' id '.' EXP | '(' EXP ')'

Exemplos de expressões do cálculo lambda: `x`, `\x.x`, `(\x.\y.x y) (\x.x) (\x.x)`. 
	
### Questão 3	
	
A semântica do cálculo lambda call-by-value é dada por substituição: o valor de uma variável é
indefinido; o valor de uma abstração é ela mesma; para obter o valor de uma aplicação obtemos
o valor do seu lado esquerdo (que deverá ser uma abstração, ou a aplicação é indefinida)
e seu lado direito, substituímos o parâmetro do lado esquerdo pelo
valor do lado direito no corpo do lado esquerdo, e achamos o valor do resultado.

Para evitar capturas indevidas, adotaremos uma definição simplificada onde o valor sendo substituído não
pode ter variáveis livres.

Escreva a função que acha as variáveis livres `fv(e: CL): Set[String]`, a
função de substituição `subst(oque: String, peloque: CL, onde: CL)`, 
o interpretador big-step `eval(e: CL): Abs` e o interpretador small-step `step(e: CL): CL`.

### Questão 4

Escreva as funções `eval_cbn` e `step_cbn` para o interpretador call-by-name do 
cálculo lambda.
	
* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

