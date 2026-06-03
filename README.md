# F1 App

Aplicativo Flutter de classificação da Fórmula 1. Exibe lista de pilotos, pontuação, equipe e detalhes individuais com tema escuro inspirado na identidade visual da F1.

## Funcionalidades

- **Splash screen** com logo F1 e transição automática para a tela principal.
- **Classificação de Pilotos** em lista, com gradiente personalizado por equipe, posição, pontos e foto.
- **Detalhes do Piloto**: cabeçalho com imagem, estatísticas (posição, pódios, pontos), card da equipe e seção de pódios recentes.
- **Tabs**: Pilotos e Equipes (em breve).
- **Bottom Navigation**: News, Races, Classificação.

## Estrutura do Projeto

```
lib/
├── main.dart                    # Entry point — runApp(F1App())
├── f1_app.dart                  # MaterialApp + tema escuro F1
├── splash_screen.dart           # Tela inicial com logo + transição
├── piloto.dart                  # Modelo Piloto
├── pilotos_data.dart            # Lista estática de pilotos
├── card_piloto.dart             # Widget de card na listagem
├── tela_classificacao.dart      # Tela principal (Tabs + lista)
└── tela_detalhe_piloto.dart     # Tela de detalhes do piloto
```

## Modelo `Piloto`

| Campo          | Tipo     | Descrição                          |
|----------------|----------|------------------------------------|
| `nome`         | String   | Nome completo                      |
| `equipe`       | String   | Nome da escuderia                  |
| `numero`       | int      | Número do carro                    |
| `nacionalidade`| String   | País de origem                     |
| `imagem`       | String   | URL da foto oficial                |
| `corEquipe`    | Color    | Cor primária do time               |
| `posicao`      | int      | Colocação no campeonato            |
| `pontos`       | int      | Pontos acumulados                  |
| `podios`       | int      | Quantidade de pódios               |

## Requisitos

- Flutter SDK `^3.11.0`
- Dart SDK compatível
- Android Studio / VS Code com plugin Flutter
- Emulador Android, iOS Simulator ou device físico

## Como Executar

```bash
flutter pub get
flutter run
```

Para escolher dispositivo:

```bash
flutter devices
flutter run -d <device_id>
```

## Build

```bash
flutter build apk            # Android APK
flutter build appbundle      # Android AAB (Play Store)
flutter build ios            # iOS (requer macOS)
```

## Testes

```bash
flutter test
```

## Tema

- Background: `#111111`
- Acento: `#E8002D` (vermelho F1)
- Cards: `#1A1A1A`
- Brightness: dark

## Próximos Passos

- Aba **Equipes** com classificação de construtores.
- Telas **News** e **Races**.
- Integração com API real (ex: Ergast / F1 oficial).
- Persistência local de favoritos.

## Autor

Vinícius Salves
