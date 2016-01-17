import Tkinter
import math
import datetime

def hoje():
    return str(datetime.date.today())

def cor_tkinter(cor):
    return "#%02x%02x%02x" % (int(cor[0]*255),
                              int(cor[1]*255),
                              int(cor[2]*255))

class Janela(Tkinter.Tk):
    def __init__(self, titulo, larg, alt):
        Tkinter.Tk.__init__(self)
        self.title(titulo)
        x = (self.winfo_screenwidth()-larg)/2
        y = (self.winfo_screenheight()-alt)/2
        self.geometry("%dx%d+%d+%d" % (larg, alt, x, y))
        self.resizable(False, False)
        #self["bg"] = "#ffffff"
        self.componentes()

    def componentes(self):
        raise NotImplementedError()

class Botao(Tkinter.Button):
    def __init__(self, janela, x, y, larg, alt, texto, fonte):
        Tkinter.Button.__init__(self, janela)
        self["text"] = texto
        if type(fonte) == int:
            self["font"] = "Arial %d" % fonte
        else:
            self["font"] = fonte
        self.place({ "x": x, "y": y, 
                     "width": larg, "height": alt })
        self["command"] = self.executar

    def executar(self):
        raise NotImplementedError()

class Rotulo(Tkinter.Label):
    def __init__(self, janela, x, y, larg, alt, texto, fonte, ancora):
        Tkinter.Label.__init__(self, janela)
        self["text"] = texto
        self["anchor"] = ancora
        if type(fonte) == int:
            self["font"] = "Arial %d" % fonte
        else:
            self["font"] = fonte
        self.place({ "x": x, "y": y, "width": larg, "height": alt })
        
    def mudou(self, texto):
        self["text"] = str(texto)

class Canvas(Tkinter.Canvas):
    def __init__(self, janela, x, y, larg, alt):
        Tkinter.Canvas.__init__(self, janela)
        self["bg"] = "#ffffff"
        self.bind("<ButtonPress-1>", self.apertou)
        self.bind("<ButtonRelease-1>", self.soltou)
        self.bind("<B1-Motion>", self.arrastou)
        self.place({ "x": x, "y": y, "width": larg, "height": alt })

    def apertou(self, evt):
        pass

    def soltou(self, evt):
        pass

    def arrastou(self, evt):
        pass

    def limpar(self):
        self.delete(Tkinter.ALL)

    def triangulo(self, p1, p2, p3, cor):
        self.create_polygon([p1[0], p1[1], p2[0], p2[1], p3[0], p3[1]],
                            { "fill": cor_tkinter(cor), "outline": cor_tkinter(cor) })

    def linha(self, p1, p2, cor):
        self.create_line(p1[0], p1[1], p2[0], p2[1],
                         { "fill": cor_tkinter(cor) })

class CaixaTexto(Tkinter.Text):
    def __init__(self, janela, x, y, larg, alt, fonte):
        Tkinter.Text.__init__(self, janela)
        if type(fonte) == int:
            self["font"] = "Arial %d" % fonte
        else:
            self["font"] = fonte
        self.place({ "x": x, "y": y, "width": larg - 20, "height": alt })
        sb = Tkinter.Scrollbar(janela)
        sb["command"] = self.yview
        self["yscrollcommand"] = sb.set
        sb.place({ "x" : x + larg - 20, "y": y, "width": 20, "height" : alt })
                
    def texto(self):
        return self.get(1.0, Tkinter.END)

    def limpar(self):
        self.delete(1.0, Tkinter.END)

class CaixaEntrada(Tkinter.Entry):
    def __init__(self, janela, x, y, larg, alt, fonte):
        Tkinter.Entry.__init__(self, janela)
        if type(fonte) == int:
            self["font"] = "Arial %d" % fonte
        else:
            self["font"] = fonte
        self.place({ "x": x, "y": y, "width": larg, "height": alt })

    def escreve(self, texto):
        self.limpar()
        self.insert(0, texto)

    def texto(self):
        return self.get()    

    def limpar(self):
        self.delete(0, Tkinter.END)

class CaixaLista(Tkinter.Listbox):
    def __init__(self, janela, x, y, larg, alt, fonte):
        Tkinter.Listbox.__init__(self, janela)
        if type(fonte) == int:
            self["font"] = "Arial %d" % fonte
        else:
            self["font"] = fonte
        self.place({ "x": x, "y": y, "width": larg - 20, "height": alt })
        sb = Tkinter.Scrollbar(janela)
        sb["command"] = self.yview
        self["yscrollcommand"] = sb.set
        sb.place({ "x" : x + larg - 20, "y": y, "width": 20, "height" : alt })
                
    def inserir(self, item):
        self.insert(Tkinter.END, item)

    def remover(self, indice):
        self.delete(indice)

    def selecionado(self):
        sel = self.curselection()
        if len(sel) > 0:
            return self.get(sel[0])
        else:
            return None

    def limpar(self):
        self.delete(0, Tkinter.END)

class CaixaOpcao(Tkinter.OptionMenu):
    def __init__(self, janela, x, y, larg, alt, fonte, texto, opcoes):
        self.var = Tkinter.StringVar()
        self.var.set(texto)
        Tkinter.OptionMenu.__init__(self, janela, self.var, *opcoes)
        self["anchor"] = "w"
        if type(fonte) == int:
            self["font"] = "Arial %d" % fonte
        else:
            self["font"] = fonte
        self.place({ "x": x, "y": y, "width": larg, "height": alt })
                
    def selecionado(self):
        return self.var.get()

#### Modelo

class Conta:
    def __init__(self, numero, nome, saldo):
        self.numero = numero
        self.correntista = nome
        self.saldo = saldo
        self.lancamentos = [{ "data": hoje(), "mensagem": "abertura", "valor": saldo }]
        self.obs = []

    def observar(self, observador):
        self.obs.append(observador)

    def notificar(self):
        for obs in self.obs:
            obs.mudou(self)

    def deposito(self, valor, mensagem = "deposito"):
        lancamento = { "data": hoje(), "mensagem": mensagem, "valor": valor }
        self.lancamentos.append(lancamento)
        self.saldo = self.saldo + valor
        self.notificar()

    def saque(self, valor, mensagem = "saque"):
        lancamento = { "data": hoje(), "mensagem": mensagem, "valor": -valor }
        self.lancamentos.append(lancamento)
        self.saldo = self.saldo - valor
        self.notificar()

    def transferencia(self, outra, valor):
        self.saque(valor, "transferencia para %s" % outra.numero)
        outra.deposito(valor, "transferencia de %s" % self.numero)

    def extrato(self, data):
        linhas = []
        saldo = self.saldo
        i = len(self.lancamentos) - 1
        while i >= 0 and self.lancamentos[i]["data"] >= data:
            saldo = saldo - self.lancamentos[i]["valor"]
            i = i - 1
        i = i + 1
        while i < len(self.lancamentos):
            data = self.lancamentos[i]["data"]
            mensagem = self.lancamentos[i]["mensagem"]
            valor = self.lancamentos[i]["valor"]
            saldo = saldo + valor
            linhas.append("%s %-25s%10.2f%10.2f" % (data, mensagem, valor, saldo))
            i = i + 1
        return linhas

class Contas:
    def __init__(self):
        self.contas = {}
        self.contas["123"] = Conta("123", "Fulano", 40)
        self.contas["456"] = Conta("456", "Beltrano", 100)
        self.contas["768"] = Conta("768", "Cicrano", 70)
        self.contas["123"].lancamentos = [{ "data": "2015-04-20", "mensagem": "abertura", "valor": 100 },
                                          { "data": "2015-05-10", "mensagem": "saque", "valor": -30 },
                                          { "data": "2015-05-15", "mensagem": "deposito", "valor": 20 },
                                          { "data": "2015-05-29", "mensagem": "transferencia para 456", "valor": -50}]
        self.contas["456"].lancamentos = [{ "data": "2015-04-12", "mensagem": "abertura", "valor": 50},
                                          { "data": "2015-05-29", "mensagem": "transferencia de 123", "valor": 50}]
        self.contas["768"].lancamentos = [{ "data": "2015-05-01", "mensagem": "abertura", "valor": 70}]
    
    def conta(self, numero):
        return self.contas[numero]

    def numeros(self):
        return self.contas.keys()

#### Rodando

class BotaoExtrato(Botao):
    def __init__(self, janela, x, y, larg, alt, texto, tamanho, contas, co, cl, ce):
        Botao.__init__(self, janela, x, y, larg, alt, texto, tamanho)
        self.contas = contas
        self.cl = cl
        self.co = co
        self.ce = ce
    
    def executar(self):
        numero = self.co.selecionado()
        if numero != "Escolha uma conta":
            conta = self.contas.conta(numero)
            self.cl.limpar()
            self.cl.inserir("%-10s %-25s%10s%10s" % ("Data", "Descricao", "Valor", "Saldo"))
            self.cl.inserir("=" * 56)
            data = self.ce.texto()
            if data == "": data = hoje()
            for linha in conta.extrato(data):
                self.cl.inserir(linha)
        
class JanelaProg(Janela):
    def __init__(self):
        Janela.__init__(self, "Programa", 600, 400)

    def componentes(self):
        contas = Contas()
        numeros = contas.numeros()
        Rotulo(self, 0, 0, 80, 50, "Conta:", 16, "w")
        co = CaixaOpcao(self, 80, 0, 520, 50, 16, numeros[0], numeros)
        Rotulo(self, 0, 50, 80, 50, "Data:", 16, "w")
        ce = CaixaEntrada(self, 80, 50, 520, 50, 16)
        ce.escreve("2015-01-01")
        cl = CaixaLista(self, 0, 100, 600, 250, "Courier 12")
        BotaoExtrato(self, 0, 350, 100, 50, "Extrato", 16, contas, co, cl, ce)
                
raiz = JanelaProg()
raiz.mainloop()
