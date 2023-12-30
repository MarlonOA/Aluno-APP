import 'package:flutter/material.dart';
import 'package:prova_aluno_pdm/domain/Aluno.dart';
import 'package:prova_aluno_pdm/helpers/Aluno_helper.dart';

class TelaDetalhes extends StatefulWidget {
  final int alunoId;

  const TelaDetalhes({Key? key, required this.alunoId}) : super(key: key);

  @override
  _TelaDetalhesState createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  final alunoHelper = AlunoHelper();
  late Future<Aluno?> aluno;

  @override
  void initState() {
    super.initState();
    aluno = alunoHelper.getAluno(widget.alunoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Detalhes do Aluno"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite o ID do Aluno',
              ),
              onSubmitted: (value) {
                int alunoId = int.tryParse(value) ?? 0;
                if (alunoId > 0) {
                  setState(() {
                    aluno = alunoHelper.getAluno(alunoId);
                  });
                } else {
                  // Lógica para lidar com um ID inválido
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ID Inválido'),
                        content: Text('Por favor, digite um ID válido.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<Aluno?>(
            future: aluno,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro ao carregar dados do aluno.');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('Aluno não encontrado.');
              } else {
                // Exiba os detalhes do aluno
                Aluno aluno = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${aluno.id}'),
                    Text('Nome: ${aluno.nome}'),
                    Text('Idade: ${aluno.idade}'),
                    Text('Curso: ${aluno.curso}'),
                    Text('Endereço: ${aluno.endereco}'),
                    Text('Notas: ${aluno.notas}'),
                    Text('Situação: ${aluno.situacao ? 'Ativo' : 'Inativo'}'),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
