import java.io.*;

public class GossipDriver {
    public static void main(String[] args) throws Exception {
        FileReader input = new FileReader(args[0]);
        GossipScanner scanner = new GossipScanner(input);
        GossipToken token;
        while((token = scanner.getToken()) != null) {
            System.out.println(token);
        }
    }
}
