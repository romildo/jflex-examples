
%%

%class Lexer2
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

%%
 
if             { return token(Token.T.IF); }
[a-z][a-z0-9]* { return token(Token.T.ID, yytext()); }
[0-9]+         { return token(Token.T.INT, new Integer(yytext())); }
[0-9]+"."[0-9]*|[0-9]*"."[0-9]+
               { return token(Token.T.FLOAT, new Double(yytext())); }
[ \t\n\r]+     { /* do nothing */ }
<<EOF>>        { return token(Token.T.EOF); }
.              { System.out.printf("error: unexpected char |%s|\n",
                                   yytext());
               }
