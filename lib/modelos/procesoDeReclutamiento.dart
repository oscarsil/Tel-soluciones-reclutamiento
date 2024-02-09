class ProccesoDeContratacion{
  final int? id;
  final String? nombreReclutador;
  final int? idReclutante;
  final int? idProspecto;
  final String nombreProspecto;
  final String pts;

  ProccesoDeContratacion({
    this.id,
    this.nombreReclutador,
     this.idReclutante,
    required this.nombreProspecto,
    required this.idProspecto,
    required this.pts
});

  factory ProccesoDeContratacion.fromMap(Map<String, dynamic> json) => ProccesoDeContratacion(
      id: json["id"],
      nombreReclutador: json["nombreReclutador"],
      idReclutante: json["idReclutante"],
      nombreProspecto: json["nombreProspecto"],
      idProspecto: json["idProspecto"],
      pts: json["pts"]);

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombreReclutador':nombreReclutador,
      'idReclutante':idReclutante,
      'nombreProspecto': nombreProspecto,
      'idProspecto':idProspecto,
      'pts':pts,
    };
  }

}