# Guia de Instalação - Night City Underworld (NCU)

Bem-vindo ao submundo! Para que o mod funcione corretamente, você precisa garantir que a base de scripts do jogo esteja preparada para receber as nossas injeções de código.

Siga os passos abaixo com atenção.

---

## 🛑 Pré-requisitos Obrigatórios

Antes de instalar o **NCU**, você **precisa** ter os seguintes mods base instalados no seu Cyberpunk 2077. Sem eles, o núcleo e os menus do mod não vão carregar:

1. **[Cyber Engine Tweaks (CET)](https://www.nexusmods.com/cyberpunk2077/mods/107)** - Necessário para rodar a lógica principal em `.lua` e os diálogos/sistema de contatos.
2. **[RedScript](https://www.nexusmods.com/cyberpunk2077/mods/1511)** - Necessário para que possamos alterar o comportamento interno da polícia e as reações das gangues de Night City.

*Certifique-se de baixar as versões mais recentes destes dois mods compatíveis com a versão atual do seu jogo.*

---

## 🛠️ Passo a Passo da Instalação

A instalação manual é extremamente simples e segura, pois foca apenas em adicionar arquivos nas pastas de mods externas, sem substituir os arquivos *core* do seu jogo base.

### Passo 1: Encontre a pasta do seu jogo
Localize o diretório principal de instalação do seu Cyberpunk 2077:
*   **Steam:** `C:\Program Files (x86)\Steam\steamapps\common\Cyberpunk 2077\`
*   **GOG:** `C:\Program Files (x86)\GOG Galaxy\Games\Cyberpunk 2077\`
*   **Epic Games:** `C:\Program Files\Epic Games\Cyberpunk 2077\`

### Passo 2: Extraia os arquivos
Copie todas as pastas que vieram no arquivo zip do **NCU** (normalmente são as pastas `bin`, `r6` e futuramente `archive`).

### Passo 3: Cole na pasta do jogo
Cole essas pastas diretamente dentro do diretório principal do Cyberpunk 2077 descoberto no *Passo 1*.
* O Windows perguntará se você deseja "Mesclar" as pastas. **Clique em Sim**.
* Nenhum arquivo original do seu jogo deve ser substituído neste processo.

*(Se você preferir, pode instalar usando gerenciadores como o **Vortex**, mas a instalação manual garente 100% de precisão sobre as pastas de scripts).*

---

## ✅ Como saber se funcionou?

1. Abra o jogo e carregue um Save.
2. Pressione a tecla de atalho padrão do **Cyber Engine Tweaks (CET)** (geralmente a tecla de aspas `'` ou til `~`).
3. O console abrirá na sua tela. Observe as mensagens que aparecem em texto puro. Você deve ler algo como:
   `[NCU:Contacts] Módulo de Contatos inicializado.`
   `[NCU] Banco de dados de reputação e progressão carregado!`
   `[NCU] Inicialização completa. O Submundo está ativo.`

Pronto! Se os contatos entrarem em contato pelo HUD assim que o jogo começar, a instalação foi um sucesso e você já pode começar a aceitar os favores da Yelena e do Ian.

---

## 🗑️ Como Desinstalar

Se desejar remover o mod, basta excluir as seguintes pastas no diretório do seu jogo:
1. Vá em: `bin\x64\plugins\cyber_engine_tweaks\mods\` e apague a pasta **`NCU`**.
2. Vá em: `r6\scripts\` e apague a pasta **`NCU`**.
3. Futuramente (para carros): Vá em `archive\pc\mod` e apague todos os arquivos com o nome **`NCU_assets.archive`**.
