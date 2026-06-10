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
    this.vencedor = '',
    this.equipeVencedora = '',
    required this.bandeira,
    this.realizada = false,
    this.voltaMaisRapida = '-',
    this.pilotoVoltaMaisRapida = '-',
  });

  factory Corrida.fromJson(Map<String, dynamic> json) {
    final dadosCircuito  = json['circuit']  as Map<String, dynamic>? ?? {};
    final dadosCorrida   = json['schedule'] as Map<String, dynamic>? ?? {};
    final dadosRace      = dadosCorrida['race'] as Map<String, dynamic>? ?? {};
    final dadosVencedor  = json['winner']     as Map<String, dynamic>?;
    final dadosEquipe    = json['teamWinner'] as Map<String, dynamic>?;
    final dadosVoltaRapida = json['fast_lap'] as Map<String, dynamic>? ?? {};

    final nomePais = dadosCircuito['country']?.toString() ?? 'Desconhecido';

    String data = 'A Confirmar';
    final dataRaw = dadosRace['date']?.toString();
    if (dataRaw != null) {
      final partes = dataRaw.split('-');
      if (partes.length == 3) {
        data = '${partes[2]} ${_nomeDoMes(partes[1])} ${partes[0]}';
      }
    }

    final foiRealizada = dadosVencedor != null && dadosVencedor.isNotEmpty;
    final nomeVencedor = foiRealizada ? '${dadosVencedor!['name']} ${dadosVencedor['surname']}' : '';
    final nomeEquipe = dadosEquipe?['teamName']?.toString() ?? '';

    final idPilotoVolta = dadosVoltaRapida['fast_lap_driver_id']?.toString() ?? '';
    final nomePilotoVolta = idPilotoVolta.isNotEmpty ? idPilotoVolta.split('_').last.toUpperCase() : '-';

    return Corrida(
      raceId: json['raceId']?.toString() ?? '',
      nomePais: nomePais,
      nomeGP: json['raceName']?.toString() ?? 'GP Desconhecido',
      circuito: dadosCircuito['circuitName']?.toString() ?? 'Circuito Desconhecido',
      data: data,
      vencedor: nomeVencedor,
      equipeVencedora: nomeEquipe,
      bandeira: _bandeiraDoPais(nomePais),
      realizada: foiRealizada,
      voltaMaisRapida: dadosVoltaRapida['fast_lap']?.toString() ?? '-',
      pilotoVoltaMaisRapida: nomePilotoVolta,
    );
  }

  static String _nomeDoMes(String mes) {
    switch (mes) {
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

  static String _bandeiraDoPais(String pais) {
    switch (pais.toLowerCase()) {
      case 'australia': return '🇦🇺';
      case 'china': return '🇨🇳';
      case 'japan': return '🇯🇵';
      case 'bahrain': return '🇧🇭';
      case 'saudi arabia': return '🇸🇦';
      case 'usa': case 'united states': return '🇺🇸';
      case 'italy': return '🇮🇹';
      case 'monaco': return '🇲🇨';
      case 'spain': return '🇪🇸';
      case 'canada': return '🇨🇦';
      case 'austria': return '🇦🇹';
      case 'great britain': case 'uk': return '🇬🇧';
      case 'hungary': return '🇭🇺';
      case 'belgium': return '🇧🇪';
      case 'netherlands': return '🇳🇱';
      case 'singapore': return '🇸🇬';
      case 'azerbaijan': return '🇦🇿';
      case 'mexico': return '🇲🇽';
      case 'brazil': return '🇧🇷';
      case 'qatar': return '🇶🇦';
      case 'uae': case 'abu dhabi': return '🇦🇪';
      default: return '🏳️';
    }
  }
}