import java_cup.runtime.Symbol;
import parse.Lexer7;
import parse.SymbolConstants;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public class Test7 {
   public static void main(String[] args) {
      try {
         Reader input =
            args.length > 0 ?
               new FileReader(args[0]) :
               new InputStreamReader(System.in);
         String inputName = args.length > 0 ? args[0] : "unknown";
         Lexer7 scanner = new Lexer7(input, inputName);
         Symbol token;
         do {
            token = scanner.next_token();
            System.out.printf("%-55s %-8s %s%n",
                              token,
                              SymbolConstants.terminalNames[token.sym],
                              token.value == null ? "" : token.value);
         }
         while (token.sym != SymbolConstants.EOF);
      } catch (IOException e) {
         System.err.println(e);
      }
   }
}