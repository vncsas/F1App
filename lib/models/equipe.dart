import 'package:flutter/material.dart';

const coresEquipes = {
  'mercedes': Color(0xFF00A19C),
  'ferrari': Color(0xFF9B0000),
  'red bull': Color(0xFF1A1AFF),
  'redbull': Color(0xFF1A1AFF),
  'mclaren': Color(0xFFB86A00),
  'aston martin': Color(0xFF005F3F),
  'alpine':Color(0xFF0090FF),
  'haas':Color(0xFFFFFFFF),
  'williams':Color(0xFF005AFF),
  'audi':Color.fromARGB(255, 54, 50, 50),
  'cadillac':Color.fromARGB(255, 0, 0, 0),
  'rb':Color(0xFF1A1AFF),
  'racing bulls':Color(0xFF1A1AFF),
};

const slugsEquipes = {
  'mercedes':'mercedes',
  'ferrari':'ferrari',
  'red bull':'red-bull-racing',
  'redbull':'red-bull-racing',
  'mclaren':'mclaren',
  'aston martin':'aston-martin',
  'alpine':'alpine',
  'haas':'haas-f1-team',
  'cadillac':'haas-f1-team',
  'williams':'williams',
  'sauber':'alfa-romeo',
  'audi':'alfa-romeo',
  'rb':'alphatauri',
  'racing bulls':'alphatauri',
  'alphatauri':'alphatauri',
};

Color corDaEquipe(String nomeEquipe) {
  final nome = nomeEquipe.toLowerCase();
  for (var chave in coresEquipes.keys) {
    if (nome.contains(chave)) return coresEquipes[chave]!;
  }
  return const Color.fromARGB(255, 48, 48, 48);
}

String carroDaEquipe(String nomeEquipe) {
  final nome = nomeEquipe.toLowerCase();
  var slug = 'carro';
  for (final chave in slugsEquipes.keys) {
    if (nome.contains(chave)) {
      slug = slugsEquipes[chave]!;
      break;
    }
  }
  return 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677245030/content/dam/fom-website/teams/2023/$slug.png';
}

class Equipe {
  final String teamId;
  final String nome;
  final String nacionalidade;
  final Color cor;
  final int posicao;
  final double pontos;
  final List<String> pilotos;
  final String urlCarro;

  Equipe({
    required this.teamId,
    required this.nome,
    required this.nacionalidade,
    required this.cor,
    required this.posicao,
    required this.pontos,
    required this.pilotos,
    required this.urlCarro,
  });

  factory Equipe.fromJson(Map<String, dynamic> json) {
    final nome = json['teamName'].toString();
    final nacionalidade = json['teamNationality'].toString();

    return Equipe(
      teamId: json['teamId'].toString(),
      nome: nome,
      nacionalidade: nacionalidade,
      cor: corDaEquipe(nome),
      posicao: 0,
      pontos: 0,
      pilotos: const [],
      urlCarro: carroDaEquipe(nome),
    );
  }

  Equipe copyWith({int? posicao,double? pontos,List<String>? pilotos,}) {
    return Equipe(
      teamId: teamId,
      nome: nome,
      nacionalidade: nacionalidade,
      cor: cor,
      posicao: posicao ?? this.posicao,
      pontos: pontos ?? this.pontos,
      pilotos: pilotos ?? this.pilotos,
      urlCarro: urlCarro,
    );
  }

  static String bandeiraDoPais(String pais) {
    switch (pais.toLowerCase()) {
      case 'germany': return '🇩🇪';
      case 'italy': return '🇮🇹';
      case 'austria': return '🇦🇹';
      case 'great britain': case 'uk': return '🇬🇧';
      case 'france': return '🇫🇷';
      case 'united states': case 'usa': return '🇺🇸';
      case 'switzerland': return '🇨🇭';
      default: return '🏳️';
    }
  }
}