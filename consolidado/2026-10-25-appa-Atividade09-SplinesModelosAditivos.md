# Atividade 09: Splines e modelos aditivos

Esta continuação da atividade de suavização compara uma reta, polinômio de grau 2, splines naturais e um GAM para relacionar veículos envolvidos e vítimas fatais nos boletins APPA.

## Validação cruzada

A execução usou amostra fixa de 12.000 boletins e cinco dobras.

| modelo | RMSE CV(5) |
|---|---:|
| reta | 0,2500 |
| polinômio grau 2 | 0,2503 |
| spline natural df 3 | 0,2494 |
| spline natural df 5 | 0,2491 |
| spline natural df 7 | 0,2491 |
| GAM | 0,2490 |

O ganho do GAM sobre a spline é pequeno. A resposta tem muitos zeros, portanto estas curvas servem para explorar forma funcional e não para substituir o modelo de contagens da atividade Poisson.

## Arquivos

- `estrutura/codigos/2026-10-25-appa-Atividade09-SplinesModelosAditivos.R`
- `estrutura/resultados/2026-10-25-appa-09-MetricasSplines.csv`
- `estrutura/resultados/2026-10-25-appa-09-SplinesGAM.png`
