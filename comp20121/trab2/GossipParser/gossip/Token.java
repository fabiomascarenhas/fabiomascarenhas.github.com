package gossip;

class Token implements Tokens {

    static String[] names = new String[] { "EOF", "&&",
        "BREAK", "CLASS", "ELSE", "==", "FALSE", "ID",
        "IF", "<=", "NEW", "NULL", "NUMBER", "||", "RETURN", "STRING",
        "THIS", "TRUE", "-", "VAR", "WHILE"
    };

    public int type, line, col;
    public double numVal;
    public String strVal;

    public Token(int type, int line, int col) {
        this.type = type;
        this.line = line;
        this.col = col;
    }

    public Token(int type, double numVal, int line, int col) {
        this(type, line, col);
        this.numVal = numVal;
    }

    public Token(int type, String strVal, int line, int col) {
        this(type, line, col);
        this.strVal = strVal;
    }

    public String toVal() {
        if(this.type == ID) {
            return this.strVal;
        } else if(this.type == NUMBER) {
            return String.valueOf(this.numVal);
        } else if(this.type == STRING) {
            return this.strVal;
        } else if(this.type < names.length) {
            return names[this.type].toLowerCase();
        } else {
            return Character.toString((char)this.type);
        }
    }

    public String toString() {
        if(this.type == ID) {
            return "ID(" + this.line + "," + this.col + "): " +
                    this.strVal;
        } else if(this.type == NUMBER) {
            return "NUMBER(" + this.line + "," + this.col + "): " +
                    this.numVal;
        } else if(this.type == STRING) {
            return "STRING(" + this.line + "," + this.col + "): " +
                    this.strVal;
        } else if(this.type < names.length) {
            return names[this.type] + 
                    "(" + this.line + "," + this.col + ")";
        } else {
            return Character.toString((char)this.type) + 
                    "(" + this.line + "," + this.col + ")";
        }
    }
}
