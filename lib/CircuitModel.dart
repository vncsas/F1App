class CircuitModel {
  final String circuitId;
  final String circuitName;
  final String country;
  final String city;
  final int circuitLength;
  final String? lapRecord;
  final int? firstParticipationYear;
  final int? numberOfCorners;
  final String? fastestLapDriverId;
  final String? fastestLapTeamId;
  final int? fastestLapYear;

  CircuitModel({
    required this.circuitId,
    required this.circuitName,
    required this.country,
    required this.city,
    required this.circuitLength,
    this.lapRecord,
    this.firstParticipationYear,
    this.numberOfCorners,
    this.fastestLapDriverId,
    this.fastestLapTeamId,
    this.fastestLapYear,
  });

  factory CircuitModel.fromJson(Map<String, dynamic> json) {
    return CircuitModel(
      circuitId: json['circuitId'] as String? ?? 'id_indisponivel',
      circuitName: json['circuitName'] as String? ?? 'Circuito Desconhecido',
      country: json['country'] as String? ?? 'País Desconhecido',
      city: json['city'] as String? ?? 'Cidade Desconhecida',
      circuitLength: (json['circuitLength'] as num?)?.toInt() ?? 0,
      
      lapRecord: json['lapRecord'] as String?,
      firstParticipationYear: json['firstParticipationYear'] as int?,
      numberOfCorners: json['numberOfCorners'] as int?,
      fastestLapDriverId: json['fastestLapDriverId'] as String?,
      fastestLapTeamId: json['fastestLapTeamId'] as String?,
      fastestLapYear: json['fastestLapYear'] as int?,
    );
  }
}