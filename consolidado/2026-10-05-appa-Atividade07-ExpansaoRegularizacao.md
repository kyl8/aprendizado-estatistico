# Atividade 07: expansão e regularização

Esta atividade amplia o modelo de previsão de vítimas fatais e usa regularização para controlar a complexidade. O foco não é aumentar o número de variáveis sem limite. É testar se os novos termos melhoram a previsão quando ela é medida por validação cruzada.

O script está em [2026-10-05-appa-Atividade07-ExpansaoRegularizacao.R](../estrutura/codigos/2026-10-05-appa-Atividade07-ExpansaoRegularizacao.R). Ele usa uma amostra fixa de 50.000 boletins para permitir reprodução em computador pessoal.

## Expansão

Além das quantidades de veículos, entraram transformações logarítmicas, quadrados para motocicletas e veículos, a interação entre motocicleta e pedestre, tipo de via e turno. As transformações reduzem o peso de contagens muito altas e permitem relações que não sejam só lineares.

## Regularização

Ridge reduz todos os coeficientes. Lasso também pode zerar coeficientes e deixa um modelo mais enxuto. Elastic Net mistura os dois comportamentos. Os três métodos escolhem lambda por validação cruzada de cinco dobras.

O arquivo 2026-10-05-appa-07-ModelosRegularizados.csv guarda o placar de erro. O arquivo 2026-10-05-appa-07-VariaveisLasso.csv mostra as variáveis mantidas pelo Lasso na regra de um erro padrão.

## Resultado

Na amostra de 50.000 boletins, o Ridge teve RMSE de 0,2389 na validação cruzada. O Lasso no menor erro ficou em 0,2390 com 16 preditores ativos. Pela regra de um erro padrão, o Lasso reduziu para 7 preditores e teve RMSE de 0,2422. O Elastic Net ficou em 0,2390.

A diferença entre os menores erros é pequena. O Lasso 1se perde um pouco de precisão, mas oferece um modelo menor. As variáveis selecionadas foram ligadas a tipo de via, turno, pedestres, caminhões, automóveis e total de veículos.

## Leitura

O modelo escolhido não deve ser definido pelo erro de treino. A comparação usa o RMSE da validação cruzada. Quando lambda.1se fica próximo do menor erro, ele é preferível por usar menos variáveis e tender a ser mais estável.

## Material

A Aula 08 trata de expansão de atributos e regularização.
