# Atividade 05b — Regressão de Poisson

A entrega foi refeita com a teoria e os nove módulos do guia.

- [Resolução individual](../resolucoes/aula05b_resolvido.md)
- [Consolidado individual](aula05b_consolidado.md)
- [Parte D completa](aula05b_parteD_consolidado.md)
- [Ficha](00_FICHA_PERGUNTA.md)
- [Código solicitado](../estrutura/codigo/aula05b_poisson.R)

| modelo | RMSE CV(5) |
|---|---|
| media | 27,024 |
| mqo | 14,229 |
| poisson | 13,713 |

A versão anterior usava outra agregação e uma linha de base calculada sobre toda a base. A versão atual usa exposição de calendário, preserva todas as células e aprende cada previsão apenas no treino da dobra.
