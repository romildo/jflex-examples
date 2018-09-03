import java_cup.runtime.Symbol;

%%

%class Lexer6
%implements parse.SymbolConstants
%cup
%line
%column

%{
   private Symbol token(int type) {
     return new Symbol(type, yyline, yycolumn);
   }

   private Symbol token(int type, Object val) {
     return new Symbol(type, yyline, yycolumn, val);
   }
%}

%%
 
if             { return token(IF); }
[a-z][a-z0-9]* { return token(ID, yytext()); }
[0-9]+         { return token(INT, new Long(yytext())); }
[0-9]+"."[0-9]*|[0-9]*"."[0-9]+
               { return token(FLOAT, new Double(yytext())); }
[ \t\n\r]+     { /* do nothing */ }
<<EOF>>        { return token(EOF); }
.              { System.out.printf("error: unexpected char |%s|\n", yytext()); }
