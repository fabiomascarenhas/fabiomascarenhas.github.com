---
layout: default
title: Fabio Mascarenhas
relpath: ..
---

## Laboratório 3

1\. Escreva uma função `quebra_strn` que recebe uma cadeia de caracteres `s` e um número
inteiro `n` e retorna as subcadeias de `s` com os caracteres nos intervalos `[0,n)` e 
`(n, len(s))`.

2\. Escreva uma função `quebra_strc` que recebe uma cadeia de caracteres `s` e um
caractere `c` e retorna as subcadeias de `s` com os caracteres do início até a primeira
ocorrência de `c` (sem incluir `c`) e da primeira ocorrência de `c` até o final
(novamente sem incluir `c`). Dica: use `str.find(s, c)` e a resposta da questão 1.

3\. Escreva uma função `quebra_str` que recebe uma cadeia de caracteres `s` e ou
um inteiro ou um caractere; caso o segundo parâmetro seja um número inteiro, ela
deve agir como `parte_strn` e caso ele seja um caractere ela deve agir como
`parte_strc`. Dica: use `type(v)` para ver se o segundo parâmetro é `int` ou `str`,
e as respostas das questões anteriores.

4\. Escreva uma função `quebra_strci` que funciona como `parte_strc`, mas não faz
diferença entre letras maiúsculas e minúsculas. Dica: use `str.upper(s)`.

5\. Escreva uma função `escape` que recebe uma cadeia de caracteres `s` e retorna
uma nova cadeia substituindo todas as ocorrências do caractere `<` em `s` por `&lt;`,
e todas as ocorrências de `>` por `&gt;`. Dica: use a função `str.replace(s, de, por)`.

6\. Podemos representar uma cor usando uma tripla de números decimais no intervalo `[0,1]`,
cada elemento da tripla correspondendo à intensidade de uma das cores primárias (vermelho,
verde e azul). Defina as seguintes funções:

    I. `complemento`, que recebe uma cor e retorna seu complemento
    II. `soma`, que recebe duas cores e retorna sua "soma" (cada componente do resultado
    é o máximo entre os valores correspondentes nas duas cores dadas)
    III. `media`, que recebe duas cores e retorna uma cor em que cada componente é
    a média entre os valores correspondentes

7\. O registro de um aluno do curso pode ser representado por um dicionário com
os seguintes campos: `nome` (cadeia de caracteres), `dre` (cadeia de caracteres),
`notas` (uma tripla de floats) e `faltas` (um número inteiro).

    I. Uma função que recebe três floats e retorna os dois maiores
    II. Uma função que recebe três floats a calcula a média aritmética dos dois
    maiores
    III. Uma função que recebe um aluno e retorna "AP" se ele foi aprovado, "RM" se
    foi reprovado apenas por ter média abaixo de 5, "RF" se foi reprovado apenas por
    ter mais do que sete faltas, e "RFM" se foi reprovado por ter média abaixo de 5 *e*
    mais do que sete faltas.
    IV. Uma função que recebe um aluno e retorna outro dicionário que associa o DRE do
    aluno a um par contendo o nome do aluno e a cadeia retornada pela função anterior.

8\. Podemos representar o estado de um jogo simples de forca (restrito a palavras de
quatro letras) usando um dicionário com três campos: `palavra`, com a palavra que
precisa ser advinhada, `mascara`, uma quádrupla com quatro booleanos indicando quais
letras da palavra já foram acertadas (ou seja, `(False,False,False,False)` no início
do jogo e `(True,True,True,True)` se o jogo foi ganho), e `erros`, um inteiro com o número
de erros já cometido. Defina as seguintes funções:

    I. Uma função que recebe duas quádruplas de booleanos e retorna uma quádrupla
    com de booleanos em que cada elemento é ou lógico dos seus correspondentes.
    II. Uma função que recebe uma quádrupla de booleanos e retorna `True` se todos
    eles são `True` ou `False` se algum deles for `False`.
    III. Uma função que recebe uma palavra de quatro letras e uma letra, e retorna
    a máscara correspondente.
    IV. Uma função que recebe um estado de jogo e uma letra, e retorna um novo
    estado que contém uma máscara atualizada ou uma falha a mais.
    V. Uma função que recebe um estado de jogo e uma letra, chama a função anterior e
    retorna "GANHOU" se todos os elementos da máscara são `True`, "PERDEU" se o número
    de falhas é igual a 6, ou o novo estado caso não valha nenhuma das duas alternativas
    anteriores.
