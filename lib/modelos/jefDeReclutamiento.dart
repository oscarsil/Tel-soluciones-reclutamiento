class JefeDeReclutamiento{
  final int? id;
  final String username,password;

  JefeDeReclutamiento({
     this.id,
    required this.username,
    required this.password
});

  factory JefeDeReclutamiento.fromMap(Map<String, dynamic> json) => JefeDeReclutamiento
    (
      id: json["id"],
      username: json["username"],
      password: json["password"]);

 Map<String, dynamic> toMap(){
   return {
     'id':id,
     'username':username,
     'password':password,
   };
 }


}