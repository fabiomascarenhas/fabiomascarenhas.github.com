// Retângulos para verificar colisões
public class Hitbox
{
    public static int TOPO     = 1;
    public static int ESQUERDO = 2;
    public static int FUNDO    = 4;
    public static int DIREITO  = 8;
    
    // Canto superior esquerdo e inferior direito
    double x0, y0, x1, y1;
    
    public Hitbox(double _x0, double _y0, double _x1, double _y1) {
        x0 = _x0; y0 = _y0;
        x1 = _x1; y1 = _y1;
    }
    
    public void mover(double _x0, double _y0, double _x1, double _y1) {
        x0 = _x0; y0 = _y0;
        x1 = _x1; y1 = _y1;
    }
    
    public boolean dentro(double x, double y) {
        return x >= x0 && x <= x1 &&
               y >= y0 && y <= y1;
    }
    
    // Esse retângulo colidiu com hb, e onde em hb?
    public int intersecao(Hitbox hb) {
        double w = ((x1-x0) + (hb.x1 - hb.x0)) / 2;
        double h = ((y1-y0) + (hb.y1 - hb.y0)) / 2;
        double dx = ((x1 + x0) - (hb.x1 + hb.x0)) / 2;
        double dy = ((y1 + y0) - (hb.y1 + hb.y0)) / 2;
        
        if (Math.abs(dx) <= w && Math.abs(dy) <= h) {
            // colisão
            double wy = w * dy;
            double hx = h * dx;
            if (wy > hx) {
                if (wy > -hx) {
                    return FUNDO;
                } else {
                    return ESQUERDO;
                }
            } else {
                if (wy > -hx) {
                    return DIREITO;
                } else {
                    return TOPO;
                }
            }
        }
        return 0;
    }
}
