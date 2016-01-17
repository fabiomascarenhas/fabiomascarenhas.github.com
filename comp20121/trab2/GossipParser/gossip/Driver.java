package gossip;

import java.io.*;

public class Driver {
    public static void main(String[] args) throws Exception {
        FileReader input = new FileReader(args[0]);
        Parser parser = new Parser(args[0], input);
        parser.parse();
        System.out.println(parser.output);
    }
}
