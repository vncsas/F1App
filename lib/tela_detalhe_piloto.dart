import 'package:flutter/material.dart';
import 'piloto.dart';

class TelaDetalhePiloto extends StatelessWidget {
  final Piloto piloto;

  const TelaDetalhePiloto({super.key, required this.piloto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: AppBar(
        title: Text("Driver Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cabecalho(context),
            SizedBox(height: 16),

            _estatisticas(),
            SizedBox(height: 24),
            _cardEquipe(),

            SizedBox(height: 24),
            _secaoPodios(),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [piloto.corEquipe.withOpacity(0.8), Color(0xFF111111)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.network(
              piloto.imagem,
              height: 260,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.person, size: 100, color: Colors.white24),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  piloto.nome.split(" ").first.toLowerCase(),
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                Text(
                  piloto.nome.split(" ").last.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${piloto.numero}  |  ${piloto.equipe}",
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _estatisticas() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemEstatistica("Standing", "${piloto.posicao}º"),
            _divisor(),
            _itemEstatistica("Podiums", "${piloto.podios}"),
            _divisor(),
            _itemEstatistica("Points", "${piloto.pontos}"),
          ],
        ),
      ),
    );
  }

  Widget _itemEstatistica(String label, String valor) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white38, fontSize: 13)),
        SizedBox(height: 8),
        Text(
          valor,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _divisor() {
    return Container(width: 1, height: 40, color: Colors.white12);
  }

  Widget _cardEquipe() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  piloto.equipe,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  piloto.nacionalidade,
                  style: TextStyle(color: Colors.white38, fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  "${piloto.posicao}º lugar",
                  style: TextStyle(color: Colors.white60, fontSize: 13),
                ),
              ],
            ),
            Icon(Icons.directions_car, color: piloto.corEquipe, size: 48),
          ],
        ),
      ),
    );
  }

  Widget _secaoPodios() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pódios",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          ...List.generate(piloto.podios.clamp(0, 3), (index) {
            return _itemPodio(index + 1);
          }),
        ],
      ),
    );
  }

  Widget _itemPodio(int posicao) {
    final pistas = ["Bahrain", "Arábia Saudita", "Austrália"];
    final datas = ["02 MAR 2025", "09 MAR 2025", "16 MAR 2025"];

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "$posicaoº  ",
                style: TextStyle(color: Colors.white38, fontSize: 14),
              ),
              Text(
                "${datas[posicao - 1]}  |  ${pistas[posicao - 1]}",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        ],
      ),
    );
  }
}
