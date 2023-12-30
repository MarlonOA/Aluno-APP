import 'package:flutter/material.dart';
import 'package:prova_aluno_pdm/domain/Aluno.dart';
import 'package:prova_aluno_pdm/helpers/Aluno_helper.dart';
import 'package:prova_aluno_pdm/widgets/CustomFormField.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("MEUS ALUNOS"),
      ),
      body: SingleChildScrollView(
        child: FormAlunoBody(),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class FormAlunoBody extends StatefulWidget {
  const FormAlunoBody({
    Key? key,
  });

  @override
  State<FormAlunoBody> createState() => _FormAlunoBodyState();
}

class _FormAlunoBodyState extends State<FormAlunoBody> {
  final _formKey = GlobalKey<FormState>();

  final aNomeController = TextEditingController();
  final aIdadeController = TextEditingController();
  final aCursoController = TextEditingController();
  final aEnderecoController = TextEditingController();
  final aNotasController = TextEditingController();
  final aSituacaoController = TextEditingController();

  double rating = 0.0;

  final alunoHelper = AlunoHelper();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Cadastro de alunos",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            CustomFormField(
              controller: aNomeController,
              labelText: "Nome",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione seu nome';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: aIdadeController,
              labelText: "Idade",
              keyboard_type: TextInputType.number,
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione sua idade';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: aCursoController,
              labelText: "Curso",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione seu curso';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: aEnderecoController,
              labelText: "Endereco",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione seu endereco';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: aNotasController,
              labelText: "Notas",
              keyboard_type: TextInputType.number,
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione suas notas';
                }
                return null;
              },
            ),
            CustomFormField(
              controller: aSituacaoController,
              labelText: "Situacao",
              validate_function: (value) {
                if (value == null || value.isEmpty) {
                  return 'Adicione sua situação';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Aluno A = Aluno(
                    nome: aNomeController.text,
                    idade: int.parse(aIdadeController.text).toString(),
                    curso: aCursoController.text,
                    endereco: aEnderecoController.text,
                    notas: int.parse(aNotasController.text),
                    situacao: aSituacaoController.text.toLowerCase() == 'true',
                  );
                  alunoHelper.saveAluno(A);
                  Navigator.pop(context);
                  // Adicione um SnackBar aqui para informar que o aluno foi cadastrado com sucesso
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aluno cadastrado com sucesso!'),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Cadastrar",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
  aNomeController
  aIdadeController
  aEnderecoController
  aNotasController
  aSituacaoController
*/