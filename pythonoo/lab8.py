import Tkinter

######
###### Classes de interface Tkinter
######

class Janela(Tkinter.Tk):
    def __init__(self, titulo, larg, alt):
        Tkinter.Tk.__init__(self)
        self.title(titulo)
        x = (self.winfo_screenwidth()-larg)/2
        y = (self.winfo_screenheight()-alt)/2
        self.geometry("%dx%d+%d+%d" % (larg, alt, x, y))
        self.resizable(False, False)
        self.componentes()

    def componentes(self):
        raise NotImplementedError()

class Botao(Tkinter.Button):
    def __init__(self, janela, x, y, larg, alt, texto):
        Tkinter.Button.__init__(self, janela)
        self["text"] = texto
        self.place({ "x": x, "y": y, 
                     "width": larg, "height": alt })
        self["command"] = self.executar

    def executar(self):
        raise NotImplementedError()

class Rotulo(Tkinter.Label):
    def __init__(self, janela, x, y, larg, alt, texto, ancora):
        Tkinter.Label.__init__(self, janela)
        self["text"] = texto
        self["anchor"] = ancora
        self.place({ "x": x, "y": y, "width": larg, "height": alt })
        
    def mudou(self, texto):
        self["text"] = str(texto)

######
###### Modelo da calculadora padrão
######

class ModeloCalc:
    def __init__(self):
        self.reset()

    def valor(self):
        return "%d" % self.display

    def digito(self, i):
        self.modo.digito(i)

    def soma(self):
        self.modo.soma()
    
    def sub(self):
        self.modo.sub()

    def mult(self):
        self.modo.mult()

    def div(self):
        self.modo.div()

    def igual(self):
        self.modo.igual()

    def reset(self):
        self.display = 0
        self.operando = 0
        self.modo = ModoNormal(self)
        self.ultima_op = self.modo
    
class ModoNormal:
    def __init__(self, modelo):
        self.modelo = modelo
        self.aumentando = False

    def faz(self, esq):
        return esq 
 
    def digito(self, i):
        if self.aumentando:
            self.modelo.display = self.modelo.display * 10 + i
        else:
            self.aumentando = True
            self.modelo.display = i

    def soma(self):
        self.modelo.operando = self.modelo.display
        self.modelo.modo = ModoOp(self.modelo, "+")

    def sub(self):
        self.modelo.operando = self.modelo.display
        self.modelo.modo = ModoOp(self.modelo, "-")

    def mult(self):
        self.modelo.operando = self.modelo.display
        self.modelo.modo = ModoOp(self.modelo, "*")

    def div(self):
        self.modelo.operando = self.modelo.display
        self.modelo.modo = ModoOp(self.modelo, "/")

    def igual(self):
        self.modelo.display = self.modelo.ultima_op.faz(self.modelo.display)
        self.aumentando = False

class ModoOp:
    def __init__(self, modelo, op):
        self.modelo = modelo
        self.op = op
        self.aumentando = False

    def faz(self, esq):
        if self.op == "+":
            return esq + self.dir
        elif self.op == "-":
            return esq - self.dir
        elif self.op == "*":
            return esq * self.dir
        elif self.op == "/":
            return esq / self.dir

    def faz_op(self, op):
        if self.aumentando:
            self.dir = self.modelo.display
            self.modelo.display = self.faz(self.modelo.operando)
            self.modelo.operando = self.modelo.display
            self.modelo.modo = ModoOp(self.modelo, op)
        else:
            self.modelo.modo = ModoOp(self.modelo, op)
            
    def digito(self, i):
        if self.aumentando:
            self.modelo.display = self.modelo.display * 10 + i
        else:
            self.aumentando = True
            self.modelo.display = i

    def soma(self):
        self.faz_op("+")

    def sub(self):
        self.faz_op("-")

    def mult(self):
        self.faz_op("*")

    def div(self):
        self.faz_op("/")

    def igual(self):
        if self.aumentando:
            self.dir = self.modelo.display
            self.modelo.ultima_op = self
            self.modelo.display = self.faz(self.modelo.operando)
            self.modelo.operando = self.modelo.display
            self.modelo.modo = ModoNormal(self.modelo)
        else:
            self.dir = self.modelo.display
            self.modelo.ultima_op = self
            self.modelo.display = self.faz(self.modelo.operando)
            self.modelo.modo = ModoNormal(self.modelo)
    
        
    
