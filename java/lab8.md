---
layout: default
title: Lab 8 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 8 - 14/01/2013
--------------------------

1\. A classe a seguir representa uma modelagem bastante simples de uma conta
corrente:

{% highlight java %}
class ContaCorrente {
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

    public void transfere(Conta destino, double valor) {
        this.retira(valor);
        destino.deposita(valor);
    }
}
{% endhighlight %}

Defina a classe `ContaCorrenteLanc` que extende `ContaCorrente` para incluir
uma lista de lançamentos (uma instância de `ArrayList\<String\>`). Essa
classe deve redefinir os métodos `deposita` e `retira` de `ContaCorrente` para
adicionar as strings *“DEPÓSITO DE n”* ou *“RETIRADA DE n”* na lista de
lançamentos a cada depósito ou retirada, respectivamente, onde $n$ é o
valor depositado ou retirado.

Redefina o método `String toString()` na classe `ContaCorrenteLanc` para retornar
um extrato de todos os lançamentos, com um lançamento por linha e o saldo no final:

{% highlight java %}
EXTRATO DA CONTA NO. 1234

DEPÓSITO DE 100.0
RETIRADA DE 50.0
DEPÓSITO de 20.0

SALDO: 250.0
{% endhighlight %}

2\. A classe `JTable` é uma classe padrão de Java que mostra uma tabela na tela (como uma planilha).
Os dados que preenchem uma `JTable` são fornecidos por uma implementação da interface `TableModel`,
o *modelo* da tabela. Essa interface tem vários métodos que muitas implementações de `TableModel` 
provavelmente implementariam de maneira idêntica, então a biblioteca de classes Java também fornece
`AbstractTableModel`, uma classe abstrata que implementa `TableModel` facilitando o trabalho de
definir esses modelos. 

Ao invés de implementar `TableModel` e implementar todos os seus métodos, uma classe pode herdar de
`AbstractTableModel` e implementar apenas os seguintes métodos:

{% highlight java %}
public int getRowCount();       // Quantas linhas a tabela tem
public int getColumnCount();    // Quantas colunas a tabela tem
// Qual o rótulo da coluna
public String getColumnName(int coluna);
// Qual o valor de cada célula
public Object getValueAt(int linha, int coluna);
{% endhighlight %}

Defina uma classe `TabelaContas` que herda de `AbstractTableModel` e mostra uma tabela a partir de uma
lista de contas (instâncias de `ContaCorrentLanc` do exercício 1). As colunas da tabela devem ser "Número", "Correntista",
"#Lanc" (quantos lançamentos essa conta tem) e "Saldo". Teste essa classe com o seguinte programa:

{% highlight java %}
import java.awt.*;
import javax.swing.*;

public class Contas extends JPanel {
    public Contas() {
        this.setFont(new Font("SanSerif",Font.PLAIN,24));
        this.setLayout(new BorderLayout());
        this.add(new JScrollPane(new JTable(new TabelaContas())));
    }
   
    public static void main(String s[]) {
        JFrame frame = new JFrame("Contas");
       
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(new Contas(),"Center");
        frame.setSize(new Dimension(400, 300));
        frame.setVisible(true);
    }
}
{% endhighlight %}

3\. A classe `Racional` abaixo representa números racionais:

{% highlight java %}
public class Racional {
    private int num; // numerador
    private int den; // denominador

    public Racional(int num, int den) {
        this.num = num;
        this.den = den;
    }

    public String toString() {
        return num + "/" + den;
    }
}
{% endhighlight %}

Implemente métodos `boolean equals(Object outro)` e `int hashCode()` na classe `Racional`,
de modo que dois números racionais sejam iguais se ambos podem ser simplificados para
o mesmo numerador e denominador (por exemplo, 3/6 e 4/8 são iguais pois ambos podem ser
simplificados para 1/2). Para simplificar um racional, divida numerador e denominador pelo
MDC desses dois números.

Executar o código a seguir no scrapbook deve imprimir "2":

{% highlight java %}
java.util.HashSet<Racional> c = new java.util.HashSet<Racional>();
c.add(new Racional(3,6));
c.add(new Racional(2,5));
c.add(new Racional(4,8));
c.add(new Racional(1,2));
c.add(new Racional(10,25));
System.out.println(c.size());
{% endhighlight %}

Enviando
--------

Use o formulário abaixo para enviar o Laboratório 8. O prazo para envio é segunda-feira, dia 21/01/2013.

<script type="text/javascript" src="http://form.jotformz.com/jsform/30125949049659">
// dummy
</script>

* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
