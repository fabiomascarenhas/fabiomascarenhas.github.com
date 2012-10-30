package notas;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import almonds.ParseException;
import almonds.ParseObject;
import almonds.ParseQuery;

public class Aluno {
	ParseObject dados;
	ParseObject notas;
	
	public Aluno(String turma) {
		this.dados = new ParseObject(RegistroNotas.ALUNOS);
		this.notas = new ParseObject(RegistroNotas.NOTAS);
		this.notas.put("turma", turma);
	}
	
	public Aluno(ParseObject dados, ParseObject notas) {
		this.dados = dados;
		this.notas = notas;
	}
	
	public String getDRE() {
		return dados.getString("dre");
	}
	
	public void setDRE(String dre) {
		this.dados.put("dre", dre);
		this.notas.put("aluno", dre);
	}
	
	public String getNome() {
		return dados.getString("nome");
	}
	
	public void setNome(String nome) {
		this.dados.put("nome", nome);
	}
	
	public Double getP1() {
		return notas.getDouble("p1");
	}
	
	public void setP1(double nota) {
		this.notas.put("p1", nota);
	}

	public Double getP2() {
		return notas.getDouble("p2");
	}

	public void setP2(double nota) {
		this.notas.put("p2", nota);
	}

	public Double getP3() {
		return notas.getDouble("p3");
	}

	public void setP3(double nota) {
		this.notas.put("p3", nota);
	}
	
	public void save() throws ParseException {
		this.dados.save();
		this.notas.save();
	}

	public static List<Aluno> alunos(String turma) throws ParseException {
		List<Aluno> res = new ArrayList<Aluno>();
		ParseQuery qNotas = new ParseQuery(RegistroNotas.NOTAS);
		qNotas.whereEqualTo("turma", turma);
		List<ParseObject> notas = qNotas.find();
		List<String> dres = new ArrayList<String>();
		Map<String, ParseObject> nAlunos = new
				HashMap<String, ParseObject>();
		for(ParseObject nota : notas) {
			String dre = nota.getString("aluno");
			dres.add(dre);
			nAlunos.put(dre, nota);
		}
		ParseQuery qAlunos = new ParseQuery(RegistroNotas.ALUNOS);
		qAlunos.whereContainedIn("dre", (List)dres);
		qAlunos.addAscendingOrder("nome");
		List<ParseObject> alunos = qAlunos.find();
		for(ParseObject aluno : alunos) {
			String dre = aluno.getString("dre");
			res.add(new Aluno(aluno, nAlunos.get(dre)));
		}
		return res;
	}	
}
