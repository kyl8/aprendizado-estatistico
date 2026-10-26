# Teoria do Aprendizado Estatístico

**Grupo:** APPA — Arthur Galvão, Pedro Henrique e Ailana.
**Apoio:** ChatGPT.

Repositório do grupo APPA para a disciplina de Teoria do Aprendizado Estatístico da FATEC. O projeto analisa registros de sinistros de trânsito no Estado de São Paulo.

## Conteúdo

- [entregas](entregas/): relatórios formais e entregas acadêmicas em LaTeX/Sweave;
- [consolidados](consolidados/): atividades e relatórios organizados por etapa;
- [estrutura/banco-de-dados](estrutura/banco-de-dados/): bases preparadas e dados serializados para modelagem;
- [estrutura/corpus](estrutura/corpus/): dicionário e base de sinistros;
- [estrutura/codigos](estrutura/codigos/): scripts de modelagem em R;
- [estrutura/resultados](estrutura/resultados/): métricas e previsões geradas pelos scripts;
- [materiais-aulas](materiais-aulas/): PDFs usados nas aulas.

Os scripts e resultados usam o prefixo de data e grupo `YYYY-MM-DD-appa`.

## Entregas Formais

A pasta [entregas/](entregas/) reúne a entrega final e os modelos da disciplina:

- **[entregas/finalizada/](entregas/finalizada/):** versão final consolidada do grupo APPA:
  - [Entrega 1: A Pergunta do Trabalho (PDF)](entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.pdf) ([Fonte Sweave](entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.Rnw), [LaTeX](entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.tex))
- **[entregas/modelo_base/](entregas/modelo_base/):** modelo e template original fornecido pela disciplina:
  - [Modelo Base: Pergunta do Trabalho](entregas/modelo_base/entrega-1-pergunta.pdf) ([Fonte Sweave](entregas/modelo_base/entrega-1-pergunta.Rnw), [LaTeX](entregas/modelo_base/entrega-1-pergunta.tex))

## Base

O arquivo [Sinistros_2025_2026.csv](estrutura/corpus/2026-08-12-appa-Sinistros_2025_2026.csv) reúne 273.372 registros e 50 variáveis, de janeiro de 2025 a junho de 2026.

O [dicionário de dados](estrutura/corpus/2026-08-11-appa-DicionarioDados.md) explica as colunas, categorias e regras usadas para tratar valores ausentes.

## Atividades

- [01: dados e variáveis](consolidados/2026-09-15-appa-Atividade01-DadosVariaveis.md)
- [02a: análise exploratória ampla](consolidados/2026-09-15-appa-Atividade02a-AnaliseExploratoriaAmpla.md)
- [02b: análise exploratória segmentada](consolidados/2026-09-15-appa-Atividade02b-AnaliseExploratoriaSegmentada.md)
- [03a: regressão linear](consolidados/2026-09-15-appa-Atividade03a-RegressaoLinear.md)
- [03b: previsão](consolidados/2026-09-15-appa-Atividade03b-Previsao.md)
- [04: regressão logística](consolidados/2026-09-15-appa-Atividade04-RegressaoLogistica.md)
- [05: avaliação e seleção de modelos](consolidados/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.md)
- [06: métodos de reamostragem](consolidados/2026-09-15-appa-Atividade06-MetodosReamostragem.md)
- [07: expansão e regularização](consolidados/2026-10-05-appa-Atividade07-ExpansaoRegularizacao.md)
- [08: métodos de suavização](consolidados/2026-10-09-appa-Atividade08-MetodosSuavizacao.md)

O relatório original da análise exploratória continua disponível em [2026-08-25-appa-AnaliseExploratoria.md](consolidados/2026-08-25-appa-AnaliseExploratoria.md).

Os scripts de modelagem devem ser executados a partir da raiz:

```text
Rscript estrutura/codigos/2026-09-15-appa-Atividade03a-RegressaoLinear.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade03b-Previsao.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade04-RegressaoLogistica.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade06-MetodosReamostragem.R
```

## Guias e aplicações

- [05b: teoria de Poisson resolvida](resolucoes/aula05b_resolvido.md)
- [05b: consolidado individual](consolidados/aula05b_consolidado.md)
- [05b: Parte D no banco APPA](consolidados/aula05b_parteD_consolidado.md)
- [Ficha da pergunta](consolidados/00_FICHA_PERGUNTA.md)
- [09: splines, GAM e exercícios](consolidados/2026-10-25-appa-Atividade09-SplinesModelosAditivos.md)
- [Guias originais de Poisson](guias-estudo/)

```powershell
Rscript estrutura/codigo/aula05b_poisson.R
Rscript estrutura/codigos/aula10_splines.R
```

As três bases simuladas do guia reproduzem os números esperados. Na prática, a exposição
é de calendário; não há fluxo de tráfego disponível para estimar risco por veículo.

[Oficina: duas perguntas e escolha com CV](consolidados/entrega1_duas_perguntas.md) · [Exploração atualizada](estrutura/resultados/exploratoria/)

Executar todas as etapas: `Rscript estrutura/codigos/executar_atualizacao.R`. Dependências: mgcv e glmnet. Os PDFs históricos permanecem preservados; revisões atuais estão nos consolidados em Markdown.

No Windows, execute `powershell -ExecutionPolicy Bypass -File .\executar_atualizacao.ps1`. Em outro ambiente, use R instalado no PATH.

## Referências

Materiais da disciplina: [Danilo — Teoria do Aprendizado Estatístico](https://github.com/danilopradooficial/teoriaaprendizadoestatistico), versão `fac02f1`. Os guias de Poisson estão em [guias-estudo/](guias-estudo/).
