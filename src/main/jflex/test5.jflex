
%%

%class Lexer
%type Token
%line
%column

%{
   private int commentLevel = 0;
   
   private Token token(Token.T type) {
      return new Token(type, yyline, yycolumn);
   }

   private Token token(Token.T type, Object val) {
      return new Token(type, val, yyline, yycolumn);
   }
%}

%state COMMENT

alpha = [a-zA-Z]
dig   = [0-9]
id    = {alpha} ({alpha} | {dig})*
int   = {dig}+
float = {dig}+ "." {dig}* | {dig}* "." {dig}+

%%

<YYINITIAL> {
if              { return token(Token.T.IF); }
{id}            { return token(Token.T.ID, yytext()); }
{int}           { return token(Token.T.INT, new Integer(yytext())); }
{float}         { return token(Token.T.FLOAT, new Double(yytext())); }
"/*"            { commentLevel = 1;
                  yybegin(COMMENT);
                }
[ \t\n\r]+      { /* do nothing */ }
<<EOF>>         { return token(Token.T.EOF); }
}

<COMMENT> {
"*/"            { commentLevel --;
                  if (commentLevel == 0)
                      yybegin(YYINITIAL);
                }
"/*"            { commentLevel ++; }
<<EOF>>         { yybegin(YYINITIAL);
                  System.err.println("error: unclosed comment");
                }
.|\n            { }
}

.|\n            { System.err.printf("error: unexpected char |%s|\n",
                                    yytext());
                }
