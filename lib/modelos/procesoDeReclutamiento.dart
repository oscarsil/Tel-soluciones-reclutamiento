class ProccesoDeContratacion{
  final int? id;
  final String nombre_reclutador;
  final int id_reclutante, id_prospecto;
  final String proc_time_stamp;

  ProccesoDeContratacion({
    this.id,
    required this.nombre_reclutador,
    required this.id_reclutante,
    required this.id_prospecto,
    required this.proc_time_stamp
});

  factory ProccesoDeContratacion.fromMap(Map<String, dynamic> json) => ProccesoDeContratacion(
      id: json["id"],
      nombre_reclutador: json["nombre_reclutador"],
      id_reclutante: json["id_reclutante"],
      id_prospecto: json["id_prospecto"],
      proc_time_stamp: json["proc_time_stamp"]);

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombre_reclutador':nombre_reclutador,
      'id_reclutante':id_reclutante,
      'id_prospecto':id_prospecto,
      'proc_time_stamp':proc_time_stamp,
    };
  }

}