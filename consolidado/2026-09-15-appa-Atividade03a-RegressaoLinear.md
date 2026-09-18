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

O modelo foi ajustado em 151.833 boletins. O R² foi 0,1098 e o R² ajustado foi 0,1097. O erro padrão residual foi 0,2387. O resultado indica associação limitada entre as variáveis escolhidas e a quantidade de vítimas fatais, então os coeficientes não devem ser usados sozinhos para previsão.

## Material

[Aula 04](../materiais-aulas/Aula%2004%20-%20Regress%C3%A3o%20Linear.PDF).
