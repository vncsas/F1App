import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/piloto.dart';
import '../models/equipe.dart';

class F1ApiService {
  final Dio dio;
  final String apiURL = "https://f1api.dev/api";

  F1ApiService(this.dio);

  Future<List<Piloto>> getDrivers() async {
    try {
      final response = await dio.get("$apiURL/current/drivers-championship");
      final lista = response.data['drivers_championship'] as List<dynamic>;

      final pilotos = lista.map((piloto) {
        return Piloto.fromJson(piloto as Map<String, dynamic>);
      }).toList();
      pilotos.sort((a, b) {
        if (a.posicao != b.posicao) {
          return a.posicao.compareTo(b.posicao);
        }
        return a.numero.compareTo(b.numero);
      });

      return pilotos;

    } catch (e) {
      debugPrint("Erro na busca dos pilotos: $e");
      return [];
    }
  }

  Future<List<Equipe>> getTeams() async {
    try {
      final response = await dio.get("$apiURL/current/teams");
      final list = response.data['teams'] as List<dynamic>;
      return list.map((equipe) => Equipe.fromJson(equipe as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint("Erro na busca das equipes: $e");
      return [];
    }
  }
}
