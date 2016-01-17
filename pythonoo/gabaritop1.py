1.

# interface Conta
# interface Investimento

class ContaCorrente:  # Conta
    def __init__(self, numero, correntista,
                 saldo, limite):
        self.numero = numero
        self.correntista = correntista
        self.saldo = saldo
        self.limite = limite

class Poupanca:  # Conta e Investimento
    def __init__(self, numero, correntista,
                 saldo):
        self.numero = numero
        self.correntista = correntista
        self.saldo = saldo
        self.taxa = 0.016

class CD:  # Investimento
    def __init__(self, numero, correntista, saldo, taxa, vencimento):
        self.numero = numero
        self.correntista = correntista
        self.saldo = saldo
        self.taxa = taxa
        self.vencimento = vencimento

a)

cc = ContaCorrente(1234, "Joao", 1250.50, 100.0)
pp = Poupanca(9999, "Joao", 850.75)
cd = CD(5555, "Joao", 360.60, 0.023, "2015-05-25")

b)

# interface Conta
#     def deposita(self, valor)

Devemos implementar deposita em ContaCorrente e Poupanca

# class ContaCorrente
    def deposita(self, valor):
        self.saldo = self.saldo + valor

# class Poupanca
    def deposita(self, valor):
        self.saldo = self.saldo + valor

c)

# interface Conta
#     def retira(self, valor)

# class ContaCorrente
    def retira(self, valor):
        if valor <= self.saldo + self.limite:
            self.saldo = self.saldo - valor
            return True
        else:
            return False

# class Poupanca
    def retira(self, valor):
        if valor <= self.saldo:
            self.saldo = self.saldo - valor
            return True
        else:
            return False

d)

# interface Investimento
#     def corrige(self)

# class Poupanca
    def corrige(self):
        self.saldo = self.saldo + self.saldo * self.taxa

# class CD
    def corrige(self):
        if hoje() < self.vencimento:
            self.saldo = self.saldo + self.saldo * self.taxa

2.

# interface Arvore
#     def tamanho(self)

a)

class ArvoreVazia: # Arvore
    def __init__(self):
        pass

    def tamanho(self):
        return 0

class ArvoreNodo: # Arvore
    def __init__(self, elem, esq, dir):
        self.elem = elem
        self.esq = esq
        self.dir = dir

    def tamanho(self):
        return 1 + self.esq.tamanho() + self.dir.tamanho()
                 
b)

# interface Acao
#     def executa(self, elem)

# interface Arvore
#     def percorrer(self, acao)

# class ArvoreVazia:
    def percorrer(self, acao):
        pass
        
# class ArvoreNodo:
    def percorrer(self, acao):
        acao.executa(self.elem)
        self.esq.percorrer(acao)
        self.dir.percorrer(acao)

class AcaoLista: # Acao
    def __init__(self):
        self.lista = []
    
    def executa(self, elem):
        self.lista.append(elem)
