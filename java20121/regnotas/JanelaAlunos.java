package notas;

import java.awt.BorderLayout;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.table.AbstractTableModel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JButton;

import almonds.ParseException;

import java.awt.GridLayout;
import java.util.ArrayList;
import java.util.List;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

class AlunosModel extends AbstractTableModel {
	List<Aluno> alunos;
	
	static String[] cabecalho = new String[] {
			"DRE", "Nome", "P1", "P2", "P3", "Media"
	};
	
	AlunosModel(List<Aluno> alunos) {
		this.alunos = alunos;
	}

	public String getColumnName(int coluna) {
		return cabecalho[coluna];
	}
	
	@Override
	public int getColumnCount() {
		return 6;
	}

	@Override
	public int getRowCount() {
		return this.alunos.size();
	}

	@Override
	public Object getValueAt(int linha, int coluna) {
		Aluno aluno = this.alunos.get(linha);
		switch(coluna) {
		case 0: return aluno.getDRE();
		case 1: return aluno.getNome();
		case 2: return aluno.getP1();
		case 3: return aluno.getP2();
		case 4: return aluno.getP3();
		case 5: return 0.0;
		}
		return null;
	}
	
	
}

public class JanelaAlunos extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8137090217890626901L;
	private JPanel contentPane;
	private JTable tabAlunos;
	
	private List<Aluno> alunos;
	private AlunosModel tabModel;
	private JButton botNovo;

	/**
	 * Create the frame.
	 */
	public JanelaAlunos(String turma) {
		setTitle("Alunos da Turma " + turma);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 621, 367);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JScrollPane scrollPane = new JScrollPane();
		contentPane.add(scrollPane, BorderLayout.CENTER);
		
		tabAlunos = new JTable();
		try {
			alunos = Aluno.alunos(turma);
		} catch(ParseException pe) {
			alunos = new ArrayList<Aluno>();
		}
		tabModel = new AlunosModel(alunos);
		tabAlunos.setModel(tabModel);
		scrollPane.setViewportView(tabAlunos);
		
		JPanel panel = new JPanel();
		contentPane.add(panel, BorderLayout.SOUTH);
		panel.setLayout(new GridLayout(0, 2, 0, 0));
		
		botNovo = new JButton("Novo Aluno...");
		botNovo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				Aluno aluno = alunos.get(tabAlunos.getSelectedRow());
				aluno.setP1(aluno.getP1() + 0.5);
				tabModel.fireTableDataChanged();
			}
		});
		panel.add(botNovo);
		
		JButton botEditar = new JButton("Editar Aluno...");
		panel.add(botEditar);
	}

}
