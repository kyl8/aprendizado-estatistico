# Demonstração de contagem temporal — APPA

**Apoio:** ChatGPT. Esta aplicação demonstra Poisson e quase-Poisson em um alvo de contagem. Registra preparação, ajuste e saídas, sem concluir sobre o fenômeno ou escolher a ferramenta definitiva do trabalho. A pergunta de pico continua como contexto principal; o [mapa dos materiais](FERRAMENTAS-E-DEMONSTRACOES.md) distingue os exemplos.

## 1. Material e pergunta usada como exemplo

O [guia 05b de Poisson](../materiais-tutora/GUIA_ESTUDO_aula05b.md) apresenta regressão para contagens e está marcado como **tema extra, não dado em aula**. A pergunta usada para praticar é: **quantos boletins são registrados em uma hora de um dia do calendário?**

## 2. Banco, alvo e preditoras

São 151.591 boletins com data e hora válidas. Como tipo de via não é preditor deste exemplo, os 416 casos com via indisponível e horário válido permanecem nas contagens. Isso explica a diferença para os 151.175 registros do exemplo de classificação de pico.

- **Alvo:** número de boletins por data × hora.
- **Grade:** 546 dias × 24 horas = 13.104 células, incluindo 285 zeros.
- **Preditoras:** hora do dia e dia da semana, como categorias do calendário.
- **Exposição nominal:** uma hora por célula; sem offset variável. Não há volume de tráfego na base.

A hora pode entrar neste exemplo porque o alvo é uma contagem. No exemplo de classificação, ela determina o indicador de pico e fica fora dos preditores. O código verifica que a soma das contagens conserva os eventos e que cada célula é única.

## 3. Sequência da demonstração

1. Completar a grade de calendário, preservando células sem registros.
2. Separar 2025 para treino (8.760 células) e janeiro–junho/2026 para teste (4.344).
3. Ajustar a linha de base pela média do treino e o Poisson `n ~ hora + dia`, com ligação log.
4. Ajustar também quase-Poisson para demonstrar a diferença na incerteza, mantendo a mesma especificação de média.
5. Aplicar ao teste e registrar erros, previsões e perfil por hora.

O exemplo não inclui tendência, feriados, sazonalidade anual ou interação hora × dia. Os dados já foram examinados antes; a demonstração temporal é retrospectiva.

## 4. Saídas observadas

| Ajuste | RMSE em sinistros por célula | MAE |
|---|---:|---:|
| Média do treino | 7,2988 | 5,9803 |
| Poisson | 5,2220 | 3,9630 |

A diferença percentual entre esses RMSE nesta execução foi cerca de 28,5%. O propósito é demonstrar o cálculo e a comparação na mesma unidade e partição, sem certificar o modelo ou afirmar desempenho futuro. A dispersão de Pearson calculada no treino foi 1,9238; esse número permite discutir a suposição de variância do Poisson. Poisson e quase-Poisson produziram os mesmos coeficientes e médias neste ajuste; não são duas previsões independentes.

[Métricas](../estrutura/codigos/resultados/contagem-temporal/met.csv), [previsões](../estrutura/codigos/resultados/contagem-temporal/prev.csv), [auditoria](../estrutura/codigos/resultados/contagem-temporal/auditoria.csv) e [perfil por hora](../estrutura/codigos/resultados/contagem-temporal/perfil-horario-teste.png).

## 5. Complementos opcionais da revisão

Wald agrupado por data, HC1, Holm e bootstrap em blocos semanais foram acrescentados com IA; não foram identificados como ferramentas dos PDFs conferidos. A tabela apenas registra suas saídas para exemplificar testes conjuntos:

| Hipótese nula usada no exemplo | Estatística | Graus de liberdade | p após Holm |
|---|---:|---:|---:|
| Coeficientes de hora iguais a zero, ajustando por dia | 4144,05 | 23 | < 0,001 |
| Coeficientes de dia iguais a zero, ajustando por hora | 124,57 | 6 | < 0,001 |

Não encerramos uma conclusão sobre associação ou causalidade a partir desses números. O agrupamento usa 365 datas de treino e depende de suposições sobre as datas e o modelo. Holm é aplicado à família dos dois testes. `log_p_valor` registra o logaritmo quando um p-valor muito pequeno arredonda numericamente para zero. [Testes](../estrutura/codigos/resultados/contagem-temporal/testes.csv) e [coeficientes](../estrutura/codigos/resultados/contagem-temporal/coefs.csv). Métodos: [vcovCL](https://sandwich.r-forge.r-project.org/reference/vcovCL.html) e [p.adjust](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/p.adjust.html).

No exemplo de bootstrap, a diferença de MSE base menos Poisson foi 26,0032; o intervalo percentílico registrado foi 22,5614 a 29,4605, com 1.000 reamostragens circulares de blocos de sete dias. É uma saída em erros quadráticos, não número de sinistros evitados. Os ajustes ficam fixos e a reamostragem supõe estabilidade aproximada dos blocos. [Saída](../estrutura/codigos/resultados/contagem-temporal/incerteza.csv).

## 6. Roteiro para discutir a aplicação

Mostrar como as linhas individuais viram contagens, onde entram os zeros, por que as preditoras são de calendário, como ocorre a divisão temporal e como são calculados os erros. Comparar as saídas sem transformar a execução em certeza sobre o problema. Este exemplo e a [classificação de pico](2026-11-11-appa-EstudoPicoRelatorio.md) têm alvos e unidades diferentes; não se comparam Brier e RMSE como um placar único.

Reproduzir na raiz: `Rscript estrutura/codigos/2026-11-11-appa-ContagemTemporal.R`. Dependências: R e `sandwich`.
