import 'package:flutter/material.dart';

class Piloto {
  final String nome;
  final String equipe;
  final int numero;
  final String nacionalidade;
  final String imagem;
  final Color corEquipe;
  final int posicao;
  final int pontos;
  final int podios;

  Piloto({
    required this.nome,
    required this.equipe,
    required this.numero,
    required this.nacionalidade,
    required this.imagem,
    required this.corEquipe,
    required this.posicao,
    required this.pontos,
    required this.podios,
  });
}
