---
layout: default
title: Lab I de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 2 - 05/11/2012
--------------------------

Esse laboratório é uma continuação do laboratório da semana anterior, então
abra a página do [Laboratório 1](lab1.html) em outra aba do browser e 
comece completando os exercícios que você não fez. Você pode continuar
utilizando o mesmo projeto Eclipse.

1\. Queremos que os carros do exercício 2 do laboratório da semana passada
tenham donos. Para isso crie uma classe `Dono` com os campos nome e idade, e
adicione um campo dono à classe `Carro`. Não esqueça de corrigir o construtor
`Carro` para inicializar o novo campo!

2\. Um carro é velho se ele foi feito antes de 2002. Implemente um
método `public boolean carroVelho()` na classe `Carro` que diz se uma instância de
carro é velha ou não. 

3\. Escreva um método `public boolean feitoAntes(int ano)` que diz se um carro foi
feito antes de determinado ano.

4\. Escreva um método `public boolean maisVelho(Carro outro)` que diz se um carro é
mais velho que outro ou não. Use o método que você implementou no
exercício anterior.

5\. Escreva um método `public boolean igual(Dono outro)` na classe `Dono` que diz se
duas instâncias de dono são iguais; duas instâncias de dono são iguais
se seus atributos são iguais. Números são comparados com o operador
`==`, enquanto strings são comparadas com o método `equals`.

6\. Escreva um método `public boolean mesmoDono(Carro outro)` na classe carro que diz
se duas instâncias de carro têm o mesmo dono. Use o método da classe
`Dono` definido no exercício anterior.

7\. Os carros do jogo Frogger (exercício 4 do laboratório da semana
passada) se movem de um canto a outro da tela. Quando eles "saem" da tela eles
aprecem de volta vindo do lado oposto. Implemente o método `void mover(double dt)`
que faz o movimento do carro para um intervalo de tempo `dt`, em segundos. Assuma
que a tela tem 800 pixels de largura.

<iframe width="420" height="315" src="http://www.youtube.com/embed/l9fO-YuWPSk" frameborder="0" allowfullscreen="1">
dummy
</iframe>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
