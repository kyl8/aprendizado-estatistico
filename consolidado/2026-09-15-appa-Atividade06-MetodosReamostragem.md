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
