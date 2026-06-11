# F1 App — Trabalho Final P2

**Autores:**
- Vinícius Alves de Santana — 2002488
- Thiago Gabriel Silva Braga da Cruz — 2002246

**Disciplina:** Sistemas Móveis

---

## Sobre o app

Aplicativo Flutter que mostra a **classificação de pilotos** e **classificação de equipes** da temporada atual da Fórmula 1, consumindo a API pública [f1api.dev](https://f1api.dev).

Visual escuro com identidade da F1 (preto `#111111` + vermelho `#E8002D`).

---

## Arquitetura

Organizamos o `lib/` em **4 pastas por camada** (Layered Architecture), partindo da base da `menu_lanchonete` mas evoluindo a separação:

```
lib/
├── components/         # Cards reutilizáveis (StatelessWidget com parâmetro)
│   ├── card_piloto.dart
│   └── card_equipe.dart
├── data/               # Camada de dados (API REST)
│   └── f1_api_service.dart
├── models/             # Modelos do domínio
│   ├── piloto.dart
│   └── equipe.dart
├── screens/            # Telas
│   ├── tela_pilotos.dart           # home, lista de pilotos
│   ├── tela_equipes.dart           # lista de equipes
│   ├── tela_detalhe_piloto.dart    # detalhe ao clicar num piloto
│   └── tela_detalhe_equipe.dart    # detalhe ao clicar numa equipe
├── f1_app.dart         # MaterialApp + tema + home
└── main.dart           # runApp(F1App())
```

---

## O que adicionamos além da base da lanchonete

- **Consumo de API REST** com `Dio` em vez de lista hardcoded
- **`FutureBuilder`** para renderizar dados assíncronos com tratamento de loading, erro e lista vazia
- **Componentes próprios** (`CardPiloto`, `CardEquipe`) em arquivos separados, recebendo objeto e callback de toque
- **`GestureDetector`** customizado para os cards (em vez de `ListTile`) por controle visual total: gradiente, borda arredondada, imagem do piloto/carro
- **Tema customizado** no `F1App` com `google_fonts` (Roboto) e paleta dark da F1
- **Separação por camadas** em 4 pastas para escalar melhor que a lanchonete (que tinha tudo solto em `lib/`)

---

## Requisitos cumpridos

| # | Requisito | Onde está |
|---|---|---|
| 1 | 3+ telas com passagem de parâmetro | 4 telas. Detalhes recebem o objeto via construtor: `TelaDetalhePiloto(piloto: ...)` e `TelaDetalheEquipe(equipe: ...)` |
| 2 | API REST ou banco de dados | `lib/data/f1_api_service.dart` consome `f1api.dev` via `Dio` |
| 3 | StatefulWidget | `TelaPilotos` e `TelaEquipes` |
| 4 | Carousel / Drawer / Animação / **BottomNavigationBar** | `BottomNavigationBar` em `TelaPilotos` e `TelaEquipes`, alterna entre as duas com `pushReplacement` |
| 5 | Lib do pub.dev (exceto BD/API) | `google_fonts` para aplicar a fonte Roboto no tema |
| 6 | Componentes em arquivos separados com parâmetros | `lib/components/card_piloto.dart` (recebe `Piloto`) e `card_equipe.dart` (recebe `Equipe`) |

---

## Como rodar

```bash
flutter pub get
flutter run
```

---

## Dependências (`pubspec.yaml`)

- `flutter` — SDK base
- `dio` — cliente HTTP para consumir a API
- `google_fonts` — fonte Roboto no tema
