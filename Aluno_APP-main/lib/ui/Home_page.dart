import 'package:flutter/material.dart';
import 'package:prova_aluno_pdm/domain/Aluno.dart';
import 'package:prova_aluno_pdm/helpers/Aluno_helper.dart';
import 'package:prova_aluno_pdm/ui/Cadastro_page.dart';
import 'package:prova_aluno_pdm/ui/Detalhe_page.dart';
import 'package:prova_aluno_pdm/ui/TelaAlteracaoDetalhes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Meus alunos"),
      ),
      body: const Column(
        children: [
          ListBody(),
        ],
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
    );
  }
}

class ListBody extends StatefulWidget {
  const ListBody({Key? key});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  final alunoHelper = AlunoHelper();
  late Future<List<Aluno>> aluno;

  @override
  void initState() {
    super.initState();
    aluno = alunoHelper.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Aluno>>(
      future: aluno,
      builder: (context, snapshot) {
        print("Snapshot data: ${snapshot.data}");
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListItem(aluno: snapshot.data![i]);
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final Aluno aluno;
  const ListItem({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDetalhes(alunoId: aluno.id),
          ),
        );
      },
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaAlteracaoDetalhes(aluno: aluno, alunoId: aluno.id),
          ),
        );
      },
      child: ListTile(
        title: Text(aluno.nome),
      ),
    );
  }
}
