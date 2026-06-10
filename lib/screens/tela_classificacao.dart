import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../components/card_equipe.dart';
import '../components/card_piloto.dart';
import '../data/f1_api_service.dart';
import '../models/equipe.dart';
import '../models/piloto.dart';
import 'tela_corridas.dart';
import 'tela_detalhe_equipe.dart';
import 'tela_detalhe_piloto.dart';

class TelaClassificacao extends StatefulWidget {
  @override
  State<TelaClassificacao> createState() => _TelaClassificacaoState();
}

class _TelaClassificacaoState extends State<TelaClassificacao>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);
  final F1ApiService _apiService = F1ApiService(Dio());
  late final Future<List<Piloto>> _pilotosFuture = _apiService.getDrivers();
  late final Future<List<Equipe>> _equipesFuture = _loadEquipes();
  int _indiceBottomNav = 0;

  Future<List<Equipe>> _loadEquipes() async {
    final equipes = await _apiService.getTeams();
    final pilotos = await _pilotosFuture;

    final agregadas = equipes.map((base) {
      var pontos = 0.0;
      final nomesPilotos = <String>[];

      for (final p in pilotos) {
        if (p.equipe.toLowerCase() == base.nome.toLowerCase() || p.teamId == base.teamId) {
          pontos += p.pontos;
          nomesPilotos.add(p.nome);
        }
      }
      return base.comDados(pontos: pontos, pilotos: nomesPilotos);
    }).toList();

    agregadas.sort((a, b) => b.pontos.compareTo(a.pontos));
    return [
      for (var i = 0; i < agregadas.length; i++) agregadas[i].comDados(posicao: i + 1),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classificação"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFFE8002D),
          labelColor: Color(0xFFE8002D),
          unselectedLabelColor: Colors.white38,
          tabs: [
            Tab(text: "Pilotos"),
            Tab(text: "Equipes"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_listaPilotos(), _listaEquipes()],
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
              MaterialPageRoute(builder: (context) => TelaCorridas()),
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

  Widget _listaPilotos() {
    return FutureBuilder<List<Piloto>>(
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
          return _buildMessage("Erro ao carregar pilotos.");
        }

        final pilotos = snapshot.data;
        if (pilotos == null || pilotos.isEmpty) {
          return _buildMessage("Nenhum piloto encontrado.");
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
    );
  }

  Widget _listaEquipes() {
    return FutureBuilder<List<Equipe>>(
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
          return _buildMessage("Erro ao carregar equipes.");
        }

        final equipes = snapshot.data;
        if (equipes == null || equipes.isEmpty) {
          return _buildMessage("Nenhuma equipe encontrada.");
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
    );
  }

  Widget _buildMessage(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
