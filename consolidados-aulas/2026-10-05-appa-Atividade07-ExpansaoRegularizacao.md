# Atividade 07: expansão e regularização

Esta atividade amplia o modelo de previsão de vítimas fatais e usa regularização para controlar a complexidade. O foco não é aumentar o número de variáveis sem limite. É testar se os novos termos melhoram a previsão quando ela é medida por validação cruzada.

O script está em [2026-10-05-appa-Atividade07-ExpansaoRegularizacao.R](../estrutura/codigos/2026-10-05-appa-Atividade07-ExpansaoRegularizacao.R). Ele usa uma amostra fixa de 50.000 boletins para permitir reprodução em computador pessoal.

## Expansão

Além das quantidades de veículos, entraram transformações logarítmicas, quadrados para motocicletas e veículos, a interação entre motocicleta e pedestre, tipo de via e turno. As transformações reduzem o peso de contagens muito altas e permitem relações que não sejam só lineares.

## Regularização

Ridge reduz todos os coeficientes. Lasso também pode zerar coeficientes e deixa um modelo mais enxuto. Elastic Net mistura os dois comportamentos. Os três métodos escolhem lambda por validação cruzada de cinco dobras.

O arquivo 2026-10-05-appa-07-ModelosRegularizados.csv guarda o placar de erro. O arquivo 2026-10-05-appa-07-VariaveisLasso.csv mostra as variáveis mantidas pelo Lasso na regra de um erro padrão.

## Resultado

Na amostra de 50.000 boletins (sorteada entre os 151.175 do recorte dos modelos), o Ridge teve RMSE de 0,2326 na validação cruzada. O Lasso no menor erro ficou em 0,2326 com 12 preditores ativos. Pela regra de um erro padrão, o Lasso reduziu para 3 preditores e teve RMSE de 0,2365. O Elastic Net ficou em 0,2326 com 13 preditores.

A diferença entre os menores erros é desprezível (quarta casa decimal). O Lasso 1se perde cerca de 0,004 de RMSE e fica com apenas três termos: via urbana, pedestres e caminhões. Esse trade-off entre parcimônia e erro deve ser decidido pelo uso: para interpretar, o modelo de três termos; para prever, qualquer um dos outros três.

## Leitura

O modelo escolhido não deve ser definido pelo erro de treino. A comparação usa o RMSE da validação cruzada. Quando lambda.1se fica próximo do menor erro, ele é preferível por usar menos variáveis e tender a ser mais estável.

## Material

A Aula 08 trata de expansão de atributos e regularização.

## Nota de Revisão Metodológica (Alinhamento com Aula 08 - Expansão e Regularização)
- **Padronização e Regra de Parcimônia (`lambda.1se`)**: Os preditores são padronizados antes da penalização Ridge ($L_2$) e Lasso ($L_1$), a seleção do hiperparâmetro segue a regra de um erro-padrão (`s = "lambda.1se"`) e os coeficientes reportados pelo `glmnet` são devidamente apresentados na escala original das variáveis.

## Reexecução em 06/11/2026

[2026-10-05-appa-07-ModelosRegularizados.csv](../estrutura/codigos/resultados/2026-10-05-appa-07-ModelosRegularizados.csv)

| modelo | alpha | lambda | mse_cv | rmse_cv | preditores_ativos |
|---|---|---|---|---|---|
| Ridge | 0 | 0.00358039 | 0.0540941 | 0.232581 | 14 |
| Lasso_lambda_min | 1 | 0.000134799 | 0.0540881 | 0.232569 | 12 |
| Lasso_lambda_1se | 1 | 0.0186682 | 0.0559262 | 0.236487 | 3 |
| Elastic_Net | 0.5 | 0.000269599 | 0.0540882 | 0.232569 | 13 |

Ridge, Lasso e Elastic Net compartilham exatamente o mesmo `foldid`; os escores não usam sorteios distintos por método. Para o Ridge, `preditores_ativos` é sempre o total de colunas (14), pois ele não zera coeficientes.
