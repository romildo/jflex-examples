
%%

%class Lexer4
%type Token
%line
%column

%{
    private StringBuilder str = new StringBuilder();
    
    private Token token(Token.T type) {
      return new Token(type, yyline, yycolumn);
    }

    private Token token(Token.T type, Object val) {
      return new Token(type, val, yyline, yycolumn);
    }
%}

%state STR

alpha = [a-zA-Z]
dig   = [0-9]
id    = {alpha} ({alpha} | {dig})*
int   = {dig}+
float = {dig}+ "." {dig}* | {dig}* "." {dig}+

%%

<YYINITIAL> {
if               { return token(Token.T.IF); }
{id}             { return token(Token.T.ID, yytext()); }
{int}            { return token(Token.T.INT, new Integer(yytext())); }
{float}          { return token(Token.T.FLOAT, new Double(yytext())); }
\"               { str.setLength(0);
                   yybegin(STR);
                 }
[ \t\n\r]+       { /* do nothing */ }
<<EOF>>          { return token(Token.T.EOF); }
}

<STR> \"         { yybegin(YYINITIAL);
                   return token(Token.T.STR, str.toString());
                 }
<STR> \\t        { str.append('\t'); }
<STR> \\n        { str.append('\n'); }
<STR> \\\"       { str.append('"'); }
<STR> \\\\       { str.append('\\'); }
<STR> [^\r\n\\]+ { str.append(yytext()); }
<STR> <<EOF>>    { yybegin(YYINITIAL);
                   System.out.println("error: unclosed string literal");
                 }

[^]              { System.out.printf("error: unexpected char |%s|\n", yytext()); }
