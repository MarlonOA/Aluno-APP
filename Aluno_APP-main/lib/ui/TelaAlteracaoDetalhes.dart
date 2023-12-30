// TelaAlteracaoDetalhes.dart
import 'package:flutter/material.dart';
import 'package:prova_aluno_pdm/domain/Aluno.dart';
import 'package:prova_aluno_pdm/helpers/Aluno_helper.dart';
import 'package:prova_aluno_pdm/ui/Home_page.dart';

class TelaAlteracaoDetalhes extends StatefulWidget {
  final Aluno aluno;
  final int alunoId;

  const TelaAlteracaoDetalhes(
      {Key? key, required this.aluno, required this.alunoId})
      : super(key: key);

  @override
  _TelaAlteracaoDetalhesState createState() => _TelaAlteracaoDetalhesState();
}

class _TelaAlteracaoDetalhesState extends State<TelaAlteracaoDetalhes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _notasController = TextEditingController();
  final TextEditingController _situacaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    preencherCampos();
  }

  void preencherCampos() async {
    Aluno aluno = await AlunoHelper().getAluno(widget.alunoId) ??
        Aluno(
            nome: '',
            idade: '',
            curso: '',
            endereco: '',
            notas: 0,
            situacao: true);
    _nomeController.text = aluno.nome;
    _idadeController.text = aluno.idade;
    _cursoController.text = aluno.curso;
    _enderecoController.text = aluno.endereco;
    _notasController.text = aluno.notas.toString();
    _situacaoController.text = aluno.situacao.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Alteração Detalhes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nomeController,
                onChanged: (value) {
                  setState(() {
                    widget.aluno.nome = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: _idadeController,
                onChanged: (value) {
                  setState(() {
                    widget.aluno.idade = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Idade'),
              ),
              TextFormField(
                controller: _cursoController,
                onChanged: (value) {
                  setState(() {
                    widget.aluno.curso = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Curso'),
              ),
              TextFormField(
                controller: _enderecoController,
                onChanged: (value) {
                  setState(() {
                    widget.aluno.endereco = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
              TextFormField(
                controller: _notasController,
                onChanged: (value) {
                  setState(() {
                    widget.aluno.notas = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(labelText: 'Notas'),
              ),
              TextFormField(
                controller: _situacaoController,
                onChanged: (value) {
                  setState(() {
                    widget.aluno.situacao = value.toLowerCase() == 'true';
                  });
                },
                decoration: InputDecoration(labelText: 'Situação'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.aluno != null) {
                    // Atualizar os valores no banco de dados
                    await AlunoHelper().updateAluno(widget.aluno);

                    // Navegar de volta para a HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  } else {
                    print("Erro: 'widget.aluno' é nulo ao tentar atualizar.");
                  }
                },
                child: Text("Confirmar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
