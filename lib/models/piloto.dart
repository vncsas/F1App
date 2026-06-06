import 'package:flutter/material.dart';

class Piloto {
  final String driverId;
  final String teamId;
  final String nome;
  final String equipe;
  final String nacionalidade;
  final int numero;
  final int posicao;
  final double pontos;
  final int vitorias;
  final String imagem;
  final Color corEquipe;
  final String logoEquipe;

  Piloto({
    required this.driverId,
    required this.teamId,
    required this.nome,
    required this.equipe,
    required this.nacionalidade,
    required this.numero,
    required this.posicao,
    required this.pontos,
    required this.vitorias,
    required this.imagem,
    required this.corEquipe,
    required this.logoEquipe,
  });

  factory Piloto.fromJson(Map<String, dynamic> json) {
    final driverData = json['driver'] as Map<String, dynamic>? ?? {};
    String firstName = driverData['name']?.toString() ?? '';
    String lastName = driverData['surname']?.toString() ?? '';

    // Tratamento específico para o Antonelli
    if (firstName.toLowerCase() == 'andrea' && lastName.toLowerCase().contains('antonelli')) {
      firstName = 'Kimi';
      lastName = 'Antonelli';
    }

    String equipeNome = 'Desconhecida';
    if (json['team'] is Map<String, dynamic>) {
      equipeNome = json['team']['teamName']?.toString() ?? json['team']['teamId']?.toString() ?? 'Desconhecida';
    } else if (json['team'] != null) {
      equipeNome = json['team'].toString();
    } else if (json['teamId'] != null) {
      equipeNome = json['teamId'].toString();
    }

    return Piloto(
      driverId: json['driverId']?.toString() ?? '',
      teamId: _formatTeamId(equipeNome),
      nome: '$firstName $lastName'.trim(),
      equipe: equipeNome,
      nacionalidade: driverData['nationality']?.toString() ?? 'Desconhecida',
      numero: int.tryParse(driverData['number']?.toString() ?? '0') ?? 0,
      posicao: int.tryParse(json['position']?.toString() ?? '0') ?? 0,
      pontos: double.tryParse(json['points']?.toString() ?? '0') ?? 0.0,
      vitorias: int.tryParse(json['wins']?.toString() ?? '0') ?? 0,
      imagem: _buildImageUrl(firstName, lastName),
      corEquipe: _getTeamColor(equipeNome),
      logoEquipe: _getLogoEquipe(equipeNome),
    );
  }

  static String _formatTeamId(String rawName) {
    return rawName.trim().toLowerCase().replaceAll(' ', '-');
  }

  static String _getLogoEquipe(String teamName) {
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

    return 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677245030/content/dam/fom-website/teams/2023/$nomeOficial.png';
  }
  static Color _getTeamColor(String teamName) {
    final nomeLower = teamName.toLowerCase();
    
    if (nomeLower.contains('mercedes')) return const Color(0xFF00A19C);
    if (nomeLower.contains('ferrari')) return const Color(0xFF9B0000);
    if (nomeLower.contains('red bull') || nomeLower.contains('redbull')) return const Color(0xFF1A1AFF);
    if (nomeLower.contains('mclaren')) return const Color(0xFFB86A00);
    if (nomeLower.contains('aston martin')) return const Color(0xFF005F3F);
    if (nomeLower.contains('alpine')) return const Color(0xFF0090FF);
    if (nomeLower.contains('haas')) return const Color(0xFFFFFFFF);
    if (nomeLower.contains('williams')) return const Color(0xFF005AFF);
    if (nomeLower.contains('sauber') || nomeLower.contains('alfa')) return const Color(0xFF8B0000);
    if (nomeLower.contains('rb') || nomeLower.contains('racing bulls')) return const Color(0xFF1A1AFF);

    return const Color(0xFFE8002D);
  }

    static String _buildImageUrl(String firstName, String lastName) {
    if (firstName.isEmpty || lastName.isEmpty) return '';

    if (firstName.toLowerCase() == 'kimi' && lastName.toLowerCase() == 'antonelli') {
      final url = 'https://img2.51gt3.com/rac/racer/202503/bcca7f61b6684e26bb28aedaf8d97c53.png';
      debugPrint('URL Imagem [$firstName $lastName]: $url');
      return url;
    }

    final cleanFirst = _removeDiacritics(firstName);
    final cleanLast = _removeDiacritics(lastName);

    // Remove espaços e acentos e pega as 3 primeiras letras (ex: MAX, VER)
    final firstAlpha = cleanFirst.replaceAll(RegExp(r'[^A-Za-z]'), '').padRight(3, 'X');
    final lastAlpha = cleanLast.replaceAll(RegExp(r'[^A-Za-z]'), '').padRight(3, 'X');
    final codigo = '${firstAlpha.substring(0, 3).toUpperCase()}${lastAlpha.substring(0, 3).toUpperCase()}01';

    // Slugs para as pastas (ex: Max, Verstappen)
    final firstSlug = cleanFirst.trim().replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').replaceAll(' ', '_');
    final lastSlug = cleanLast.trim().replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').replaceAll(' ', '_');
    
    // Agora pega a primeira letra do PRIMEIRO NOME (ex: M)
    final inicial = firstSlug.isNotEmpty ? firstSlug[0].toUpperCase() : 'X';
    final pasta = '${codigo}_${_capitalize(firstSlug)}_${_capitalize(lastSlug)}';

    // Retorna a URL perfeitamente formatada
    final url = 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677244985/content/dam/fom-website/drivers/$inicial/$pasta/${codigo.toLowerCase()}.png';
    debugPrint('URL Imagem [$firstName $lastName]: $url');
    return url;
  }

  static String _removeDiacritics(String text) {
    const withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < withDia.length; i++) {
      text = text.replaceAll(withDia[i], withoutDia[i]);
    }
    return text;
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}