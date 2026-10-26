# Atividade 05b: Regressão de Poisson

A atividade agrega os boletins APPA por mês, região administrativa e turno. A resposta é o número de sinistros em cada combinação, preservando as 157 células sem ocorrência.

## Modelo e validação

O ajuste usa regressão de Poisson com mês, região e turno como preditores. A dispersão de Pearson foi 2,223, acima de 1; por isso os erros padrão também são disponibilizados pelo ajuste quase-Poisson.

| modelo | RMSE em validação cruzada de 5 dobras |
|---|---:|
| média | 206,345 |
| MQO | 104,888 |
| Poisson | 20,011 |

O Poisson teve o menor erro e preserva a escala não negativa. O resultado descreve associações na tabela agregada; não deve ser usado para atribuir causalidade a turno ou região.

## Saídas

- `2026-10-25-appa-05b-ContagensSinistros.csv`
- `2026-10-25-appa-05b-MetricasPoisson.csv`
- `2026-10-25-appa-05b-CoeficientesPoisson.csv`
- `2026-10-25-appa-05b-ObservadoPrevistoPoisson.png`
