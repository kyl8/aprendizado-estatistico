# Atividade 04: regressão logística

A regressão logística é adequada quando a resposta tem duas classes. Neste projeto, o recorte mais direto é classificar se um boletim é fatal ou não fatal.

O ajuste foi implementado em [2026-09-15-appa-Atividade04-RegressaoLogistica.R](../estrutura/codigos/2026-09-15-appa-Atividade04-RegressaoLogistica.R). Notificações ficaram fora do modelo.

## Definição da resposta

Criar uma variável binária a partir de `tipo_registro`, usando os boletins fatais como uma classe e os boletins não fatais como outra. Notificações ficam fora desse ajuste porque têm origem e preenchimento diferentes.

## Variáveis candidatas

Tipo de via, turno, região administrativa, presença de pedestre, motocicleta, caminhão e as demais quantidades de veículos. A escolha final deve considerar valores ausentes e possíveis variáveis que já revelem diretamente a gravidade.

## Interpretação

O modelo estima uma probabilidade entre zero e um. Os coeficientes podem ser convertidos em razão de chances, mas a interpretação deve respeitar o recorte dos boletins e a qualidade da base.

O ajuste é reproduzível pelo script da atividade e os coeficientes ficam na pasta `estrutura/resultados`.

## Avaliação necessária

A proporção de registros fatais é pequena em relação aos não fatais. A acurácia sozinha pode esconder um modelo que sempre escolhe a classe majoritária. O relatório deve mostrar matriz de confusão, sensibilidade, especificidade e, se possível, uma curva ROC.

Também é preciso separar treinamento e teste e definir o ponto de corte da probabilidade. Esse ponto muda o equilíbrio entre encontrar casos fatais e evitar falsos alarmes.

## Resultado obtido

Com ponto de corte 0,5, a acurácia foi 0,9472, praticamente igual à da classe majoritária (0,9474, "nunca fatal"). A sensibilidade foi só 0,0044: o modelo acertou 7 dos 1.591 boletins fatais do teste. A especificidade foi 0,9995, a precisão foi 0,35 e a AUC foi 0,7587. A matriz teve 28.631 verdadeiros negativos, 13 falsos positivos, 1.584 falsos negativos e 7 verdadeiros positivos.

A AUC de 0,76 mostra que o modelo ordena os casos melhor que o acaso, mas o corte de 0,5 é inadequado para uma classe de 5,3%. Escolhendo o corte que maximiza o F1 no **treino** (0,10), a sensibilidade sobe para 0,326, a especificidade cai para 0,917 e a precisão é 0,179, com acurácia de 0,886. O corte foi escolhido no treino, e não no teste, para não usar o conjunto de teste na decisão.

A versão anterior (sensibilidade 0,078; AUC 0,77; razão de chances de 776 para `tipo_via = NAO DISPONIVEL`) incluía os marcadores `NAO DISPONIVEL` como preditores. Eles quase só aparecem em fatais e inflavam o desempenho; foram retirados (ver Atividade 03a).

## Material

[Aula 05](../materiais-aulas/Aula%2005%20-%20Classifica%C3%A7%C3%A3o%20e%20Regress%C3%A3o%20Log%C3%ADstica.PDF).

## Nota de Revisão Metodológica (Alinhamento com Aula 05 - Regressão Logística)
- **Interpretação via *Odds Ratio* e Matriz de Confusão**: No modelo logit $\log\left(\frac{p}{1-p}\right) = \beta_0 + \sum \beta_j X_j$, o parâmetro $\beta_j$ atua linearmente sobre o logito; na escala da chance (*odds*), o efeito multiplicativo *ceteris paribus* é dado pela Razão de Chances (*Odds Ratio*) $OR_j = e^{\beta_j}$. Na matriz de confusão com limiar $0,5$, a classe positiva é `fatal == TRUE` ($Y=1$), de modo que $\text{Sensibilidade} = \frac{VP}{VP + FN}$ e $\text{Especificidade} = \frac{VN}{VN + FP}$.

## Reexecução em 06/11/2026

[2026-09-15-appa-04-MetricasRegressaoLogistica.csv](../estrutura/resultados/2026-09-15-appa-04-MetricasRegressaoLogistica.csv)

| registros_treino | registros_teste | acuracia_majoritaria | acuracia | sensibilidade | especificidade | precisao | auc |
|---|---|---|---|---|---|---|---|
| 120940 | 30235 | 0.947379 | 0.94718 | 0.0044 | 0.999546 | 0.35 | 0.758672 |

Com o corte de 0,10 (F1 máximo no treino): sensibilidade 0,3262, especificidade 0,9170, precisão 0,1792, acurácia 0,8859.

Matriz de confusão no corte 0,5 (linhas: observado; colunas: previsto):

| | 0 | 1 |
|---|---|---|
| 0 | 28631 | 13 |
| 1 | 1584 | 7 |
