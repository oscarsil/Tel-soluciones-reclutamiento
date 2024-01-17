import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telsolreclutamiento/modelos/jefDeReclutamiento.dart';
import 'package:telsolreclutamiento/modelos/reclutador.dart';

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
      print('base de datos creados');
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



}