# Atividade 03b: previsão

Uma previsão precisa responder a uma pergunta definida antes do ajuste. Para este conjunto de dados, uma pergunta possível é estimar a quantidade de vítimas fatais em um boletim a partir do tipo de via, turno e veículos envolvidos.

O código está em [2026-09-15-appa-Atividade03b-Previsao.R](../estrutura/codigos/2026-09-15-appa-Atividade03b-Previsao.R). A divisão foi feita com semente fixa, usando 80% dos boletins para treino e 20% para teste.

## O que deve ser informado

- quais registros foram usados no treinamento e no teste;
- quais variáveis entraram no modelo;
- qual medida foi usada para avaliar o erro;
- um exemplo de previsão e seu valor observado;
- as limitações causadas por valores ausentes e pela diferença entre boletins e notificações.

O código e as métricas geradas ficam na pasta `estrutura/resultados`.

## Separação dos dados

O conjunto de teste precisa ficar separado durante o ajuste. Avaliar o modelo nos mesmos registros usados para treiná-lo produz uma estimativa otimista do desempenho.

Uma previsão também precisa carregar a incerteza do modelo. Um único número pode parecer preciso mesmo quando a base tem muitos registros ausentes ou poucos casos fatais.

## Resultado obtido

Foram usados 121.466 registros no treino e 30.367 no teste. O erro absoluto médio foi 0,1013, o RMSE foi 0,2458 e o R² no teste foi 0,1068. O desempenho confirma que este modelo simples explica apenas uma parte pequena da variação.

## Material

[Aula 04](../materiais-aulas/Aula%2004%20-%20Regress%C3%A3o%20Linear.PDF).
