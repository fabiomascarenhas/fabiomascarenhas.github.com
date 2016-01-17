import Tkinter
import math
import tkFileDialog
import numpy
import matplotlib.pyplot

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
    def __init__(self, janela, x, y, larg, alt, texto, tamanho):
        Tkinter.Button.__init__(self, janela)
        self["text"] = texto
        self["font"] = "Arial %d" % tamanho
        self.place({ "x": x, "y": y, 
                     "width": larg, "height": alt })
        self["command"] = self.executar

    def executar(self):
        raise NotImplementedError()

class JanelaEditor(Janela):
    def componentes(self):
        self.LARGURA = 800
        self.ALTURA = 600
        self.modelo = Modelo((0, 0, 0))
        BotaoMover(self, 20, 20, 100, 50, self.modelo)
        BotaoRetangulo(self, 20, 90, 100, 50, self.modelo)
        BotaoPonto(self, 20, 160, 100, 50, self.modelo)
        BotaoApagar(self, 20, 300, 100, 50, self.modelo)
        BotaoCirculo(self, 20, 230, 100, 50, self.modelo)
        BotaoDesfazer(self, 20, 440, 100, 50, self.modelo)
        BotaoRefazer(self, 20, 510, 100, 50, self.modelo)
        SliderCor(self, self.LARGURA - 70, 50, 40, 100, self.modelo, 0)
        SliderCor(self, self.LARGURA - 70, 200, 40, 100, self.modelo, 1)
        SliderCor(self, self.LARGURA - 70, 350, 40, 100, self.modelo, 2)
        paleta = Paleta(self, self.LARGURA - 85, 500, 70, 70, (1, 1, 1))
        self.modelo.observar_cor(paleta)
        canvas = CanvasEditor(self, 140, 0, self.LARGURA - 240, self.ALTURA, self.modelo)
        self.modelo.observar_figuras(canvas)
        
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

class Paleta(Tkinter.Label):
    def __init__(self, janela, x, y, larg, alt, cor):
        Tkinter.Label.__init__(self, janela)
        self["text"] = ""
        self["bg"] = cor_tkinter(cor)
        self.place({ "x": x, "y": y, "width": larg, "height": alt })
    
    def mudou(self, cor):
        self["bg"] = cor_tkinter(cor)
 
class Slider(Tkinter.Scale):
    def __init__(self, janela, x, y, larg, alt, inicio, fim):
        Tkinter.Scale.__init__(self, janela)
        self["from"] = inicio
        self["to"] = fim
        self["resolution"] = -1
        self["showvalue"] = 0
        self["width"] = larg
        self.set(inicio)
        self["command"] = self.mudou
        self.place({ "x": x, "y": y, "height": alt })

    def valor(self):
        return self.get()

    def mudou(self, valor):
        raise NotImplementedError()

class SliderCor(Slider):
    def __init__(self, janela, x, y, larg, alt, modelo, cor):
        Slider.__init__(self, janela, x, y, larg, alt, 0.0, 1.0)
        self.cor = cor
        self.modelo = modelo

    def mudou(self, valor):
        cor_modelo = [self.modelo.cor[0], self.modelo.cor[1], self.modelo.cor[2]]
        cor_modelo[self.cor] = float(valor)
        self.modelo.muda_cor((cor_modelo[0], cor_modelo[1], cor_modelo[2]))

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

    def retangulo(self, x, y, larg, alt, cor):
        self.create_rectangle(x, y, x+larg, y+alt, { "fill": cor_tkinter(cor),
                                                     "outline": cor_tkinter(cor) })

    def circulo(self, x, y, raio, cor):
        self.create_oval(x-raio, y-raio, x+raio, y+raio, { "fill": cor_tkinter(cor),
                                                               "outline": cor_tkinter(cor)})

class BotaoMover(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Mover", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.modo_mover()

class BotaoRetangulo(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Retangulo", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.modo_ret()

class BotaoPonto(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Ponto", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.modo_ponto()

class BotaoCirculo(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Circulo", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.modo_circ()

class BotaoApagar(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Apagar", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.modo_apagar()

class BotaoDesfazer(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Desfazer", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.desfazer()

class BotaoRefazer(Botao):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Botao.__init__(self, janela, x, y, larg, alt, "Refazer", 14)
        self.modelo = modelo

    def executar(self):
        self.modelo.refazer()

class CanvasEditor(Canvas):
    def __init__(self, janela, x, y, larg, alt, modelo):
        Canvas.__init__(self, janela, x, y, larg, alt)
        self.modelo = modelo

    def apertou(self, evt):
        x = self.canvasx(evt.x)
        y = self.canvasy(evt.y)
        self.modelo.inicio(x, y)

    def arrastou(self, evt):
        x = self.canvasx(evt.x)
        y = self.canvasy(evt.y)
        self.modelo.meio(x, y)

    def soltou(self, evt):
        x = self.canvasx(evt.x)
        y = self.canvasy(evt.y)
        self.modelo.fim(x, y)

    def mudou(self, figuras):
        self.limpar()
        self.modelo.desenhar(self)
    

####
#### MODELO
####

class Modelo:
    def __init__(self, cor):
        self.figuras = []
        self.feitos = []
        self.desfeitos = []
        self.modo = ModoMover(self)
        self.cor = cor
        self.obs_cor = []
        self.obs_figuras = []

    def observar_cor(self, o):
        self.obs_cor.append(o)

    def observar_figuras(self, o):
        self.obs_figuras.append(o)

    def muda_cor(self, cor):
        self.cor = cor
        for o in self.obs_cor:
            o.mudou(self.cor)

    def notificar_figuras(self):
        for o in self.obs_figuras:
            o.mudou(self.figuras)

    def modo_mover(self):
        self.modo.encerrar()
        self.modo = ModoMover(self)

    def modo_ret(self):
        self.modo.encerrar()
        self.modo = ModoRet(self)

    def modo_circ(self):
        self.modo.encerrar()
        self.modo = ModoCirc(self)

    def modo_ponto(self):
        self.modo.encerrar()
        self.modo = ModoPonto(self)

    def modo_apagar(self):
        self.modo.encerrar()
        self.modo = ModoApagar(self)

    def desfazer(self):
        if len(self.feitos) > 0:
            cmd = self.feitos.pop()
            self.desfeitos.append(cmd)
            cmd.desfazer(self)
            self.notificar_figuras()

    def refazer(self):
        if len(self.desfeitos) > 0:
            cmd = self.desfeitos.pop()
            self.feitos.append(cmd)
            cmd.fazer(self)
            self.notificar_figuras()

    def inicio(self, x, y):
        self.modo.inicio(x, y)

    def meio(self, x, y):
        self.modo.meio(x, y)
        self.notificar_figuras()

    def fim(self, x, y):
        self.modo.fim(x, y)
        self.notificar_figuras()

    def desenhar(self, canvas):
        for figura in self.figuras:
            figura.desenhar(canvas)
        self.modo.desenhar(canvas)

class ComandoMover:
    def __init__(self, figura, dx, dy):
        self.figura = figura
        self.dx = dx
        self.dy = dy

    def fazer(self, modelo):
        self.figura.mover(self.dx, self.dy)

    def desfazer(self, modelo):
        self.figura.mover(-self.dx, -self.dy)

class ComandoApagar:
    def __init__(self, figura):
        self.figura = figura

    def fazer(self, modelo):
        modelo.figuras.remove(self.figura)

    def desfazer(self, modelo):
        modelo.figuras.append(self.figura)

class ComandoAdicionar:
    def __init__(self, figura):
        self.figura = figura

    def fazer(self, modelo):
        modelo.figuras.append(self.figura)

    def desfazer(self, modelo):
        modelo.figuras.remove(self.figura)
    
class ModoMover:
    def __init__(self, modelo):
        self.modelo = modelo
        self.movendo = False

    def __str__(self):
        return "MOVER"

    def desenhar(self, canvas):
        pass

    def encerrar(self):
        pass

    def inicio(self, x, y):
        for figura in self.modelo.figuras:
            if figura.dentro(x, y):
                self.movendo = True
                self.figura = figura
                self.x = x
                self.y = y
                self.x_orig = x
                self.y_orig = y

    def meio(self, x, y):
        if self.movendo:
            dx = x - self.x
            dy = y - self.y
            self.x = x
            self.y = y
            self.figura.mover(dx, dy)

    def fim(self, x, y):
        if self.movendo:
            self.movendo = False
            dx = x - self.x
            dy = y - self.y
            self.figura.mover(dx, dy)
            self.modelo.feitos.append(ComandoMover(self.figura, x - self.x_orig, y - self.y_orig))
    
class ModoRet:
    def __init__(self, modelo):
        self.modelo = modelo
        self.desenhando = False

    def __str__(self):
        return "RETANGULO"

    def desenhar(self, canvas):
        if self.desenhando:
            canvas.retangulo(min(self.x1, self.x2),
                             min(self.y1, self.y2),
                             abs(self.x2 - self.x1),
                             abs(self.y2 - self.y1),
                             self.modelo.cor)

    def encerrar(self):
        pass

    def inicio(self, x, y):
        self.desenhando = True
        self.x1 = x
        self.y1 = y
        self.x2 = x
        self.y2 = y

    def meio(self, x, y):
        self.x2 = x
        self.y2 = y

    def fim(self, x, y):
        self.desenhando = False
        self.x2 = x
        self.y2 = y
        ret = Retangulo(min(self.x1, self.x2),
                        min(self.y1, self.y2),
                        abs(self.x2 - self.x1),
                        abs(self.y2 - self.y1),
                        self.modelo.cor)
        self.modelo.figuras.append(ret)
        self.modelo.feitos.append(ComandoAdicionar(ret))

class ModoPonto:
    def __init__(self, modelo):
        self.modelo = modelo
        self.desenhando = False

    def __str__(self):
        return "PONTO"

    def desenhar(self, canvas):
        if self.desenhando:
            canvas.circulo(self.x, self.y, 2, self.modelo.cor)

    def encerrar(self):
        pass

    def inicio(self, x, y):
        self.desenhando = True
        self.x = x
        self.y = y

    def meio(self, x, y):
        self.x = x
        self.y = y

    def fim(self, x, y):
        self.desenhando = False
        self.x = x
        self.y = y
        pt = Ponto(self.x, self.y, self.modelo.cor)
        self.modelo.figuras.append(pt)
        self.modelo.feitos.append(ComandoAdicionar(pt))

class ModoCirc:
    def __init__(self, modelo):
        self.modelo = modelo
        self.desenhando = False

    def __str__(self):
        return "CIRCULO"

    def desenhar(self, canvas):
        if self.desenhando:
            dx = self.x2 - self.x1
            dy = self.y2 - self.y1
            raio = math.sqrt(dx*dx + dy*dy)
            canvas.circulo(self.x1, self.y1,
                           raio, self.modelo.cor)

    def encerrar(self):
        pass

    def inicio(self, x, y):
        self.desenhando = True
        self.x1 = x
        self.y1 = y
        self.x2 = x
        self.y2 = y

    def meio(self, x, y):
        self.x2 = x
        self.y2 = y

    def fim(self, x, y):
        self.desenhando = False
        self.x2 = x
        self.y2 = y
        dx = self.x2 - self.x1
        dy = self.y2 - self.y1
        raio = math.sqrt(dx*dx + dy*dy)
        circ = Circulo(self.x1, self.y1,
                       raio, self.modelo.cor)
        self.modelo.figuras.append(circ)
        self.modelo.feitos.append(ComandoAdicionar(circ))

class ModoApagar:
    def __init__(self, modelo):
        self.modelo = modelo
        self.apagando = False

    def __str__(self):
        return "APAGAR"

    def desenhar(self, canvas):
        pass

    def encerrar(self):
        pass

    def inicio(self, x, y):
        for figura in self.modelo.figuras:
            if figura.dentro(x, y):
                self.apagando = True
                self.figura = figura

    def meio(self, x, y):
        pass

    def fim(self, x, y):
        if self.apagando and self.figura.dentro(x, y):
            self.modelo.figuras.remove(self.figura)
            self.modelo.feitos.append(ComandoApagar(self.figura))

# classe abstrata
class FiguraPt:
    def __init__(self, x, y, cor):
        self.x = x
        self.y = y
        self.cor = cor

    # metodo abstrato
    def desenhar(self, canvas):
        raise NotImplementedError()

    # metodo abstrato
    def dentro(self, x, y):
        raise NotImplementedError()

    def mover(self, dx, dy):
        self.x = self.x + dx
        self.y = self.y + dy

class Ponto(FiguraPt):
    def desenhar(self, canvas):
        canvas.circulo(self.x, self.y, 2, self.cor)

    def dentro(self, x, y):
        return abs(x - self.x) <= 2 and abs(y - self.y) <= 2
    
class Retangulo(FiguraPt):
    def __init__(self, x, y, larg, alt, cor):
        FiguraPt.__init__(self, x, y, cor)
        self.larg = larg
        self.alt = alt

    def desenhar(self, canvas):
        canvas.retangulo(self.x, self.y, self.larg, self.alt, self.cor)

    def dentro(self, x, y):
        return (x >= self.x and y >= self.y and x <= self.x + self.larg and
                y <= self.y + self.alt)

class Circulo(FiguraPt):
    def __init__(self, x, y, raio, cor):
        FiguraPt.__init__(self, x, y, cor)
        self.raio = raio

    def desenhar(self, canvas):
        canvas.circulo(self.x, self.y, self.raio, self.cor)

    def dentro(self, x, y):
        dx = x - self.x
        dy = y - self.y
        return (dx*dx + dy*dy) <= (self.raio*self.raio)        
        
raiz = JanelaEditor("Editor Grafico", 800, 600)
raiz.mainloop()
