# Teoria do Aprendizado Estatístico

Repositório do grupo APPA para a disciplina de Teoria do Aprendizado Estatístico da FATEC. O projeto analisa registros de sinistros de trânsito no Estado de São Paulo.

## Conteúdo

- [entregas](entregas/): relatórios formais e entregas acadêmicas em LaTeX/Sweave;
- [consolidado](consolidado/): atividades e relatórios organizados por etapa;
- [estrutura/banco-de-dados](estrutura/banco-de-dados/): bases preparadas e dados serializados para modelagem;
- [estrutura/corpus](estrutura/corpus/): dicionário e base de sinistros;
- [estrutura/codigos](estrutura/codigos/): scripts de modelagem em R;
- [estrutura/resultados](estrutura/resultados/): métricas e previsões geradas pelos scripts;
- [materiais-aulas](materiais-aulas/): PDFs usados nas aulas.

Os scripts e os resultados usam nomes próprios do grupo, com a data da atualização em 15 de setembro de 2026.

## Entregas Formais

A pasta [entregas/](entregas/) está organizada em duas divisões principais:

- **[entregas/finalizada/](entregas/finalizada/):** versão final consolidada do grupo APPA:
  - [Entrega 1: A Pergunta do Trabalho (PDF)](entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.pdf) ([Fonte Sweave](entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.Rnw))
- **[entregas/modelo_base/](entregas/modelo_base/):** modelo e template original fornecido pela disciplina:
  - [Modelo Base: Pergunta do Trabalho](entregas/modelo_base/entrega-1-pergunta.pdf) ([Fonte Sweave](entregas/modelo_base/entrega-1-pergunta.Rnw))

## Base

O arquivo [Sinistros_2025_2026.csv](estrutura/corpus/2026-08-12-appa-Sinistros_2025_2026.csv) reúne 273.371 registros e 50 variáveis, de janeiro de 2025 a junho de 2026.

O [dicionário de dados](estrutura/corpus/2026-08-11-appa-DicionarioDados.md) explica as colunas, categorias e regras usadas para tratar valores ausentes.

## Atividades

- [01: dados e variáveis](consolidado/2026-09-15-appa-Atividade01-DadosVariaveis.md)
- [02a: análise exploratória ampla](consolidado/2026-09-15-appa-Atividade02a-AnaliseExploratoriaAmpla.md)
- [02b: análise exploratória segmentada](consolidado/2026-09-15-appa-Atividade02b-AnaliseExploratoriaSegmentada.md)
- [03a: regressão linear](consolidado/2026-09-15-appa-Atividade03a-RegressaoLinear.md)
- [03b: previsão](consolidado/2026-09-15-appa-Atividade03b-Previsao.md)
- [04: regressão logística](consolidado/2026-09-15-appa-Atividade04-RegressaoLogistica.md)
- [05: avaliação e seleção de modelos](consolidado/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.md)
- [06: métodos de reamostragem](consolidado/2026-09-15-appa-Atividade06-MetodosReamostragem.md)

O relatório original da análise exploratória continua disponível em [2026-08-25-appa-AnaliseExploratoria.md](consolidado/2026-08-25-appa-AnaliseExploratoria.md).

Os scripts de modelagem devem ser executados a partir da raiz:

```text
Rscript estrutura/codigos/2026-09-15-appa-Atividade03a-RegressaoLinear.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade03b-Previsao.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade04-RegressaoLogistica.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R
Rscript estrutura/codigos/2026-09-15-appa-Atividade06-MetodosReamostragem.R
```
