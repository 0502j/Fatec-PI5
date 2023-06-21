class Event {
  int id;
  String nome;
  String data;
  String hora;
  String descricao;
  String tipo;
  String? image;
  String local;

  Event(
      {required this.id,
      required this.nome,
      required this.data,
      required this.hora,
      required this.descricao,
      required this.tipo,
      required this.local,
      this.image});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      nome: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      data: json['data'] ?? '',
      hora: json['hora'] ?? '',
      image: json['image'],
      tipo: json['tipo'] ?? '',
      local: json['local'] ?? '',
    );
  }
}

class Participant {
  final int id;
  final String nome;
  final String email;
  final String? image;

  Participant({
    required this.id,
    required this.nome,
    required this.email,
    this.image,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      image: json['image'],
    );
  }
}
