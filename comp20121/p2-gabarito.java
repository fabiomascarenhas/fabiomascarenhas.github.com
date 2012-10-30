/* Questão 1 - a

O ponto marca a posição no item

estado 0
    S -> . L $
    L -> . L ; C
    L -> . C
    C -> . id := E

    id shift 3
    L goto 1
    C goto 2

estado 1
    S -> L . $
    L -> L . ; C

    $ accept
    ; shift 4

estado 2
    L -> C .

estado 3
    C -> id . := E

    := shift 5

estado 4
    L -> L ; . C
    C -> . id := E

    id shift 3
    C goto 6

estado 5
    C -> id := . E
    E -> . id
    E -> . id ( )
    E -> . num

    id shift 8
    num shift 9
    E goto 7

estado 6
    L -> L ; C .

estado 7
    C -> id := E .

estado 8
    E -> id .
    E -> id . ( )

    ( shift 10

estado 9
    E -> num .

estado 10
    E -> id ( . )

    ) shift 11

estado 11
    E -> id ( ) .

*/

/* Questão 1 - b

A gramática não é LR(0) pois o estado 8 tem um conflito shift-reduce LR(0). Ela é SLR(1),
pois o terminal ( não está no FOLLOW de E, que é o conjunto { ';' , '$' }, então não há
conflito shift-reduce no estado 8.

*/

/* Questão 1 - c

Numerando as produções da esquerda pra direita e de cima pra baixo, com L -> L ; C sendo a produção 1:

shift 3, shift 5, shift 8, shift 10, shift 11, reduce 5, reduce 3, reduce 2, accept

*/

/* Questão 2 */

Tipo tipo(Map<String,Tipo> vars, Map<String,TipoFuncao> funcs) {
    TipoFuncao tf = funcs.get(this.nomeFunc);
    if(tf.tipoArgs.length != this.args.length)
        throw new RuntimeException("erro de aridade");
    for(int i = 0; i < this.args.length; i++)
        if(!tf.tipoArgs[i].equals(this.args.tipo(vars, funcs)))
            throw new RuntimeException("tipo do arg " + i + " errado");
    return tf.tipoRet;
}

/* Questão 3 - a 

iload 1
invokestatic sqr
ldc 4
iload 0
mul
iload 2
mul
sub
istore 3

*/

/* Questão 3 - b */

// Atrib
void geraCodigo(Saida s) {
    this.rval.geraCodigo(s);
    s.istore(s.vars.get(this.lval));
}

// Var
void geraCodigo(Saida s) {
    s.iload(s.vars.get(this.nome));
}

// Num
void geraCodigo(Saida s) {
    s.ldc(this.val);
}

// Sub
void geraCodigo(Saida s) {
    this.esq.geraCodigo(s);
    this.dir.geraCodigo(s);
    s.sub();
}

// Mul
void geraCodigo(Saida s) {
    this.esq.geraCodigo(s);
    this.dir.geraCodigo(s);
    s.mul();
}

// ChamadaFuncao
void geraCodigo(Saida s) {
    for(Expressao e : this.args)
        e.geraCodigo(s);
    s.invokestatic(this.nomeFunc);
}
