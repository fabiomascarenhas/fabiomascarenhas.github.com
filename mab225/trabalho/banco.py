from datetime import date

def hoje():
    return str(date.today())

class Conta:
    def __init__(self, numero, nome, saldo = 0):
        self.numero = numero
        self.correntista = nome
        self.saldo = saldo
        self.lancamentos = []
    def alterarNome(self, nome):
        self.correntista = nome
    def deposito(self, valor, msg = "deposito"):
        self.lancamentos.append((hoje(), msg, valor))
        self.saldo = self.saldo + valor
    def saque(self, valor, msg = "saque"):
        self.lancamentos.append((hoje(), msg, -valor))
        self.saldo = self.saldo - valor
    def transferencia(self, outra, valor):
        self.saque(valor, "transferencia para %s" % outra.numero)
        outra.deposito(valor, "transferencia de %s" % self.numero)
    def extrato(self, data):
        linhas = []
        saldo = self.saldo
        i = len(self.lancamentos) - 1
        while i >= 0 and self.lancamentos[i][0] >= data:
            saldo = saldo - self.lancamentos[i][2]
            i = i - 1
        i = i + 1
        while i < len(self.lancamentos):
            datalanc, desc, val = self.lancamentos[i]
            saldo = saldo + val
            linhas.append("%s %-34s%10.2f%10.2f" % (datalanc, desc, val, saldo))
            i = i + 1
        return linhas

contas = {}

contas["123"] = Conta("123", "Fulano", 40)
contas["456"] = Conta("456", "Beltrano", 100)
contas["768"] = Conta("768", "Cicrano", 70)

contas["123"].lancamentos = [("2011-04-20", "abertura", 100),\
                             ("2011-05-10", "saque", -30),\
                             ("2011-05-15", "deposito", 20),\
                             ("2011-05-29", "transferencia para 456", -50)]

contas["456"].lancamentos = [("2011-04-12", "abertura", 50),\
                             ("2011-05-29", "transferencia de 123", 50)]

contas["768"].lancamentos = [("2011-05-01", "abertura", 70)]

