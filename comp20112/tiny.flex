
%%

%class TINYScanner
%function getToken
%type TINYToken
%yylexthrow Exception
%line
%column

%state STRING

%{
  StringBuilder sb;
%}

digit = [0-9]
letter = [a-zA-Z]
alpha = {letter} | {digit} | [_]
space = [ \n\t]
comment = "{"~"}"

%%

<YYINITIAL> {

"if"    { return new TINYToken(TINYToken.IF); }
"then"    { return new TINYToken(TINYToken.THEN); }
"else"    { return new TINYToken(TINYToken.ELSE); }
"end"    { return new TINYToken(TINYToken.END); }
"repeat"    { return new TINYToken(TINYToken.REPEAT); }
"until"    { return new TINYToken(TINYToken.UNTIL); }
"read"    { return new TINYToken(TINYToken.READ); }
"write"    { return new TINYToken(TINYToken.WRITE); }

"+" | "-" | "*" | "/" | "=" | "<" | "(" | ")" | ";" { return new TINYToken((int)yytext().charAt(0)); }

":="   { return new TINYToken(TINYToken.ATTRIB); }

{letter}{alpha}*	     { return new TINYToken(TINYToken.ID, yytext()); }

{digit}+   { return new TINYToken(TINYToken.NUM, Integer.parseInt(yytext())); }

{space}    { }

{comment}    { }

[']     { yybegin(STRING); sb = new StringBuilder(); }

}

<STRING> {

['][']  { sb.append("'"); }

#{digit}{digit}{digit}  { 
  String scode = yytext().substring(1, 4);
  int icode = Integer.parseInt(scode);
  sb.append(Character.toString((char)icode));
}

##    { sb.append("#"); }

[^'#\n]  { sb.append(yytext()); }

[']   { yybegin(YYINITIAL); return new TINYToken(TINYToken.STRING, sb.toString()); }

}

.  { throw new Exception("scanner error at line " + yyline + " column " + yycolumn + ", token: " + yytext()); }
