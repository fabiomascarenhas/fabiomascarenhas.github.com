
// Questão 1 - a

class Mover implements Acao {
    Forma f;
    int dx;
    int dy;

    Mover(Forma f, int dx, int dy) {
        this.f = f;
        this.dx = dx;
        this.dy = dy;
    }

    public void fazer() {
        this.f.mover(this.dx, this.dy);
    }

    public void desfazer() {
        this.f.mover(-this.dx, -this.dy);
    }
}

class Redimensionar implements Acao {
    Forma f;
    float escala;

    Redimensionar(Forma f, float escala) {
        this.f = f;
        this.escala = escala;
    }

    public void fazer() {
        this.f.redimensionar(this.escala);
    }

    public void desfazer() {
        this.f.redimensionar(1/this.escala);
    }
}

class Rotacionar implements Acao {
    Forma f;
    int graus;

    Rotacionar(Forma f, int graus) {
        this.f = f;
        this.graus = graus;
    }

    public void fazer() {
        this.f.rotacionar(this.graus);
    }

    public void desfazer() {
        this.f.rotacionar(-this.graus);
    }
}

// Questão 1 - b

void fazer(Acao a) {
    a.fazer();
    this.cursor = this.cursor + 1;
    this.acoes.add(this.cursor, a);
}

void desfazer() {
    if(this.cursor >= 0) {
        Acao a = this.acoes.get(this.cursor);
        a.desfazer();
        this.cursor = this.cursor - 1;
    }
}

void refazer() {
    if(this.cursor < this.acoes.size() - 1) {
        this.cursor = this.cursor + 1;
        Acao a = this.acoes.get(this.cursor);
        a.fazer();
    }
}

// Questão 2

// Implementação 1 - Derivada de Lista
class Conjunto extends Lista {
    public Conjunto() {
        super();
    }

    public void adiciona(int num) {
        if(this.contem(num)) {
            throw new RuntimeException("elemento já existe");
        } else {
            super.adiciona(num);
        }
    }
}

// Implementação 2 - usa Lista como repr. interna
class Conjunto {
    Lista l;

    public Conjunto() {
        this.l = new Lista();
    }

    public void adiciona(int num) {
        if(this.contem(num)) {
            throw new RuntimeException("elemento já existe");
        } else {
            this.l.adiciona(num);
        }
    }

    public boolean contem(int num) {
        return this.l.contem(num);
    }

    public void remove(int num) {
        this.l.remove(num);
    }
}

