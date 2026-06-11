import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/card_piloto.dart';
import '../data/f1_api_service.dart';
import '../models/piloto.dart';
import 'tela_detalhe_piloto.dart';
import 'tela_equipes.dart';

class TelaPilotos extends StatefulWidget {
  @override
  State<TelaPilotos> createState() => _TelaPilotosState();
}

class _TelaPilotosState extends State<TelaPilotos> {
  final F1ApiService _apiService = F1ApiService(Dio());
  late final Future<List<Piloto>> _pilotosFuture = _apiService.getDrivers();
  int _indiceBottomNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilotos"),
      ),
      body: FutureBuilder<List<Piloto>>(
        future: _pilotosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE8002D),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Erro ao carregar pilotos.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            );
          }

          final pilotos = snapshot.data;
          if (pilotos == null || pilotos.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Nenhum piloto encontrado.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: pilotos.length,
            itemBuilder: (context, index) {
              return CardPiloto(
                piloto: pilotos[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalhePiloto(piloto: pilotos[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Color(0xFFE8002D),
        unselectedItemColor: Colors.white38,
        currentIndex: _indiceBottomNav,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TelaEquipes()),
            );
          } else {
            setState(() {
              _indiceBottomNav = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Pilotos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: "Equipes",
          ),
        ],
      ),
    );
  }
}
