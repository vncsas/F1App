import 'package:flutter/material.dart';
import '../models/corrida.dart';

class TelaDetalheCorrida extends StatelessWidget {
  final Corrida corrida;

  const TelaDetalheCorrida({super.key, required this.corrida});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: AppBar(
        title: Text(corrida.nomeGP),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cabecalho(),
            SizedBox(height: 24),
            _secaoInfo(),
            SizedBox(height: 24),
            corrida.realizada
                ? _secaoResultado()
                : _secaoAguardando(),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            corrida.realizada
                ? Color(0xFF00A19C).withOpacity(0.6)
                : Color(0xFFE8002D).withOpacity(0.6),
            Color(0xFF111111),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Text(
            corrida.bandeira,
            style: TextStyle(fontSize: 64),
          ),
          SizedBox(height: 12),
          Text(
            corrida.nomeGP.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            corrida.data,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: corrida.realizada
                  ? Color(0xFF00A19C).withOpacity(0.2)
                  : Color(0xFFE8002D).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: corrida.realizada
                    ? Color(0xFF00A19C)
                    : Color(0xFFE8002D),
                width: 1,
              ),
            ),
            child: Text(
              corrida.realizada ? "✓ Realizada" : "⏳ Aguardando",
              style: TextStyle(
                color: corrida.realizada
                    ? Color(0xFF00A19C)
                    : Color(0xFFE8002D),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
          _itemInfo(Icons.location_on_outlined, "Circuito", corrida.circuito),
          _itemInfo(Icons.flag_outlined, "País", corrida.nomePais),
          _itemInfo(Icons.calendar_today_outlined, "Data", corrida.data),
        ],
      ),
    );
  }

  Widget _itemInfo(IconData icone, String label, String valor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icone, color: Colors.white38, size: 18),
          SizedBox(width: 12),
          Text(
            "$label: ",
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          Expanded(
            child: Text(
              valor,
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _secaoResultado() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Resultado",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: Color(0xFFFFD700),
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: Color(0xFFFFD700),
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Vencedor",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  corrida.vencedor,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  corrida.equipeVencedora,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _secaoAguardando() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.white24,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              "Corrida ainda não realizada",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              corrida.data,
              style: TextStyle(
                color: Color(0xFFE8002D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}