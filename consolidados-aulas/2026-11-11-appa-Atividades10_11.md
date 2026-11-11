# Árvores, floresta, agrupamento e PCA — APPA

**Apoio:** ChatGPT. As análises usam amostra reproduzível de até 10.000 boletins do recorte de modelagem; a resposta da parte supervisionada é quantidade de vítimas fatais.

Na validação cruzada de cinco dobras, a média teve RMSE 0,252334, a regressão linear 0,246758, o GAM aditivo 0,246353, a árvore podada 0,244107 e a floresta 0,242928. Os modelos compartilham a mesma amostra e dobras; o GAM usa os mesmos preditores, com funções suaves para motocicletas e automóveis. A resposta é uma contagem com poucos valores distintos; o ajuste de regressão é um exercício e não fundamenta conclusão causal. A floresta usa mtry=3 fixado antes desta comparação; a escolha OOB abaixo é exploratória e não é inserida retroativamente no placar.

Para a análise não supervisionada, as quantidades por modalidade foram padronizadas e a resposta ficou fora da matriz. Em uma amostra de 1.500 boletins, a maior silhueta da grade 2–8 ocorreu em k=8, com 0,716213. A PCA e as associações dos pontos aos grupos estão nos arquivos gerados; a silhueta descreve separação geométrica, não comprova categorias reais. Como o máximo está no limite da grade, não há evidência de que oito seja o número ideal global.

Código: `estrutura/codigos/2026-11-11-appa-Atividades10_11.R`. Resultados: `estrutura/codigos/resultados/aulas11_12/`.

## Bagging, OOB e importância

Na mesma amostra, o erro quadrático médio OOB foi 0,059037 para mtry=2, 0,059277 para mtry=3 e 0,060748 para bagging (mtry=7). OOB é calculado nas observações fora de cada amostra bootstrap; esses valores não são o RMSE da validação cruzada acima. A comparação OOB e a importância são exploratórias na amostra completa. Na floresta com mtry=2, via teve maior importância por permutação (26,42% de aumento de MSE), seguida por pedestre (23,11%); isso não identifica efeito causal.

A ligação completa foi calculada nas 1.500 observações padronizadas e cortada em oito grupos; o dendrograma mostra apenas as primeiras 80. As duas primeiras componentes explicam 27,56% e 24,36% da variância (51,92% acumulados). PC1 contrasta motocicletas (+0,73) com automóveis (−0,67); PC2 contrasta sobretudo ônibus (−0,64) e pedestres (−0,55) com automóveis (+0,42). O sinal das componentes é arbitrário.

Os centros nas unidades originais estão em `agrupamento_centros.csv`: os grupos 1 e 2 concentram pedestres; 3 e 8, ônibus; 4, caminhões; 5, automóveis; 6, motos e automóveis; 7, motos. O grupo 1 contém apenas quatro observações, tornando sua média instável. A média de vítimas fatais varia de zero nos grupos 1 e 3 a 0,180 no grupo 2; ela foi examinada depois de formar os grupos, sem integrar a matriz. O grupo pode ser candidato a preditor, mas precisaria ser construído dentro de cada dobra antes de avaliar previsão.

A raiz da árvore separa vias urbanas de estradas e rodovias; a pergunta seguinte sobre pedestres depende do ramo anterior. Isso sugere explorar interações na análise de gravidade, sem concluir causalidade. A figura corta ramos profundos somente para leitura; as métricas usam a árvore podada completa. O resumo da árvore, os gráficos, as cargas, as atribuições e as médias por grupo estão em `estrutura/codigos/resultados/aulas11_12/`. A amostra tem muitas contagens repetidas e desbalanceamento da resposta; isso limita a interpretação dos grupos e da silhueta.

Os exercícios dos slides foram resolvidos em [resoluções das atividades 10 e 11](../consolidados-tutora/2026-11-11-appa-Atividades10_11.md).
