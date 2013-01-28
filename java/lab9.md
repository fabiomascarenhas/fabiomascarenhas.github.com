---
layout: default
title: Lab 9 de MAB 240
relpath: ..
---

MAB 240 - Computação II
=======================

Laboratório 9 - 21/01/2013
--------------------------

Para esse laboratório vamos usar as mesmas classes do [laboratório 8](lab8.html), então
aproveite para terminar esse laboratório caso ainda não tenha acabado. O objetivo do
laboratório 9 é incluir sinalização e tratamento de erros nas classes do último laboratório.

1\. A primeira tarefa é impedir que contas fiquem no vermelho. Crie uma nova exceção **não-checada**
chamada `SaldoInsuficiente`. Uma tentativa de retirar dinheiro além do saldo da conta deve 
lançar essa exceção. Modifique a classe `ContaCorrente` para fazer isso. O que acontece caso se tente transferir
um valor maior que o saldo restante da conta?

Relacionado à última pergunta: qual o problema com a seguinte implementação do método `transfere`?

{% highlight java %}
    public void transfere(ContaCorrente destino, double valor) {
        destino.deposita(valor);
        this.retira(valor);
    }
{% endhighlight %}

É necessário mudar alguma coisa na implementação de `ContaCorrenteLanc` para ter a verificação
de saldo nela? Por quê?

2\. Escreva um método `void processa(BufferedReader buf)` que lê uma sequência de transações de
`buf`, uma transação por linha (usando o método `readLine()` de `BufferedReader`), convertendo
cada linha de string para double com `Double.parseDouble` e fazendo uma retirada se o número
resultante for menor do que 0 ou depósito se for maior do que 0. Capture e trate os erros `SaldoInsuficiente`
e `NumberFormatException`: em um erro `SaldoInsuficiente` você deve imprimir com `System.out.println` uma mensagem
informando que não houve saldo para a retirada, e quanto seria retirado, e erros `NumberFormatException`
devem ser ignorados. O método `processa` deve simplesmente propagar erros `IOException` resultantes
da leitura de `buf`.

Teste `processa` com o seguinte código:

{% highlight java %}
ContaCorrente c = new ContaCorrente(1234, "Fulano", 200);
String trans = "50\n-100.25\nFOO\n-200\n125.25\n-200\n-90\n-50\n";
// o processamento deve imprimir duas mensagens de saldo insuficiente
c.processa(new java.io.BufferedReader(new java.io.StringReader(trans)));
System.out.println(c.saldo); // deve imprimir 25
{% endhighlight %}

3\. Escreva o código de tratamento de exceções para o programa a seguir, seguindo os comentários
no método `actionPerformed`. O usuário deve ser informado caso as exceções citadas aconteçam,
usando o método `mostraMensagem` da classe `Transacoes`.

{% highlight java %}
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.io.*;

public class Transacoes extends JFrame {
    private JTextField numero;
    private JTextField correntista;
    private JTextField saldo;
	
    public Transacoes() {
	super("Transacoes");	
    	setFont(new Font("SanSerif",Font.PLAIN,24));
        setLayout(new GridLayout(4, 1));
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(new Dimension(400, 200));
        add(new JLabel("Número"));
        numero = new JTextField();
        add(numero);
        add(new JLabel("Correntista"));
        correntista = new JTextField();
        add(correntista);
        add(new JLabel("Saldo"));
        saldo = new JTextField();
        add(saldo);
        JButton processar = new JButton("Processar");
        processar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evt) {
				// tratar exceção NumberFormatException
				ContaCorrente conta = new Conta(Integer.parseInt(numero.getText()),
							            correntista.getText(),
							            Double.parseDouble(saldo.getText());
				JFileChooser abreArq = new JFileChooser();
				abreArq.showOpenDialog(null);
				// tratar exceção FileNotFoundException
				File arq = abreArq.getSelectedFile();
				FileReader leitor = new FileReader(arq);
				// Tratar exceção IOException e garantir que arquivo será
				// sempre fechado com finally
				conta.processar(new BufferedReader(new FileReader(arq)));
				saldo.setText("" + conta.saldo);
				leitor.close();
			}
        });
        add(processar);
        JButton limpar = new JButton("Limpar");
        limpar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evt) {
				numero.setText("");
				correntista.setText("");
				saldo.setText("");
			}
        });
        add(limpar);
    }
    
    public void mostraMensagem(String msg) {
    	JOptionPane.showMessageDialog(this, msg);
    }
   
    public static void main(String s[]) {
    	new Transacoes().setVisible(true);
    }
}
{% endhighlight %}


* * * * *

Última Atualização: {{ site.time | date: "%Y-%m-%d %H:%M" }}
