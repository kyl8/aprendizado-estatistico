# Comparação das referências em 17/11/2026

Os dois repositórios de referência foram consultados por `git fetch`, comparando o último estado conferido com `origin/main`. A referência de Estatística foi avançada por fast-forward; a do PI já estava atualizada.

| Projeto | Estado anterior | Estado atual | Atualizações |
|---|---|---|---|
| PI III | `fafe046` | `fafe046` | Nenhuma alteração posterior à conferência anterior. |
| Aprendizado Estatístico | `5c8198e` | `077c28d` | Dois commits de 14/11/2026: `74029b8` e `077c28d`. |

Em Estatística, os novos arquivos estão exclusivamente nas pastas da Entrega 2 e da apresentação final, além da atualização do README. Não houve mudança nos códigos anteriores, guias, corpus ou materiais de aula nesse intervalo.

## Correspondência com o repositório APPA

| Referência atualizada | Implementação APPA |
|---|---|
| `entregas/entrega-2/artigo-final.Rnw` e PDF | [Artigo APPA](../entregas/entrega-2/README.md), com fontes Rnw/LaTeX e PDF. |
| `entrega-2-banco.R`, banco preparado e números | [Código de preparação e ajuste](../entregas/entrega-2/entrega-2-banco.R), CSV preparado e tabelas em `resultados/`. |
| `entrega-2/modelo-professor/artigo-final.Rnw` | Modelo preservado byte a byte na mesma localização relativa. |
| `referencias.bib` | Bibliografia própria sobre os dados Infosiga, logística e R. |
| `entregas/apresentacao-final/` | [Apresentação APPA](../entregas/apresentacao-final/README.md), com HTML offline, PDF e fontes Remotion/React. |

O artigo de referência utiliza floresta aleatória e dados portuários. O projeto APPA mantém a escolha de **uma regressão logística** para o alvo binário `pico`, com tipo de via, dia da semana e região. A forma acadêmica acompanha o modelo, com conteúdo e cálculos próprios.

No modelo genérico do professor, o ajuste utiliza o banco inteiro. A implementação APPA adapta esse trecho para ajustar somente em 2025 e avaliar em janeiro–junho de 2026. O relatório completo do R é incluído no apêndice; a conclusão fecha a etapa demonstrativa, sem estabelecer uma conclusão definitiva sobre o problema.

A apresentação de referência foi gerada em Python para PPTX. Por solicitação, a APPA utiliza **Remotion/React**, com a organização acadêmica da disciplina e a direção visual dos HTMLs fornecidos pelo solicitante. O Python da APPA apenas importa resultados e reúne frames renderizados pelo Remotion em PDF. O roteiro principal cobre 10–12 minutos e inclui um slide adicional de apoio.

Esta comparação registra correspondência de estrutura e conteúdo solicitado, não igualdade de bases, métodos, resultados ou formato de apresentação. Não foi identificado um enunciado adicional com data de entrega nos novos arquivos da referência; a data de 18/11 foi informada pelo solicitante.
