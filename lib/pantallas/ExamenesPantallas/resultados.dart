import 'package:flutter/material.dart';
import 'package:telsolreclutamiento/componentes/barras.dart';

class Resultados extends StatelessWidget {
  final int time;
  final int errors;
  final int length;

  const Resultados({
    Key? key,
    required this.time,
    required this.length,
    required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50),child:barraInformativa(titulo:'Examen de Teclado')),
      body: Center(
        child: Column(
          children: [
            _buildDataRow('Tiempo', time),
            _buildDataRow('Errores', errors),
            _buildDataRow('Letras tecleadas', length),
            _buildDataRow('PPM', sacarWpm(length, time)),
            _buildDataRow('Eficiencia', sacarEf(length,errors)),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, dynamic value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 16, // Tamaño de fuente
            fontWeight: FontWeight.bold, // Negrita
            color: Colors.blue, // Color de texto
          ),
        ),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 16, // Tamaño de fuente
            color: Colors.black, // Color de texto
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  String sacarWpm(int letras, int segundos) {
    double palabras = letras / 5;
    double resultado = (palabras / segundos) * 60;
    return resultado.toStringAsFixed(2);
  }
  String sacarEf(int length, int errors) {
    double resultado = 100-((errors*100)/length);
    return "${resultado.toStringAsFixed(2)} %";
  }
}
