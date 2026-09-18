# Atividade 05: avaliação e seleção de modelos

Esta atividade compara modelos com dados que não participaram do ajuste. A pergunta é simples: qual modelo mantém o menor erro quando recebe registros novos?

## Recorte

Foram usados 151.833 boletins policiais. A base foi separada antes dos ajustes:

- 70% para treino, com 106.283 registros;
- 30% para teste, com 45.550 registros;
- resposta: `qtd_gravidade_fatal`;
- preditores: tipo de via, turno e quantidades de veículos.

As notificações ficaram fora do recorte porque têm origem e preenchimento diferentes dos boletins.

## Modelos comparados

O primeiro modelo usa apenas `tipo_via` e `turno`. O segundo acrescenta pedestres, motocicletas, automóveis, ônibus e caminhões. O terceiro inclui as mesmas variáveis, interações entre via e turno e o total de veículos.

| Modelo | RMSE treino | RMSE teste | MAE teste | R² teste |
|---|---:|---:|---:|---:|
| m1, via e turno | 0,2395 | 0,2447 | 0,1015 | 0,0858 |
| m2, veículos | 0,2375 | 0,2424 | 0,1003 | 0,1025 |
| m3, interações | 0,2365 | 0,2415 | 0,0998 | 0,1092 |

## Escolha

O modelo escolhido foi o m3, porque teve o menor RMSE no teste. A diferença é pequena, então não é correto dizer que ele resolve sozinho a previsão da gravidade. Ele explica apenas uma parte da variação observada.

O código está em [2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R](../estrutura/codigos/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R). Os números ficam em [2026-09-15-appa-05-AvaliacoesModelos.csv](../estrutura/resultados/2026-09-15-appa-05-AvaliacoesModelos.csv).

## Material

[Aula 06: avaliação e seleção de modelos](../materiais-aulas/Aula%2006%20-%20Avalia%C3%A7%C3%A3o%20e%20Sele%C3%A7%C3%A3o%20de%20Modelos.PDF).
