import 'package:flutter/material.dart';
import '../models/equipe.dart';

class TelaDetalheEquipe extends StatelessWidget {
  final Equipe equipe;

  const TelaDetalheEquipe({super.key, required this.equipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(equipe.nome),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cabecalho(),
            SizedBox(height: 16),
            _estatisticas(),
            SizedBox(height: 24),
            _secaoPilotos(),
            SizedBox(height: 24),
            _secaoInfo(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [equipe.cor.withValues(alpha:0.8), Color(0xFF111111)],
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
              equipe.urlCarro,
              height: 160,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            left: 20,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipe.nome.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
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
            _itemEstatistica("Posição", "${equipe.posicao}º"),
            _divisor(),
            _itemEstatistica("Pontos", "${equipe.pontos}"),
            _divisor(),
            _itemEstatistica("Pilotos", "${equipe.pilotos.length}"),
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

  Widget _secaoPilotos() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pilotos",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          ...equipe.pilotos.map((piloto) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(color: equipe.cor, width: 4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    piloto,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.person, color: equipe.cor, size: 20),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _secaoInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informações",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          _itemInfo("País", Equipe.bandeiraDoPais(equipe.nacionalidade)),
          _itemInfo("Pilotos", equipe.pilotos.join(" e ")),
        ],
      ),
    );
  }

  Widget _itemInfo(String label, String valor) {
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
          Text(label, style: TextStyle(color: Colors.white38, fontSize: 14)),
          Text(valor, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
