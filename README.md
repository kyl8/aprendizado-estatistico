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

O arquivo [Sinistros_2025_2026.csv](estrutura/corpus/2026-08-12-appa-Sinistros_2025_2026.csv) reúne 273.371 registros e 50 variáveis, de janeiro de 2025 a junho de 2026.

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
- [05b: regressão de Poisson](consolidados/2026-10-25-appa-Atividade05b-RegressaoPoisson.md)
- [09: splines e modelos aditivos](consolidados/2026-10-25-appa-Atividade09-SplinesModelosAditivos.md)

O relatório original da análise exploratória continua disponível em [2026-08-25-appa-AnaliseExploratoria.md](consolidados/2026-08-25-appa-AnaliseExploratoria.md).

Todos os scripts devem ser executados a partir da raiz do repositório. Para rodar todas as etapas na ordem:

```text
Rscript estrutura/codigos/executar_atualizacao.R
```

Dependências: `glmnet` e `mgcv`.

Há duas pastas de código, de propósito:

- [`estrutura/codigos/`](estrutura/codigos/README.md) (plural): scripts de cada atividade, com o padrão `YYYY-MM-DD-appa-<Nome>.R`.
- [`estrutura/codigo/`](estrutura/codigo/README.md) (singular): arquivos da Aula 05b e da oficina; o nome e o caminho vêm do guia da disciplina, que manda salvar `estrutura/codigo/aula05b_poisson.R`.

Convenções de dados: os CSVs de métricas usam `write.csv2` (ponto e vírgula, vírgula decimal) nas Atividades 03b a 08; os demais (03a, 05b, 09, exploratória, entrega1) usam `write.csv` (vírgula, ponto decimal). O recorte de modelagem (`boletins_modelo`) exclui boletins com `tipo_via` ou `turno` iguais a `NAO DISPONIVEL`, que quase só ocorrem em fatais.

## Guias e aplicações

- [05b: teoria de Poisson resolvida](resolucoes/aula05b_resolvido.md)
- [05b: consolidado individual](consolidados/aula05b_consolidado.md)
- [05b: Parte D no banco APPA](consolidados/aula05b_parteD_consolidado.md)
- [Ficha da pergunta](consolidados/00_FICHA_PERGUNTA.md)
- [09: splines, GAM e exercícios](consolidados/2026-10-25-appa-Atividade09-SplinesModelosAditivos.md)
- [Guias originais de Poisson](guias-estudo/)
- Nota de numeração: as atividades 04 a 09 correspondem às aulas 05 a 10 (a Atividade 05b é da aula 05b).

As três bases simuladas do guia reproduzem os números esperados. Na prática, a exposição
é de calendário; não há fluxo de tráfego disponível para estimar risco por veículo.

[Oficina: duas perguntas e escolha com CV](consolidados/2026-10-25-appa-OficinaDuasPerguntas.md) · [Exploração atualizada](estrutura/resultados/exploratoria/)

No Windows, execute `powershell -ExecutionPolicy Bypass -File .\executar_atualizacao.ps1`. Em outro ambiente, use R instalado no PATH.

## Referências
Os guias de Poisson estão em [guias-estudo/](guias-estudo/).

## Situação em 11/11/2026

Referência conferida: [Danilo, Estatística (`5c8198e`)](https://github.com/danilopradooficial/teoriaaprendizadoestatistico/tree/5c8198e).
Os PDFs das Aulas 11 (árvores/random forest) e 12 (agrupamento/PCA) foram incorporados.
As aplicações ao APPA e a recompilação do PDF da Entrega 1 estão na [lista de pendências](PENDENCIAS_GRUPO.md).
O pipeline completo foi reexecutado, incluindo a regeneração das métricas, dos gráficos e da base de pico conforme as correções de 06/11.
