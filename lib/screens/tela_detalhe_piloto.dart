import 'package:flutter/material.dart';
import '../models/piloto.dart';

class TelaDetalhePiloto extends StatelessWidget {
  final Piloto piloto;

  const TelaDetalhePiloto({super.key, required this.piloto});

  @override
  Widget build(BuildContext context) {
    final pistas = ["Bahrain", "Arábia Saudita", "Austrália"];
    final datas = ["02 MAR 2025", "09 MAR 2025", "16 MAR 2025"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Piloto"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [piloto.corEquipe.withValues(alpha: 0.8), Color(0xFF111111)],
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
            ),
            SizedBox(height: 16),
            Padding(
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
                    Column(
                      children: [
                        Text("Colocação", style: TextStyle(color: Colors.white38, fontSize: 13)),
                        SizedBox(height: 8),
                        Text(
                          "${piloto.posicao}º",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 40, color: Colors.white12),
                    Column(
                      children: [
                        Text("Vitórias", style: TextStyle(color: Colors.white38, fontSize: 13)),
                        SizedBox(height: 8),
                        Text(
                          "${piloto.vitorias}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 40, color: Colors.white12),
                    Column(
                      children: [
                        Text("Pontos", style: TextStyle(color: Colors.white38, fontSize: 13)),
                        SizedBox(height: 8),
                        Text(
                          "${piloto.pontos}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
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
                    Image.network(
                      piloto.logoEquipe,
                      width: 80,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vitórias",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  ...List.generate(piloto.vitorias.clamp(0, 3), (index) {
                    final posicao = index + 1;
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
                  }),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
