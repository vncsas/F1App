class TeamModel {
  String? teamId;
  String? teamName;
  String? teamNationality;
  int? firstAppeareance;
  int? constructorsChampionships;
  int? driversChampionships;
  String? logo;

  TeamModel({
    this.teamId,
    this.teamName,
    this.teamNationality,
    this.firstAppeareance,
    this.constructorsChampionships,
    this.driversChampionships,
    this.logo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final teamName = json['teamName'] as String? ?? '';
    return TeamModel(
      teamId: json['teamId'] as String?,
      teamName: teamName,
      teamNationality: json['teamNationality'] as String?,
      firstAppeareance: json['firstAppeareance'] as int?,
      constructorsChampionships: json['constructorsChampionships'] as int?,
      driversChampionships: json['driversChampionships'] as int?,
      logo: _generateTeamLogo(teamName),
    );
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
      'alpin': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Alpine.png',
      'rb': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Racing_Bulls.png',
      'racingbulls': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Racing_Bulls.png',
      'williams': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Williams.png',
      'sauber': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Kick_Sauber.png',
      'kicksauber': 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Kick_Sauber.png',
    };

    return logoMap[normalized] ?? 'https://media.formula1.com/content/dam/fom-website/2024-redesign-assets/team-logos/Mercedes.png';
  }
}
