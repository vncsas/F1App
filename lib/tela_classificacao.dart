import 'package:flutter/material.dart';
import 'piloto.dart';
import 'pilotos_data.dart';
import 'card_piloto.dart';
import 'tela_detalhe_piloto.dart';
import 'equipe.dart';
import 'equipes_data.dart';
import 'card_equipe.dart';
import 'tela_detalhe_equipe.dart';
import 'tela_corridas.dart';

class TelaClassificacao extends StatefulWidget {
  @override
  State<TelaClassificacao> createState() => _TelaClassificacaoState();
}

class _TelaClassificacaoState extends State<TelaClassificacao>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _indiceBottomNav = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 12),
      itemCount: pilotosIniciais.length,
      itemBuilder: (context, index) {
        return CardPiloto(
          piloto: pilotosIniciais[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TelaDetalhePiloto(piloto: pilotosIniciais[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _listaEquipes() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 12),
      
      itemCount: equipesIniciais.length,
      itemBuilder: (context, index) {
        return CardEquipe(
          equipe: equipesIniciais[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TelaDetalheEquipe(equipe: equipesIniciais[index]),
              ),
            );
          },
        );
      },
    );
  }
}
