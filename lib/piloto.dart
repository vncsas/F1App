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
  final int podios;
  final String imagem;
  final Color corEquipe;

  Piloto({
    required this.driverId,
    required this.teamId,
    required this.nome,
    required this.equipe,
    required this.nacionalidade,
    required this.numero,
    required this.posicao,
    required this.pontos,
    required this.podios,
    required this.imagem,
    required this.corEquipe,
  });

  factory Piloto.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('driver') && json['driver'] is Map<String, dynamic>) {
      return Piloto._fromLegacyJson(json);
    }
    return Piloto.fromOpenF1(json);
  }

  factory Piloto._fromLegacyJson(Map<String, dynamic> json) {
    final driverData = json['driver'] as Map<String, dynamic>;
    final firstName = (driverData['name'] as String?)?.trim() ?? '';
    final lastName = (driverData['surname'] as String?)?.trim() ?? '';
    final fullName = '$firstName $lastName'.trim();
    final equipe = json['team'] as String? ?? json['teamId'] as String? ?? '';
    final teamId = _normalizeTeamId(equipe);
    final imagem = _buildImageUrl(null, firstName, lastName);
    final colorString = json['teamColor'] as String?;

    return Piloto(
      driverId: json['driverId'] as String? ?? '',
      teamId: teamId,
      nome: fullName,
      equipe: equipe,
      nacionalidade: (driverData['nationality'] as String?)?.trim() ?? '',
      numero: (driverData['number'] as num?)?.toInt() ?? 0,
      posicao: (json['position'] as num?)?.toInt() ?? 0,
      pontos: (json['points'] as num?)?.toDouble() ?? 0.0,
      podios: (json['wins'] as num?)?.toInt() ?? 0,
      imagem: imagem,
      corEquipe: _parseTeamColor(colorString) ?? _defaultTeamColor(teamId),
    );
  }

  factory Piloto.fromOpenF1(
    Map<String, dynamic> json, {
    Map<String, dynamic>? standings,
  }) {
    final firstName = (json['first_name'] as String?)?.trim() ?? '';
    final lastName = (json['last_name'] as String?)?.trim() ?? '';
    final fullName = (json['full_name'] as String?)?.trim() ??
        '$firstName $lastName'.trim();
    final equipe = (json['team_name'] as String?)?.trim() ?? '';
    final teamId = _normalizeTeamId(equipe);
    final numero = (json['driver_number'] as num?)?.toInt() ?? 0;
    final imagem = _buildImageUrl(json, firstName, lastName);
    final corEquipe = _parseTeamColor(json['team_colour'] as String?) ??
        _defaultTeamColor(teamId);

    return Piloto(
      driverId: json['driver_number']?.toString() ??
          (json['name_acronym'] as String?)?.trim() ??
          fullName,
      teamId: teamId,
      nome: fullName,
      equipe: equipe,
      nacionalidade: (json['country_code'] as String?)?.trim() ?? '',
      numero: numero,
      posicao: (standings?['position'] as num?)?.toInt() ?? 0,
      pontos: (standings?['points'] as num?)?.toDouble() ?? 0.0,
      podios: (standings?['wins'] as num?)?.toInt() ?? 0,
      imagem: imagem,
      corEquipe: corEquipe,
    );
  }

  static String _normalizeTeamId(String raw) {
    return raw.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
  }

  static String _buildImageUrl(
    Map<String, dynamic>? openF1,
    String firstName,
    String lastName,
  ) {
    final headshotUrl = openF1?['headshot_url'] as String?;
    if (headshotUrl != null && headshotUrl.isNotEmpty) {
      final contentMatch = RegExp(r'/content/dam/.*?\.png')
          .firstMatch(headshotUrl);
      if (contentMatch != null) {
        return 'https://media.formula1.com${contentMatch.group(0)}';
      }
    }

    final first = _slug(firstName);
    final last = _slug(lastName);
    final prefix = _imageCode(firstName, lastName);
    final folder = '${prefix}_${_capitalize(first)}_${_capitalize(last)}';
    final lastInitial = last.isNotEmpty ? last[0].toUpperCase() : 'X';

    return 'https://media.formula1.com/content/dam/fom-website/drivers/$lastInitial/$folder/${prefix.toLowerCase()}.png';
  }

  static String _imageCode(String firstName, String lastName) {
    final first = _alphaOnly(firstName).padRight(3, 'X');
    final last = _alphaOnly(lastName).padRight(3, 'X');
    return '${first.substring(0, 3).toUpperCase()}${last.substring(0, 3).toUpperCase()}01';
  }

  static String _alphaOnly(String value) {
    return value.replaceAll(RegExp(r'[^A-Za-z]'), '');
  }

  static String _slug(String value) {
    return value
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '')
        .replaceAll(' ', '_');
  }

  static String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  static Color? _parseTeamColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    final sanitized = colorString.replaceAll('#', '').trim();
    if (sanitized.length == 6) {
      return Color(int.parse('FF$sanitized', radix: 16));
    }
    if (sanitized.length == 8) {
      return Color(int.parse(sanitized, radix: 16));
    }
    return null;
  }

  static Color _defaultTeamColor(String teamId) {
    switch (teamId.toLowerCase()) {
      case 'mercedes':
        return Color(0xFF00D2BE);
      case 'ferrari':
        return Color(0xFFDC0000);
      case 'red_bull':
      case 'redbull':
      case 'red bull racing':
        return Color(0xFF1E41FF);
      case 'mclaren':
        return Color(0xFFFF8700);
      case 'alpine':
        return Color(0xFF0090FF);
      case 'alfa':
      case 'alfa_romeo':
      case 'alfa romeo':
        return Color(0xFF8B0000);
      case 'aston_martin':
      case 'aston martin':
        return Color(0xFF0B6A48);
      default:
        return Color(0xFFE8002D);
    }
  }
}
