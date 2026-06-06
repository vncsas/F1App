// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'piloto.dart';
// import 'CircuitModel.dart';
// import 'TeamModel.dart';

// class F1ApiService {
//   final Dio dio;
//   final String openF1BaseUrl = "https://api.openf1.org/v1";
//   final String legacyBaseUrl = "https://f1api.dev/api";

//   F1ApiService(this.dio);

//   Future<List<Piloto>> getDrivers() async {
//     try {
//       final openF1Response = await dio.get(
//         "$openF1BaseUrl/drivers",
//         queryParameters: {'session_key': 'latest'},
//       );
//       final legacyResponse =
//           await dio.get("$legacyBaseUrl/current/drivers-championship");

//       final List<dynamic> openF1Drivers =
//           openF1Response.data as List<dynamic>;
//       final List<dynamic> legacyDrivers =
//           legacyResponse.data['drivers_championship'] as List<dynamic>;

//       debugPrint("=== LEGACY DRIVERS MAP ===");
//       final legacyMap = <int, Map<String, dynamic>>{};
//       for (final driver in legacyDrivers) {
//         final driverData = driver['driver'] as Map<String, dynamic>?;
//         if (driverData != null) {
//           final number = (driverData['number'] as num?)?.toInt();
//           final points = (driver['points'] as num?)?.toDouble() ?? 0.0;
//           final position = (driver['position'] as num?)?.toInt() ?? 0;
//           final wins = (driver['wins'] as num?)?.toInt() ?? 0;
//           final name = (driverData['name'] as String?)?.trim() ?? '';
//           final surname = (driverData['surname'] as String?)?.trim() ?? '';
          
//           if (number != null) {
//             debugPrint("Legacy #$number: $name $surname | Pos: $position | Pts: $points | Wins: $wins");
//             legacyMap[number] = driver as Map<String, dynamic>;
//           }
//         }
//       }

//       debugPrint("=== OPENF1 DRIVERS MAPPING ===");
//       final drivers = openF1Drivers.map((driver) {
//         final openF1Driver = driver as Map<String, dynamic>;
//         final numero = (openF1Driver['driver_number'] as num?)?.toInt() ?? 0;
//         final firstName = (openF1Driver['first_name'] as String?)?.trim() ?? '';
//         final lastName = (openF1Driver['last_name'] as String?)?.trim() ?? '';
//         final standingsData = numero > 0 ? legacyMap[numero] : null;
        
//         final standPoints = (standingsData?['points'] as num?)?.toDouble() ?? 0.0;
//         final standPosition = (standingsData?['position'] as num?)?.toInt() ?? 0;
//         final standWins = (standingsData?['wins'] as num?)?.toInt() ?? 0;
        
//         debugPrint("OpenF1 #$numero: $firstName $lastName | Found: ${standingsData != null} | Pos: $standPosition | Pts: $standPoints | Wins: $standWins");
        
//         return Piloto.fromOpenF1(openF1Driver, standings: standingsData);
//       }).toList();

//       drivers.sort((a, b) {
//         if (a.posicao != b.posicao) {
//           return a.posicao.compareTo(b.posicao);
//         }
//         return a.numero.compareTo(b.numero);
//       });

//       debugPrint("=== FINAL DRIVERS LIST ===");
//       for (final driver in drivers) {
//         debugPrint("${driver.numero} | ${driver.nome} | ${driver.equipe} | Pos: ${driver.posicao} | Pts: ${driver.pontos} | Wins: ${driver.podios}");
//       }

//       return drivers;
//     } catch (e) {
//       debugPrint("Erro na busca dos pilotos: $e");
//       return [];
//     }
//   }

//   Future<List<CircuitModel>> getCircuits() async {
//     try {
//       final response = await dio.get("$legacyBaseUrl/circuits");
//       final List<dynamic> listaDeCircuitos = response.data['circuits'];

//       return listaDeCircuitos
//           .map((circuit) => CircuitModel.fromJson(circuit as Map<String, dynamic>))
//           .toList();
//     } catch (e) {
//       debugPrint("Erro na busca dos circuitos: $e");
//       return [];
//     }
//   }

//   Future<List<TeamModel>> getTeams() async {
//     try {
//       final response = await dio.get("$legacyBaseUrl/current/teams");
//       final List<dynamic> listaDeEquipes = response.data['teams'];

//       return listaDeEquipes
//           .map((team) => TeamModel.fromJson(team as Map<String, dynamic>))
//           .toList();
//     } catch (e) {
//       debugPrint("Erro na busca das equipes: $e");
//       return [];
//     }
//   }
// }

// void main() async {
//   final dio = Dio();
//   final apiService = F1ApiService(dio);
//   final drivers = await apiService.getDrivers();
//   final circuits = await apiService.getCircuits();
//   final teams = await apiService.getTeams();

//   debugPrint("Pilotos:");
//   for (var driver in drivers) {
//     debugPrint("- ${driver.nome} | ${driver.equipe} | #${driver.numero} | ${driver.pontos} pts");
//   }
//   debugPrint("\nCircuitos:");
//   for (var circuit in circuits) {
//     debugPrint("- ${circuit.circuitName} em ${circuit.city}, ${circuit.country}");
//   }
//   debugPrint("\nEquipes:");
//   for (var team in teams) {
//     debugPrint("- ${team.teamName} (${team.teamNationality})");
//   }
// }