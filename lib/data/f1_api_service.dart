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
      final response = await dio.get("$legacyBaseUrl/current/drivers-championship");
      final list = response.data['drivers_championship'] as List<dynamic>;

      final drivers = list
          .where((d) => d['driver'] != null)
          .map((d) => Piloto.fromJson(d as Map<String, dynamic>))
          .toList();

      drivers.sort((a, b) {
        if (a.posicao != b.posicao) return a.posicao.compareTo(b.posicao);
        return a.numero.compareTo(b.numero);
      });

      return drivers;
    } catch (e) {
      debugPrint("Erro na busca dos pilotos: $e");
      return [];
    }
  }

  Future<List<Corrida>> getRaces() async {
    try {
      final response = await dio.get("$legacyBaseUrl/current");
      final list = (response.data['races'] ?? []) as List<dynamic>;
      return list
          .map((c) => Corrida.fromJson(c as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("Erro na busca das corridas: $e");
      return [];
    }
  }

  Future<List<Equipe>> getTeams() async {
    try {
      final response = await dio.get("$legacyBaseUrl/current/teams");
      final list = response.data['teams'] as List<dynamic>;
      return list
          .map((t) => Equipe.fromJson(t as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("Erro na busca das equipes: $e");
      return [];
    }
  }
}
