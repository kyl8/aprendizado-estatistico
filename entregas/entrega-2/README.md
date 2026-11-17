# Entrega 2: artigo da demonstração

**Grupo APPA:** Arthur Galvão, Pedro Henrique e Ailana Pereira Gonsalez. **Professor:** João Paulo Ferreira de Mello. Documento preparado para 18/11/2026.

- **[Artigo em PDF](artigo-final.pdf)**: nove páginas, com apresentação acadêmica, resultados e relatório completo do R no apêndice.
- [Fonte Rnw](artigo-final.Rnw), [LaTeX gerado](artigo-final.tex) e [referências](referencias.bib).
- [Código de preparação e ajuste](entrega-2-banco.R) e [compilação](compilar-entrega-2.R).
- [Banco preparado](entrega-2-sinistros.csv), [tabelas e relatório](resultados/) e [figuras](figuras/).
- [Modelo da disciplina preservado](modelo-professor/artigo-final.Rnw).
- [Apresentação final e código Remotion](../apresentacao-final/README.md).

A [curadoria](../../CURADORIA_APPA.md) registra fontes, correções e auditoria cruzada. O texto revisado explica por que 59,43% de acurácia coexistem com 1,85% de sensibilidade; a logística soma quatro acertos à referência no teste. O novo [gráfico de denominadores](figuras/acuracia-e-sensibilidade.png) usa a mesma escala de 0 a 100%.

## Especificação desta entrega

Uma única ferramenta: **regressão logística**, `pico ~ via + dia + regiao`. O alvo vem das três janelas de horário; as preditoras são tipo de via, dia da semana e região administrativa. Hora e turno não entram no ajuste.

A auditoria de exclusões está em [exclusoes.csv](resultados/exclusoes.csv): 656 dos 658 excluídos são fatais (8.501 antes e 7.845 depois do filtro). A composição do recorte limita a interpretação.

O banco tem 151.175 boletins: 101.666 de 2025 para treino e 49.509 de janeiro–junho/2026 para teste. O modelo é ajustado **somente no treino**. A frequência do treino é uma referência constante para avaliação. O protocolo adapta o modelo genérico do professor, que ajustava no banco inteiro, para preservar o teste temporal do projeto.

| Parte do modelo da disciplina | Local no artigo APPA |
|---|---|
| Identificação e resumo | Primeira página, professor e integrantes. |
| Introdução | Motivação e problema. |
| Os dados | Fonte, unidade, seleção, alvo e preditoras. |
| A pergunta e o modelo | Uma ferramenta, fórmula e partição temporal. |
| Resultados | Relatório, métricas, matriz de confusão, gráficos e testes. |
| Discussão | Leitura das saídas e alcance do procedimento. |
| Conclusão | Fechamento da etapa demonstrativa, sem conclusão definitiva sobre o fenômeno. |
| Referências e relatório da ferramenta | Bibliografia e `summary(modelo)` completo no apêndice. |

## Reproduzir

Na raiz do repositório, com R, `knitr`, `sandwich` e LaTeX com `abntex2`:

```text
Rscript estrutura/codigos/testar_estudo_pico.R
Rscript entregas/entrega-2/compilar-entrega-2.R
```

O script executa a preparação e o ajuste, atualiza CSVs e figuras, gera o `.tex`, compila a bibliografia e substitui o PDF somente após a compilação completa. O banco é lido em Latin-1 e exportado em UTF-8. As asserções conferem totais, níveis, datas, convergência e reprodução das métricas anteriores da logística. A execução desta entrega não ajusta árvore, PCA ou Poisson.

A avaliação é retrospectiva. Os testes de hipótese e intervalos são demonstrações condicionadas às respectivas suposições. O texto registra saídas e limites do procedimento, preservando a orientação de não encerrar conclusões definitivas sobre o problema. Apoio de IA identificado no artigo.
