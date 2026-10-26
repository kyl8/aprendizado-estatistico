# Oficina — Duas perguntas, diagnóstico e escolha
**Grupo APPA · 2026-10-25 · apoio: ChatGPT.**
**Solicitante:** Grupo APPA — Arthur Galvão, Pedro Henrique e Ailana.

## As duas fichas
| Campo | Candidata A | Candidata B |
|---|---|---|
| Pergunta | Que características estão associadas a um boletim ter ocorrido no pico? | Quantos sinistros são esperados por mês, dia da semana e faixa horária de uma hora? |
| Resposta | `pico`, binária, janelas da Entrega 1 | `n`, contagem de boletins na célula |
| Preditores | Tipo de via, dia da semana, região: três colunas, 24 coeficientes incluindo intercepto | Mês, dia e hora: três colunas; exposição pelo calendário |
| Tipo | Supervisionado, classificação, associação | Supervisionado, regressão de contagem, predição de células do mesmo período |
| Métrica | Brier, erro quadrático da probabilidade; AUC complementar | RMSE, em sinistros por célula |
| Linha de base | Probabilidade de pico estimada no treino | Média das contagens estimada no treino |
| Dono do problema | Gestor de mobilidade que descreve o perfil dos boletins no pico | Gestor que distribui fiscalização e acompanha a frequência temporal dos sinistros |

## Diagnóstico do banco
O banco tem 273.372 registros e 50 colunas; 151.833 são boletins. A candidata A usa
151591 casos completos, com 60848 no pico e 90743 fora.
O palpite de classe majoritária atinge acurácia 0,599.
Temos muito mais observações que parâmetros; isso não elimina desequilíbrio nem viés de registro.
Os faltantes por coluna estão no CSV `faltantes-banco.csv`; a candidata A usa exclusão explícita
de casos incompletos, sem imputar a partir da validação.

**Vazamento:** hora determina `pico`, portanto fica fora dos preditores da candidata A; turno
também foi retirado para evitar um substituto direto do horário. Não usamos gravidade posterior
como explicação causal. Correlação numérica não detecta esse tipo de vazamento por definição.
Na candidata B, todas as células do calendário permanecem na tabela, com exposição conhecida.

## Validação cruzada, cinco dobras
| Pergunta | Linha de base | Modelo | Ganho relativo na métrica principal |
|---|---|---|---|
| A, Brier | 0,240279 | 0,236357 | 1,63% |
| B, RMSE | 27,024 | Poisson 13,713; MQO 14,229 | 49,26% |

A AUC da logística foi 0,575; a acurácia foi 0,599, praticamente
igual à classe majoritária. Os modelos de cada pergunta compartilham as mesmas dobras e aprendem
a linha de base apenas no treino. Não comparamos numericamente Brier com RMSE: são escalas distintas.

## Escolha da proposta
Escolhemos **B para a proposta de revisão**: o ganho relativo foi maior, os preditores estão disponíveis
antes da contagem e a resposta mede diretamente a frequência temporal que motivou o projeto.
A pergunta A discrimina pouco além da linha de base. A ficha original de classificação e seu PDF
permanecem como histórico; a Parte D prevê discutir com o professor antes de trocar a pergunta oficial.

**O que as próximas aulas podem mudar:** interações e modelos mais flexíveis podem melhorar a
previsão; validação temporal e exposição de tráfego podem mudar a avaliação e a interpretação de risco.

**Reprodução:** `Rscript estrutura/codigo/entrega1_duas_perguntas.R` e
`Rscript estrutura/codigo/aula05b_poisson.R`. Métricas e previsões em `estrutura/resultados/entrega1/`
e `estrutura/resultados/2026-10-25-appa-05b-*`. Duas páginas aproximadamente em formato de relatório.
