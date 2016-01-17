
class TINYToken {
    static int IF = 1;
    static int THEN = 2;
    static int ELSE = 3;
    static int END = 4;
    static int REPEAT = 5;
    static int UNTIL = 6;
    static int READ = 7;
    static int WRITE = 8;
    static int ATTRIB = 9;
    static int NUM = 10;
    static int ID = 11;
    static int STRING = 12;

    static String[] names = new String[] { "EOF", "IF", "THEN",
        "ELSE", "END", "REPEAT", "UNTIL", "READ", "WRITE", "ATTRIB",
        "NUM", "ID", "STRING"
    };

    public int type;
    public int intVal;
    public String strVal;

    public TINYToken(int type) {
        this.type = type;
    }

    public TINYToken(int type, int intVal) {
        this.type = type;
        this.intVal = intVal;
    }

    public TINYToken(int type, String strVal) {
        this.type = type;
        this.strVal = strVal;
    }

    public String toString() {
        if(this.type < 10) {
            return TINYToken.names[this.type];
        } else if(this.type == 10) {
            return "NUM: " + this.intVal;
        } else if(this.type == 11) {
            return "ID: " + this.strVal;
        } else if(this.type == 12) {
            return "STRING: " + this.strVal;
        } else {
            return Character.toString((char)this.type);
        }
    }
}
