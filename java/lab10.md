---
layout: default
title: Lab 10 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 10 - 28/01/2013
---------------------------

1\. Vamos usar as classes `ObjectOutputStream` e `ObjectInputStream` junto com classes genéricas
para criar um banco de objetos que vai poder ser usado com diferentes tipos de objeto. O único
requisito para um objeto poder ser salvo em um banco vai ser implementar a interface `Elemento`:

{% highlight java %}
public interface Elemento extends java.io.Serializable {
	String chave();
}
{% endhighlight %}

Construa uma classe genérica `BancoObjetos<TELEM extends Elemento>` para armazenar objetos.
O construtor de `BancoObjetos` deve receber uma string dando o diretório onde os objetos serão
gravados e lidos. Caso o diretório não exista ele deve ser criado. Use a classe `File` para isso,
em particular os métodos `exists` e `mkdirs`. 

Cada elemento do banco deve ficar armazenado em um arquivo separado nesse diretório, com o nome do arquivo é
formado pela chave mais a extensão ".objeto". `BancoObjetos` precisa de dois métodos, `ler` e `gravar`.
O método `ler` recebe uma chave e retorna o objeto correspondente àquela chave (ou `null` se ele não existir).
O método `gravar` recebe um objeto e o grava no banco, e retorna `true` se a gravação foi bem sucedida ou
`false` se ocorreu algum problema na gravação.

Para instanciar as classes `ObjectOutputStream` e `ObjectInputStream` você também vai precisar instanciar
`FileOutputStream` e `FileInputStream`.

A classe `ContaCorrente` abaixo exercita o banco de objetos:

{% highlight java %}
class ContaCorrente implements Elemento {
    private int numero;
    private String correntista;
    private double saldo;

    public ContaCorrente(int numero, String correntista, double saldo) {
        this.numero = numero;
        this.correntista = correntista;
        this.saldo = saldo;
    }

    public void deposita(double valor) {
        this.saldo += valor;
    }

    public void retira(double valor) {
        this.saldo -= valor;
    }

    public void transfere(ContaCorrente destino, double valor) {
        this.retira(valor);
        destino.deposita(valor);
    }
    
    public String chave() {
    		return "" + numero;
    }
    
    public String toString() {
    		return numero + ", " + correntista + ", " + saldo;
    }
    
    public static void main(String[] args) throws java.io.IOException {
    		BancoObjetos<ContaCorrente> bd = new BancoObjetos<ContaCorrente>("banco");
    		java.io.BufferedReader in = new java.io.BufferedReader(new java.io.InputStreamReader(System.in));
    		while(true) {
    			System.out.print("Entre um número de conta: ");
    			int numero = Integer.parseInt(in.readLine());
    			if(numero == 0) break;
    			ContaCorrente cc = bd.ler("" + numero);
    			if(cc == null) {
        			System.out.print("Entre um correntista: ");
    				String correntista = in.readLine();
        			System.out.print("Entre um saldo: ");
    				double saldo = Double.parseDouble(in.readLine());
    				bd.gravar(new ContaCorrente(numero, correntista, saldo));
    			} else {
    				System.out.println(cc.toString());
    			}
    		}
    }
}
{% endhighlight %}

2\. Adicione *memória* ao [modelo da calculadora](Calculadora.zip). A calculadora tem quatro operações
envolvendo a memória: `limpa`, que zera a memória, `msoma`, que adiciona o valor do display à memória,
`msub`, que subtrai o valor do display da memória, e `recupera`, que substitui o que está no display
pelo valor da memória. O funcionamento da memória é o mesmo não importa qual o estado da calculadora.

3\. Adicione uma operação `trocaSinal` ao modelo da calculadora do exercício anterior, que inverte o sinal
do que está no display (negativo para positivo, positivo para negativo).

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
