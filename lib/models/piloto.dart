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
    final dadosPiloto = json['driver'] as Map<String, dynamic>? ?? const {};
    var primeiroNome = dadosPiloto['name']?.toString() ?? '';
    var sobrenome = dadosPiloto['surname']?.toString() ?? '';

    if (primeiroNome.toLowerCase() == 'andrea' &&
        sobrenome.toLowerCase().contains('antonelli')) {
      primeiroNome = 'Kimi';
      sobrenome = 'Antonelli';
    }

    if (sobrenome.toLowerCase().contains('pérez') ||
        sobrenome.toLowerCase().contains('perez')) {
      primeiroNome = 'Sergio';
      sobrenome = 'Perez';
    }

    var nomeEquipe = 'Desconhecida';
    var idEquipe = '';
    final dadosEquipe = json['team'];

    if (dadosEquipe is Map<String, dynamic>) {
      nomeEquipe =
          (dadosEquipe['teamName'] ?? dadosEquipe['teamId'] ?? 'Desconhecida')
              .toString();
      idEquipe = dadosEquipe['teamId']?.toString() ?? _gerarSlug(nomeEquipe);
    } else if (dadosEquipe != null) {
      nomeEquipe = dadosEquipe.toString();
      idEquipe = _gerarSlug(nomeEquipe);
    } else if (json['teamId'] != null) {
      nomeEquipe = json['teamId'].toString();
      idEquipe = nomeEquipe;
    }

    return Piloto(
      driverId: json['driverId']?.toString() ?? '',
      teamId: idEquipe,
      nome: '$primeiroNome $sobrenome'.trim(),
      equipe: nomeEquipe,
      nacionalidade: dadosPiloto['nationality']?.toString() ?? 'Desconhecida',
      numero: int.tryParse(dadosPiloto['number']?.toString() ?? '') ?? 0,
      posicao: int.tryParse(json['position']?.toString() ?? '') ?? 0,
      pontos: double.tryParse(json['points']?.toString() ?? '') ?? 0.0,
      vitorias: int.tryParse(json['wins']?.toString() ?? '') ?? 0,
      imagem: _montarUrlFoto(primeiroNome, sobrenome),
      corEquipe: corDaEquipe(nomeEquipe),
      logoEquipe: carroDaEquipe(nomeEquipe),
    );
  }

  static String _gerarSlug(String texto) =>
      texto.trim().toLowerCase().replaceAll(' ', '-');

  static String _montarUrlFoto(String primeiroNome, String sobrenome) {
    if (primeiroNome.isEmpty || sobrenome.isEmpty) return '';

    if (primeiroNome.toLowerCase() == 'kimi' &&
        sobrenome.toLowerCase() == 'antonelli') {
      return 'https://www.formulaonehistory.com/wp-content/uploads/2025/12/Kimi-Antonelli-F1-2026.webp';
    }

    if (primeiroNome.toLowerCase() == 'arvid' &&
        sobrenome.toLowerCase() == 'lindblad') {
      return 'https://www.formulaonehistory.com/wp-content/uploads/2025/12/Arvid-Lindblad-F1-2026.webp';
    }

    if (primeiroNome.toLowerCase() == 'alex' &&
        sobrenome.toLowerCase() == 'albon') {
      return 'https://media.formula1.com/image/upload/f_auto,c_limit,q_75,w_auto/content/dam/fom-website/2018-redesign-assets/drivers/2023/alealb01.png';
    }

    final codigoPiloto = _gerarCodigoPiloto(primeiroNome, sobrenome);

    final nomeSlug = _primeiraLetraMaiuscula(
      primeiroNome
          .replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '')
          .replaceAll(' ', '_'),
    );
    final sobrenomeSlug = _primeiraLetraMaiuscula(
      sobrenome.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').replaceAll(' ', '_'),
    );

    final inicial = primeiroNome.isNotEmpty
        ? primeiroNome[0].toUpperCase()
        : 'X';
    final pasta = '${codigoPiloto}_${nomeSlug}_${sobrenomeSlug}';

    return 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677244985/content/dam/fom-website/drivers/$inicial/$pasta/${codigoPiloto.toLowerCase()}.png';
  }

  static String _gerarCodigoPiloto(String primeiroNome, String sobrenome) {
    final parteNome = primeiroNome
        .replaceAll(RegExp(r'[^A-Za-z]'), '')
        .padRight(3, 'X');
    final parteSobrenome = sobrenome
        .replaceAll(RegExp(r'[^A-Za-z]'), '')
        .padRight(3, 'X');
    return '${parteNome.substring(0, 3).toUpperCase()}${parteSobrenome.substring(0, 3).toUpperCase()}01';
  }

  static String _primeiraLetraMaiuscula(String texto) {
    if (texto.isEmpty) return texto;
    return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
  }
}
