class Prospecto{
  final int? id;
  final String nombre,primerApellido,segundoApellido,direccion,telefono,escolaridad;
  final int edad;
  final int? calquizz, calexamTec, calexamAud;
  final String? campana, estatus, motivo;

  Prospecto({
    this.id,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.direccion,
    required this.telefono,
    required this.escolaridad,
    required this.edad,
    this.calquizz,
    this.calexamTec,
    this.calexamAud,
    this.campana,
    this.estatus,
    this.motivo
});

  factory Prospecto.fromMap(Map<String, dynamic> json) => Prospecto(
      id: json["id"],
      nombre: json["nombre"],
      primerApellido: json["primerApellido"],
      segundoApellido: json["segundoApellido"],
      direccion: json["direccion"],
      telefono: json["telefono"],
      escolaridad: json["escolaridad"],
      edad: json["edad"],
      calquizz:  json["calquizz"],
      calexamTec: json["calexamTec"],
      calexamAud: json["calexamAud"],
      campana: json["campana"],
      estatus: json["estatus"],
      motivo: json["motivo"]
  );

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'primerApellido':primerApellido,
      'segundoApellido':segundoApellido,
      'direccion':direccion,
      'telefono':telefono,
      'escolaridad':escolaridad,
      'edad': edad,
      'calquizz':calquizz,
      'calexamTec':calexamTec,
      'calexamAud':calexamAud,
      'campana':campana,
      'estatus':estatus,
      'motivo':motivo
    };
  }

}