# Atividade 03b: previsão

Uma previsão precisa responder a uma pergunta definida antes do ajuste. Para este conjunto de dados, uma pergunta possível é estimar a quantidade de vítimas fatais em um boletim a partir do tipo de via, turno e veículos envolvidos.

O código está em [2026-09-15-appa-Atividade03b-Previsao.R](../estrutura/codigos/2026-09-15-appa-Atividade03b-Previsao.R). A divisão foi feita com semente fixa, usando 80% dos boletins para treino e 20% para teste.

## O que deve ser informado

- quais registros foram usados no treinamento e no teste;
- quais variáveis entraram no modelo;
- qual medida foi usada para avaliar o erro;
- um exemplo de previsão e seu valor observado;
- as limitações causadas por valores ausentes e pela diferença entre boletins e notificações.

O código e as métricas geradas ficam na pasta `estrutura/codigos/resultados`.

## Separação dos dados

O conjunto de teste precisa ficar separado durante o ajuste. Avaliar o modelo nos mesmos registros usados para treiná-lo produz uma estimativa otimista do desempenho.

Uma previsão também precisa carregar a incerteza do modelo. Um único número pode parecer preciso mesmo quando a base tem muitos registros ausentes ou poucos casos fatais.

## Resultado obtido

Foram usados 120.940 registros no treino e 30.235 no teste. O erro absoluto médio foi 0,0994, o RMSE foi 0,2360 e o R² no teste foi 0,0535. O modelo linear gerou 653 previsões negativas no teste, impossíveis para uma contagem de vítimas. O desempenho confirma que este modelo simples explica apenas uma parte pequena da variação. O recorte exclui os boletins com `tipo_via` ou `turno` iguais a `NAO DISPONIVEL` (ver Atividade 03a).

## Material

[Aula 04](../materiais-aulas/Aula%2004%20-%20Regress%C3%A3o%20Linear.PDF).

## Nota de Revisão Metodológica (Alinhamento com Aula 04 - Previsão Fora da Amostra)
- **Cálculo Correto do $R^2$ de Teste**: O coeficiente de determinação no conjunto de teste é calculado tomando como referência a média amostral do próprio conjunto de teste: $R^2_{\text{teste}} = 1 - \frac{\sum (y_{i,\text{teste}} - \hat{y}_{i,\text{teste}})^2}{\sum (y_{i,\text{teste}} - \bar{y}_{\text{teste}})^2}$.

## Reexecução em 06/11/2026

[2026-09-15-appa-03b-MetricasPrevisao.csv](../estrutura/codigos/resultados/2026-09-15-appa-03b-MetricasPrevisao.csv)

| treino | teste | mae | rmse | r2_teste | previsoes_negativas |
|---|---|---|---|---|---|
| 120940 | 30235 | 0.0994354 | 0.236015 | 0.0534668 | 653 |

As previsões exportadas ficam na mesma escala dos resíduos e das métricas: não aplico truncagem apenas no CSV.
