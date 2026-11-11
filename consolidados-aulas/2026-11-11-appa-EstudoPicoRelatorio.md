# Estudo de sinistros nos horários de pico — APPA

**Grupo:** Arthur Galvão, Pedro Henrique e Ailana. **Apoio:** ChatGPT. Este relatório reúne resultados reproduzíveis para orientar o futuro artigo; não registra avaliação individual nem identifica efeitos causais.

## 1. Motivação e problema

O planejamento de fiscalização e mobilidade precisa conhecer padrões nos registros de sinistros. Os períodos de pico concentram deslocamentos e podem apresentar perfis distintos de ocorrência. Os dados disponíveis, porém, contêm apenas eventos registrados: não informam quantos veículos ou pessoas circularam sem sofrer sinistro. Assim, permitem comparar características **entre boletins**, mas não estimar risco por viagem ou por veículo, nem concluir que uma característica causou um acidente.

## 2. Pergunta e hipótese

**Pergunta principal:** que características registradas dos sinistros estão associadas à ocorrência em horários de pico?

Hipótese examinada no treino: **H₀:** após ajustar por dia da semana e região administrativa, os coeficientes associados ao tipo de via são zero; **H₁:** pelo menos um desses coeficientes é diferente de zero. Foi usado um teste de razão de verossimilhanças entre regressões logísticas aninhadas e nível de referência de 5%. Esse teste depende das suposições do modelo, inclusive independência dos boletins e especificação adequada. Dependências por dia, local ou região podem alterar a incerteza; o resultado deve ser tratado como exploratório, não como prova causal.

## 3. Banco, alvo e preditoras

A fonte é a base de sinistros de trânsito de São Paulo do Infosiga, de janeiro de 2025 a junho de 2026: 273.371 registros brutos de 50 colunas, sendo 151.833 boletins de sinistros fatais ou não fatais. Notificações não são a unidade deste estudo. Após exigir data e hora válidas e excluir via `NAO DISPONIVEL`, restaram **151.175 boletins**; não houve exclusão adicional por campos ausentes entre as três preditoras usadas. A exclusão da via indisponível altera a população analisada e deve ser informada no artigo.

O **alvo** `pico` vale 1 para 06:30–08:30, 11:30–13:30 ou 17:00–19:30, incluindo os extremos; fora dessas janelas vale 0. Foram usadas três **preditoras** categóricas: tipo de via, dia da semana e região administrativa. Hora e turno ficam fora por determinarem ou revelarem diretamente o alvo. Gravidade, tipo de sinistro e modais envolvidos também não entram neste experimento, pois são características registradas após o evento e respondem a outra pergunta. O modelo classifica o horário de um boletim existente: não é um sistema de previsão antecipada de sinistros.

## 4. Ferramentas e desenho de avaliação

| Ferramenta | Papel neste estudo | Limite |
|---|---|---|
| Frequência de pico no treino | Linha de base para probabilidades e classe majoritária. | Não diferencia os perfis. |
| Regressão logística | Modelo principal; fornece probabilidades, razões de chances e teste ajustado. | Exige cuidado com especificação e dependência; associação não é causa. |
| Árvore de classificação | Comparação flexível; poda escolhida por validação interna no treino. | Pode ser instável e não fornece causalidade. |
| PCA | Exploração não supervisionada de variáveis numéricas; existe em [relatório separado](2026-11-11-appa-Atividades10_11.md). | Não usa o alvo e não substitui um classificador. |
| Poisson/quase-Poisson | Análise alternativa de contagens por calendário, em [relatório próprio](2026-10-25-appa-Atividade05b-RegressaoPoisson.md). | Tem outro alvo e outra unidade; RMSE de contagens não é comparável ao Brier da classificação. |

Usamos divisão **temporal**, sem embaralhar: 01/01–31/12/2025 para treino (**101.666**) e 01/01–30/06/2026 para teste (**49.509**). Os níveis das categorias são aprendidos no treino; o script para se aparecer categoria inédita no teste. A probabilidade constante da linha de base, o ajuste da logística e a poda da árvore usam apenas o treino. O limiar de classe de 0,5 é fixo; não foi escolhido pelo teste. A prevalência de pico foi 39,97% no treino e 40,58% no teste.

Essa é uma avaliação retrospectiva, feita depois de estudos anteriores com a mesma base; não constitui um teste historicamente intocado. A validação cruzada anterior da análise de Poisson dividiu células do mesmo período e não demonstra previsão para meses futuros.

## 5. Relatório das ferramentas no teste temporal

| Modelo | Brier ↓ | AUC ↑ | Acurácia | Sensibilidade ao pico | Especificidade |
|---|---:|---:|---:|---:|---:|
| Frequência do treino | 0,241157 | 0,5000 | 0,5942 | 0,0000 | 1,0000 |
| Logística | 0,237184 | 0,5757 | 0,5943 | 0,0185 | 0,9875 |
| Árvore | 0,237546 | 0,5679 | 0,5944 | 0,0352 | 0,9763 |

O Brier mede o erro quadrático médio das probabilidades; menor é melhor. A logística melhora **0,003972** em relação à base, cerca de **1,65%** do Brier da base. Um bootstrap pareado por dia no teste, com 1.000 reamostragens, deu intervalo percentílico de **0,003353 a 0,004567** para essa diferença. O intervalo descreve a variabilidade entre dias observados no período de teste e não garante desempenho em outros anos ou fontes.

A AUC de 0,576 indica discriminação modesta. A acurácia quase não melhora sobre a classe majoritária e, com limiar 0,5, a logística identifica somente **1,85%** dos boletins de pico. Não seria adequado apresentá-la como classificador operacional eficaz. A árvore também tem discriminação modesta; sua comparação é descritiva, pois o mesmo teste foi visto para os dois modelos.

Gráficos de [Brier](../estrutura/codigos/resultados/estudo-pico/brier-teste.png) e [calibração](../estrutura/codigos/resultados/estudo-pico/calibracao-teste.png), além das [métricas](../estrutura/codigos/resultados/estudo-pico/metricas.csv), [probabilidades](../estrutura/codigos/resultados/estudo-pico/pred.csv) e [auditoria](../estrutura/codigos/resultados/estudo-pico/auditoria.csv), permitem conferir os resultados.

## 6. Teste de hipótese e interpretação

No treino, a comparação da logística com e sem tipo de via produziu $\chi^2(1)=3,7925$, **p = 0,0515**. Ao nível de 5%, não rejeitamos H₀; isso não prova igualdade nem ausência de associação. A razão de chances estimada de vias urbanas em relação a estradas e rodovias foi **0,966** (intervalo de Wald de 95%: **0,9336 a 1,0002**), ajustada por dia e região. É uma razão de chances **entre boletins registrados**, não uma razão de riscos de sinistro. [Teste](../estrutura/codigos/resultados/estudo-pico/hipotese.csv) e [coeficientes](../estrutura/codigos/resultados/estudo-pico/coeficientes.csv).

Como análises exploratórias adicionais no treino, testamos H₀ de ausência de associação conjunta para cada grupo de coeficientes, condicionado aos demais: dia da semana, $\chi^2(6)=1410,46$, $p<0,001$; e região, $\chi^2(15)=312,24$, $p<0,001$. Ambos rejeitam suas hipóteses nulas no nível de 5%, sob as mesmas suposições. Esses testes adicionais não foram ajustados para multiplicidade e, com amostra grande, um p-valor pequeno não indica por si só efeito importante. A [tabela completa](../estrutura/codigos/resultados/estudo-pico/testes.csv) registra os valores calculados.

O resultado está próximo do limiar e depende das suposições do modelo. O p-valor convencional não corrige agrupamento temporal ou espacial. O bootstrap por dia acima mede o ganho de previsão no teste, não corrige o teste de hipótese dos coeficientes. Para inferência mais forte, planejar análise com incerteza agrupada e, idealmente, dados adicionais de exposição ao tráfego.

## 7. Discussão e análise final

A logística é adequada como primeiro instrumento para a pergunta binária e facilita a interpretação, mas as três características escolhidas oferecem pouco poder discriminativo. A árvore confirma que flexibilidade por si só não garantiu melhora neste teste. PCA ajuda a resumir perfis de modais, mas usa outro conjunto de variáveis e não valida a pergunta de pico. Poisson é apropriado para a pergunta alternativa de contagem, desde que se considerem exposição, sobredispersão e uma validação temporal adequada; seu resultado anterior não substitui o teste desta pergunta.

Antes do artigo, vale documentar as regras de seleção, as definições das janelas, as limitações da fonte, as suposições e a natureza retrospectiva do teste. Qualquer novo modelo ou mudança de limiar deve ser desenvolvido sem reutilizar o mesmo teste como se fosse inédito. O conjunto não informa fluxo de tráfego, e registros agregados ou incompletos podem limitar a generalização.

Reprodução na raiz do repositório: `Rscript estrutura/codigos/2026-11-11-appa-EstudoPico.R`. O código salva resultados em `estrutura/codigos/resultados/estudo-pico/`; depende de R e `rpart`. Ele faz verificações de datas, níveis, probabilidades, AUC e contagem por dia.
