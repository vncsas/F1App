import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/card_equipe.dart';
import '../data/f1_api_service.dart';
import '../models/equipe.dart';
import 'tela_detalhe_equipe.dart';
import 'tela_pilotos.dart';

class TelaEquipes extends StatefulWidget {
  @override
  State<TelaEquipes> createState() => _TelaEquipesState();
}

class _TelaEquipesState extends State<TelaEquipes> {
  final F1ApiService _apiService = F1ApiService(Dio());
  late final Future<List<Equipe>> _equipesFuture = _loadEquipes();
  int _indiceBottomNav = 1;

  Future<List<Equipe>> _loadEquipes() async {
    final equipes = await _apiService.getTeams();
    final pilotos = await _apiService.getDrivers();

    final agregadas = equipes.map((base) {
      var pontos = 0.0;
      final nomesPilotos = <String>[];

      for (final p in pilotos) {
        if (p.equipe.toLowerCase() == base.nome.toLowerCase() || p.teamId == base.teamId) {
          pontos += p.pontos;
          nomesPilotos.add(p.nome);
        }
      }
      return base.copyWith(pontos: pontos, pilotos: nomesPilotos);
    }).toList();

    agregadas.sort((a, b) => b.pontos.compareTo(a.pontos));
    return [
      for (var i = 0; i < agregadas.length; i++) agregadas[i].copyWith(posicao: i + 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipes"),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Equipe>>(
        future: _equipesFuture,
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
                  "Erro ao carregar equipes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            );
          }

          final equipes = snapshot.data;
          if (equipes == null || equipes.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Nenhuma equipe encontrada.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: equipes.length,
            itemBuilder: (context, index) {
              return CardEquipe(
                equipe: equipes[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalheEquipe(equipe: equipes[index]),
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
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TelaPilotos()),
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
