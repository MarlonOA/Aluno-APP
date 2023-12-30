class Aluno {
  static const String alunoTable = "aluno_Table";
  static const String alunoid = "id";
  static const String aNome = "nome";
  static const String aIdade = "idade";
  static const String aCurso = "curso";
  static const String aEndereco = "endereco";
  static const String aNotas = "notas";
  static const String aSituacao = "situacao";

  int id = 0;
  String nome = '';
  String curso = '';
  String idade = '';
  String endereco = '';
  int notas = 0;
  bool situacao = false;

  Aluno({
    required this.nome,
    required this.idade,
    required this.curso,
    required this.endereco,
    required this.notas,
    required this.situacao,
  });

  Aluno.fromMap(Map<String, dynamic> map) {
    id = map[alunoid];
    nome = map[aNome];
    idade = map[aIdade].toString();
    curso = map[aCurso];
    endereco = map[aEndereco];
    notas = map[aNotas];
    situacao = map[aSituacao] == 1;
  }

  Map<String, dynamic> toMap() {
    return {
      aNome: nome,
      aIdade: idade,
      aCurso: curso,
      aEndereco: endereco,
      aNotas: notas,
      aSituacao: situacao ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'Aluno(nome: $nome, idade: $idade, curso: $curso, endereco: $endereco, notas: $notas, situacao: $situacao)';
  }
}