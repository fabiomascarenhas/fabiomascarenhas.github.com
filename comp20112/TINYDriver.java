import java.io.*;

public class TINYDriver {
    public static void main(String[] args) throws Exception {
        FileReader input = new FileReader(args[0]);
        TINYScanner scanner = new TINYScanner(input);
        TINYToken token;
        while((token = scanner.getToken()) != null) {
            System.out.println(token);
        }
    }
}
