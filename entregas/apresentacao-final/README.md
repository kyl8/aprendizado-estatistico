# Apresentação final APPA

Apresentação para **10–12 minutos**, com **16 slides principais e um de apoio**. Professor: **João Paulo Ferreira de Mello**. Integrantes: **Arthur Galvão, Pedro Henrique e Ailana Pereira Gonsalez**.

Abra [apresentacao-final-appa.html](apresentacao-final-appa.html) no Chrome ou Edge. O arquivo contém código, dados e fontes e funciona sem internet. O [PDF](apresentacao-final-appa.pdf) é uma alternativa estática para projetar ou enviar; suas páginas foram renderizadas pelo Remotion.

## Controles

- Setas, Page Up/Down e espaço: navegar; Home/End: primeiro/último.
- **N**: notas com roteiro sugerido; **M**: índice; **F**: tela cheia; **Esc**: fechar painel.
- Os controles na tela permitem as mesmas ações. O ritmo é manual; a animação de entrada termina e o slide permanece parado.
- No celular, uma versão textual acompanha cada slide, com controles maiores de horário, perfil e limiar sincronizados à visualização. Movimento reduzido respeita a preferência do sistema.

As interações demonstram a regra de horário, a probabilidade de um perfil com os coeficientes reais e o efeito do limiar sobre a matriz de confusão. A exploração do limiar usa o teste e **não seleciona** um novo valor para os resultados do artigo, que mantêm 0,5.

## Código completo

| Arquivo | Função |
|---|---|
| [src/Deck.tsx](src/Deck.tsx) | Conteúdo, gráficos e interações dos slides. |
| [src/slides.ts](src/slides.ts) | Ordem, notas e distribuição sugerida das falas. |
| [src/main.tsx](src/main.tsx) | Remotion Player, teclado, índice, notas e tela cheia. |
| [src/remotion.tsx](src/remotion.tsx) | Composição Remotion para exportar frames e vídeo. |
| [src/style.css](src/style.css) | Tipografia, cores, composição e adaptação ao celular. |
| [preparar-dados.py](preparar-dados.py) | Importação dos resultados calculados em R e conferência das probabilidades. |
| [src/dados.json](src/dados.json) | Dados incorporados na apresentação, com hash do banco preparado. |
| [scripts/build.mjs](scripts/build.mjs) | Geração do HTML offline com JavaScript, estilos e fontes incorporados. |
| [scripts/exportar-pdf.mjs](scripts/exportar-pdf.mjs) | Renderização dos frames pelo Remotion. |
| [scripts/montar-pdf.py](scripts/montar-pdf.py) | Montagem dos frames em um PDF, sem redesenhar os slides. |
| [scripts/verificar.mjs](scripts/verificar.mjs) | Verificações de navegação, interações, celular e execução sem rede. |

O Python importa tabelas e reúne frames; **o conteúdo visual é implementado em React/Remotion**. Não foi gerado com PowerPoint ou com `python-pptx`.

## Reproduzir

Requisitos: Node.js 22.12+ ou 24, npm, Python com `PyMuPDF` e Chrome. A versão entregue foi verificada com Node 24.18.0 e Remotion 4.0.544. `package-lock.json` registra as dependências.

Na raiz do repositório, para recalcular os dados:

```powershell
Rscript entregas/entrega-2/compilar-entrega-2.R
```

Depois, em `entregas/apresentacao-final/`:

```powershell
npm ci
npm run dados
npm run build
npm test
npm run pdf
```

Para editar com prévia no navegador: `npm run dev`. Para editar no Remotion Studio: `npm run studio`. Para gerar um **vídeo silencioso opcional**, com dez segundos por slide: `npm run video`. Esse vídeo não tem as interações nem substitui a apresentação manual de 10–12 minutos. Não foi incluído um MP4 nesta entrega.

`CHROME_PATH` permite indicar outro executável Chrome/Chromium nos scripts de verificação e PDF. Em outro sistema, instale um navegador compatível. A primeira instalação das dependências requer internet; o HTML já gerado não requer instalação ou rede.

## Conteúdo e referências visuais

Os números vêm da [Entrega 2](../entrega-2/README.md). Há uma ferramenta principal, a logística. PCA e Poisson aparecem somente no slide de apoio. A narrativa demonstra procedimentos e discute suas limitações, sem encerrar conclusões científicas sobre o problema.

A estrutura acadêmica acompanha o modelo da disciplina. A direção visual retoma os HTMLs indicados pelo solicitante: `Evento_PLN_FatecRL.html` e `Consciencia_Artificial_Interativa_5_Integrantes.html`, com tipografia expressiva, alternância de superfícies, navegação manual e exemplos interativos. As fontes Space Grotesk e DM Sans são distribuídas pelos pacotes `@fontsource` e incorporadas ao HTML sob suas licenças. Gráficos SVG são calculados a partir das saídas; os frames exportados são gerados pelo Remotion. Apoio de IA na implementação e no texto.
