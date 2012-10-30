package notas;

import java.util.ArrayList;
import java.util.List;

import almonds.ParseException;
import almonds.ParseObject;
import almonds.ParseQuery;

public class Turma {
	private ParseObject dados;
	
	public Turma(ParseObject dados) {
		this.dados = dados;
	}
	
	public static List<Turma> turmas() throws ParseException {
		ParseQuery qry = new ParseQuery(RegistroNotas.TURMAS);
		qry.addAscendingOrder("nome");
		List<ParseObject> ts = qry.find();
		List<Turma> turmas = new ArrayList<Turma>();
		for(ParseObject turma : ts) {
			turmas.add(new Turma(turma));
		}
		return turmas;
	}

	public String getNome() {
		return this.dados.getString("nome");
	}

	public String toString() {
		return this.getNome();
	}
}
