package br.com.gpmodontosystem.manager;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import br.com.gpmodontosystem.model.Endereco;
import br.com.gpmodontosystem.model.Paciente;
import br.com.gpmodontosystem.model.Plano;
import br.com.gpmodontosystem.service.endereco.EnderecoServiceImpl;
import br.com.gpmodontosystem.service.endereco.IEnderecoService;
import br.com.gpmodontosystem.service.paciente.IPacienteService;
import br.com.gpmodontosystem.service.paciente.PacienteServiceImp;
import br.com.gpmodontosystem.service.plano.IPlanoService;
import br.com.gpmodontosystem.service.plano.PlanoServiceImp;
import br.com.gpmodontosystem.utilitario.BuscaCep;

@ManagedBean(name="mbPaciente")
@RequestScoped
public class PacienteBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Paciente paciente;
	private List<Paciente> listaPaciente;
	
	private Plano plano;
	private List<Plano> listaPlano;
	
	private Endereco endereco;
	
	private IPacienteService pacienteService;
	private IPlanoService planoService;
	private IEnderecoService enderecoService;
	
	private boolean flagCadastroEndereco = true;
	private boolean flagCadastroPaciente = true;
	private boolean flagCadastroConvenio = true;
	private String nomeAutoComplete;
	
	
	@PostConstruct
	public void init(){
		paciente = new Paciente();
		listaPaciente = new ArrayList<Paciente>();
		pacienteService = new PacienteServiceImp();
		Calendar c = Calendar.getInstance();
		paciente.setDataNascimento(c);
		
		planoService = new PlanoServiceImp();
		plano = new Plano();
		
		endereco = new Endereco();
		paciente.setEndereco(endereco);
		
	}
	

	public void cadastrarPaciente(){
		FacesContext fc = FacesContext.getCurrentInstance();
		try {
			pacienteService.inserir(paciente);
			fc.addMessage("formCadConsPaciente", new FacesMessage("Paciente cadastrado com sucesso."));
		} catch (Exception e) {
			fc.addMessage("formCadConsPaciente", new FacesMessage("Ocorreu um erro interno ao salvar o Paciente."));
			e.printStackTrace();
		}
	}
	
	public void consultarPaciente(){
		FacesContext fc = FacesContext.getCurrentInstance();
		
		try {
			paciente = pacienteService.consultarPeloId(paciente);
		} catch (Exception e) {
			fc.addMessage("formCadConsPaciente", new FacesMessage("Ocorreu um erro interno ao consultar o Paciente."));
			e.printStackTrace();
		}
	}
	
	
	public List<Paciente> listarPacienteAutoComplete(String nome){
		FacesContext fc = FacesContext.getCurrentInstance();
		try {
			listaPaciente = pacienteService.listarPacientesPeloNomeCpfEmail(nome);
		} catch (Exception e) {
			fc.addMessage("formAutoCompletePaciente", new FacesMessage("Ocorreu um erro interno ao consultar o Paciente."));
		}
		return listaPaciente;
	}
	
	public void excluirPaciente(){
		FacesContext fc = FacesContext.getCurrentInstance();
		
		
	}
	
	public String cancelarCadastroPaciente(){
		
		return null;
	}
	
	public void buscarCep(){
		FacesContext fc = FacesContext.getCurrentInstance();
		try {
			if(!new BuscaCep().buscarCep(paciente.getEndereco())){
			fc.addMessage("formBuscaCep", new FacesMessage("CEP n�o localizado."));
			}
		} catch (Exception e) {
			fc.addMessage("formBuscaCep", new FacesMessage("Ocorreu um erro interno ao consultar o CEP."));
		}
	}
	
	public void cancelarPreenchimentoEndereco(){
		endereco = new Endereco();
		paciente.setEndereco(endereco);
	}
	
	public void cadastrarEndereco(){
		FacesContext fc = FacesContext.getCurrentInstance();
		try {
			enderecoService = new EnderecoServiceImpl();
			enderecoService.inserir(paciente);
			flagCadastroEndereco = false;
			fc.addMessage("formCadConsPaciente", new FacesMessage("Endere�o cadastrado com sucesso."));
		} catch (Exception e) {
			e.printStackTrace();
			fc.addMessage("formCadConsPaciente", new FacesMessage("Ocorreu um erro interno ao cadastrar o endere�o."));
		}
	}
	
	public void alterarEndereco(){
		
	}
	
	
	

	public Paciente getPaciente() {
		return paciente;
	}

	public void setPaciente(Paciente paciente) {
		this.paciente = paciente;
	}

	public List<Paciente> getListaPaciente() {
		return listaPaciente;
	}

	public void setListaPaciente(List<Paciente> listaPaciente) {
		this.listaPaciente = listaPaciente;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public Plano getPlano() {
		return plano;
	}

	public void setPlano(Plano plano) {
		this.plano = plano;
	}

	public List<Plano> getListaPlano() {
		try {
			listaPlano = planoService.listarPlanos();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listaPlano;
	}

	public void setListaPlano(List<Plano> listaPlano) {
		this.listaPlano = listaPlano;
	}


	public Endereco getEndereco() {
		return endereco;
	}


	public void setEndereco(Endereco endereco) {
		this.endereco = endereco;
	}


	public boolean isFlagCadastroEndereco() {
		return flagCadastroEndereco;
	}


	public void setFlagCadastroEndereco(boolean flagCadastroEndereco) {
		this.flagCadastroEndereco = flagCadastroEndereco;
	}


	public boolean isFlagCadastroPaciente() {
		return flagCadastroPaciente;
	}


	public void setFlagCadastroPaciente(boolean flagCadastroPaciente) {
		this.flagCadastroPaciente = flagCadastroPaciente;
	}


	public boolean isFlagCadastroConvenio() {
		return flagCadastroConvenio;
	}


	public void setFlagCadastroConvenio(boolean flagCadastroConvenio) {
		this.flagCadastroConvenio = flagCadastroConvenio;
	}


	public String getNomeAutoComplete() {
		return nomeAutoComplete;
	}


	public void setNomeAutoComplete(String nomeAutoComplete) {
		this.nomeAutoComplete = nomeAutoComplete;
	}
	
	
	

}
