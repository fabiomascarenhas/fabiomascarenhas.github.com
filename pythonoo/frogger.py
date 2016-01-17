
import motor
import random

class Carro:
    def __init__(self, x, y, larg, vx):
        self.x = x
        self.y = y 
        self.vx = vx
        self.larg = larg
        self.alt = 50
        self.cor = (random.random(), random.random(),
                    random.random())

    def mover(self, dt):
        self.x = self.x + self.vx * dt
        if self.x >= 400:
            self.x = -self.larg

    def desenhar(self, tela):
        tela.retangulo(self.x, self.y, self.larg,
                       self.alt, self.cor)

class Frogger:
    def __init__(self):
        self.TITULO = "Frogger"
        self.LARGURA = 400
        self.ALTURA = 300
        self.carro = Carro(200, 200, 50, 100)
        
    def tique(self, dt, teclas):
        self.carro.mover(dt)

    def desenhar(self, tela):
        self.carro.desenhar(tela)

    def tecla(self, tecla):
        pass

motor.rodar(Frogger())
