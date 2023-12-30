// HomePage.dart
import 'package:flutter/material.dart';
import 'package:prova_aluno_pdm/domain/Aluno.dart';
import 'package:prova_aluno_pdm/helpers/Aluno_helper.dart';
import 'package:prova_aluno_pdm/ui/Cadastro_page.dart';
import 'package:prova_aluno_pdm/ui/Detalhe_page.dart';
import 'package:prova_aluno_pdm/ui/TelaAltera_page.dart';
import 'package:prova_aluno_pdm/ui/TelaAlteracaoDetalhes.dart';
import 'package:prova_aluno_pdm/ui/TelaSobre_page.dart'; // Importe a TelaSobre

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final alunoHelper = AlunoHelper();
  late Future<List<Aluno>> alunos;

  @override
  void initState() {
    super.initState();
    alunos = alunoHelper.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Meus alunos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaSobre(),
                ),
              );
            },
            icon: Icon(Icons.info), // Ícone para a TelaSobre
          ),
        ],
      ),
      body: FutureBuilder<List<Aluno>>(
        future: alunos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar dados dos alunos.');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('Nenhum aluno encontrado.');
          } else {
            List<Aluno> alunos = snapshot.data!;
            return Column(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaAlteracaoDetalhes(
                              aluno: Aluno(nome: '', idade: '', curso: '', endereco: '', notas: 0, situacao: true),
                              alunoId: alunoId,
                            ),
                          ),
                        );
                      } else {
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
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: alunos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(alunos[index].nome),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaAlteracaoDetalhes(
                                aluno: Aluno(nome: '', idade: '', curso: '', endereco: '', notas: 0, situacao: true),
                                alunoId: alunos[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroPage(),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaDetalhes(alunoId: 0),
                  ),
                );
              },
              icon: Icon(Icons.details),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaAlteracao(),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
