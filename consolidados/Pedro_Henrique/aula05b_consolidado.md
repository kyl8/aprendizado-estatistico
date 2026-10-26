# Consolidado — Teoria do Aprendizado Estatístico — Aula 05b — 2026-10-25
*Guia versão 1 · apoio: ChatGPT · estudo teórico e exemplos resolvidos.*
**Aluno:** Pedro Henrique · **Grupo:** APPA.
**Solicitante:** Grupo APPA — Arthur Galvão, Pedro Henrique e Ailana.

## 1. O que foi passado
- M1 — contagens não negativas; probabilidade de zero e variância da Poisson.
- M2 — log da média como reta; $e^{\beta}$ como multiplicador.
- M3 — `glm(family=poisson)` e `predict(type="response")`.
- M4 — exposição e `offset(log(dias))`.
- M5 — dispersão de Pearson e quase-Poisson.
- M6 — validação cruzada nas mesmas cinco dobras.

## 2. Como foi o aprendizado — opinião da tutora
A resolução conecta a distribuição de Poisson à modelagem da média pelo log e à interpretação
multiplicativa dos coeficientes. Os exemplos separam contagem, exposição e taxa, mostrando por que
o offset tem coeficiente fixo. A análise de dispersão e a comparação nas mesmas dobras completam
a interpretação do modelo e das previsões.

**Teste final:** seis respostas resolvidas no caderno para revisão dos conceitos e das contas.

## 3. Observações para a frente
- **Revisar:** interpretação multiplicativa, escala do `predict` e papel do offset.
- **Produzido:** previsões e placar reproduzido: $3{,}99/2{,}39/1{,}76$.
- **Perguntas guardadas:** binomial negativa e excesso de zeros ficam para um estudo posterior.
- **Parte D:** executada no banco do APPA; consolidado e ficha salvos no repositório.
