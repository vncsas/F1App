import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'piloto.dart';
import 'pilotos_data.dart';
import 'card_piloto.dart';
import 'card_equipe.dart';
import 'tela_detalhe_piloto.dart';
import 'TeamModel.dart';

class TelaClassificacao extends StatefulWidget {
  const TelaClassificacao({super.key});

  @override
  State<TelaClassificacao> createState() => _TelaClassificacaoState();
}

class _TelaClassificacaoState extends State<TelaClassificacao>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Piloto>> _pilotosFuture;
  late Future<List<TeamModel>> _equipesFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pilotosFuture = F1ApiService(Dio()).getDrivers();
    _equipesFuture = F1ApiService(Dio()).getTeams();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
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
        children: [
          _listaPilotos(),
          _telaEquipesEmBreve(),
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
              valueColor: AlwaysStoppedAnimation(Color(0xFFE8002D)),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Erro ao carregar os pilotos",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        final drivers = snapshot.data ?? [];
        if (drivers.isEmpty) {
          return Center(
            child: Text(
              "Nenhum piloto encontrado",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 12),
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return CardPiloto(
              piloto: drivers[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaDetalhePiloto(
                      piloto: drivers[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _telaEquipesEmBreve() {
    return FutureBuilder<List<TeamModel>>(
      future: _equipesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xFFE8002D)),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Erro ao carregar as equipes",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        final teams = snapshot.data ?? [];
        if (teams.isEmpty) {
          return Center(
            child: Text(
              "Nenhuma equipe encontrada",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 12),
          itemCount: teams.length,
          itemBuilder: (context, index) {
            return CardEquipe(team: teams[index]);
          },
        );
      },
    );
  }
}