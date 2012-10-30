package gossip;

import java.util.*;

interface Node {
}

interface Expression extends Node {
}

interface Command extends Node {
}

class Program implements Node {
	public List<gossip.Class> classes;
	
	Program(List<gossip.Class> classes) {
		this.classes = classes;
	}
		
	public String toString() {
		StringBuilder sb = new StringBuilder();
		for(gossip.Class c : classes) {
			sb.append(c.toString());
		}
		return sb.toString();
	}
}

class Class implements Node {
	public String name;
	public List<Member> members;

	public int line, col;
	
	Class(String name, List<Member> members, int line, int col) {
		this.name = name;
		this.members = members;
		this.line = line;
		this.col = col;
	}
		
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class " + name + " {\n");
		for(Member m : members)
			sb.append(m.toString());
		sb.append("}\n");
		return sb.toString();
	}
}

interface Member extends Node {
}

class Field implements Member {
	public String name;
	
	public int line, col;
	
	Field(String name, int line, int col) {
		this.name = name;
		this.line = line;
		this.col = col;
	}
	
	public String toString() {
		return "var " + name + ";\n";
	}
}

class Method implements Member {
	public String name;
	public List<String> params;
	public List<Command> body;
	
	public int line, col;
	
	Method(String name, List<String> params, List<Command> body, int line, int col) {
		this.name = name;
		this.params = params;
		this.body = body;
		this.line = line;
		this.col = col;
	}
	
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(name + "(");
		boolean first = true;
		for(String param : params) {
			if(first) {
				sb.append(param);
				first = false;
			} else {
				sb.append(", "+ param);
			}
		}
		sb.append(") {\n");
		for(Command cmd : body)
			sb.append(cmd.toString());
		sb.append("}\n");
		return sb.toString();
	}
}

class Block implements Command {
	public List<Command> body;
	
	Block(List<Command> body) {
		this.body = body;
	}

	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{\n");
		for(Command cmd : body)
			sb.append(cmd.toString());
		sb.append("}\n");
		return sb.toString();
	}
}

class If implements Command {
	public Expression cond;
	public Command then;
	public Command celse;
	
	If(Expression cond, Command then, Command celse) {
		this.cond = cond;
		this.then = then;
		this.celse = celse;
	}
		
	public String toString() {
		return "if(" + cond.toString() + ")\n" + then.toString() +
				(celse == null ? "" : "else\n" + celse.toString());
	}
}

class While implements Command {
	public Expression cond;
	public Command body;
	
	While(Expression cond, Command body) {
		this.cond = cond;
		this.body = body;
	}
	
	public String toString() {
		return "while(" + cond.toString() + ")\n" + body.toString();
	}
}

class Break implements Command {
	Break() {}
		
	public String toString() {
		return "break;\n";
	}
}

class Return implements Command {
	public Expression exp;
	
	Return(Expression exp) {
		this.exp = exp;
	}

	public String toString() {
		return "return " + exp.toString() + ";\n";
	}
}

class Assign implements Command {
	public Expression lval;
	public Expression rval;
	
	Assign(Expression lval, Expression rval) {
		this.lval = lval;
		this.rval = rval;
	}
		
	public String toString() {
		return lval.toString() + " = " + rval.toString() + ";\n";
	}
}

class Empty implements Command {
	Empty() { }
		
	public String toString() {
		return ";\n";
	}
}

class MethodCallCmd implements Command {
	public Expression obj;
	public String name;
	public List<Expression> args;

	MethodCallCmd(Expression obj, String name, List<Expression> args) {
		this.obj = obj;
		this.name = name;
		this.args = args;
	}
		
	public String toString() {
		return obj.toString() + "." + name + "(" + StringUtils.join(args, ",") + ");\n";
	}
}

class Var implements Command {
	public String name;
	public Expression exp;
	
	public int line, col;

	Var(String name, Expression exp, int line, int col) {
		this.name = name;
		this.exp = exp;
		this.line = line;
		this.col = col;
	}
		
	public String toString() {
		return "var " + name + " = " + exp.toString() + ";\n";
	}
}

class VarExp implements Expression {
	public String name;
	
	VarExp(String name) { this.name = name; }
	
	public String toString() {
		return name;
	}
}

class Simple implements Expression {
	public Expression exp;
	public Suffix suffix;
	
	Simple(Expression exp, Suffix suffix) {
		this.exp = exp;
		this.suffix = suffix;
	}
		
	public String toString() {
		return exp.toString() + suffix.toString();
	}
}

interface Suffix extends Node { }

class Index implements Suffix {
	public Expression exp;
	
	Index(Expression exp) {
		this.exp = exp;
	}
		
	public String toString() {
		return "[" + exp.toString() + "]";
	}
}

class MethodCall implements Suffix {
	public String name;
	public List<Expression> args;
	
	MethodCall(String name, List<Expression> args) {
		this.name = name;
		this.args = args;
	}
	
	public String toString() {
		return "." + name + "(" + StringUtils.join(args, ",") + ")";
	}
}

class This implements Expression {
	This() { }
		
	public String toString() {
		return "this";
	}
}

class Null implements Expression {
	Null() { }
	
	public String toString() {
		return "null";
	}
}

class True implements Expression {
	True() { }
	
	public String toString() {
		return "true";
	}
}

class False implements Expression {
	False() { }
	
	public String toString() {
		return "false";
	}
}

class Number implements Expression {
	public double num;
	
	Number(double num) { this.num = num; }
	
	public String toString() {
		return "" + num;
	}
}

class Literal implements Expression {
	public String str;
	
	Literal(String str) { this.str = str; }
	
	public String toString() {
		return str;
	}
}

class Arith implements Expression {
	public String op;
	public Expression left;
	public Expression right;
	
	Arith(String op, Expression left, Expression right) {
		this.op = op;
		this.left = left;
		this.right = right;
	}
	
	public String toString() {
		String op = "";
		if(this.op == "ADD") op = "+";
		else if(this.op == "SUB") op = "-";
		else if(this.op == "MUL") op = "*";
		else if(this.op == "DIV") op = "/";
		return "(" + left.toString() + op + right.toString() + ")";
	}
}

class Rel implements Expression {
	public String op;
	public Expression left;
	public Expression right;
	
	Rel(String op, Expression left, Expression right) {
		this.op = op;
		this.left = left;
		this.right = right;
	}

	public String toString() {
		String op = "";
		if(this.op == "EQ") op = "==";
		else if(this.op == "LEQ") op = "<=";
		else if(this.op == "LT") op = "<";
		return "(" + left.toString() + op + right.toString() + ")";
	}
}

class And implements Expression {
	public Expression left;
	public Expression right;
	
	And(Expression left, Expression right) {
		this.left = left;
		this.right = right;
	}

	public String toString() {
		return "(" + left.toString() + " && " + right.toString() + ")";
	}
}

class Or implements Expression {
	public Expression left;
	public Expression right;
	
	Or(Expression left, Expression right) {
		this.left = left;
		this.right = right;
	}

	public String toString() {
		return "(" + left.toString() + " || " + right.toString() + ")";
	}
}


class Not implements Expression {
	public Expression exp;

	Not(Expression exp) {
		this.exp = exp;
	}
	
	public String toString() {
		return "(!" + exp.toString() + ")";
	}
}

class New implements Expression {
	public String name;
	public List<Expression> args;
	
	public int line, col;
	
	New(String name, List<Expression> args, int line, int col) {
		this.name = name;
		this.args = args;
		this.line = line;
		this.col = col;
	}
	
	public String toString() {
		return "new " + name + "(" + StringUtils.join(args, ",") + ")";
	}
}
