# Atividade 05: avaliação e seleção de modelos

Esta atividade compara modelos com dados que não participaram do ajuste. A pergunta é simples: qual modelo mantém o menor erro quando recebe registros novos?

## Recorte

Foram usados 151.175 boletins policiais (sem os marcadores `NAO DISPONIVEL` de via e turno; ver Atividade 03a). A base foi separada em três partes antes dos ajustes:

- 60% para treino, com 90.767 registros;
- 20% para validação, com 30.066 registros, onde o modelo é escolhido;
- 20% para teste, com 30.342 registros, usado uma única vez para o modelo escolhido;
- resposta: `qtd_gravidade_fatal`;
- preditores: tipo de via, turno e quantidades de veículos.

As notificações ficaram fora do recorte porque têm origem e preenchimento diferentes dos boletins.

## Modelos comparados

O primeiro modelo usa apenas `tipo_via` e `turno`. O segundo acrescenta pedestres, bicicletas, motocicletas, automóveis, ônibus e caminhões (os mesmos preditores das Atividades 03 e 04). O terceiro inclui as mesmas variáveis e a interação entre via e turno.

| Modelo | RMSE treino | RMSE validação | MAE validação | R² validação |
|---|---:|---:|---:|---:|
| m1, via e turno | 0,2411 | 0,2487 | 0,1028 | 0,0345 |
| m2, veículos | 0,2390 | 0,2465 | 0,1012 | 0,0511 |
| m3, interações | 0,2386 | 0,2460 | 0,1007 | 0,0552 |

## Escolha

O modelo escolhido foi o m3, porque teve o menor RMSE na **validação**. No teste, reservado para esse único modelo, o RMSE foi 0,2294, o MAE 0,0967 e o R² 0,0520. A diferença entre os candidatos é pequena, então não é correto dizer que ele resolve sozinho a previsão da gravidade: explica cerca de 5% da variação.

O código está em [2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R](../estrutura/codigos/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R). Os números ficam em [2026-09-15-appa-05-AvaliacoesModelos.csv](../estrutura/codigos/resultados/2026-09-15-appa-05-AvaliacoesModelos.csv) e [2026-09-15-appa-05-ModeloEscolhido.csv](../estrutura/codigos/resultados/2026-09-15-appa-05-ModeloEscolhido.csv). Nas versões anteriores a escolha e o relato usavam o mesmo conjunto de teste, o que torna o erro otimista; a divisão em três partes corrige isso. A partição é diferente da das Atividades 03b e 04 (80/20), então os erros de teste não são comparáveis entre atividades.

## Material

[Aula 06: avaliação e seleção de modelos](../materiais-aulas/Aula%2006%20-%20Avalia%C3%A7%C3%A3o%20e%20Sele%C3%A7%C3%A3o%20de%20Modelos.PDF).

## Nota de Revisão Metodológica (Alinhamento com Aula 06 - Avaliação e Seleção de Modelos)
- **Penalização de Complexidade ($AIC$, $BIC$, $C_p$ e $R^2_{\text{ajustado}}$)**: Os critérios de seleção penalizam o número de parâmetros $p$ sobre a soma de quadrados dos resíduos de treino ($AIC = n\log(RSS/n) + 2p$ e $BIC = n\log(RSS/n) + p\log(n)$), enquanto a avaliação direta em validação utiliza o $R^2_{\text{teste}}$ referenciado em $\bar{y}_{\text{teste}}$.

## Reexecução em 06/11/2026

| modelo | rmse_treino | rmse_validacao | mae_validacao | r2_validacao | vencedor |
|---|---|---|---|---|---|
| m1_tipo_via_turno | 0.241114 | 0.248675 | 0.10279 | 0.0344667 | FALSE |
| m2_veiculos | 0.239002 | 0.246526 | 0.101218 | 0.0510862 | FALSE |
| m3_interacoes | 0.238612 | 0.245991 | 0.100671 | 0.0552007 | TRUE |

Teste do modelo escolhido: rmse 0.229383, mae 0.0967233, r2 0.0519615.
