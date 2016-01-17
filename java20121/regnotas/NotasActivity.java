package notas.android;

import java.util.List;

import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

class CliqueVerOutro implements OnClickListener {
	NotasActivity app;
	
	CliqueVerOutro(NotasActivity app) {
		this.app = app;
	}
	
	@Override
	public void onClick(View v) {
		app.pedeDRE();
	}
	
}

class CliqueOkDRE implements DialogInterface.OnClickListener {

	@Override
	public void onClick(DialogInterface arg0, int arg1) {
		// mostra um ProgressDialog e
		// busca na tabela ALUNOS pelo DRE, 
		// usando findInBackground e passando uma
		// inst‰ncia de FinalBuscaNome
	}
	
}

class FinalBuscaNome extends FindCallback {

	@Override
	public void done(List<ParseObject> alunos, ParseException pe) {
		// Atualiza os campos DRE e Nome da interface,
		// e busca na tabela NOTAS pelo DRE,
		// usando findInBackground e passando
		// uma inst‰ncia de FinalBuscaNota
	}
	
}

class FinalBuscaNota extends FindCallback {

	@Override
	public void done(List<ParseObject> notas, ParseException pe) {
		// Atualiza a interface com as notas,
		// e fecha a ProgressDialog
	}
	
}

public class NotasActivity extends Activity {

	static String APP_KEY = "WcOrVgrzFkh8X4Bxa93ta6DEveLl7NJJMaWvx9rQ";
	static String CLIENT_KEY = "j1NgkHcxTIoSlXmcOyWkp91BySLij3FzLtFWctoP";

	static String ALUNOS = "G_99_99_Alunos";
	static String TURMAS = "G_99_99_Turmas";
	static String NOTAS = "G_99_99_Notas";

	@Override
	public Dialog onCreateDialog(int codigo) {
		AlertDialog.Builder dre = new AlertDialog.Builder(this);
		dre.setTitle("Notas");
		dre.setMessage("Entre o DRE:");
		EditText entrada = new EditText(this);
		dre.setView(entrada);
		dre.setPositiveButton("Ok", null);
		dre.setNegativeButton("Cancelar", null);
		return dre.create();
	}
	
	/** Called when the activity is first created. */

	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Parse.initialize(this, APP_KEY, CLIENT_KEY);
        setContentView(R.layout.main);
        Button voutro = (Button)this.findViewById(R.id.button1);
        voutro.setOnClickListener(new CliqueVerOutro(this));
        this.pedeDRE();
	}
	
	void pedeDRE() {
		this.showDialog(0);
	}
}