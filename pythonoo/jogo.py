import motor

class Jogo(object):
    def __init__(self):
        self.LARGURA = 800
        self.ALTURA = 600
        self.TITULO = "Meu Jogo"
        self.texto = "Ola Mundo"
        self.x_texto = 50
        self.v_texto = 300
    
    def tique(self, dt, teclas):
        larg, alt = motor.tamanho_texto(self.texto)
        if self.x_texto < 0 and self.v_texto < 0:
            self.v_texto = -self.v_texto
        if self.x_texto + larg > self.LARGURA and self.v_texto > 0:
            self.v_texto = -self.v_texto
        self.x_texto = self.x_texto + self.v_texto * dt

    def tecla(self, t):
        self.texto = t

    def desenhar(self, tela):
        tela.linha(10, 10, 300, 10, 3, (1.0, 0.0, 0.0))
        tela.retangulo(50, 50, 100, 200, (0.0, 1.0, 0.0))
        tela.elipse(10, 300, 50, 50, (0.0, 0.0, 1.0))
        tela.triangulo(400, 200, 300, 250, 500, 250)
        tela.texto(self.x_texto, 500, self.texto)

jogo = Jogo()
motor.rodar(jogo)


