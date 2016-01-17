---
layout: default
title: Lab 10 de MAB 225
relpath: ..
---

MAB 225 - Computação II
=======================

Laboratório 10 - 17/06/2015
--------------------------

Para esse laboratório use [esse arquivo](lab10.py), que contém as classes
de todos os componentes que criamos até agora, e mais algumas que serão usadas
nos exerícios abaixo.

1\. O controle `Tkinter.Frame` é uma moldura para outros controles. Na tela ela
é só um retângulo, mas podemos por outros controles dentro dele passando
a instância da moldura no lugar da janela quando eles são criados.
A principal utilidade de uma moldura é poder trocar partes da interface,
ou mesmo toda a interface do programa, de maneira simples. A ideia é
que podemos esconder uma moldura para esconder diversos componentes
de uma só tacada, e do mesmo modo exibir uma moldura para exibir
diversos componentes de uma vez.

Implemente a classe `Moldura` para derivar de `Tkinter.Frame`.
Seu construtor deve receber a janela que irá conter a moldura,
suas coordenadas e seu tamanho. Ao contrário dos outros componentes,
a moldura não se exibe com `place` no momento em que ela é construída:
ela possui um método `mostra(self)` que faz isso, e um método `esconde(self)`
que chama o método `place_forget(self)` para esconder a moldura e tudo
que está dentro dela.

2\. O arquivo está implementando um programa para mostrar o extrato de uma
conta bancária a partir de certa data. A conta é selecionada através de
uma `CaixaOpcao`, e a data é digitada em uma `CaixaEntrada` (uma `CaixaTexto`
que contém apenas uma linha). Vocês irão usar molduras para quebrar a
aplicação em diversas telas diferentes.

a\. A primeira tela terá apenas uma mensagem de boas vindas (um `Rotulo`),
uma `CaixaOpcao` com os números das contas e um `Botao` "Entrar". Quando
clicado o botão passará para a tela seguinte (escondendo a moldura da
tela de boas vindas e mostrando a da próxima).

b\. A segunda tela terá uma `CaixaLista` como a que está agora na aplicação,
mas sem a `CaixaOpcao`, mostrando o extrato da conta que foi selecionada na
primeira tela. Ao invés de ficar na parte inferior o botão "Extrato" deve
ficar ao lado da caixa de entrada da data. Na parte inferior estarão
dois botões: "Transferência" e "Encerrar". O botão encerrar volta para
a primeira tela. O botão "Transferência" prossegue para a terceira.

c\. A terceira tela permite escolher uma conta usando uma `CaixaOpcao`
(a conta ativa não deve aparecer), e entrar um valor para transferência
em uma `CaixaEntrada`. Coloque os rótulos apropriados. Ela tem dois
botões: o botão "Transferir" efetua a transferência, e volta para
a segunda tela, que deve estar mostrando o novo lançamento, e o botão
"Cancelar" volta para a segunda tela sem transferir.

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}

