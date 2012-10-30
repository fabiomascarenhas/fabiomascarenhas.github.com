package notas;

import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.DefaultListModel;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JButton;
import java.awt.GridLayout;
import javax.swing.JList;
import javax.swing.AbstractListModel;

import almonds.ParseException;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

class CliqueAbrir implements ActionListener {
	private JList listTurmas;

	public CliqueAbrir(JList listTurmas) {
		this.listTurmas = listTurmas;
	}

	public void actionPerformed(ActionEvent arg0) {
		Turma t =(Turma)listTurmas.getSelectedValue();
		JanelaAlunos ja = new JanelaAlunos(t.getNome());
		ja.setVisible(true);
	}
}

public class JanelaTurmas extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1081189492924383403L;
	private JPanel contentPane;

	private DefaultListModel<Turma> modelo;
	
	/**
	 * Create the frame.
	 */
	public JanelaTurmas() {
		setTitle("Turmas");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 267, 203);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JLabel labEscolha = new JLabel("Escolha uma turma:");
		contentPane.add(labEscolha, BorderLayout.NORTH);
		
		
		final JList listTurmas = new JList();
		modelo = new DefaultListModel<Turma>();
		try {
			for(Turma t : Turma.turmas()) {
				modelo.addElement(t);
			}
			listTurmas.setModel(modelo);
		} catch(ParseException pe) {
			JOptionPane.showMessageDialog(this, "Erro de comunicação");
		}
		
		JScrollPane scrollPane = new JScrollPane(listTurmas);
		contentPane.add(scrollPane, BorderLayout.CENTER);

		JPanel panel = new JPanel();
		contentPane.add(panel, BorderLayout.SOUTH);
		panel.setLayout(new GridLayout(0, 2, 0, 0));
		
		JButton botAbrir = new JButton("Abrir turma...");
		botAbrir.addActionListener(new CliqueAbrir(listTurmas));
		panel.add(botAbrir);
		
		JButton botNova = new JButton("Nova turma...");
		panel.add(botNova);
	}

}
