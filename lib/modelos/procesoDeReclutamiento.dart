class ProccesoDeContratacion{
  final int? id;
  final String nombreReclutador;
  final int? idReclutante, idProspecto;
  final String pts;

  ProccesoDeContratacion({
    this.id,
    required this.nombreReclutador,
    required this.idReclutante,
    required this.idProspecto,
    required this.pts
});

  factory ProccesoDeContratacion.fromMap(Map<String, dynamic> json) => ProccesoDeContratacion(
      id: json["id"],
      nombreReclutador: json["nombreReclutador"],
      idReclutante: json["idReclutante"],
      idProspecto: json["idProspecto"],
      pts: json["pts"]);

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombreReclutador':nombreReclutador,
      'idReclutante':idReclutante,
      'idProspecto':idProspecto,
      'pts':pts,
    };
  }

}