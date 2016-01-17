/* Questão 1

L -> C L'
L' -> ; C L' | <vazio>
C -> id := E
E -> id E' | num
E' -> () | <vazio>

FIRST+(L'->;CL') = { ; }
FIRST+(L'-><vazio>) = { $ }
FIRST+(E->id E') = { id }
FIRST+(E->num) = { num }
FIRST+(E'->()) = { ( }
FIRST+(E'-><vazio>) = { ; $ }

*/

/* Questão 2

a)

 ---------       ---------      ---------
| a : int |     | y : int |    | b : int |
| b : int |  <- | z : int | <- |         |
| c : int |     | a : int |    |         |
 ---------       ---------      ---------

b) Quando o compilador entra em um escopo ele substitui a tabela
de símbolos corrente por uma nova ligada com a corrente, quando sai do
escopo a tabela de símbolos corrente é substituída pela tabela com
a qual ela está ligada.

*/

/* Questão 3 */

class LogE implements Expressao {
    Expressao esq;
    Expressao dir;
    
    void saltaSeFalso(Saida s, String rotulo) {
        esq.saltaSeFalso(s, rotulo);
        dir.saltaSeFalso(s, rotulo);
    }
}

class LogOu implements Expressao {
    Expressao esq;
    Expressao dir;

    void saltaSeFalso(Saida s, String rotulo) {
        String cont = s.novoRotulo();
        String fim = s.novoRotulo();
        esq.saltaSeFalso(s, cont);
        s.goto(fim);
        s.rotulo(cont);
        dir.saltaSeFalso(s, rotulo);
        s.rotulo(fim);
    }
}
