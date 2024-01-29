import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telsolreclutamiento/modelos/jefDeReclutamiento.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';
import 'package:telsolreclutamiento/modelos/procesoDeReclutamiento.dart';
import 'package:telsolreclutamiento/modelos/prospecto.dart';

class database_helper {
  final datbaseName = "telsol.db";
  String JefeRecluTable = "CREATE TABLE JEFEDERECLU (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT)";
  String JefeDeReclu = "INSERT INTO JEFEDERECLU (username, password) VALUES ('Vladimir Jimenez','Telsol01')";
  String ReclutadorTable = "CREATE TABLE RECLUTADOR (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT, habilitado INTEGER)";
  String pruebaReclutador = "INSERT INTO RECLUTADOR (username, password, habilitado) VALUES ('Judith Garcia','Telsol01',0)";
  String createProspectoTable = "CREATE TABLE PROSPECTO (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, "
      "primerApellido TEXT, segundoApellido TEXT, direccion TEXT, telefono TEXT, escolaridad TEXT, edad INTEGER, calquizz INTEGER,"
      " calexamTec INTEGER, calexamAud INTEGER, campana TEXT, estatus TEXT, motivo TEXT)";
  String createProcesoTable = "CREATE TABLE PROCESO (id INTEGER PRIMARY KEY "
      "AUTOINCREMENT, nombreReclutador TEXT, idReclutante INTEGER, idProspecto INTEGER, pts TEXT)";

  Future<Database> initDB() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,datbaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(JefeRecluTable);
      await db.execute(JefeDeReclu);
      await db.execute(ReclutadorTable);
      await db.execute(pruebaReclutador);
      await db.execute(createProspectoTable);
      await db.execute(createProcesoTable);
    });
  }

  Future<bool> login(JefeDeReclutamiento jefe) async{
    final Database db = await initDB();
    var result = await db.rawQuery(
      "SELECT * FROM JEFEDERECLU WHERE username = '${jefe.username}' AND password = '${jefe.password}'");
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> loginReclu(Reclutador reclu) async{
    final Database db = await initDB();
    var result = await db.rawQuery(
      "SELECT * FROM RECLUTADOR WHERE username = '${reclu.username}' AND password = '${reclu.password}'"
    );
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  // METODOS DE CREAR

  Future<int> crearReclutador(Reclutador reclu) async {
    final Database db = await initDB();
    return db.insert('RECLUTADOR', reclu.toMap());
  }

  Future<int> crearProspecto(Prospecto pros) async {
    final Database db = await initDB();
    return db.insert('Prospecto', pros.toMap());
  }

  Future<int> crearProceso(ProccesoDeContratacion pros) async{
    final Database db = await initDB();
    return db.insert('PROCESO', pros.toMap());
  }

  //METODOS DE BUSCAR

  Future<List<Reclutador>> getReclutadores() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('RECLUTADOR');
    return result.map((e) => Reclutador.fromMap(e)).toList();
  }
  Future<List<Reclutador>> buscarReclutador(String keyword) async{
    final Database db = await initDB();
    List<Map<String, Object?>> resultadobusqeda = await db.
    rawQuery("SELECT * FROM RECLUTADOR WHERE username LIKE ?", ["%$keyword%"]);
    return resultadobusqeda.map((e) => Reclutador.fromMap(e)).toList();
  }

  Future<List<Reclutador>> buscarReclutadorPorId(int id) async {
    final Database db = await initDB();
    List<Map<String, Object?>> resultado = (await
    db.rawQuery("SELECT * FROM RECLUTADOR WHERE id = ?", ["%$id%"]));
    return resultado.map((e) => Reclutador.fromMap(e)).toList();
  }

  Future<List<Prospecto>> getProspectos() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('Prospecto');
    return result.map((e) => Prospecto.fromMap(e)).toList();
  }

  Future<List<Prospecto>> searchProspecto(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db.rawQuery(
        "SELECT * FROM PROSPECTO WHERE nombre || ' ' || primerApellido || ' ' || segundoApellido LIKE ? ", ["%$keyword%"]);
    return searchResult.map((e) => Prospecto.fromMap(e)).toList();
  }

  Future<List<Prospecto>> noscore() async{
    final Database db = await initDB();
    List<Map<String, Object?>> resultado = (await
    db.rawQuery("SELECT * FROM PROSPECTO WHERE calquizz IS NULL"));
    return resultado.map((e) => Prospecto.fromMap(e)).toList();
  }

  Future<List<ProccesoDeContratacion>> buscarProcesoPorFecha(String desde, hasta) async {
    final Database db = await initDB();
    List<Map<String, Object?>> resultado = await db.rawQuery("SELECT * FROM PROCESO WHERE pts > ? and pts < ?", [desde,hasta]);
    return resultado.map((e) => ProccesoDeContratacion.fromMap(e)).toList();
  }



  //METODOS DE BORRAR

  Future<int> borrarReclutador(int id) async {
    final Database db = await initDB();
    return db.delete('RECLUTADOR', where: 'id=?', whereArgs: [id]);
  }

  Future<int> borrarProspecto(int id) async {
    final Database db = await initDB();
    return db.delete('Prospecto', where: 'id = ?', whereArgs: [id]);
  }

  //METODOS DE ACTUALIZAR

  Future<int> editarReclutador(username, password, habilitado, id) async{
    final Database db = await initDB();
    return db.rawUpdate(
        'UPDATE RECLUTADOR SET username = ?, password = ?, habilitado = ? WHERE id = ?',
        [username,password,habilitado, id]);
  }

  Future<int> editarProspecto(nombre, PA, SA, D, T, ESC, EDAD, CAMP, EST, MOT,ID) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'UPDATE PROSPECTO SET nombre = ?, primerApellido = ?, '
            'segundoApellido = ?, direccion = ?, telefono = ?, '
            'escolaridad = ?, edad = ?, campana = ?, estatus =?, motivo = ?'
            'WHERE id = ?'
        ,[nombre, PA,SA,D,T,ESC, EDAD, CAMP, EST, MOT,ID]
    );
  }

  Future<int> editarCalificacionProspecto(calquizz, calexamTec, calexamAud, id) async {
    final Database db = await initDB();
    return db.rawUpdate('UPDATE PROSPECTO SET calquizz = ?, calexamTec = ?, calexamAud = ? WHERE id = ?',[calquizz, calexamTec, calexamAud, id]);
  }

  Future<String> getCount(idReclu,desde,hasta) async {
    final Database db = await initDB();
    var x = await db.rawQuery('SELECT COUNT (*) FROM PROCESO WHERE idReclutante = ? AND pts > ? and pts < ?',[idReclu, desde,hasta]);
    int? count = await Sqflite.firstIntValue(x);
    return count.toString();
  }

  Future<List<ProccesoDeContratacion>> getProcesos() async{
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('PROCESO');
    return result.map((e) => ProccesoDeContratacion.fromMap(e)).toList();
  }


}