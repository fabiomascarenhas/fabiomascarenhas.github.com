---
layout: default
title: Lab 6 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 6 - 02/04/2014
--------------------------

No laboratório de hoje vocês irão fazer extensões ao projeto do Editor Gráfico.
O [projeto Eclipse](Editor.zip) irá servir de base. As extensões pedidas
abaixo são cumulativas. Lembro que as classes e interfaces que fazem parte do framework
(`Motor`, `Cor`, `Tela`, `Jogo` e `App`) **não** devem ser modificadas.

1\. Um componente deveria receber um evento `solta` para cada evento `aperto`, mas
isso não acontece atualmente, porque o usuário pode arrastar o mouse para fora
do componente. Modifique a implementação do evento `solta` em `GuiApp` para
consetar isso, e fazer o evento ir para o componente que havia recebido o
evento `aperto`, ao invés do componente dado pelas coordenadas atuais. Faça
o mesmo para o evento `arrasto`. Dica: use um novo campo em `GuiApp` para
guardar o componente que tem o "foco".

2\. Implemente o modo de redimensionamento de figuras, de maneira análoga do
modo de movimentação. A maneira de transformar o movimento do mouse em um fator
de escala fica a seu critério, seja criativo!

3\. Modifique o modo de desenho de novos retângulos para permitir que se arraste o
mouse para qualquer ponto, não apenas pontos abaixo e à direita do ponto
inicial.

4\. Adicione um novo modo de operação ao editor com um novo botão, "Apagar". Um
clique em uma figura nesse modo apaga a figura.

5\. O objeto `Tela` do framework também permite desenhar triângulos. Implemente
isso no editor através de um novo modo de operação ligado a um novo botão, 
"Triângulo". Um triângulo não é desenhado arrastando e soltando. Um triângulo
é desenhado com três cliques, um para cada ponto do triângulo. O local de cada
um dos dois primeiros cliques é marcado com um ponto na tela.

Para os novos modos, lembre-se de integrá-los à funcionalidade de desfazer e
refazer do editor.

A entrega do Laboratório 6 será feita junto com a entrega do Laboratório 7, onde
mais extensões ao editor serão pedidas.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

