# Atividade 03a: regressão linear

Esta etapa usa um modelo para explicar uma medida numérica a partir das características do sinistro.

O ajuste foi implementado em [2026-09-15-appa-Atividade03a-RegressaoLinear.R](../estrutura/codigos/2026-09-15-appa-Atividade03a-RegressaoLinear.R). Ele usa somente boletins policiais e não usa variáveis de gravidade como preditoras.

## Recorte recomendado

Usar somente boletins policiais e definir como resposta uma contagem numérica, como `qtd_gravidade_fatal` ou o total de veículos envolvidos. Os preditores podem incluir tipo de via, turno, região e quantidades de veículos.

## Cuidados

Contagens com muitos zeros podem violar as suposições da regressão linear. Antes de usar o modelo, é preciso verificar resíduos, assimetria, valores extremos e a relação entre a resposta e os preditores. Se a resposta for uma contagem, Poisson ou binomial negativa pode ser mais adequada.

## Próxima entrega

Registrar a fórmula, o recorte de linhas, os coeficientes, os resíduos e um exemplo de previsão. O resultado só deve ser incluído depois que o código e a saída puderem ser reproduzidos.

## Estrutura do relatório

O consolidado deve apresentar a variável resposta, o conjunto de preditores, a quantidade de linhas usadas e a fórmula do modelo. Em seguida, deve mostrar os coeficientes com uma interpretação em linguagem comum.

Também é necessário verificar resíduos e observar se há concentração de valores zero. Caso essas verificações indiquem que a resposta não é contínua, a regressão linear deve ser trocada por um modelo adequado ao tipo de dado.

## Resultado obtido

O modelo foi ajustado em 151.175 boletins. O R² foi 0,0506 e o R² ajustado foi 0,0506. O erro padrão residual foi 0,2387. O resultado indica associação limitada entre as variáveis escolhidas e a quantidade de vítimas fatais, então os coeficientes não devem ser usados sozinhos para previsão.

A resposta é uma contagem com cerca de 94% de zeros, o que viola as suposições da regressão linear. O diagnóstico dos resíduos confirma isso (arquivos `03a-DiagnosticoResiduos.csv` e `.png`): 5,1% dos resíduos padronizados passam de 3 em módulo, a assimetria é 5,4 e a curtose é 75 (a normal teria 0 e 3), e o gráfico Q-Q se afasta muito da reta. A alavancagem máxima é baixa (0,0055), então nenhum ponto isolado domina o ajuste. A regressão linear é usada aqui como exercício da aula; a Atividade 05b mostra o modelo adequado a contagens (Poisson).

## Recorte dos modelos

Os modelos usam 151.175 dos 151.833 boletins: ficam de fora os 447 com `tipo_via = NAO DISPONIVEL` e os 242 com `turno = NAO DISPONIVEL` (658 boletins no total, pois há sobreposição). Esse valor quase só aparece em boletins fatais (445 dos 447 em `tipo_via`) e funciona como marcador de óbito, não como característica da via; mantê-lo nos modelos fazia a razão de chances chegar a 776 (via) e a 28 milhões (turno) e inflava o ajuste. A preparação da base também passou a respeitar as aspas do CSV: a leitura anterior desalinhava 3 linhas e criava um registro fantasma (273.372 em vez de 273.371 registros).

## Material

[Aula 04](../materiais-aulas/Aula%2004%20-%20Regress%C3%A3o%20Linear.PDF).

## Nota de Revisão Metodológica (Alinhamento com Aula 04 - Regressão Linear)
- **Condição *Ceteris Paribus* e Posto Completo**: Cada coeficiente $\hat{\beta}_j$ representa a variação esperada na variável resposta por unidade adicional do preditor $X_j$, **mantendo todas as demais variáveis constantes (*ceteris paribus*)**. A variável redundante `veiculos` (soma exata dos tipos individuais) foi removida da especificação simultânea para eliminar a multicolinearidade perfeita, e o diagnóstico de homoscedasticidade utiliza os resíduos padronizados via matriz *hat* ($r_i = \frac{e_i}{s\sqrt{1 - h_{ii}}}$).

## Reexecução em 06/11/2026

Os valores abaixo vêm de [2026-09-15-appa-03a-MetricasRegressaoLinear.csv](../estrutura/resultados/2026-09-15-appa-03a-MetricasRegressaoLinear.csv) e foram obtidos após as correções de leitura da base e de recorte descritas acima.

| registros | r2 | r2_ajustado | erro_padrao_residual | aic |
|---|---|---|---|---|
| 151175 | 0.0506294 | 0.0505666 | 0.238703 | -4098.04 |
