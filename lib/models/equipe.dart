import 'package:flutter/material.dart';

class TeamModel {
  String? teamId;
  String? teamName;
  String? teamNationality;
  int? firstAppeareance;
  int? constructorsChampionships;
  int? driversChampionships;
  String? logo;

  TeamModel({
    this.teamId,
    this.teamName,
    this.teamNationality,
    this.firstAppeareance,
    this.constructorsChampionships,
    this.driversChampionships,
    this.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final teamName = json['teamName'] as String? ?? '';
    return TeamModel(
      teamId: json['teamId'] as String?,
      teamName: teamName,
      teamNationality: json['teamNationality'] as String?,
      firstAppeareance: json['firstAppeareance'] as int?,
      constructorsChampionships: json['constructorsChampionships'] as int?,
      driversChampionships: json['driversChampionships'] as int?,
      logo: _generateTeamLogo(teamName),
    );
  }

  static String _generateTeamLogo(String teamName) {
    final nomeLower = teamName.toLowerCase();
    
    String nomeOficial = 'mercedes'; // fallback genérico
    if (nomeLower.contains('mercedes')) nomeOficial = 'mercedes';
    else if (nomeLower.contains('ferrari')) nomeOficial = 'ferrari';
    else if (nomeLower.contains('red bull') || nomeLower.contains('redbull')) nomeOficial = 'red-bull-racing';
    else if (nomeLower.contains('mclaren')) nomeOficial = 'mclaren';
    else if (nomeLower.contains('aston martin')) nomeOficial = 'aston-martin';
    else if (nomeLower.contains('alpine')) nomeOficial = 'alpine';
    else if (nomeLower.contains('haas')) nomeOficial = 'haas-f1-team';
    else if (nomeLower.contains('williams')) nomeOficial = 'williams';
    else if (nomeLower.contains('sauber') || nomeLower.contains('alfa') || nomeLower.contains('audi')) nomeOficial = 'alfa-romeo';
    else if (nomeLower.contains('rb') || nomeLower.contains('racing bulls') || nomeLower.contains('alphatauri')) nomeOficial = 'alphatauri';
    else if (nomeLower.contains('cadillac')) nomeOficial = 'haas-f1-team';

    final url = 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677245030/content/dam/fom-website/teams/2023/$nomeOficial.png';
    debugPrint('URL Carro [$teamName]: $url');
    return url;
  }
}

class Equipe {
  final String nome;
  final String cor;
  final Color corEquipe;
  final String motor;
  final int posicao;
  final double pontos;
  final List<String> pilotos;
  final String imagemCarro;

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

  factory Equipe.fromTeamModel(
    TeamModel team, {
    int posicao = 0,
    double pontos = 0.0,
    List<String>? pilotos,
  }) {
    final nome = team.teamName?.trim().isNotEmpty == true
        ? team.teamName!.trim()
        : 'Equipe Desconhecida';
    final cor = team.teamNationality?.trim().isNotEmpty == true
        ? team.teamNationality!.trim()
        : 'N/A';
    final corEquipe = _defaultTeamColor(nome);
    final imagemCarro = team.logo ?? _defaultTeamLogo(nome);
    final motor = 'N/A';

    return Equipe(
      nome: nome,
      cor: cor,
      corEquipe: corEquipe,
      motor: motor,
      posicao: posicao,
      pontos: pontos,
      pilotos: pilotos ?? [],
      imagemCarro: imagemCarro,
    );
  }

  static Color _defaultTeamColor(String teamName) {
    final nomeLower = teamName.toLowerCase();

    if (nomeLower.contains('mercedes')) return const Color(0xFF00A19C);
    if (nomeLower.contains('ferrari')) return const Color(0xFF9B0000);
    if (nomeLower.contains('red bull') || nomeLower.contains('redbull'))
      return const Color(0xFF1A1AFF);
    if (nomeLower.contains('mclaren')) return const Color(0xFFB86A00);
    if (nomeLower.contains('aston martin')) return const Color(0xFF005F3F);
    if (nomeLower.contains('alpine')) return const Color(0xFF0090FF);
    if (nomeLower.contains('haas')) return const Color(0xFFFFFFFF);
    if (nomeLower.contains('williams')) return const Color(0xFF005AFF);
    if (nomeLower.contains('sauber') || nomeLower.contains('alfa'))
      return const Color(0xFF8B0000);
    if (nomeLower.contains('rb') || nomeLower.contains('racing bulls'))
      return const Color(0xFF1A1AFF);

    return const Color(0xFFE8002D);
  }

  static String _defaultTeamLogo(String teamName) {
    return TeamModel._generateTeamLogo(teamName);
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
