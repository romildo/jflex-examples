import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

public class Test3 {
   public static void main(String[] args) {
      try {
         Reader input =
            args.length > 0 ?
               new FileReader(args[0]) :
               new InputStreamReader(System.in);
         Lexer3 scanner = new Lexer3(input);
         Token token;
         do {
            token = scanner.yylex();
            System.out.println(token);
         }
         while (token.type != Token.T.EOF);
      } catch (IOException e) {
         System.err.println(e);
      }
   }
}