import java_cup.runtime.Symbol;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

import static parse.SymbolConstants.EOF;
import static parse.SymbolConstants.terminalNames;

public class Test6 {
   public static void main(String[] args) {
      try {
         Reader input =
            args.length > 0 ?
               new FileReader(args[0]) :
               new InputStreamReader(System.in);
         Lexer6 scanner = new Lexer6(input);
         Symbol token;
         do {
            token = scanner.next_token();
            System.out.printf("%3d.%3d: %-8s %s%n",
                              token.left, token.right,
                              terminalNames[token.sym],
                              token.value == null ? "" : token.value);
         }
         while (token.sym != EOF);
      } catch (IOException e) {
         System.err.println(e);
      }
   }
}