import 'package:flutter/material.dart';
import '../models/piloto.dart';

class CardPiloto extends StatelessWidget {
  final Piloto piloto;
  final VoidCallback onTap;

  const CardPiloto({
    super.key,
    required this.piloto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              piloto.corEquipe.withOpacity(0.9),
              piloto.corEquipe.withOpacity(0.3),
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      piloto.nome.split(" ").first.toLowerCase(), 
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      piloto.nome.split(" ").last.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      piloto.equipe,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    RichText(                 
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${piloto.posicao}º posição  ",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: "${piloto.pontos}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " pts",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.network(
                piloto.imagem,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  color: Colors.white10,
                  child: Icon(Icons.person, color: Colors.white30, size: 40),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}