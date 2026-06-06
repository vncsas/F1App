import 'package:flutter/material.dart';
import '../models/corrida.dart';

class CardCorrida extends StatelessWidget {
  final Corrida corrida;
  final VoidCallback onTap;

  const CardCorrida({
    super.key,
    required this.corrida,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'bandeira-${corrida.nomeGP}',
                  child: Text(
                    corrida.bandeira,
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  corrida.data,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    corrida.nomeGP,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    corrida.circuito,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  corrida.realizada
                      ? Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Color(0xFFFFD700),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              corrida.vencedor,
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white38,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Aguardando...",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white24,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}