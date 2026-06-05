import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/piloto.dart';
import '../models/equipe.dart';

class F1ApiService {
  final Dio dio;
  final String openF1BaseUrl = "https://api.openf1.org/v1";
  final String legacyBaseUrl = "https://f1api.dev/api";

  F1ApiService(this.dio);

  Future<List<Piloto>> getDrivers() async {
    try {
      final openF1Response = await dio.get(
        "$openF1BaseUrl/drivers",
        queryParameters: {'session_key': 'latest'},
      );
      final legacyResponse =
          await dio.get("$legacyBaseUrl/current/drivers-championship");

      final List<dynamic> openF1Drivers = openF1Response.data as List<dynamic>;
      final List<dynamic> legacyDrivers =
          legacyResponse.data['drivers_championship'] as List<dynamic>;

      final legacyMap = <int, Map<String, dynamic>>{};
      for (final driver in legacyDrivers) {
        final driverData = driver['driver'] as Map<String, dynamic>?;
        if (driverData != null) {
          final number = (driverData['number'] as num?)?.toInt();
          if (number != null) {
            legacyMap[number] = driver as Map<String, dynamic>;
          }
        }
      }

      final drivers = <Piloto>[];
      for (final d in openF1Drivers) {
        final open = d as Map<String, dynamic>;
        final numero = (open['driver_number'] as num?)?.toInt() ?? 0;
        final firstName = (open['first_name'] as String?)?.trim() ?? '';
        final lastName = (open['last_name'] as String?)?.trim() ?? '';
        final fullName = (open['full_name'] as String?)?.trim() ??
            ('$firstName $lastName'.trim());
        final equipe = (open['team_name'] as String?)?.trim() ?? '';
        final country = (open['country_code'] as String?)?.trim() ?? '';
        final standings = numero > 0 ? legacyMap[numero] : null;

        final image = _buildImageUrl(open, firstName, lastName);
        final color = _parseTeamColor(open['team_colour'] as String?) ??
            _defaultTeamColor(equipe);

        drivers.add(Piloto(
          nome: fullName,
          equipe: equipe,
          numero: numero,
          nacionalidade: country,
          imagem: image,
          corEquipe: color,
          posicao: (standings?['position'] as num?)?.toInt() ?? 0,
          pontos: ((standings?['points'] as num?)?.toInt() ?? 0),
          podios: (standings?['wins'] as num?)?.toInt() ?? 0,
        ));
      }

      drivers.sort((a, b) {
        if (a.posicao != b.posicao) return a.posicao.compareTo(b.posicao);
        return a.numero.compareTo(b.numero);
      });

      if (kDebugMode) {
        debugPrint('=== FINAL DRIVERS LIST ===');
        for (final driver in drivers) {
          debugPrint(
              '${driver.numero} | ${driver.nome} | ${driver.equipe} | Pos: ${driver.posicao} | Pts: ${driver.pontos} | Podios: ${driver.podios}');
        }
      }

      return drivers;
    } catch (e) {
      debugPrint('Erro na busca dos pilotos: $e');
      return [];
    }
  }

  Future<List<Equipe>> getTeams() async {
    try {
      final response = await dio.get('$legacyBaseUrl/current/teams');
      final List<dynamic> lista = response.data['teams'] as List<dynamic>;

      final teams = lista.map((t) {
        final team = t as Map<String, dynamic>;
        final name = team['teamName'] as String? ?? team['name'] as String? ?? '';
        final nationality = team['teamNationality'] as String? ?? '';
        final constructors = (team['constructorsChampionships'] as num?)?.toInt() ?? 0;
        return Equipe(
          nome: name,
          cor: '#000000',
          corEquipe: _defaultTeamColor(name),
          motor: nationality,
          posicao: 0,
          pontos: 0,
          pilotos: [],
          imagemCarro: _generateTeamLogo(name),
        );
      }).toList();

      return teams;
    } catch (e) {
      debugPrint('Erro na busca das equipes: $e');
      return [];
    }
  }

  static String _buildImageUrl(Map<String, dynamic>? openF1, String firstName, String lastName) {
    final headshotUrl = openF1?['headshot_url'] as String?;
    if (headshotUrl != null && headshotUrl.isNotEmpty) {
      final contentMatch = RegExp(r'/content/dam/.*?\.png').firstMatch(headshotUrl);
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

  static String _alphaOnly(String value) => value.replaceAll(RegExp(r'[^A-Za-z]'), '');

  static String _slug(String value) => value.trim().replaceAll(RegExp(r'[^A-Za-z0-9 ]'), '').replaceAll(' ', '_');

  static String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  static Color? _parseTeamColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    final sanitized = colorString.replaceAll('#', '').trim();
    if (sanitized.length == 6) return Color(int.parse('FF$sanitized', radix: 16));
    if (sanitized.length == 8) return Color(int.parse(sanitized, radix: 16));
    return null;
  }

  static Color _defaultTeamColor(String teamName) {
    final id = teamName.trim().toLowerCase();
    switch (id) {
      case 'mercedes':
        return Color(0xFF00D2BE);
      case 'ferrari':
        return Color(0xFFDC0000);
      case 'red bull racing':
      case 'redbull':
      case 'red_bull':
        return Color(0xFF1E41FF);
      case 'mclaren':
        return Color(0xFFFF8700);
      case 'alpine':
        return Color(0xFF0090FF);
      case 'alfa romeo':
      case 'alfaromeo':
        return Color(0xFF8B0000);
      case 'aston martin':
        return Color(0xFF0B6A48);
      default:
        return Color(0xFFE8002D);
    }
  }

  static String _generateTeamLogo(String teamName) {
    final normalized = teamName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    final logoMap = {
      'mercedes': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Mercedes.png',
      'ferrari': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Ferrari.png',
      'redbullracing': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Red_Bull.png',
      'redbluracing': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Red_Bull.png',
      'mclaren': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/McLaren.png',
      'alpine': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Alpine.png',
      'astonmartin': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Aston_Martin.png',
      'alfaromeo': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Alfa.png',
      'haas': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Haas.png',
      'williams': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Williams.png',
      'kicksauber': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Kick_Sauber.png',
    };
    return logoMap[normalized] ?? 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Mercedes.png';
  }
}
