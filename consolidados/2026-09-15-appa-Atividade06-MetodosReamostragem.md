# Atividade 06: métodos de reamostragem

A divisão treino e teste depende de um único sorteio. Nesta atividade, a validação cruzada repete a avaliação em cinco dobras e o bootstrap mostra quanto um coeficiente varia quando a amostra é reconstituída.

## Validação cruzada

Os mesmos três modelos da Atividade 05 foram avaliados em cinco dobras. Em cada rodada, quatro partes treinam o modelo e uma parte é usada para validação. Assim, cada registro participa uma vez da validação.

| Modelo | MSE médio CV(5) | RMSE CV(5) |
|---|---:|---:|
| m1, via e turno | 0,0581 | 0,2411 |
| m2, veículos | 0,0571 | 0,2390 |
| m3, interações | 0,0567 | 0,2381 |

O m3 continua com o menor erro. A validação cruzada reforça a escolha feita com a divisão 70/30, embora a diferença entre os modelos seja pequena.

## Bootstrap

O bootstrap foi usado para o coeficiente de `qtd_motocicleta` no m2. Foram feitas 300 amostras com reposição, cada uma com o mesmo tamanho da base original.

| Medida | Valor |
|---|---:|
| Coeficiente observado | -0,0175 |
| Erro padrão bootstrap | 0,0016 |
| Intervalo de 95% | -0,0209 a -0,0142 |

O intervalo não contém zero, mas isso não prova que a motocicleta cause menor gravidade. O coeficiente depende das outras variáveis do modelo e do recorte dos boletins.

## Reprodução

O código está em [2026-09-15-appa-Atividade06-MetodosReamostragem.R](../estrutura/codigos/2026-09-15-appa-Atividade06-MetodosReamostragem.R). Os resultados estão em [2026-09-15-appa-06-ValidacaoCruzada.csv](../estrutura/resultados/2026-09-15-appa-06-ValidacaoCruzada.csv) e [2026-09-15-appa-06-BootstrapMotocicleta.csv](../estrutura/resultados/2026-09-15-appa-06-BootstrapMotocicleta.csv).

## Material

[Aula 07: métodos de reamostragem](../materiais-aulas/Aula%2007%20-%20M%C3%A9todos%20de%20Reamostragem.PDF).

## Nota de Revisão Metodológica (Alinhamento com Aula 07 - Métodos de Reamostragem)
- **Reprodutibilidade em Validação Cruzada ($k$-fold CV)**: A partição das dobras utiliza semente fixa (`set.seed(42)`) e passagem explícita de argumentos para garantir reprodutibilidade exata do erro estimado $CV_{(k)} = \frac{1}{k}\sum_{j=1}^k MSE_j$.

## Reexecução em 25/10/2026

Refiz o script sobre o banco APPA com a leitura Latin-1 corrigida. Os valores atuais são os das tabelas abaixo; os CSVs mantêm a precisão completa.

[2026-09-15-appa-06-ValidacaoCruzada.csv](../estrutura/resultados/2026-09-15-appa-06-ValidacaoCruzada.csv)

| modelo | mse_cv5 | rmse_cv5 |
|---|---|---|
| m1_tipo_via_turno | 0.0581198 | 0.24108 |
| m2_veiculos | 0.0571435 | 0.239047 |
| m3_interacoes | 0.0567865 | 0.238299 |

[2026-09-15-appa-06-BootstrapMotocicleta.csv](../estrutura/resultados/2026-09-15-appa-06-BootstrapMotocicleta.csv)

| coeficiente_observado | erro_padrao_bootstrap | ic_95_inferior | ic_95_superior | replicacoes |
|---|---|---|---|---|
| -0.017502 | 0.0016399 | -0.0208771 | -0.0142076 | 300 |
