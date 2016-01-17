
class GossipToken {
    static int CLASS  =  1;
    static int VAR    =  2;
    static int DEF    =  3;
    static int NEW    =  4;
    static int WHILE  =  5;
    static int IF     =  6;
    static int ELSE   =  7;
    static int TRUE   =  8;
    static int FALSE  =  9;
    static int THIS   = 10;
    static int NULL   = 11;
    static int BREAK  = 12;
    static int RETURN = 13;
    static int LEQ    = 14;  // <=
    static int CONCAT = 15;  // ..
    static int EQ     = 16;  // ==
    static int AND    = 17;  // &&
    static int OR     = 18;  // ||
    static int ID     = 19;  // identificadores
    static int NUMBER = 20;  // nœmeros
    static int STRING = 21;  // strings

    static String[] names = new String[] { "EOF", "CLASS", "VAR",
        "DEF", "NEW", "WHILE", "IF", "ELSE", "TRUE", "FALSE", "THIS",
        "NULL", "BREAK", "RETURN", "<=", "..", "==", "&&",
        "||", "ID", "NUMBER", "STRING"
    };

    public int type, line, col;
    public double numVal;
    public String strVal;

    public GossipToken(int type, int line, int col) {
        this.type = type;
        this.line = line;
        this.col = col;
    }

    public GossipToken(int type, double numVal, int line, int col) {
        this(type, line, col);
        this.numVal = numVal;
    }

    public GossipToken(int type, String strVal, int line, int col) {
        this(type, line, col);
        this.strVal = strVal;
    }

    public String toString() {
        if(this.type < 19) {
            return GossipToken.names[this.type] + 
                    "(" + this.line + "," + this.col + ")";
        } else if(this.type == 19) {
            return "ID(" + this.line + "," + this.col + "): " +
                    this.strVal;
        } else if(this.type == 20) {
            return "NUMBER(" + this.line + "," + this.col + "): " +
                    this.numVal;
        } else if(this.type == 21) {
            return "STRING(" + this.line + "," + this.col + "): " +
                    this.strVal;
        } else {
            return Character.toString((char)this.type) + 
                    "(" + this.line + "," + this.col + ")";
        }
    }
}
