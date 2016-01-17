# Interface para listas
#
# def adicionar(self, elem)  # retorna uma nova lista contendo elem no inicio
# def le(self, i)            # retorna o i-esimo elemento da lista (ou None se nao existir)
# def tamanho(self)          # retorna o tamanho da lista
# def remover(self, elem)    # retorna uma nova lista sem
#                            # a primeira ocorrencia de elem
#                            # se elem nao existir, retorna a mesma
#                            # lista
# def append(self, elem)     # retorna uma nova lista contendo elem no final
# def str(self)              # retorna a lista como uma string
# def iterar(self, acao)     # executa acao para cada elemento da lista

# Interface Acao:
#     def executar(self, elem)

# Uma lista e':
#
# uma lista vazia (ListaVazia)
# um par de primeiro elemento e o resto da lista, que e outra lista (ListaPar)
#

class ListaVazia:
    def __init__(self):
        pass

    def tamanho(self):
        return 0

    def le(self, i):
        return None

    def adicionar(self, elem):
        return ListaPar(elem, self)

    def remover(self, elem):
        return self

    def append(self, elem):
        return self.adicionar(elem)

    def str(self):
        return "[]"

    def iterar(self, acao):
        pass
    
class ListaPar:
    def __init__(self, primeiro, resto):
        self.primeiro = primeiro
        self.resto = resto

    def tamanho(self):
        return self.resto.tamanho() + 1

    def le(self, i):
        if i == 0:
            return self.primeiro
        else:
            return self.resto.le(i-1)

    def adicionar(self, elem):
        return ListaPar(elem, self)

    def remover(self, elem):
        if elem == self.primeiro:
            return self.resto
        else:
            novo_resto = self.resto.remover(elem)
            if novo_resto == self.resto:
                return self
            else:
                return ListaPar(self.primeiro, novo_resto) 

    def append(self, elem):
        return ListaPar(self.primeiro, self.resto.append(elem))        

    def str(self):
        sr = self.resto.str()
        if sr == "[]":
            return "[" + str(self.primeiro) + "]"
        else:
            return "[" + str(self.primeiro) + "," + sr[1:]

    def iterar(self, acao):
        acao.executar(self.primeiro)
        self.resto.iterar(acao)
        
class AcaoPrint:
    def executar(self, elem):
        print elem

class AcaoSoma:
    def __init__(self):
        self.soma = 0

    def executar(self, elem):
        self.soma = self.soma + elem
