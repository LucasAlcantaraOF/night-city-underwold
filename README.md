# 🌃 Night City Underworld (NCU)

**Night City Underworld (NCU)** é um mod ambicioso para **Cyberpunk 2077** que expande o submundo do crime e a vida nas ruas de Night City. Construído utilizando comandos locais via **Cyber Engine Tweaks (CET)** baseados em `.lua` e injeção direta no motor do jogo com **RedScript** (`.reds`), este mod visa criar dinâmicas reativas, vivas e imersivas para os mercenários mais ousados.

## 🎯 MVP (Minimum Viable Product) - Metas Iniciais

Para o nosso lançamento inicial (MVP), estamos focando em trazer as seguintes funcionalidades principais para refinar a experiência do submundo de Night City:

- 📞 **Novos Contatos e Ligações Misteriosas**: Uma rede de fixers não-convencionais e clientes anônimos que entregam contratos misteriosos de forma progressiva, totalmente dublados em pt-br.
- 🚗 **Roubos de Carros Exóticos**: Contratos de altíssimo risco e recompensa para adquirir veículos de exóticos, fortemente guardados e muitas vezes em trânsito.
- 🏁 **Corridas Clandestinas**: Disputas ilegais nas ruas escuras envolvendo novos adversários e trajetos extremamente perigosos.
- 🔪 **Acerto de Contas & Cobrança de Dívidas**: Missões brutais onde você atua diretamente como o executor de facções criminosas.
- 🎯 **Assassinato de Aluguel**: Contratos de eliminação cirúrgica com alvos muito peculiares (exigindo mais planejamento do que força bruta).
- 🚨 **Novo Sistema de Polícia (Revisão NCU)**: Ajustes pontuais no comportamento da polícia de Night City, tornando o nível de resposta dependente de qual território do mapa você se encontra.
- 🏎️ **Novos Carros Exóticos**: Introdução de novos modelos de veículos construídos exclusivamente para a locomoção do V e para contratos de alto nível.

## 📁 Estrutura de Pastas Sugerida

Como se trata de um projeto que une abordagens diferentes no ecossistema de modding da **REDengine 4**, a estrutura abaixo é recomendada. Ela imita o diretório do jogo base do Cyberpunk 2077 para facilitar a criação de pacotes `.zip` para envio no Nexus Mods e a extração local por parte dos jogadores:

```text
night-city-underwold/
├── bin/
│   └── x64/
│       └── plugins/
│           └── cyber_engine_tweaks/
│               └── mods/
│                   └── NCU/
│                       ├── init.lua              # Ponto de entrada do mod em CET
│                       ├── modules/              # Lógica fracionada em pequenos serviços
│                       │   ├── contacts.lua      # Sistema customizado de chamadas (UI e Lógica)
│                       │   ├── missions.lua      # Gerenciador de missões/progresso (Cobranças/Assassinatos)
│                       │   └── races.lua         # Eventos de corrida
│                       └── data/                 # Mini banco de dados Json/Lua do MVP
│                           └── database.json
│
├── r6/
│   └── scripts/
│       └── NCU/
│           ├── PoliceSystemHook.reds             # Hooks na IA de spawn/comportamento da polícia
│           ├── VehicleTheftHook.reds             # Alterações de lógica de hacking/fuga em roubo de carros
│           └── PlayerInteractions.reds           # Comportamentos hardcoded de RedScript para otimização
│
├── archive/
│   └── pc/
│       └── mod/
│           └── NCU_assets.archive                # Pacote compilado via WolvenKit contendo áudios, modelos 3D de novos carros, etc.
│
├── docs/                                         # Documentação para desenvolvedores da comunidade
├── .gitignore
├── LICENSE
└── README.md                                     # Você está aqui!
```

## 🛠️ Tecnologias, Bibliotecas e Ferramentas

- **[Cyber Engine Tweaks (CET)](https://github.com/maximegmd/CyberEngineTweaks)**: Para injeção de scripts Lua dinâmicos e desenvolvimento de interfaces de usuário imersivas (UI In-game).
- **[RedScript](https://github.com/jac3km4/redscript)**: Uma linguagem de script / compilador que nos permite interceptar e sobrescrever classes originais do motor do jogo, criando sistemas vitais como a modificação policial.
- **[WolvenKit](https://github.com/WolvenKit/WolvenKit)**: IDE oficial/hub da comunidade para manipulação e re-empacotamento de assets `.archive` (fundamental para os _Novos Carros Exóticos_).

---

Sinta-se à vontade para contribuir por meio de **Issues** e enviar **Pull Requests**. Vamos fazer o Submundo de Night City se tornar imprevisível!
