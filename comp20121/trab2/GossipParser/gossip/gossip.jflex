package gossip;

%%

%class Scanner
%function getToken
%type Token
%yylexthrow Exception
%line
%column

%state STRING

%{
  StringBuilder sb;
  int col;
%}

digit = [0-9]
letter = [a-zA-Z_]
alpha = {letter} | {digit}
space = [ \n\r\t]
comment = "/*"~"*/"

%%

<YYINITIAL> {

"class"    { return new Token(Token.CLASS, yyline, yycolumn); }
"var"    { return new Token(Token.VAR, yyline, yycolumn); }
"new"    { return new Token(Token.NEW, yyline, yycolumn); }
"while"    { return new Token(Token.WHILE, yyline, yycolumn); }
"if"    { return new Token(Token.IF, yyline, yycolumn); }
"else"    { return new Token(Token.ELSE, yyline, yycolumn); }
"true"    { return new Token(Token.TRUE, yyline, yycolumn); }
"false"    { return new Token(Token.FALSE, yyline, yycolumn); }
"this"    { return new Token(Token.THIS, yyline, yycolumn); }
"null"    { return new Token(Token.NULL, yyline, yycolumn); }
"break"    { return new Token(Token.BREAK, yyline, yycolumn); }
"return"    { return new Token(Token.RETURN, yyline, yycolumn); }

{letter}{alpha}*	     { return new Token(Token.ID, yytext(), yyline, yycolumn); }

{digit}+("."{digit}+)?([eE]("+"|"-")?{digit}+)?  
   { return new Token(Token.NUMBER, Double.parseDouble(yytext()), yyline, yycolumn); }

"<="   { return new Token(Token.LEQ, yyline, yycolumn); }
"=="   { return new Token(Token.EQ, yyline, yycolumn); }
"&&"   { return new Token(Token.AND, yyline, yycolumn); }
"||"   { return new Token(Token.OR, yyline, yycolumn); }

"+" | "-" | "*" | "/" | "=" | "<" | "(" | ")" | ";" | "!" | 
   "{" | "}" | "[" | "]" | "," | "." { return new Token((int)yytext().charAt(0), yyline, yycolumn); }

{space}    { }

{comment}    { }

[\"]     { yybegin(STRING); col = yycolumn; sb = new StringBuilder(); sb.append("\""); }

}

<STRING> {

"\\n" | "\\r" | "\\t" | "\\\"" | "\\\\" | [^\"\\\n]  { sb.append(yytext()); }

[\"]   { yybegin(YYINITIAL); sb.append("\""); return new Token(Token.STRING, sb.toString(), yyline, col); }

}

.  { throw new Exception("scanner error at line " + yyline + " column " + yycolumn + ", token: " + yytext()); }
