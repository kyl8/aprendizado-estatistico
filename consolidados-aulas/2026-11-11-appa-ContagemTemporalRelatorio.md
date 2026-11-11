# Contagem temporal de sinistros — avaliação complementar

**APPA · apoio de IA · estudo retrospectivo e exploratório.** A pergunta oficial de pico permanece no [estudo principal](2026-11-11-appa-EstudoPicoRelatorio.md). Esta análise examina a pergunta alternativa: **quantos sinistros registrados são esperados em uma hora de um dia do calendário?**

## Banco, alvo e preditoras

Usamos os **151.591 boletins com data e hora válidas** de janeiro/2025 a junho/2026. Aqui, tipo de via não é preditor: os 416 casos com via indisponível e horário válido permanecem nas contagens. Essa é a razão da diferença em relação aos 151.175 registros da classificação de pico.

O alvo é o número de boletins por **data × hora**. A grade completa tem **546 dias × 24 horas = 13.104 células**, incluindo **285 zeros**. O código verifica que a soma das contagens coincide com o total de boletins elegíveis e que cada célula é única. As preditoras são a hora do dia (24 categorias) e o dia da semana (7 categorias), conhecidos no calendário. A hora é válida nesta tarefa: o alvo é uma contagem futura, e não o indicador de pico definido pela própria hora.

Cada célula representa uma hora de calendário, de exposição nominal igual a 1; por isso não há offset variável. Não há dado sobre volume de veículos em circulação. Os modelos descrevem frequência de registros, não risco por veículo, por pessoa ou por viagem. A cobertura dos registros também pode variar entre datas.

## Ferramentas e avaliação

Poisson usa ligação log e produz médias não negativas para contagens. A linha de base é a média de boletins por célula de hora no treino, sem diferenciar horários ou dias da semana. Ambos usam os mesmos períodos e observações de teste.

- **Treino:** janeiro a dezembro de 2025, 8.760 células.
- **Teste:** janeiro a junho de 2026, 4.344 células.
- **Preditoras do Poisson:** `hora + dia`, sem identificação de meses futuros e sem usar contagens do teste no ajuste.

O modelo assume que o perfil de hora e dia aprendido em 2025 se transporta para o primeiro semestre de 2026. Não contém tendência, sazonalidade anual, feriados ou interação entre hora e dia. Portanto, fornece uma referência temporal simples, não uma busca pelo melhor modelo possível. O teste já havia sido examinado em estudos anteriores da base; não é uma validação inédita.

## Resultados no teste

| Modelo | RMSE (sinistros por célula) | MAE |
|---|---:|---:|
| Média do treino | 7,2988 | 5,9803 |
| Poisson | 5,2220 | 3,9630 |

O RMSE caiu cerca de **28,5%**. A diferença pareada de MSE, base menos Poisson, foi **26,0032**, com intervalo percentílico de 95% **22,5614 a 29,4605**, usando 1.000 reamostragens circulares de blocos de sete dias no teste. O intervalo é para diferença de **erros quadráticos**, não para RMSE, e não deve ser apresentado como número de sinistros evitados.

O bootstrap conserva os 24 horários de cada dia e dias consecutivos dentro dos blocos. Trata os ajustes como fixos, supõe estabilidade aproximada dos blocos e não mede toda a incerteza de desenvolvimento. [Métricas](../estrutura/codigos/resultados/contagem-temporal/met.csv), [previsões](../estrutura/codigos/resultados/contagem-temporal/prev.csv), [incerteza](../estrutura/codigos/resultados/contagem-temporal/incerteza.csv) e [perfil por hora](../estrutura/codigos/resultados/contagem-temporal/perfil-horario-teste.png).

## Sobredispersão e testes de hipótese

A dispersão de Pearson no treino foi **1,9238**, superior a 1. A suposição de variância igual à média do Poisson é insuficiente como descrição da dispersão. Foi ajustado também um quase-Poisson: os coeficientes e médias são iguais aos do Poisson, enquanto a incerteza convencional muda. O quase-Poisson não é uma segunda previsão independente e não recebe outra linha no placar.

Para inferência, usamos a covariância HC1 agrupada por data, com 365 datas de treino, e testes conjuntos de Wald:

| Hipótese nula no treino | Estatística | Graus de liberdade | p após Holm |
|---|---:|---:|---:|
| Todos os efeitos de hora são zero, ajustando por dia | 4144,05 | 23 | < 0,001 |
| Todos os efeitos de dia são zero, ajustando por hora | 124,57 | 6 | < 0,001 |

Os testes apontam associação do perfil de calendário com as contagens, sob as suposições do modelo. Não são testes de causalidade. O agrupamento permite dependência dentro do dia, mas não remove automaticamente dependência entre datas ou dependência espacial. Holm corrige a família dos dois testes; o diagnóstico de dispersão não é um teste adicional nessa família. Para p-valores extremamente pequenos, a coluna `log_p_valor` preserva o logaritmo calculado quando o valor numérico arredonda para zero. [Testes](../estrutura/codigos/resultados/contagem-temporal/testes.csv) e [coeficientes com intervalos agrupados](../estrutura/codigos/resultados/contagem-temporal/coefs.csv).

Métodos: [vcovCL do pacote sandwich](https://sandwich.r-forge.r-project.org/reference/vcovCL.html) e [correção de Holm no R](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/p.adjust.html).

## Discussão para o artigo

O calendário fornece mais informação sobre a frequência de registros do que a média constante nesta divisão temporal. Isso é uma evidência para a pergunta de contagem e não pode ser usado para afirmar que o classificador de pico é bom. A logística continua com discriminação modesta, enquanto o Poisson tem outro alvo e outra unidade; seus Brier e RMSE não são comparáveis numericamente.

A escolha entre as perguntas deve considerar finalidade e disponibilidade dos dados, não apenas a maior melhora percentual. Para inferência sobre risco, falta a exposição de tráfego. Para previsão operacional de contagens, faltam testes em períodos adicionais e avaliação de tendência, sazonalidade e mudanças de registro; qualquer desenvolvimento posterior deve evitar tratar o mesmo teste como se ainda estivesse reservado.

Reproduzir na raiz: `Rscript estrutura/codigos/2026-11-11-appa-ContagemTemporal.R`. Dependências: R e `sandwich`. A [auditoria](../estrutura/codigos/resultados/contagem-temporal/auditoria.csv) registra eventos, zeros, unidades e tamanhos das partições.
