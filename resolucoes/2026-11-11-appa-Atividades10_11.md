# Exercícios das aulas 11 e 12

Resolução preparada com apoio de IA, para conferência do grupo; não registra respostas individuais.

## Árvores e floresta — cálculos

1. Cortes 80, 135 e 175: RSS respectivamente 14.275, 11.950 e 9.280. Entre os três, a árvore escolhe 175.
2. Para 30/40 e 10/40: erro 0,25; Gini 0,375; entropia 0,8113 bits. Ambas as divisões têm erro ponderado 0,25; o Gini ponderado é 0,25 na primeira e 1/3 na segunda. O Gini prefere a primeira.
3. A probabilidade OOB é $(1-1/n)^n$: 0,3487 para 10 e 0,3677 para 1.000. Em 300 árvores, espera-se cerca de 110,3 previsões OOB por observação.
4. Para 1, 4 e 12 folhas, os custos em $\alpha=10$ são 910, 340 e 320; em 50 são 950, 500 e 800; em 300 são 1.200, 1.500 e 3.800. Vencem 12, 4 e 1 folha, respectivamente. A árvore de quatro folhas vence a de 12 quando $\alpha>12,5$; em 12,5 há empate entre essas duas.

## Árvores e floresta — conceitos

- A busca exaustiva de partições cresce rapidamente. Num preço com prêmio somente quando imóvel é grande **e** bem localizado, uma divisão inicial pouco informativa pode impedir que a estratégia gulosa encontre a melhor árvore pequena.
- Uma pergunta num ramo depende das anteriores, representando interação; o GAM puramente aditivo soma efeitos isolados, salvo se interações forem especificadas.
- Mais árvores reduzem a variabilidade da média do bagging, embora não garantam ausência de erro ou viés; mais folhas numa única árvore podem memorizar ruído.
- Sortear preditores reduz a correlação entre árvores. Com apenas três preditores, há poucas escolhas distintas e o ganho pode ser pequeno.
- Importância por permutação mede perda de previsão ao embaralhar uma variável, não direção de efeito nem causalidade; correlação e confundimento também afetam sua leitura.

## Agrupamento e PCA — cálculos

1. Centros iniciais 50 e 60 levam, após iterações, aos grupos {50,60,70} e {140,150,160,250}, centros 60 e 175, com $W=200+7700=7900$. Uma solução com três grupos {50,60,70}, {140,150,160}, {250} tem $W=400$. Como adicionar centros pode reduzir $W$, essa medida sozinha não escolhe $K$.
2. Para 160, $a=(20+10)/2=15$. As distâncias médias aos grupos vizinhos são 100 para {50,60,70} e 90 para {250}; logo o vizinho é {250}, $b=90$ e a silhueta é $(90-15)/90=0,8333$.
3. Na ligação simples, 50–60 e 140–150 juntam-se na altura 10; 80 entra no primeiro grupo na altura 20 e a última junção ocorre em 60. Na ligação média, 80 entra a 25 e a última junção ocorre a $490/6=81,667$.
4. Com correlação 0,6, os autovalores são 1,6 e 0,4; PC1 guarda 80% da variância. Uma orientação é $(z_1+z_2)/\sqrt 2$ e o escore de (2,1) é $3/\sqrt2=2,1213$. O sinal inverso é equivalente.

## Agrupamento e PCA — conceitos

- Sem padronização, a variável com maior dispersão numérica domina a distância; mudar sua unidade para metros pode alterar o resultado.
- K-médias sempre devolve grupos: examine silhueta, estabilidade, tamanhos, sensibilidade à escala e plausibilidade, sem tratar o número escolhido como verdade.
- Ligação simples usa o par mais próximo e pode encadear pontos; completa usa a maior distância entre membros, exigindo grupos mais compactos.
- PCA ignora a resposta: maior variância de X não implica maior poder preditivo de Y. Isso exige avaliação supervisionada fora da amostra.
- Grupos podem ser usados como preditor categórico ou para investigar modelos por perfil; a formação dos grupos deve ocorrer no treino de cada dobra para evitar vazamento.
