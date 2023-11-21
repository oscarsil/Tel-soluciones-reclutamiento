class validarRespuestaExamenAuditorio{

  static List<String> respuestascorecctas = ['4567','15/09/23','100','22/07/67','jose hernandez moreno','sinaloa','Sun mall'];

  bool validarBoton(String ns,fs,ps,nas,nos,es,cs){
    if(ns==''||fs==''||ps==''||nas==''||nos==''||es==''||cs==''){return false;}else{return true;}
  }

  double Calificacion(String ns,fs,ps,nas,nos,es,cs){
    double score=0;
    List<String> respuestas = [ns,fs,ps,nas,nos,es,cs];
    respuestascorecctas.forEach((element) {
      if(respuestas.contains(element)){
        score = score+10;
      }
    });
    return score;
  }

  double calcularcalificacion(double score){
    return (score*100)/70;
  }

}