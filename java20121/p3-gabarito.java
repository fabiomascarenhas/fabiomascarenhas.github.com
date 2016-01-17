/* Questão 1 - a */

class Exp implements Funcao {
    int n;

    public Exp(int n) {
        this.n = n;
    }

    public double valor(double x) {
        return Math.pow(n, x);
    }
}

/* Questão 1 - b */

class Derivada implements Funcao {
    Funcao f;
    double e;

    public Derivada(Funcao f, double e) {
        this.f = f;
        this.e = e;
    }

    public double valor(double x) {
        return (this.f.valor(x+this.e) - 
                this.f.valor(x)) / this.e;
    }
}

/* Questão 2 */

class ContaCorrenteLanc extends ContaCorrente {
    ArrayList<String> lancamentos;

    public ContaCorrenteLanc(int numero, double saldo) {
        super(numero, saldo);
        this.lancamentos = new ArrayList<String>();
    }

    public void deposita(double valor) {
        super.deposita(valor);
        this.lancamentos.add("DEPÓSITO DE " + valor);
    }

    public void retira(double valor) {
        super.retira(valor);
        this.lancamentos.add("RETIRADA DE " + valor);
    }
}

/* Questão 3 - a */

class EnumVetor implements Enumerador {
    int[] vetor;
    int pos;

    public EnumVetor(int[] vetor) {
        this.vetor = vetor;
        this.pos = 0;
    }

    public int proximo() {
        if(this.pos < vetor.length) {
            return this.vetor[this.pos++];
        } else {
            throw new RuntimeException("enumerador não tem mais elementos");
        }
    }

    public boolean final() {
        return this.pos >= this.vetor.length;
    }
}

/* Questão 3 - b */

static List<Integer> listaDeEnum(Enumerador e) {
    List<Integer> lista = new ArrayList<Integer>();
    while(!e.final()) {
        lista.add(e.proximo);
    }
    return lista;
}
