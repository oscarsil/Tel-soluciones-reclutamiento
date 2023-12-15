import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';

class borrarReclu extends StatefulWidget{
  @override
  State<borrarReclu> createState() => _borrarRecluState();
}

class _borrarRecluState extends State<borrarReclu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: barraRegSal(titulo: "borrar reclutador"), preferredSize: const Size.fromHeight(50)),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text("buscar por nombre"),
                Container(width:200,child: TextFormField()),
                ElevatedButton(onPressed: () {}, child: Icon(Icons.search))
              ],
            ),
            Table(
              children: [
                TableRow(
                  children: <Widget>[
                    Row(
                      children: [
                        Text("Mariana Paz"),
                        Icon(Icons.delete)
                      ],
                    )
                  ]
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}