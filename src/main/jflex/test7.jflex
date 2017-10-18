package parse;

import java_cup.runtime.Symbol;
import java_cup.runtime.SymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.ComplexSymbolFactory;

%%
%public
%final
%class Lexer7
%implements SymbolConstants
%cupsym SymbolConstants
%cup
%line
%column

%eofval{
    return tok(EOF);
%eofval}

%ctorarg String unitName

%init{
   this.unit = unitName;
%init}


%{
   private String unit;

   private ComplexSymbolFactory complexSymbolFactory = new ComplexSymbolFactory();

   public SymbolFactory getSymbolFactory() {
      return complexSymbolFactory;
   }

   // auxiliary methods to construct terminal symbols at current location

   private Location locLeft() {
      return new Location(unit, yyline + 1, yycolumn + 1);
   }

   private Location locRight() {
      return new Location(unit, yyline + 1, yycolumn + 1 + yylength());
   }

   private Symbol tok(int type, String lexeme, Object value) {
      return complexSymbolFactory.newSymbol(lexeme, type, locLeft(), locRight(), value);
   }

   private Symbol tok(int type, Object value) {
      return tok(type, yytext(), value);
   }

   private Symbol tok(int type) {
      return tok(type, null);
   }
%}

%%
 
if             { return tok(IF); }
[a-z][a-z0-9]* { return tok(ID, yytext()); }
[0-9]+         { return tok(INT, new Integer(yytext())); }
[0-9]+"."[0-9]*|[0-9]*"."[0-9]+
               { return tok(FLOAT, new Double(yytext())); }
[ \t\n\r]+     { /* do nothing */ }
<<EOF>>        { return tok(EOF); }
.              { System.out.printf("error: unexpected char |%s|\n", yytext()); }
