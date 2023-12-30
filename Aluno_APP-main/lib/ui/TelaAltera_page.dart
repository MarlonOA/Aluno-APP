import 'package:flutter/material.dart';
import 'package:prova_aluno_pdm/domain/Aluno.dart';
import 'package:prova_aluno_pdm/helpers/Aluno_helper.dart';
import 'package:prova_aluno_pdm/ui/Home_page.dart';
import 'package:prova_aluno_pdm/ui/TelaAlteracaoDetalhes.dart';

class TelaAlteracao extends StatefulWidget {
  const TelaAlteracao({Key? key}) : super(key: key);

  @override
  _TelaAlteracaoState createState() => _TelaAlteracaoState();
}

class _TelaAlteracaoState extends State<TelaAlteracao> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Alteração"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "ID do Aluno"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, insira um ID válido.";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    int alunoId = int.parse(_idController.text);
                    Aluno aluno = await AlunoHelper().getAluno(alunoId) ??
                        Aluno(
                          nome: "",
                          idade: "",
                          curso: "",
                          endereco: "",
                          notas: 0,
                          situacao: false,
                        );
                    if (aluno.id != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaAlteracaoDetalhes(
                                aluno:
                                    Aluno(nome: '', idade: '', curso: '', endereco: '', notas: 0, situacao: true), // Substitua Aluno() pelo objeto Aluno correspondente
                                alunoId: alunoId,
                              ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Aluno não encontrado."),
                        ),
                      );
                    }
                  }
                },
                child: Text("Buscar Aluno"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
