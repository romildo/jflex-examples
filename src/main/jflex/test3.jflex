
%%

%class Lexer
%type Token
%line
%column

%{
    private Token token(Token.T type) {
      return new Token(type, yyline, yycolumn);
    }

    private Token token(Token.T type, Object val) {
      return new Token(type, val, yyline, yycolumn);
    }
%}

alpha = [a-zA-Z]
dig   = [0-9]
id    = {alpha} ({alpha} | {dig})*
int   = {dig}+
float = {dig}+ "." {dig}* | {dig}* "." {dig}+

%%

if         { return token(Token.T.IF); }
{id}       { return token(Token.T.ID, yytext()); }
{int}      { return token(Token.T.INT, new Integer(yytext())); }
{float}    { return token(Token.T.FLOAT, new Double(yytext())); }
[ \t\n\r]+ { /* do nothing */ }
<<EOF>>    { return token(Token.T.EOF); }
.          { System.out.printf("error: unexpected char |%s|\n",
                               yytext());
           }
