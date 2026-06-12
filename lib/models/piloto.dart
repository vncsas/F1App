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
    final dadosEquipe = json['team'] as Map<String, dynamic>? ?? const {};
    var primeiroNome = dadosPiloto['name'].toString();
    var sobrenome = dadosPiloto['surname'].toString();
    var nomeEquipe = dadosEquipe['teamName']?.toString() ?? '';

    if (primeiroNome.toLowerCase() == 'andrea' && sobrenome.toLowerCase().contains('antonelli')) {
      primeiroNome = 'Kimi';
      sobrenome = 'Antonelli';
    }

    if (sobrenome.toLowerCase().contains('pérez')) {
      primeiroNome = 'Sergio';
      sobrenome = 'Perez';
    }

    return Piloto(
      driverId: json['driverId']?.toString() ?? '',
      teamId: dadosEquipe['teamId']?.toString() ?? '',
      nome: '$primeiroNome $sobrenome'.trim(),
      equipe: nomeEquipe,
      nacionalidade: dadosPiloto['nationality']?.toString() ?? '',
      numero: int.tryParse(dadosPiloto['number']?.toString() ?? '') ?? 0,
      posicao: int.tryParse(json['position']?.toString() ?? '') ?? 0,
      pontos: double.tryParse(json['points']?.toString() ?? '') ?? 0.0,
      vitorias: int.tryParse(json['wins']?.toString() ?? '') ?? 0,
      imagem: _montarUrlFoto(primeiroNome, sobrenome),
      corEquipe: corDaEquipe(dadosEquipe['teamName']?.toString() ?? ''),
      logoEquipe: carroDaEquipe(dadosEquipe['teamName']?.toString() ?? ''),
    );
  }

  static String _montarUrlFoto(String primeiroNome, String sobrenome) {

    if (primeiroNome.toLowerCase() == 'kimi' && sobrenome.toLowerCase() == 'antonelli') {
      return 'https://www.formulaonehistory.com/wp-content/uploads/2025/12/Kimi-Antonelli-F1-2026.webp';
    }

    if (primeiroNome.toLowerCase() == 'arvid' && sobrenome.toLowerCase() == 'lindblad') {
      return 'https://www.formulaonehistory.com/wp-content/uploads/2025/12/Arvid-Lindblad-F1-2026.webp';
    }

    if (primeiroNome.toLowerCase() == 'alex' && sobrenome.toLowerCase() == 'albon') {
      return 'https://media.formula1.com/image/upload/f_auto,c_limit,q_75,w_auto/content/dam/fom-website/2018-redesign-assets/drivers/2023/alealb01.png';
    }

    final codigoPiloto = _gerarCodigoPiloto(primeiroNome, sobrenome);
    final nomeSlug = _primeiraLetraMaiuscula(
      primeiroNome.replaceAll(' ', '_'),
    );
    final sobrenomeSlug = _primeiraLetraMaiuscula(
      sobrenome.replaceAll(' ', '_'),
    );

    final inicial = primeiroNome[0].toUpperCase();
    final pasta = '${codigoPiloto}_${nomeSlug}_${sobrenomeSlug}';

    return 'https://media.formula1.com/image/upload/f_auto/q_auto/v1677244985/content/dam/fom-website/drivers/$inicial/$pasta/${codigoPiloto.toLowerCase()}.png';
  }

  static String _gerarCodigoPiloto(String primeiroNome, String sobrenome) {
    return '${primeiroNome.substring(0, 3).toUpperCase()}${sobrenome.substring(0, 3).toUpperCase()}01';
  }

  static String _primeiraLetraMaiuscula(String texto) {
    return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
  }
}
