# F1 App

Aplicativo Flutter de Fórmula 1. Exibe classificação de pilotos e equipes, calendário de corridas e detalhes individuais, com tema escuro inspirado na identidade visual da F1.

## Funcionalidades

- **Splash screen** com logo F1 e transição automática para a tela principal.
- **Classificação** em abas:
  - **Pilotos**: lista com gradiente por equipe, posição, pontos e foto.
  - **Equipes**: lista de construtores com motor, posição, pontos e pilotos.
- **Detalhes do Piloto**: cabeçalho com imagem, estatísticas (colocação, pódios, pontos), card da equipe e seção de pódios recentes.
- **Detalhes da Equipe**: cabeçalho com imagem do carro, estatísticas, lista de pilotos e informações técnicas.
- **Corridas**: lista de GPs da temporada com bandeira, data, circuito e status (realizada/aguardando).
- **Detalhes da Corrida**: cabeçalho com bandeira e badge de status, informações do GP e vencedor (ou aguardando).
- **Bottom Navigation** entre Classificação e Corridas.

## Estrutura do Projeto

```
lib/
├── main.dart                       # Entry point — runApp(F1App())
├── f1_app.dart                     # MaterialApp + tema escuro F1
│
├── models/                         # Modelos de dados (POJOs)
│   ├── piloto.dart
│   ├── equipe.dart
│   └── corrida.dart
│
├── data/                           # Dados estáticos (mock)
│   ├── pilotos_data.dart
│   ├── equipes_data.dart
│   └── corridas_data.dart
│
├── screens/                        # Telas completas (rotas)
│   ├── splash_screen.dart
│   ├── tela_classificacao.dart
│   ├── tela_detalhe_piloto.dart
│   ├── tela_detalhe_equipe.dart
│   ├── tela_corridas.dart
│   └── tela_detalhe_corrida.dart
│
└── components/                     # Widgets reutilizáveis
    ├── card_piloto.dart
    ├── card_equipe.dart
    └── card_corrida.dart
```

### Por que essa arquitetura?

Separação por responsabilidade — cada pasta tem um papel claro:

- **`models/`** — define **o quê** (estrutura dos dados). Classes puras, sem lógica de UI nem fonte de dados.
- **`data/`** — define **de onde** vêm os dados. Hoje é mock estático; amanhã pode virar repositório de API/banco sem tocar nas telas.
- **`screens/`** — define **onde** o usuário está (rotas / páginas inteiras com `Scaffold`).
- **`components/`** — define **partes reutilizáveis** das telas (cards, itens de lista, badges). Recebem dados via parâmetro, não conhecem fonte.

Benefícios práticos:
- Encontrar arquivo rápido pelo nome da pasta.
- Trocar `data/` por API real sem mexer em telas ou componentes.
- Reaproveitar componentes em telas novas sem duplicação.
- Escala bem conforme novas telas (Notícias, Estatísticas, Favoritos…) forem adicionadas.

## Modelos

### `Piloto`

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

### `Equipe`

| Campo         | Tipo           | Descrição                       |
|---------------|----------------|---------------------------------|
| `nome`        | String         | Nome da escuderia               |
| `cor`         | String         | Cor descritiva                  |
| `corEquipe`   | Color          | Cor primária do time            |
| `motor`       | String         | Fornecedor de motor             |
| `posicao`     | int            | Colocação no campeonato         |
| `pontos`      | int            | Pontos acumulados               |
| `pilotos`     | List\<String\> | Pilotos titulares               |
| `imagemCarro` | String         | URL da imagem do carro          |

### `Corrida`

| Campo             | Tipo   | Descrição                                |
|-------------------|--------|------------------------------------------|
| `nomePais`        | String | País sede do GP                          |
| `nomeGP`          | String | Nome oficial do Grande Prêmio            |
| `circuito`        | String | Nome do circuito                         |
| `data`            | String | Data da corrida                          |
| `vencedor`        | String | Piloto vencedor (vazio se não realizada) |
| `equipeVencedora` | String | Equipe do vencedor                       |
| `bandeira`        | String | Emoji da bandeira do país                |
| `realizada`       | bool   | Indica se já ocorreu                     |

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

- Integração com API real (ex: Ergast / F1 oficial).
- Persistência local de favoritos.
- Tela de notícias.
- Estatísticas históricas por piloto / equipe.

## Autor

Vinícius Santana
Thiago Gabriel
