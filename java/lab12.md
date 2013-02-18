---
layout: default
title: Lab 12 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 12 - 18/02/2013
---------------------------

0\. Instale o [Android Development Tools](http://marketplace.eclipse.org/content/android-development-tools-eclipse#.UR-7-auY5a4) via Eclipse Marketplace. Depois de instalado você irá precisar instalar todos os pacotes da versão 4.0.3 do Android
usando o "Android SDK Manager" dentro do menu "Window" do Eclipse. Também no menu Window, crie uma máquina virtual
no "Android Virtual Device Manager", escolhendo "3.2" QVGA" em "Device", "Android 4.0.3" em "Target", e "Intel Atom" em "CPU/ABI".

1\. Baixe o [projeto da calculadora](CalcAndroid.zip). Modifique o modelo da calculadora para incluir a memória,
e inclua os novos botões necessários em mais uma fileira de botões logo abaixo do display. Não se esqueça de
tratar corretamente a gravação e recuperação do "instance state" da calculadora para gravar e recuperar também
o conteúdo da memória.

2\. Faça uma cópia do projeto, e o modifique para usar o modelo da
calculadora RPN que você fez no [último laboratório](lab11.html), ao invés do modelo atual.
Não se esqueça de tratar corretamente a gravação e recuperação do "instance state" da calculadora,
lembre que ele inclui a pilha!

Enviando
--------

Use o formulário abaixo para enviar o Laboratório 12. O prazo para envio é segunda-feira, dia 04/03/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/30464717825660">dummy</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
