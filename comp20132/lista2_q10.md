---
layout: default
title: MAB 471 - Compiladores I - Lista 2 Q. 10
relpath: ..
---

Lista 2, Questão 10
===================

No arquivo `tinypy.jflex`:

    [rR][eE][pP][eE][aA][tT] { return new Token(Token.REPEAT, yyline); }
    [uU][nN][tT][iI][lL]  { return new Token(Token.UNTIL, yyline); }

No arquivo `tinypy.jacc`, primeira seção:

    %token <Token> READ WRITE IF WHILE ELSE ELIF INT BOOL VOID NEG REPEAT
    %token <Token> PASS TRUE FALSE AND OR NOT ATRIB ID NUM BEGIN END UNTIL

No arquivo `tinypy.jacc`, segunda seção, não-terminal `cmd`:
	
    | REPEAT BEGIN cmds END UNTIL exp       { $$ = new Repeat($3, $6, $5.lin); }

Arquivo `ast\Repeat.java`:

{%highlight java%}
package ast;

import java.util.List;
import java.util.Map;

public class Repeat implements Cmd {
	List<Cmd> corpo;
	Exp cond;
	int lin;
	
	public Repeat(List<Cmd> _corpo, Exp _cond, int _lin) {
		corpo = _corpo;
		cond = _cond;
		lin = _lin;
	}

	@Override
	public void tipos(Map<String, Func> funcs, TabSimb<String> vars) {
		TabSimb<String> vcorpo = new TabSimb<String>(vars);
		for(Cmd cmd: corpo)
			cmd.tipos(funcs, vcorpo);
		String tcond = cond.tipo(funcs, vcorpo);
		if(!tcond.equals("bool"))
			throw new RuntimeException("condição do repeat tem que ser bool na linha " + lin);
	}

	@Override
	public void run(Map<String, Func> funcs, TabSimb<Integer> vars) {
		TabSimb<Integer> vcorpo;
		do {
			vcorpo = new TabSimb<Integer>(vars);
			for(Cmd cmd: corpo)
				cmd.run(funcs, vcorpo);
		} while(cond.val(funcs, vcorpo) == 0);
	}

	@Override
	public void codigo(Contexto ctx, TabSimb<Endereco> vars) {
		// labCorpo:
		//    <corpo>
		//    <cond>
		//    se cond for falso salta pra labCorpo
		int labCorpo = ctx.label();
		ctx.label(labCorpo);
		TabSimb<Endereco> vcorpo = new TabSimb<Endereco>(vars);
		ctx.entraEscopo();
		for(Cmd cmd: corpo)
			cmd.codigo(ctx, vcorpo);
		cond.codigoSaltoF(ctx, vcorpo, labCorpo);
		ctx.saiEscopo();
	}

}
{%endhighlight%}
