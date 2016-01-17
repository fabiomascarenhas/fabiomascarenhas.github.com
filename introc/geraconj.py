TAMANHO = 5

def gera_conjunto(vetor, tamanho, inicial):
	for i in range(tamanho):
		vetor[i] = inicial
		inicial = inicial * 2

vetor = [0] * TAMANHO

print "Este programa gera um vetor de numeros inteiros."
print "Entre com o numero inicial do conjunto. "
num = input()

gera_conjunto(vetor, TAMANHO, num)

for i in range(TAMANHO):
	print "Elemento %d = %lf" % (i, vetor[i])
