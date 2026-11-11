# Ferramentas dos materiais e demonstrações do APPA

Conferência direta dos PDFs das Aulas 01–12 e do guia 05b. Esta etapa serve para **demonstrar a aplicação das ferramentas**, com entradas, parâmetros, treino/teste e saídas registradas. Não fecha conclusões sobre o trânsito nem escolhe uma ferramenta definitiva para o artigo.

| Material | Ferramenta apresentada | Aplicação existente |
|---|---|---|
| Aula 04 — Regressão Linear | MQO e regressão linear | [Atividade 03a](../estrutura/codigos/2026-09-15-appa-Atividade03a-RegressaoLinear.R) |
| Aula 05 — Classificação e Regressão Logística | Logística para alvo binário | [Atividade 04](../estrutura/codigos/2026-09-15-appa-Atividade04-RegressaoLogistica.R) e [demonstração de pico](2026-11-11-appa-EstudoPicoRelatorio.md) |
| Aula 06 — Avaliação e Seleção de Modelos | Treino, validação, teste e métricas | [Atividade 05](../estrutura/codigos/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R) e partições das demonstrações atuais |
| Aula 07 — Métodos de Reamostragem | Validação cruzada e bootstrap | [Atividade 06](../estrutura/codigos/2026-09-15-appa-Atividade06-MetodosReamostragem.R) |
| Aula 08 — Expansão e Regularização | Ridge, Lasso e Elastic Net | [Atividade 07](../estrutura/codigos/2026-10-05-appa-Atividade07-ExpansaoRegularizacao.R) |
| Aula 09 — Métodos de Suavização | KNN de regressão e kernel | [Atividade 08](../estrutura/codigos/2026-10-09-appa-Atividade08-MetodosSuavizacao.R) |
| Aula 10 — Splines e Modelos Aditivos | Splines de regressão, de suavização e GAM | [Atividade 09](../estrutura/codigos/2026-10-25-appa-Atividade09-SplinesModelosAditivos.R) |
| Aula 11 — Árvores de Decisão e Random Forest | Árvore, poda, bagging, floresta, OOB e importância | [Atividades 10/11](../estrutura/codigos/2026-11-11-appa-Atividades10_11.R); árvore também no exemplo de pico |
| Aula 12 — Agrupamento e Componentes Principais | K-médias, hierárquico e PCA | [Atividades 10/11](../estrutura/codigos/2026-11-11-appa-Atividades10_11.R) |
| Guia 05b — Regressão de Poisson | Poisson, exposição e sobredispersão | [Aula 05b](../estrutura/codigos/aula05b_poisson.R) e [exemplo temporal](2026-11-11-appa-ContagemTemporalRelatorio.md) |

O [guia de Poisson](../materiais-tutora/GUIA_ESTUDO_aula05b.md) é identificado no próprio texto como **“Tema extra: não é dado em aula”**. Sua presença entre os materiais não demonstra que tenha sido apresentado presencialmente.

## Aplicações mais recentes

- **Pico:** logística e árvore; alvo `pico`; preditoras tipo de via, dia da semana e região.
- **Contagem:** Poisson e quase-Poisson; alvo número de boletins por data × hora; preditoras hora e dia da semana.
- **PCA e agrupamento:** quantidades de modais, sem alvo na matriz. É uma aplicação não supervisionada, não uma classificação de pico.
- **Demais atividades:** usam respostas e recortes próprios para demonstrar os métodos. Seus placares não formam uma competição única sobre o mesmo alvo.

## Complementos acrescentados com apoio de IA

HC1 agrupada por data, Wald agrupado, Holm, teste conjunto de calibração e bootstrap em blocos semanais foram acrescentados na revisão. Não foram identificados como procedimentos ensinados nos PDFs conferidos. Estão registrados como **complementos opcionais**, sem serem apresentados como exigências do professor ou conclusões do trabalho.

Para discutir uma demonstração: mostrar a ferramenta e seu material, indicar alvo e preditoras quando houver, explicar parâmetros e partição dos dados, executar e apresentar tabelas/gráficos. Os números descrevem aquela execução; não certificam a ferramenta nem estabelecem certeza sobre o fenômeno.
