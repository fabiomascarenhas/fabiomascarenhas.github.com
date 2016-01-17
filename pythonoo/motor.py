import pygame

def cor_int(cor):
    r, g, b = cor
    return (int(r * 255), int(g * 255), int(b * 255))

class Tela:
    def __init__(self, screen):
        self.screen = screen
        
    def linha(self, x1, y1, x2, y2, larg = 5, cor = (1.0, 1.0, 1.0)):
        p1 = [int(x1), int(y1)]
        p2 = [int(x2), int(y2)]
        pygame.draw.line(self.screen, cor_int(cor), p1, p2, larg)

    def retangulo(self, x, y, larg, alt, cor = (1.0, 1.0, 1.0), borda = 0):
        pygame.draw.rect(self.screen, cor_int(cor), [int(x), int(y), int(larg), int(alt)], borda)

    def elipse(self, x, y, larg, alt, cor = (1.0, 1.0, 1.0), borda = 0):
        pygame.draw.ellipse(self.screen, cor_int(cor), [int(x), int(y), int(larg), int(alt)], borda)

    def triangulo(self, x1, y1, x2, y2, x3, y3, cor = (1.0, 1.0, 1.0), borda = 0):
        pygame.draw.polygon(self.screen, cor_int(cor), [[int(x1), int(y1)], [int(x2), int(y2)], [int(x3), int(y3)]], borda)

    def texto(self, x, y, s, cor = (1.0, 1.0, 1.0)):
        text = font.render(s, True, cor_int(cor))
        self.screen.blit(text, [int(x), int(y)])

def tamanho_texto(s):
    text = font.render(s, True, (0, 0, 0))
    rect = text.get_rect()
    return (rect.width, rect.height)
        
def rodar(jogo):
    global font
    pygame.init()
    font = pygame.font.SysFont('Courier', 32, True, False)
    screen = pygame.display.set_mode((jogo.LARGURA, jogo.ALTURA))
    pygame.display.set_caption(jogo.TITULO)
    clock = pygame.time.Clock()
    tela = Tela(screen)
    done = False
    keyset = set()
    while not done:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                done = True
            elif event.type == pygame.KEYDOWN:
                keyset.add(pygame.key.name(event.key))
            elif event.type == pygame.KEYUP:
                tecla = pygame.key.name(event.key)
                keyset.remove(tecla)
                jogo.tecla(tecla)
        screen.fill((0, 0, 0))
        jogo.tique(clock.tick(60)/1000.0, keyset)
        jogo.desenhar(tela)
        pygame.display.flip()
    pygame.quit()
