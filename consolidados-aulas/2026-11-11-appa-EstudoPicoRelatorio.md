# Demonstração de classificação de pico — APPA

**Grupo:** Arthur Galvão, Pedro Henrique e Ailana. **Apoio:** ChatGPT. O objetivo é demonstrar a aplicação de logística e árvore: definir entradas, ajustar, testar e registrar saídas. Não fechamos conclusões sobre o problema nem escolhemos uma ferramenta definitiva para o artigo. Consulte o [mapa dos materiais e aplicações](FERRAMENTAS-E-DEMONSTRACOES.md).

Para o [relatório consolidado](00_CONSOLIDADO_GERAL_DEMONSTRACOES.md), a ferramenta principal selecionada é a **regressão logística**. As saídas de árvore nesta página são o registro da comparação anterior e permanecem como atividade complementar.

## 1. Motivação, problema e pergunta de trabalho

Os registros de sinistros permitem montar exemplos de classificação e discutir perfis associados a horários de pico. A pergunta usada como contexto é: **que características registradas dos sinistros estão associadas à ocorrência em horários de pico?**

Nesta etapa, ela orienta a demonstração; não será respondida de maneira definitiva. A base contém eventos registrados e não informa o volume de tráfego sem sinistro. O exercício não mede risco por veículo nem estabelece causas.

## 2. Banco, alvo e preditoras

A base Infosiga/SP tem 273.371 registros brutos de 50 colunas, de janeiro/2025 a junho/2026, sendo 151.833 boletins de sinistros fatais ou não fatais. O exemplo de classificação usa 151.175 boletins: foram excluídos 242 sem data/hora válidas e, entre os restantes, 416 com via indisponível. Não houve exclusão adicional por ausência nas três preditoras. A auditoria desta leitura não encontrou IDs duplicados nem divergências entre dia da semana e calendário. [Fluxo de seleção](../estrutura/codigos/resultados/estudo-pico/coorte.csv).

- **Alvo:** `pico`, igual a 1 em 06:30–08:30, 11:30–13:30 e 17:00–19:30, incluindo os extremos; 0 fora dessas janelas.
- **Preditoras:** tipo de via, dia da semana e região administrativa, todas categóricas.
- **Preparação:** validação do formato do horário, derivação do alvo e do dia pelo calendário, seleção dos registros e definição dos níveis categóricos no treino.
- **Disponibilidade:** hora e turno ficam fora dos preditores por revelarem o alvo; gravidade, tipo de sinistro e quantidades de envolvidos não entram neste exemplo.

## 3. Ferramentas dos materiais e sequência da demonstração

Logística corresponde à Aula 05; árvore e poda, à Aula 11; divisão de dados e métricas, à Aula 06; bootstrap, à Aula 07. Não aplicamos PCA como classificador: a demonstração não supervisionada está nas [atividades 10/11](2026-11-11-appa-Atividades10_11.md), com outra matriz de dados.

1. Separar 2025 para treino (**101.666 boletins**) e janeiro–junho/2026 para teste (**49.509**).
2. Calcular a frequência de pico no treino como linha de base e ajustar a logística `y ~ via + dia + regiao`.
3. Demonstrar a escolha de poda da árvore: janeiro–setembro/2025 para ajuste interno (**76.266**), outubro–dezembro para validação (**25.400**).
4. Avaliar cp em 0,01; 0,005; 0,001; 0,0005; 0,0001. Nesta execução, o menor Brier de validação ocorreu em 0,0001, na borda da grade. Reajustar a árvore em todo 2025 com esse parâmetro.
5. Aplicar os ajustes ao teste e registrar probabilidades, métricas e gráficos. O limiar de classe permanece em 0,5.

Os níveis de teste são conferidos contra os de treino. A prevalência registrada foi 39,97% no treino e 40,58% no teste. Os dados já foram usados em atividades anteriores: a divisão é uma demonstração retrospectiva, não um teste historicamente intocado. [Grade de poda](../estrutura/codigos/resultados/estudo-pico/poda.csv) e [auditoria](../estrutura/codigos/resultados/estudo-pico/auditoria.csv).

## 4. Saídas observadas

| Ajuste | Brier | AUC | Acurácia | Sensibilidade ao pico | Especificidade |
|---|---:|---:|---:|---:|---:|
| Frequência do treino | 0,241157 | 0,5000 | 0,5942 | 0,0000 | 1,0000 |
| Logística | 0,237184 | 0,5757 | 0,5943 | 0,0185 | 0,9875 |
| Árvore | 0,237563 | 0,5682 | 0,5944 | 0,0539 | 0,9635 |

Brier e log-loss exemplificam a avaliação das probabilidades; AUC usa a ordenação dos escores; acurácia, sensibilidade e especificidade usam o limiar. A acurácia balanceada calculada foi 0,5030 para logística e 0,5087 para árvore; a log-loss foi 0,6671 e 0,6678, contra 0,6754 da base. A tabela serve para discutir essas diferentes leituras, sem declarar um modelo vencedor ou certificar eficácia.

[Métricas](../estrutura/codigos/resultados/estudo-pico/metricas.csv), [probabilidades](../estrutura/codigos/resultados/estudo-pico/pred.csv), [gráfico de Brier](../estrutura/codigos/resultados/estudo-pico/brier-teste.png) e [gráfico de calibração](../estrutura/codigos/resultados/estudo-pico/calibracao-teste.png).

## 5. Exemplos de hipóteses e complementos opcionais

Hipótese usada para demonstrar o cálculo: **H₀:** os coeficientes de tipo de via são zero após ajustar por dia e região; **H₁:** pelo menos um deles difere de zero. O teste convencional registrou p = 0,0515. A razão de chances calculada para vias urbanas em relação a estradas/rodovias foi 0,966.

HC1 agrupada por data, Wald agrupado, Holm, diagnóstico conjunto de calibração e bootstrap em blocos semanais são **complementos acrescentados com IA**, não identificados como procedimentos apresentados nos PDFs conferidos. Permanecem como exemplos opcionais de cálculo e registro da incerteza.

| Exemplo complementar | Saída registrada |
|---|---|
| Wald para via, agrupado por data | χ²(1) = 3,6182; p = 0,0572; p após Holm = 0,0572 |
| Intervalo agrupado para a razão de chances de via | 0,9328 a 1,0010 |
| Wald conjunto para dia | χ²(6) = 952,36; p após Holm < 0,001 |
| Wald conjunto para região | χ²(15) = 284,84; p após Holm < 0,001 |
| Diagnóstico de calibração: intercepto 0 e inclinação 1 | χ²(2) = 10,7884; p = 0,00454; intercepto calculado 0,0221 e inclinação 0,9756 |

Os valores são saídas dos procedimentos sob suas suposições. Não encerramos aqui uma conclusão sobre associação, calibração ou o fenômeno real. O agrupamento usa 365 datas de treino e permite dependência dentro da data; não elimina automaticamente autocorrelação entre datas, dependência espacial ou viés da fonte. Holm foi aplicado à família das três comparações de coeficientes; o diagnóstico de calibração é separado e não foi usado para reajustar previsões.

O exemplo de bootstrap diário produziu intervalo de 0,003353 a 0,004567 para a diferença de Brier base menos logística. Com blocos circulares de sete dias, o intervalo foi 0,003421 a 0,004472. Para Brier da árvore menos logística, foi 0,000172 a 0,000571. Foram usadas 1.000 reamostragens e ajustes fixos; os exemplos não capturam toda a incerteza de desenvolvimento.

[Testes convencionais](../estrutura/codigos/resultados/estudo-pico/testes.csv), [testes agrupados](../estrutura/codigos/resultados/estudo-pico/testes_robustos.csv), [coeficientes](../estrutura/codigos/resultados/estudo-pico/coeficientes.csv), [intervalos em blocos](../estrutura/codigos/resultados/estudo-pico/incerteza_semanal.csv) e [diagnóstico de calibração](../estrutura/codigos/resultados/estudo-pico/calibracao_teste.csv). Referências dos complementos: [vcovCL](https://sandwich.r-forge.r-project.org/reference/vcovCL.html) e [p.adjust](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/p.adjust.html).

## 6. Roteiro para discutir a aplicação

Mostrar a preparação do alvo, justificar a exclusão de hora/turno, localizar treino e teste no calendário e explicar os parâmetros. Depois, ler as tabelas e gráficos, distinguindo saída de uma execução, interpretação da métrica e conclusão de pesquisa. A AUC mensal registrada variou de 0,560 a 0,583; as tabelas por região são descritivas. Nenhuma delas foi usada para declarar diferenças entre regiões ou definir uma ferramenta final.

[Resultados mensais](../estrutura/codigos/resultados/estudo-pico/por_mes.csv), [por região](../estrutura/codigos/resultados/estudo-pico/por_regiao.csv) e [gráfico mensal](../estrutura/codigos/resultados/estudo-pico/estabilidade-mensal.png). A demonstração de [contagem com Poisson](2026-11-11-appa-ContagemTemporalRelatorio.md) tem outro alvo e outra unidade; seus resultados não compõem um placar único com esta classificação.

## 7. Reprodução

Na raiz: `Rscript estrutura/codigos/testar_estudo_pico.R` e `Rscript estrutura/codigos/2026-11-11-appa-EstudoPico.R`. Dependências: R, `rpart` e `sandwich`. [Versões](../estrutura/codigos/resultados/estudo-pico/versoes.csv).

As verificações cobrem horários inválidos, limites do alvo, AUC em 100.000 rótulos, datas, categorias e conservação dos totais. Elas verificam o funcionamento do código, sem comprovar hipóteses sobre o trânsito.
