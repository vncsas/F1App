import 'package:flutter/material.dart';
import 'equipe.dart';

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
    final driverData = json['driver'] as Map<String, dynamic>? ?? const {};
    var firstName = driverData['name']?.toString() ?? '';
    var lastName = driverData['surname']?.toString() ?? '';

    if (firstName.toLowerCase() == 'andrea' && lastName.toLowerCase().contains('antonelli')) {
      firstName = 'Kimi';
      lastName = 'Antonelli';
    }

    var equipeNome = 'Desconhecida';
    var teamIdValue = '';
    final team = json['team'];
    if (team is Map<String, dynamic>) {
      equipeNome = (team['teamName'] ?? team['teamId'] ?? 'Desconhecida').toString();
      teamIdValue = team['teamId']?.toString() ?? _slug(equipeNome);
    } else if (team != null) {
      equipeNome = team.toString();
      teamIdValue = _slug(equipeNome);
    } else if (json['teamId'] != null) {
      equipeNome = json['teamId'].toString();
      teamIdValue = equipeNome;
    }

    return Piloto(
      driverId: json['driverId']?.toString() ?? '',
      teamId: teamIdValue,
      nome: '$firstName $lastName'.trim(),
      equipe: equipeNome,
      nacionalidade: driverData['nationality']?.toString() ?? 'Desconhecida',
      numero: int.tryParse(driverData['number']?.toString() ?? '') ?? 0,
      posicao: int.tryParse(json['position']?.toString() ?? '') ?? 0,
      pontos: double.tryParse(json['points']?.toString() ?? '') ?? 0.0,
      vitorias: int.tryParse(json['wins']?.toString() ?? '') ?? 0,
      imagem: _buildImageUrl(firstName, lastName),
      corEquipe: teamColor(equipeNome),
      logoEquipe: teamLogo(equipeNome),
    );
  }

  static String _slug(String raw) => raw.trim().toLowerCase().replaceAll(' ', '-');

  static String _buildImageUrl(String firstName, String lastName) {
    if (firstName.isEmpty || lastName.isEmpty) return '';

    if (firstName.toLowerCase() == 'kimi' && lastName.toLowerCase() == 'antonelli') {
      return 'https://img2.51gt3.com/rac/racer/202503/bcca7f61b6684e26bb28aedaf8d97c53.png';
    }

    final cleanFirst = _removeDiacritics(firstName);
    final cleanLast = _removeDiacritics(lastName);

    final firstAlpha = cleanFirst.replaceAll(RegExp(r'[^A-Za-z]'), '').padRight(3, 'X');
    final lastAlpha = cleanLast.replaceAll(RegExp(r'[^A-Za-z]'), '').padRight(3, 'X');
    final codigo = '${firstAlpha.substring(0, 3).toUpperCase()}${lastAlpha.substring(0, 3).toUpperCase()}01';

    final firstSlug = cleanFirst.trim().replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').replaceAll(' ', '_');
    final lastSlug = cleanLast.trim().replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').replaceAll(' ', '_');

    final inicial = firstSlug.isNotEmpty ? firstSlug[0].toUpperCase() : 'X';
    final pasta = '${codigo}_${_capitalize(firstSlug)}_${_capitalize(lastSlug)}';

    return 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677244985/content/dam/fom-website/drivers/$inicial/$pasta/${codigo.toLowerCase()}.png';
  }

  static String _removeDiacritics(String text) {
    const withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (var i = 0; i < withDia.length; i++) {
      text = text.replaceAll(withDia[i], withoutDia[i]);
    }
    return text;
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
