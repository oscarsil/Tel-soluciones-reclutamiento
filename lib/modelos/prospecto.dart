class Prospecto{
  final int? id;
  final String nombre,primerApellido,segundoApellido,direccion,telefono,correo;
  final int? calquizz, calexamTec, calexamAud;
  final String? campana, estatus, motivo;

  Prospecto({
    this.id,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.direccion,
    required this.telefono,
    required this.correo,
    this.calquizz,
    this.calexamTec,
    this.calexamAud,
    this.campana,
    this.estatus,
    this.motivo
});

  factory Prospecto.fromMap(Map<String, dynamic> json) => Prospecto(
      nombre: json["nombre"],
      primerApellido: json["primerApellido"],
      segundoApellido: json["segundoApellido"],
      direccion: json["direccion"],
      telefono: json["telefono"],
      correo: json["correo"]);

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'primerApellido':primerApellido,
      'segundoApellido':segundoApellido,
      'direccion':direccion,
      'telefono':telefono,
      'correo':correo,
      'calquizz':calquizz,
      'calexamTec':calexamTec,
      'calecamAud':calexamAud,
      'campana':campana,
      'estatus':estatus,
      'motivo':motivo
    };
  }

}