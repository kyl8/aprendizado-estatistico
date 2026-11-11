# Estudo de sinistros nos horários de pico — APPA

**Grupo:** Arthur Galvão, Pedro Henrique e Ailana. **Apoio:** ChatGPT. Este relatório reúne resultados reproduzíveis para orientar o futuro artigo; não registra avaliação individual nem identifica efeitos causais.

## 1. Motivação e problema

O planejamento de fiscalização e mobilidade precisa conhecer padrões nos registros de sinistros. Os períodos de pico concentram deslocamentos e podem apresentar perfis distintos de ocorrência. Os dados disponíveis, porém, contêm apenas eventos registrados: não informam quantos veículos ou pessoas circularam sem sofrer sinistro. Assim, permitem comparar características **entre boletins**, mas não estimar risco por viagem ou por veículo, nem concluir que uma característica causou um acidente.

## 2. Pergunta e hipótese

**Pergunta principal:** que características registradas dos sinistros estão associadas à ocorrência em horários de pico?

Hipótese examinada no treino: **H₀:** após ajustar por dia da semana e região administrativa, os coeficientes associados ao tipo de via são zero; **H₁:** pelo menos um desses coeficientes é diferente de zero. A revisão usa Wald com covariância HC1 agrupada por data e nível de referência de 5%; o teste de razão de verossimilhanças convencional permanece como comparação. Há 365 datas de treino. As três hipóteses por grupos de coeficientes (via, dia e região) recebem correção de Holm. Todas as análises são retrospectivas e exploratórias, sem pré-registro.

A covariância permite dependência entre boletins da mesma data, mas ainda supõe independência entre datas e depende da especificação do modelo. Não corrige automaticamente dependência espacial, autocorrelação entre dias nem viés de registro. Método: [documentação de vcovCL](https://sandwich.r-forge.r-project.org/reference/vcovCL.html); multiplicidade: [p.adjust do R](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/p.adjust.html).

## 3. Banco, alvo e preditoras

A fonte é a base de sinistros de trânsito de São Paulo do Infosiga, de janeiro de 2025 a junho de 2026: 273.371 registros brutos de 50 colunas, sendo 151.833 boletins de sinistros fatais ou não fatais. Notificações não são a unidade deste estudo. O fluxo de exclusões é: **242** boletins sem data/hora válidas e, entre os restantes, **416** com via indisponível; restaram **151.175 boletins**. Não houve exclusão adicional por campos ausentes entre as três preditoras. A auditoria não encontrou identificadores de sinistro duplicados nem divergência entre dia da semana informado e o calendário. A exclusão da via indisponível altera a população analisada. [Coorte](../estrutura/codigos/resultados/estudo-pico/coorte.csv).

O **alvo** `pico` vale 1 para 06:30–08:30, 11:30–13:30 ou 17:00–19:30, incluindo os extremos; fora dessas janelas vale 0. Foram usadas três **preditoras** categóricas: tipo de via, dia da semana e região administrativa. Hora e turno ficam fora por determinarem ou revelarem diretamente o alvo. Gravidade, tipo de sinistro e modais envolvidos também não entram neste experimento, pois são características registradas após o evento e respondem a outra pergunta. O modelo classifica o horário de um boletim existente: não é um sistema de previsão antecipada de sinistros.

## 4. Ferramentas e desenho de avaliação

| Ferramenta | Papel neste estudo | Limite |
|---|---|---|
| Frequência de pico no treino | Linha de base para probabilidades e classe majoritária. | Não diferencia os perfis. |
| Regressão logística | Modelo principal; fornece probabilidades, razões de chances e teste ajustado. | Exige cuidado com especificação e dependência; associação não é causa. |
| Árvore de classificação | Comparação flexível; poda escolhida por validação temporal interna. | Pode ser instável e não fornece causalidade. |
| PCA | Exploração não supervisionada de variáveis numéricas; existe em [relatório separado](2026-11-11-appa-Atividades10_11.md). | Não usa o alvo e não substitui um classificador. |
| Poisson/quase-Poisson | Análise alternativa de contagens por calendário, agora com [teste temporal](2026-11-11-appa-ContagemTemporalRelatorio.md). | Tem outro alvo e outra unidade; RMSE de contagens não é comparável ao Brier da classificação. |

Usamos divisão **temporal**, sem embaralhar: 01/01–31/12/2025 para treino (**101.666**) e 01/01–30/06/2026 para teste (**49.509**). Os níveis das categorias são aprendidos no treino; o script para se aparecer categoria inédita no teste. A probabilidade constante da linha de base, o ajuste da logística e a poda da árvore usam apenas o treino. O limiar de classe de 0,5 é fixo; não foi escolhido pelo teste. A prevalência de pico foi 39,97% no treino e 40,58% no teste.

Para a árvore, janeiro a setembro de 2025 fornece 76.266 observações de ajuste interno; outubro a dezembro fornece 25.400 de validação. A grade de cp foi 0,01; 0,005; 0,001; 0,0005; 0,0001; o menor Brier de validação ocorreu em 0,0001. A árvore foi então reajustada em todo 2025 com esse cp. Como a escolha está na borda da grade, isso não estabelece um ótimo global. Não usamos validação aleatória por boletim para escolher a poda. [Grade](../estrutura/codigos/resultados/estudo-pico/poda.csv).

Essa é uma avaliação retrospectiva, feita depois de estudos anteriores com a mesma base; não constitui um teste historicamente intocado. A validação cruzada anterior da análise de Poisson dividiu células do mesmo período e não demonstra previsão para meses futuros.

## 5. Relatório das ferramentas no teste temporal

| Modelo | Brier ↓ | AUC ↑ | Acurácia | Sensibilidade ao pico | Especificidade |
|---|---:|---:|---:|---:|---:|
| Frequência do treino | 0,241157 | 0,5000 | 0,5942 | 0,0000 | 1,0000 |
| Logística | 0,237184 | 0,5757 | 0,5943 | 0,0185 | 0,9875 |
| Árvore | 0,237563 | 0,5682 | 0,5944 | 0,0539 | 0,9635 |

O Brier mede o erro quadrático médio das probabilidades; menor é melhor. A logística melhora **0,003972** em relação à base, cerca de **1,65%** do Brier da base. Um bootstrap pareado por dia no teste, com 1.000 reamostragens, deu intervalo percentílico de **0,003353 a 0,004567** para essa diferença. O intervalo descreve a variabilidade entre dias observados no período de teste e não garante desempenho em outros anos ou fontes.

Como sensibilidade à dependência entre dias consecutivos, o bootstrap circular em blocos de **sete dias**, também com 1.000 repetições, deu **0,003421 a 0,004472**. Para Brier da árvore menos Brier da logística, o ganho desta última foi **0,000379**, intervalo **0,000172 a 0,000571**. A comparação é exploratória, pois os modelos e seus resultados já foram examinados. O bootstrap considera os ajustes fixos, sem reestimar modelos ou seleção, e assume estabilidade aproximada dos blocos; não captura toda a incerteza de desenvolvimento. [Intervalos em blocos](../estrutura/codigos/resultados/estudo-pico/incerteza_semanal.csv).

A AUC de 0,576 indica discriminação modesta. A acurácia quase não melhora sobre a classe majoritária e, com limiar 0,5, a logística identifica somente **1,85%** dos boletins de pico. Não seria adequado apresentá-la como classificador operacional eficaz. A árvore também tem discriminação modesta; sua comparação é descritiva, pois o mesmo teste foi visto para os dois modelos.

A acurácia balanceada foi **0,5030** para logística e **0,5087** para árvore, próximas de 0,5. A log-loss foi 0,6671 e 0,6678, contra 0,6754 da base. As métricas mostram ganho pequeno de probabilidade e desempenho fraco de classificação, apesar do tamanho da amostra.

Gráficos de [Brier](../estrutura/codigos/resultados/estudo-pico/brier-teste.png) e [calibração](../estrutura/codigos/resultados/estudo-pico/calibracao-teste.png), além das [métricas](../estrutura/codigos/resultados/estudo-pico/metricas.csv), [probabilidades](../estrutura/codigos/resultados/estudo-pico/pred.csv) e [auditoria](../estrutura/codigos/resultados/estudo-pico/auditoria.csv), permitem conferir os resultados.

## 6. Teste de hipótese e interpretação

No treino, o teste convencional para via continua com **p = 0,0515**. A revisão robusta por data produz $\chi^2(1)=3,6182$, **p = 0,0572** (também 0,0572 após Holm). Ao nível de 5%, não rejeitamos H₀; isso não prova igualdade nem ausência de associação. A razão de chances estimada de vias urbanas em relação a estradas e rodovias é **0,966**, com intervalo robusto de 95% **0,9328 a 1,0010**. É uma razão de chances **entre boletins registrados**, não uma razão de riscos de sinistro. [Testes robustos](../estrutura/codigos/resultados/estudo-pico/testes_robustos.csv) e [coeficientes](../estrutura/codigos/resultados/estudo-pico/coeficientes.csv).

Nos testes conjuntos robustos ajustados pelos demais preditores, dia da semana apresentou $\chi^2(6)=952,36$ e região $\chi^2(15)=284,84$; ambos permanecem com **p ajustado por Holm < 0,001**. Há associação sob as suposições descritas, mas a discriminação fraca no teste mostra que significância estatística não implica grande utilidade preditiva. Os [testes convencionais](../estrutura/codigos/resultados/estudo-pico/testes.csv) foram preservados como comparação, agora também com Holm.

## 7. Calibração e estabilidade

No teste, a regressão diagnóstica de calibração estimou intercepto **0,0221** e inclinação **0,9756**. O teste de Wald com agrupamento por data para H₀ conjunta (intercepto 0, inclinação 1) deu $\chi^2(2)=10,7884$, **p = 0,00454**. Isso sugere um pequeno desvio estatisticamente detectável de calibração perfeita. A análise é diagnóstica após observar o teste e não foi usada para recalibrar previsões nem mudar o limiar. [Diagnóstico](../estrutura/codigos/resultados/estudo-pico/calibracao_teste.csv).

As faixas do gráfico agora informam o número de boletins; faixas vazias não aparecem. A AUC mensal variou de **0,560 a 0,583**, mantendo discriminação modesta nos seis meses. Os resultados por região são descritivos e não foram usados para escolher modelos ou declarar diferenças significativas entre regiões. [Resultados mensais](../estrutura/codigos/resultados/estudo-pico/por_mes.csv), [por região](../estrutura/codigos/resultados/estudo-pico/por_regiao.csv) e [gráfico mensal](../estrutura/codigos/resultados/estudo-pico/estabilidade-mensal.png).

## 8. Discussão e análise final

A logística é adequada como primeiro instrumento para a pergunta binária e facilita a interpretação, mas as três características escolhidas oferecem pouco poder discriminativo. A árvore confirma que flexibilidade por si só não garantiu melhora neste teste. PCA ajuda a resumir perfis de modais, mas usa outro conjunto de variáveis e não valida a pergunta de pico. A [nova avaliação temporal de Poisson](2026-11-11-appa-ContagemTemporalRelatorio.md) atende à pergunta alternativa de frequência e deve ser discutida separadamente, com sua unidade e limitações.

Antes do artigo, vale documentar as regras de seleção, as definições das janelas, as limitações da fonte, as suposições e a natureza retrospectiva do teste. Qualquer novo modelo ou mudança de limiar deve ser desenvolvido sem reutilizar o mesmo teste como se fosse inédito. O conjunto não informa fluxo de tráfego, e registros agregados ou incompletos podem limitar a generalização.

## 9. Correções e reprodução

A revisão corrigiu a aceitação de horários malformados, preveniu overflow no cálculo de AUC em grandes amostras e substituiu a validação aleatória da poda por validação temporal. A base atual não tinha identificadores duplicados ou divergências de calendário; as proteções adicionais foram testadas também com entradas sintéticas inválidas e com 100.000 rótulos para a AUC.

Executar na raiz: `Rscript estrutura/codigos/testar_estudo_pico.R` e `Rscript estrutura/codigos/2026-11-11-appa-EstudoPico.R`. As saídas ficam em `estrutura/codigos/resultados/estudo-pico/`. Dependências: R, `rpart` e `sandwich`; as versões estão em [versoes.csv](../estrutura/codigos/resultados/estudo-pico/versoes.csv).
