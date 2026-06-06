import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/piloto.dart';
import '../models/corrida.dart';
import '../models/equipe.dart';

class F1ApiService {
  final Dio dio;
  final String legacyBaseUrl = "https://f1api.dev/api";

  F1ApiService(this.dio);

  Future<List<Piloto>> getDrivers() async {
    try {
      final legacyResponse =
          await dio.get("$legacyBaseUrl/current/drivers-championship");

      final List<dynamic> legacyDrivers =
          legacyResponse.data['drivers_championship'] as List<dynamic>;

      debugPrint("=== LEGACY DRIVERS MAP ===");
      final drivers = <Piloto>[];
      for (final driver in legacyDrivers) {
        final driverData = driver['driver'] as Map<String, dynamic>?;
        if (driverData != null) {
            drivers.add(Piloto.fromJson(driver as Map<String, dynamic>));
        }
      }

      drivers.sort((a, b) {
        if (a.posicao != b.posicao) {
          return a.posicao.compareTo(b.posicao);
        }
        return a.numero.compareTo(b.numero);
      });

      debugPrint("=== FINAL DRIVERS LIST ===");
      for (final driver in drivers) {
        debugPrint("${driver.numero} | ${driver.nome} | ${driver.equipe} | Pos: ${driver.posicao} | Pts: ${driver.pontos} | Wins: ${driver.vitorias}");
      }

      return drivers;
    } catch (e) {
      debugPrint("Erro na busca dos pilotos: $e");
      return [];
    }
  }

  Future<List<CircuitModel>> getCircuits() async {
    try {
      final response = await dio.get("$legacyBaseUrl/circuits");
      final List<dynamic> listaDeCircuitos = response.data['circuits'];

      return listaDeCircuitos
          .map((circuit) => CircuitModel.fromJson(circuit as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("Erro na busca dos circuitos: $e");
      return [];
    }
  }

  Future<List<Corrida>> getRaces() async {
    try {
      final response = await dio.get("$legacyBaseUrl/current");
      final List<dynamic> listaDeCorridas = response.data['races'] ?? [];

      return listaDeCorridas
          .map((corrida) => Corrida.fromJson(corrida as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("Erro na busca das corridas: $e");
      return [];
    }
  }

  Future<List<TeamModel>> getTeams() async {
    try {
      final response = await dio.get("$legacyBaseUrl/current/teams");
      final List<dynamic> listaDeEquipes = response.data['teams'];

      return listaDeEquipes
          .map((team) => TeamModel.fromJson(team as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("Erro na busca das equipes: $e");
      return [];
    }
  }
}

void main() async {
  final dio = Dio();
  final apiService = F1ApiService(dio);
  final drivers = await apiService.getDrivers();
  final circuits = await apiService.getCircuits();
  final teams = await apiService.getTeams();
  final races = await apiService.getRaces();

  debugPrint("Pilotos:");
  for (var driver in drivers) {
    debugPrint("- ${driver.nome} | ${driver.equipe} | #${driver.numero} | ${driver.pontos} pts");
  }
  debugPrint("\nCircuitos:");
  for (var circuit in circuits) {
    debugPrint("- ${circuit.circuitName} em ${circuit.city}, ${circuit.country}");
  }
  debugPrint("\nEquipes:");
  for (var team in teams) {
    debugPrint("- ${team.teamName} (${team.teamNationality})");
  }
  debugPrint("\nCorridas:");
  for (var race in races) {
    debugPrint("- ${race.nomeGP} em ${race.data}");
  }
}