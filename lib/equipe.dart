import 'package:flutter/material.dart';

class Equipe {
  String nome;
  String cor;             
  Color corEquipe;    
  String motor;
  int posicao;
  int pontos;
  List<String> pilotos; 
  String imagemCarro;

  Equipe({
    required this.nome,
    required this.cor,
    required this.corEquipe,
    required this.motor,
    required this.posicao,
    required this.pontos,
    required this.pilotos,
    required this.imagemCarro,
  });
}