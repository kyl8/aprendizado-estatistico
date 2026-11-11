# Teoria do Aprendizado Estatístico

**Grupo:** APPA — Arthur Galvão, Pedro Henrique e Ailana.
**Apoio:** ChatGPT.

Repositório do grupo APPA para a disciplina de Teoria do Aprendizado Estatístico da FATEC. O projeto analisa registros de sinistros de trânsito no Estado de São Paulo.

## Conteúdo

- [entregas](entregas/): relatórios formais e entregas acadêmicas em LaTeX/Sweave;
- [consolidados-aulas](consolidados-aulas/): atividades e relatórios organizados por etapa;
- [consolidados-tutora](consolidados-tutora/): estudos e resoluções dos guias;
- [estrutura/corpus/banco-de-dados](estrutura/corpus/banco-de-dados/): bases preparadas e dados serializados para modelagem;
- [estrutura/corpus](estrutura/corpus/): dicionário e base de sinistros;
- [estrutura/codigos](estrutura/codigos/): scripts de modelagem em R;
- [estrutura/codigos/resultados](estrutura/codigos/resultados/): métricas e previsões geradas pelos scripts;
- [materiais-aulas](materiais-aulas/): PDFs usados nas aulas;
- [materiais-tutora](materiais-tutora/): guias de estudo.

Os scripts e resultados usam o prefixo de data e grupo `YYYY-MM-DD-appa`.

## Entregas Formais

A pasta [entregas/](entregas/) reúne a entrega final e os modelos da disciplina:

- **[entregas/entrega-1/](entregas/entrega-1/):** versão final consolidada do grupo APPA:
  - [Entrega 1: A Pergunta do Trabalho (PDF)](entregas/entrega-1/2026-10-02-appa-entrega-1-pergunta.pdf) ([Fonte Sweave](entregas/entrega-1/2026-10-02-appa-entrega-1-pergunta.Rnw), [LaTeX](entregas/entrega-1/2026-10-02-appa-entrega-1-pergunta.tex))
- **[entregas/entrega-1/modelo-professor/](entregas/entrega-1/modelo-professor/):** modelo e template original fornecido pela disciplina:
  - [Modelo Base: Pergunta do Trabalho](entregas/entrega-1/modelo-professor/entrega-1-pergunta.pdf) ([Fonte Sweave](entregas/entrega-1/modelo-professor/entrega-1-pergunta.Rnw), [LaTeX](entregas/entrega-1/modelo-professor/entrega-1-pergunta.tex))

## Base

O arquivo [Sinistros_2025_2026.csv](estrutura/corpus/2026-08-12-appa-Sinistros_2025_2026.csv) reúne 273.371 registros e 50 variáveis, de janeiro de 2025 a junho de 2026.

O [dicionário de dados](estrutura/corpus/2026-08-11-appa-DicionarioDados.md) explica as colunas, categorias e regras usadas para tratar valores ausentes.

## Atividades

- [Estudo principal de pico: problema, alvo, modelos, hipótese e teste temporal](consolidados-aulas/2026-11-11-appa-EstudoPicoRelatorio.md)
- [Contagem por hora: Poisson, sobredispersão e teste temporal](consolidados-aulas/2026-11-11-appa-ContagemTemporalRelatorio.md)

- [01: dados e variáveis](consolidados-aulas/2026-09-15-appa-Atividade01-DadosVariaveis.md)
- [02a: análise exploratória ampla](consolidados-aulas/2026-09-15-appa-Atividade02a-AnaliseExploratoriaAmpla.md)
- [02b: análise exploratória segmentada](consolidados-aulas/2026-09-15-appa-Atividade02b-AnaliseExploratoriaSegmentada.md)
- [03a: regressão linear](consolidados-aulas/2026-09-15-appa-Atividade03a-RegressaoLinear.md)
- [03b: previsão](consolidados-aulas/2026-09-15-appa-Atividade03b-Previsao.md)
- [04: regressão logística](consolidados-aulas/2026-09-15-appa-Atividade04-RegressaoLogistica.md)
- [05: avaliação e seleção de modelos](consolidados-aulas/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.md)
- [06: métodos de reamostragem](consolidados-aulas/2026-09-15-appa-Atividade06-MetodosReamostragem.md)
- [07: expansão e regularização](consolidados-aulas/2026-10-05-appa-Atividade07-ExpansaoRegularizacao.md)
- [08: métodos de suavização](consolidados-aulas/2026-10-09-appa-Atividade08-MetodosSuavizacao.md)
- [05b: regressão de Poisson](consolidados-aulas/2026-10-25-appa-Atividade05b-RegressaoPoisson.md)
- [09: splines e modelos aditivos](consolidados-aulas/2026-10-25-appa-Atividade09-SplinesModelosAditivos.md)

O relatório original da análise exploratória continua disponível em [2026-08-25-appa-AnaliseExploratoria.md](consolidados-aulas/2026-08-25-appa-AnaliseExploratoria.md).

Todos os scripts devem ser executados a partir da raiz do repositório. Para rodar todas as etapas na ordem:

```text
Rscript estrutura/codigos/executar_atualizacao.R
```

Dependências: `glmnet`, `mgcv`, `rpart`, `randomForest`, `cluster` e `sandwich`.

As verificações do alvo e das métricas podem ser executadas com `Rscript estrutura/codigos/testar_estudo_pico.R`. Os estudos atuais incluem inferência agrupada por data, ajuste de Holm, diagnóstico de calibração e intervalos de incerteza por blocos semanais; os limites estão descritos nos relatórios de pico e de contagem temporal.

Os scripts de atividades, da Aula 05b e da oficina ficam em [`estrutura/codigos/`](estrutura/codigos/README.md); as instruções dos guias estão em [README-guias](estrutura/codigos/README-guias.md).

Convenções de dados: os CSVs de métricas usam `write.csv2` (ponto e vírgula, vírgula decimal) nas Atividades 03b a 08; os demais (03a, 05b, 09, exploratória, entrega1) usam `write.csv` (vírgula, ponto decimal). O recorte de modelagem (`boletins_modelo`) exclui boletins com `tipo_via` ou `turno` iguais a `NAO DISPONIVEL`, que quase só ocorrem em fatais.

## Guias e aplicações

- [05b: teoria de Poisson resolvida](consolidados-tutora/aula05b_resolvido.md)
- [05b: consolidado individual](consolidados-tutora/aula05b_consolidado.md)
- [05b: Parte D no banco APPA](consolidados-tutora/aula05b_parteD_consolidado.md)
- [Ficha da pergunta](consolidados-aulas/00_FICHA_PERGUNTA.md)
- [09: splines, GAM e exercícios](consolidados-aulas/2026-10-25-appa-Atividade09-SplinesModelosAditivos.md)
- [Guias originais de Poisson](materiais-tutora/)
- Nota de numeração: as atividades 04 a 09 correspondem às aulas 05 a 10 (a Atividade 05b é da aula 05b).

As três bases simuladas do guia reproduzem os números esperados. Na prática, a exposição
é de calendário; não há fluxo de tráfego disponível para estimar risco por veículo.

[Oficina: duas perguntas e escolha com CV](consolidados-aulas/2026-10-25-appa-OficinaDuasPerguntas.md) · [Exploração atualizada](estrutura/codigos/resultados/exploratoria/)

No Windows, execute `powershell -ExecutionPolicy Bypass -File .\executar_atualizacao.ps1`. Em outro ambiente, use R instalado no PATH.

## Referências
Os guias de Poisson estão em [materiais-tutora/](materiais-tutora/).

## Situação em 11/11/2026

As aplicações das Aulas 11 e 12 estão no [consolidado das atividades 10 e 11](consolidados-aulas/2026-11-11-appa-Atividades10_11.md), com [exercícios](consolidados-tutora/2026-11-11-appa-Atividades10_11.md). A Entrega 1 foi recompilada e revisada; decisões que dependem do grupo e do professor constam na [lista de pendências](PENDENCIAS_GRUPO.md).
