import 'package:flutter/material.dart';
import 'piloto.dart';
import 'pilotos_data.dart';
import 'card_piloto.dart';
import 'tela_detalhe_piloto.dart';

class TelaClassificacao extends StatefulWidget {
  @override
  State<TelaClassificacao> createState() => _TelaClassificacaoState();
}

class _TelaClassificacaoState extends State<TelaClassificacao>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int _indiceBottomNav = 2;         

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
        children: [
          _listaPilotos(),                      
          _telaEquipesEmBreve(),                 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1A1A1A),
        selectedItemColor: Color(0xFFE8002D),
        unselectedItemColor: Colors.white38,
        currentIndex: _indiceBottomNav,
        onTap: (index) {
          setState(() {
            _indiceBottomNav = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            label: "Races",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: "Classificação",
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
                builder: (context) => TelaDetalhePiloto(
                  piloto: pilotosIniciais[index],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _telaEquipesEmBreve() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, color: Colors.white24, size: 60),
          SizedBox(height: 16),
          Text(
            "Em breve...",
            style: TextStyle(color: Colors.white38, fontSize: 18),
          ),
        ],
      ),
    );
  }
}