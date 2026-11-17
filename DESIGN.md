---
name: "APPA — apresentação de Estatística"
description: "Sistema visual implementado na apresentação acadêmica interativa de regressão logística."
colors:
  ink: "#090e24"
  paper: "#f5f1e9"
  mint: "#9cf0cd"
  lav: "#bea9ff"
  indigo: "#3042d4"
  muted: "#aab5d5"
  ink-fg: "#f3f5ff"
  ink-line: "#35405c"
  paper-fg: "#10172c"
  paper-muted: "#505b73"
  paper-line: "#c4c7d1"
  mint-bg: "#d9f4e9"
  mint-fg: "#103036"
  mint-muted: "#3d6064"
  mint-accent: "#5431a5"
  mint-line: "#a5c9bd"
  indigo-fg: "#fff"
  indigo-muted: "#e0e4ff"
  indigo-line: "#7784e7"
  yellow: "#ffd84d"
  panel: "#152039"
  nav-border: "#53607f"
  nav-hover: "#202c49"
  next-fg: "#102529"
  next-hover: "#c0f8e2"
  nav-active: "#333266"
typography:
  display:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "108px"
    fontWeight: 600
    lineHeight: 0.98
    letterSpacing: "-0.035em"
  headline:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "78px"
    fontWeight: 600
    lineHeight: 1.05
    letterSpacing: "-0.035em"
  title:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "34px"
    fontWeight: 600
    lineHeight: 1.18
    letterSpacing: "-0.035em"
  body:
    fontFamily: "DM Sans, sans-serif"
    fontSize: "31px"
    lineHeight: 1.4
  label:
    fontFamily: "DM Sans, sans-serif"
    fontSize: "22px"
    lineHeight: 1.45
  body-reading:
    fontFamily: "DM Sans, sans-serif"
    fontSize: "18px"
    lineHeight: 1.7
  headline-reading:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "29px"
    fontWeight: 600
    lineHeight: 1.15
    letterSpacing: "-0.035em"
  label-ui:
    fontFamily: "DM Sans, sans-serif"
    fontSize: "14px"
rounded:
  control: "8px"
  panel: "12px"
spacing:
  control-gap: "8px"
  ui-gap: "10px"
  compact: "12px"
  related: "20px"
  section-compact: "24px"
  section: "36px"
  columns: "70px"
components:
  button-nav:
    backgroundColor: "transparent"
    textColor: "{colors.ink-fg}"
    typography: "{typography.label-ui}"
    rounded: "{rounded.control}"
    padding: "10px 14px"
  button-nav-hover:
    backgroundColor: "{colors.nav-hover}"
  button-next:
    backgroundColor: "{colors.mint}"
    textColor: "{colors.next-fg}"
    typography: "{typography.label-ui}"
    rounded: "{rounded.control}"
    padding: "10px 14px"
  button-next-hover:
    backgroundColor: "{colors.next-hover}"
  button-nav-active:
    backgroundColor: "{colors.nav-active}"
    textColor: "{colors.ink-fg}"
    rounded: "{rounded.control}"
  select-profile:
    rounded: "{rounded.control}"
    padding: "16px 15px"
    width: "100%"
  select-profile-mobile:
    backgroundColor: "{colors.panel}"
    textColor: "{colors.ink-fg}"
    rounded: "{rounded.control}"
    padding: "13px 12px"
    width: "100%"
  range-demo-mobile:
    height: "48px"
    width: "100%"
  presenter-panel:
    backgroundColor: "{colors.panel}"
    textColor: "{colors.ink-fg}"
    rounded: "{rounded.panel}"
    padding: "24px"
  index-item:
    backgroundColor: "transparent"
    rounded: "{rounded.control}"
    padding: "13px"
  index-item-current:
    backgroundColor: "{colors.indigo}"
    rounded: "{rounded.control}"
    padding: "13px"
---

# Design System: APPA

## Overview

**Creative North Star: "Identidade herdada dos HTMLs de referência"**

A apresentação combina o caráter expressivo dos dois HTMLs indicados pelo solicitante com organização acadêmica: títulos grandes, evidência numérica legível e gráficos como parte da explicação. Tinta azul escura, papel claro, menta, lavanda e índigo formam a identidade observada; este documento registra sua aplicação no código final, sem criar uma identidade adicional.

O conteúdo projetado ocupa um quadro de apresentação. Os controles do apresentador ficam fora desse quadro. Na tela pequena, uma área de leitura e controles próprios acompanham a miniatura do slide; as duas representações compartilham o mesmo estado. Diagramas e gráficos são SVG gerados por geometria e dados em runtime. Não há imagens externas geradas por IA na apresentação.

**Key Characteristics:**

- Tipografia geométrica nos títulos e leitura contínua em DM Sans.
- Alternância entre fundos escuros, papel, menta e campos índigo.
- Números e gráficos em destaque, com linhas finas para organizar a evidência.
- Navegação manual, entrada breve por frames e leitura complementar no celular.

## Colors

A paleta alterna campos claros e escuros; a cor de destaque muda com o fundo, preservando a hierarquia entre evidência, texto e apoio.

### Primary

- **Tinta azul escura** (`ink`): fundo principal do aplicativo e de slides escuros.
- **Menta luminosa** (`mint`): ênfase e resultados em slides escuros, ação de avançar e primeira janela do relógio.
- **Índigo** (`indigo`): campos de slides de síntese, ênfase nos slides de papel e seleção atual no índice.

### Secondary

- **Lavanda** (`lav`): segunda janela do relógio, bloco de teste e estado aberto de navegação.
- **Amarelo luminoso** (`yellow`): terceira janela do relógio, ênfase sobre índigo e contorno de foco visível.
- **Violeta sobre menta** (`mint-accent`): destaque do conteúdo nos slides com fundo menta.

### Neutral

- **Papel quente** (`paper`): fundo claro de perguntas, preditoras e resultados.
- **Menta de fundo** (`mint-bg`): campo claro para regra do alvo e diagnósticos.
- **Textos de tinta, papel, menta e índigo** (`ink-fg`, `paper-fg`, `mint-fg`, `indigo-fg`): primeiro plano próprio de cada tom.
- **Textos de apoio** (`muted`, `paper-muted`, `mint-muted`, `indigo-muted`): legendas, explicações e metadados conforme o tom.
- **Linhas por tom** (`ink-line`, `paper-line`, `mint-line`, `indigo-line`): divisores e limites entre grupos.
- **Azul de painel** (`panel`): notas, índice e campos da demonstração móvel. Os tokens de navegação registram borda, hover, ação principal e estado aberto.

**The Tone Pairing Rule.** Ao usar um dos quatro tons implementados, mantenha juntos seu fundo, primeiro plano, texto de apoio, destaque e linha; os pares são definidos no stylesheet.

## Typography

**Display Font:** Space Grotesk, com fallback sans-serif.

**Body Font:** DM Sans, com fallback sans-serif.

**Label/Mono Font:** rótulos usam DM Sans; código usa Consolas, Liberation Mono e monospace.

As fontes são locais, com licenças em `entregas/apresentacao-final/licencas/`. Títulos usam peso semibold e espaçamento de letras ligeiramente fechado. Números grandes usam frequentemente Space Grotesk em peso médio; contagens, índices e tabelas também usam algarismos tabulares quando precisam alinhar colunas.

### Hierarchy

- **Display:** título de abertura, com quebras explícitas. O fechamento e as afirmações têm ajustes locais de tamanho.
- **Headline:** títulos de slide; os slides mais densos usam ajustes locais observados, em vez de uma escala proporcional única.
- **Title:** subtítulos e agrupamentos de discussão.
- **Body:** texto de introdução no quadro; parágrafos de apoio variam de acordo com a composição.
- **Label:** legendas e explicações curtas dos gráficos. O quadro também usa metadados menores no topo e rodapé.
- **Body-reading / Headline-reading:** leitura do celular, fora do quadro projetado.
- **Label-ui:** controles do apresentador. No breakpoint móvel, os botões usam tamanho menor de texto, preservando a área de toque.

**The Two Contexts Rule.** Os tamanhos do quadro são coordenadas da composição Remotion; o texto de leitura e os controles do aplicativo são dimensionados no viewport. Não aplique o tamanho de um contexto ao outro.

## Layout

A composição tem dimensões de 1600 × 900 e proporção 16:9. O conteúdo usa recuo superior de 108 px, laterais de 90 px e inferior de 100 px. Topo e rodapé usam laterais de 80 px e afastamento de 35 px. O fluxo principal é uma coluna flexível com intervalo padrão de 36 px; slides de maior densidade têm ajustes explícitos.

As composições internas combinam duas colunas, sequências de três itens, tabelas e gráficos. As proporções respondem ao conteúdo: por exemplo, o perfil usa duas colunas desiguais e a divisão temporal reserva mais espaço ao treino. O sistema usa divisores finos e intervalos amplos entre blocos; não existe uma escala de espaçamento uniforme para todas as composições.

No desktop, o aplicativo ocupa a altura dinâmica da janela. O player centralizado ajusta a largura disponível e a altura restante, mantendo a proporção. Cabeçalho e navegação ficam fora dos frames exportados.

Até 700 px, a página passa a rolar, a miniatura ocupa a largura disponível e a navegação fica aderente ao topo. Rótulos opcionais e a mensagem de atalhos são ocultados. A leitura complementar tem recuo de 28 px no topo, 24 px nas laterais e 45 px na base. As demonstrações móveis usam os mesmos valores e callbacks do slide: range com altura de 48 px e selects com altura mínima de 52 px. O metadado vem depois do título nessa área de leitura. Os painéis passam a usar margens laterais de 12 px e largura automática.

## Elevation & Depth

Os slides são planos: fundos, cor, espaço e divisores estabelecem a hierarquia. O código reserva sombra aos painéis flutuantes de notas, ajuda e índice; console e blocos temporais usam superfícies tonais, sem sombra. A sombra exata dos painéis está no sidecar.

A entrada do conteúdo desloca 16 px no eixo vertical e aumenta a opacidade de 0,45 para 1 nos primeiros 28 frames, com curva quartic ease-out. O player pausa após a entrada, no frame local 45. Com preferência de movimento reduzido, mostra diretamente o conteúdo completo. Não há transição automática entre slides.

## Shapes

Controles e itens do índice usam cantos suavemente arredondados, enquanto painéis e blocos de código usam o raio maior do frontmatter. Gráficos, barras e tabelas mantêm geometria simples. O relógio circular de 24 horas é a forma de assinatura; três arcos representam as janelas do alvo e um ponteiro representa o horário selecionado.

Linhas de um pixel separam linhas de dados e grupos de conteúdo. O recorte do slide preserva os limites do quadro; a miniatura do player também oculta excedentes. Ícones de navegação são SVG em traço, com caminhos incorporados ao código.

## Components

### Buttons

Os botões do apresentador são discretos, com borda, fundo transparente e o raio de controle. A ação de avançar usa menta e texto escuro. Hover troca o fundo, e os botões de índice e notas indicam painel aberto com fundo violeta e borda lavanda. Botões indisponíveis ficam com opacidade de 0,35. A altura mínima geral é 44 px; o botão de fechar painel tem mínimo de 40 px.

Todos os botões e links possuem contorno amarelo de foco visível, com espessura de 3 px e afastamento de 5 px. Os snippets do sidecar preservam esses estados.

### Inputs / Fields

Os selects do perfil têm largura total, borda de um pixel e raio de controle; no quadro herdam as cores do tom atual. Os ranges usam a cor de destaque do tom e altura de 40 px. A representação móvel usa campos maiores e cores próprias do aplicativo. Cada campo tem rótulo textual; as saídas móveis anunciam alterações com `aria-live="polite"`.

### Panels / Containers

Notas, ajuda e índice aparecem em painéis escuros fixos à direita, com recuo interno de 24 px e rolagem própria. O índice é mais largo que o painel de notas. O botão de fechar fica no canto superior direito. Ao abrir, o foco vai ao botão de fechar; ao dispensar, o aplicativo devolve o foco ao acionador quando ele foi registrado.

O console usa fundo azul escuro, raio de painel e texto monoespaçado. Blocos de treino/teste usam preenchimento tonal e linha superior colorida. Não há componente genérico de cartão ou chip no código atual.

### Navigation

A barra persistente reúne índice, notas, ajuda, anterior, progresso, próximo e tela cheia. O índice apresenta linhas numeradas e destaca o slide atual com fundo índigo. A navegação por teclado aceita setas, espaço, Page Up/Down, Home/End e atalhos de painéis; os campos mantêm seu próprio uso das setas. No celular, os ícones permanecem e os rótulos opcionais são ocultados.

### Relógio de 24 horas e gráficos

O relógio usa arcos espessos, marcas horárias e ponteiro. No fundo menta, as três cores dos arcos são substituídas por versões escuras definidas no código para preservar a leitura. As demais visualizações usam SVG, cor de destaque para dados, `currentColor` para eixos e opacidade reduzida para referências. Rótulos, valores e unidades acompanham os gráficos; as barras comparativas usam eixo comum explícito. As figuras R do artigo e o PDF por frames Remotion têm pipelines próprios e não são imagens decorativas deste sistema.

## Do's and Don'ts

### Do:

- **Do** manter a combinação de cores completa do tom escolhido.
- **Do** usar Space Grotesk nos títulos e DM Sans na leitura, com os arquivos locais já incluídos.
- **Do** manter os controles do apresentador fora do quadro projetado e exportado.
- **Do** compartilhar o estado entre a demonstração no quadro e a demonstração móvel.
- **Do** conservar foco visível e a apresentação imediata com movimento reduzido.
- **Do** rotular os valores, referências e unidades das visualizações junto dos dados.

### Don't:

- **Don't** reduzir os campos móveis ao tamanho resultante da escala da miniatura.
- **Don't** aplicar os tamanhos de texto da composição diretamente à interface do aplicativo.
- **Don't** atribuir sombras aos slides como se fossem painéis flutuantes.
- **Don't** transformar os ajustes locais de um slide em uma escala tipográfica global inexistente.
