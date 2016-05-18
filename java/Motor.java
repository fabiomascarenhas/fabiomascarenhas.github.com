import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.image.BufferStrategy;
import java.util.HashSet;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;
import javax.sound.sampled.Clip;
import javax.sound.sampled.AudioSystem;
import java.io.File;
import javax.swing.Timer;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Canvas;

/**
 * Motor do jogo, gerencia a parte gráfica e os eventos
 */
public class Motor
{
    public Jogo jogo;
    public BufferStrategy strategy;
    public HashSet<String> keySet = new HashSet<String>();
    
    public Motor(Jogo j) {
        jogo = j;
        Canvas canvas = new Canvas();
        JFrame container = new JFrame(jogo.getTitulo());
        JPanel panel = (JPanel) container.getContentPane();
        panel.setPreferredSize(new Dimension(
                jogo.getLargura(), jogo.getAltura()));
        panel.setLayout(null);
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice[] gs = ge.getScreenDevices();
        Rectangle bounds = gs[gs.length-1].getDefaultConfiguration().getBounds();
        container.setResizable(false);
        container.setBounds(bounds.x+(bounds.width - jogo.getLargura())/2,
        		            bounds.y+(bounds.height - jogo.getAltura())/2,
        		            jogo.getLargura(),jogo.getAltura());
        canvas.setBounds(0,0,jogo.getLargura(),jogo.getAltura());
        panel.add(canvas);        
        canvas.setIgnoreRepaint(true);
        container.pack();
        container.setVisible(true);
        container.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        canvas.addKeyListener(new KeyListener() {
            @Override
            public void keyPressed(KeyEvent evt) {
                keySet.add(keyString(evt));
            }
            @Override
            public void keyReleased(KeyEvent evt) {
                keySet.remove(keyString(evt));
                jogo.tecla(keyString(evt));
            }
            @Override
            public void keyTyped(KeyEvent evt) {
                //jogo.tecla(keyString(evt));
            }
        });
        canvas.createBufferStrategy(2);
        strategy = canvas.getBufferStrategy();
        canvas.requestFocus();
        mainLoop();
    }
    
    private void mainLoop() {
		Timer t = new Timer(5, new ActionListener() {
			public long t0;
			public void actionPerformed(ActionEvent evt) {
				long t1 = System.currentTimeMillis();
				if(t0 == 0)
					t0 = t1;
				if(t1 > t0) {
					double dt = (t1 - t0) / 1000.0;
					t0 = t1;
					jogo.tique(keySet, dt);
					Graphics2D g = (Graphics2D)strategy.getDrawGraphics();
					g.setColor(Color.black);
					g.fillRect(0,0,jogo.getLargura(),
							jogo.getAltura());
					jogo.desenhar(new Tela(g));
					strategy.show();
				}
			}
		});
			
		t.start();
	}

    
    private static String keyString(KeyEvent evt) {
        return evt.getKeyText(evt.getKeyCode()).toLowerCase();
    }

    public static void tocar(String filename) {
        try {
            Clip clip = AudioSystem.getClip();
            clip.open(AudioSystem.getAudioInputStream(new File(filename)));
            clip.start();
        } catch(Exception e) {
        }
    }

}
