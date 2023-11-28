class Reclutador{
  final int? id;
  final String username,password;
  final int habilitado;

  Reclutador(
      {this.id,
      required this.username,
      required this.password,
      required this.habilitado});

  factory Reclutador.fromMap(Map<String, dynamic> json) => Reclutador(
      username: json["id"],
      password: json["password"],
      habilitado: json["habilitado"]);

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'username':username,
      'password':password,
      'habilitado':habilitado,
    };
  }

}