import 'package:flutter/material.dart';

Color teamColor(String teamName) {
  final n = teamName.toLowerCase();
  if (n.contains('mercedes')) return const Color(0xFF00A19C);
  if (n.contains('ferrari')) return const Color(0xFF9B0000);
  if (n.contains('red bull') || n.contains('redbull')) return const Color(0xFF1A1AFF);
  if (n.contains('mclaren')) return const Color(0xFFB86A00);
  if (n.contains('aston martin')) return const Color(0xFF005F3F);
  if (n.contains('alpine')) return const Color(0xFF0090FF);
  if (n.contains('haas')) return const Color(0xFFFFFFFF);
  if (n.contains('williams')) return const Color(0xFF005AFF);
  if (n.contains('sauber') || n.contains('alfa')) return const Color(0xFF8B0000);
  if (n.contains('rb') || n.contains('racing bulls')) return const Color(0xFF1A1AFF);
  return const Color(0xFFE8002D);
}

String teamLogo(String teamName) {
  final n = teamName.toLowerCase();
  var slug = 'mercedes';
  if (n.contains('mercedes')) slug = 'mercedes';
  else if (n.contains('ferrari')) slug = 'ferrari';
  else if (n.contains('red bull') || n.contains('redbull')) slug = 'red-bull-racing';
  else if (n.contains('mclaren')) slug = 'mclaren';
  else if (n.contains('aston martin')) slug = 'aston-martin';
  else if (n.contains('alpine')) slug = 'alpine';
  else if (n.contains('haas') || n.contains('cadillac')) slug = 'haas-f1-team';
  else if (n.contains('williams')) slug = 'williams';
  else if (n.contains('sauber') || n.contains('alfa') || n.contains('audi')) slug = 'alfa-romeo';
  else if (n.contains('rb') || n.contains('racing bulls') || n.contains('alphatauri')) slug = 'alphatauri';
  return 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677245030/content/dam/fom-website/teams/2023/$slug.png';
}

class Equipe {
  final String teamId;
  final String nome;
  final String cor;
  final Color corEquipe;
  final int posicao;
  final double pontos;
  final List<String> pilotos;
  final String imagemCarro;

  Equipe({
    required this.teamId,
    required this.nome,
    required this.cor,
    required this.corEquipe,
    required this.posicao,
    required this.pontos,
    required this.pilotos,
    required this.imagemCarro,
  });

  factory Equipe.fromJson(Map<String, dynamic> json) {
    final teamName = json['teamName']?.toString() ?? '';
    final nome = teamName.trim().isNotEmpty ? teamName.trim() : 'Equipe Desconhecida';
    final nacionalidade = json['teamNationality']?.toString().trim() ?? '';

    return Equipe(
      teamId: json['teamId']?.toString() ?? '',
      nome: nome,
      cor: nacionalidade.isNotEmpty ? nacionalidade : 'N/A',
      corEquipe: teamColor(nome),
      posicao: 0,
      pontos: 0,
      pilotos: const [],
      imagemCarro: teamLogo(nome),
    );
  }

  Equipe copyWith({
    int? posicao,
    double? pontos,
    List<String>? pilotos,
  }) {
    return Equipe(
      teamId: teamId,
      nome: nome,
      cor: cor,
      corEquipe: corEquipe,
      posicao: posicao ?? this.posicao,
      pontos: pontos ?? this.pontos,
      pilotos: pilotos ?? this.pilotos,
      imagemCarro: imagemCarro,
    );
  }

  static String getFlag(String country) {
    switch (country.toLowerCase()) {
      case 'germany': return '🇩🇪';
      case 'italy': return '🇮🇹';
      case 'austria': return '🇦🇹';
      case 'great britain':
      case 'uk': return '🇬🇧';
      case 'france': return '🇫🇷';
      case 'united states':
      case 'usa': return '🇺🇸';
      case 'switzerland': return '🇨🇭';
      default: return '🏳️';
    }
  }
}
