class Corrida {
  final String raceId;
  final String nomePais;
  final String nomeGP;
  final String circuito;
  final String data;
  final String vencedor;
  final String equipeVencedora;
  final String bandeira;
  final bool realizada;
  final String voltaMaisRapida;
  final String pilotoVoltaMaisRapida;

  Corrida({
    required this.raceId,
    required this.nomePais,
    required this.nomeGP,
    required this.circuito,
    required this.data,
    required this.vencedor,
    required this.equipeVencedora,
    required this.bandeira,
    required this.realizada,
    required this.voltaMaisRapida,
    required this.pilotoVoltaMaisRapida,
  });

  factory Corrida.fromJson(Map<String, dynamic> json) {
    final circuitInfo = json['circuit'] as Map<String, dynamic>? ?? {};
    final scheduleInfo = json['schedule'] as Map<String, dynamic>? ?? {};
    final raceInfo = scheduleInfo['race'] as Map<String, dynamic>? ?? {};
    final winnerInfo = json['winner'] as Map<String, dynamic>?;
    final teamWinnerInfo = json['teamWinner'] as Map<String, dynamic>?;
    final fastLapInfo = json['fast_lap'] as Map<String, dynamic>? ?? {};

    String dataFormatada = 'A Confirmar';
    if (raceInfo['date'] != null) {
      final parts = raceInfo['date'].toString().split('-');
      if (parts.length == 3) {
        final day = parts[2];
        final monthStr = _getMonthName(parts[1]);
        final year = parts[0];
        dataFormatada = '$day $monthStr $year';
      }
    }

    final nomePais = circuitInfo['country']?.toString() ?? 'Desconhecido';
    
    String vencedorNome = '';
    String equipeVencedoraNome = '';
    bool realizada = false;
    
    if (winnerInfo != null && winnerInfo.isNotEmpty) {
      realizada = true;
      vencedorNome = '${winnerInfo['name']} ${winnerInfo['surname']}';
      equipeVencedoraNome = teamWinnerInfo?['teamName'] ?? '';
    }

    String voltaTempo = fastLapInfo['fast_lap']?.toString() ?? '-';
    String pilotoVoltaId = fastLapInfo['fast_lap_driver_id']?.toString() ?? '';
    String pilotoVoltaNome = pilotoVoltaId.split('_').last.toUpperCase();
    if (pilotoVoltaNome.isEmpty) pilotoVoltaNome = '-';

    return Corrida(
      raceId: json['raceId']?.toString() ?? '',
      nomePais: nomePais,
      nomeGP: json['raceName']?.toString() ?? 'GP Desconhecido',
      circuito: circuitInfo['circuitName']?.toString() ?? 'Circuito Desconhecido',
      data: dataFormatada,
      vencedor: vencedorNome,
      equipeVencedora: equipeVencedoraNome,
      bandeira: _getFlag(nomePais),
      realizada: realizada,
      voltaMaisRapida: voltaTempo,
      pilotoVoltaMaisRapida: pilotoVoltaNome,
    );
  }

  static String _getMonthName(String month) {
    switch (month) {
      case '01': return 'JAN';
      case '02': return 'FEV';
      case '03': return 'MAR';
      case '04': return 'ABR';
      case '05': return 'MAI';
      case '06': return 'JUN';
      case '07': return 'JUL';
      case '08': return 'AGO';
      case '09': return 'SET';
      case '10': return 'OUT';
      case '11': return 'NOV';
      case '12': return 'DEZ';
      default: return '';
    }
  }

  static String _getFlag(String country) {
    switch (country.toLowerCase()) {
      case 'australia': return '🇦🇺';
      case 'china': return '🇨🇳';
      case 'japan': return '🇯🇵';
      case 'bahrain': return '🇧🇭';
      case 'saudi arabia': return '🇸🇦';
      case 'usa':
      case 'united states': return '🇺🇸';
      case 'italy': return '🇮🇹';
      case 'monaco': return '🇲🇨';
      case 'spain': return '🇪🇸';
      case 'canada': return '🇨🇦';
      case 'austria': return '🇦🇹';
      case 'great britain':
      case 'uk': return '🇬🇧';
      case 'hungary': return '🇭🇺';
      case 'belgium': return '🇧🇪';
      case 'netherlands': return '🇳🇱';
      case 'singapore': return '🇸🇬';
      case 'azerbaijan': return '🇦🇿';
      case 'mexico': return '🇲🇽';
      case 'brazil': return '🇧🇷';
      case 'qatar': return '🇶🇦';
      case 'uae':
      case 'abu dhabi': return '🇦🇪';
      default: return '🏳️';
    }
  }
}

