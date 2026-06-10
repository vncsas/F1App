import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../data/f1_api_service.dart';
import '../models/corrida.dart';
import '../components/card_corrida.dart';
import 'tela_detalhe_corrida.dart';
import 'tela_classificacao.dart';

class TelaCorridas extends StatefulWidget {
  @override
  State<TelaCorridas> createState() => _TelaCorridasState();
}

class _TelaCorridasState extends State<TelaCorridas> {
  int _indiceBottomNav = 1;
  final F1ApiService _apiService = F1ApiService(Dio());
  late final Future<List<Corrida>> _corridasFuture = _apiService.getRaces();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corridas"),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Corrida>>(
        future: _corridasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Color(0xFFE8002D)),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar as corridas.",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma corrida encontrada.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final corridas = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Temporada 2026",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8002D).withValues(alpha:0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFE8002D), width: 1),
                      ),
                      child: Text(
                        "${corridas.length} GPs",
                        style: TextStyle(
                          color: Color(0xFFE8002D),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: corridas.length,
                  itemBuilder: (context, index) {
                    final corrida = corridas[index];
                    return CardCorrida(
                      corrida: corrida,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaDetalheCorrida(
                              corrida: corrida,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Color(0xFFE8002D),
        unselectedItemColor: Colors.white38,
        currentIndex: _indiceBottomNav,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TelaClassificacao(),
              ),
            );
          } else {
            setState(() {
              _indiceBottomNav = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: "Classificação",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            label: "Corridas",
          ),
        ],
      ),
    );
  }

}