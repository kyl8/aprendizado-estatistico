# Atividade 09 — Splines e modelos aditivos (Aula 10)
**APPA · reexecução de 06/11/2026.** Banco de sinistros, seguindo o escopo de modelos, gráficos e exercícios da Aula 10.

## Pergunta auxiliar e protocolo
Modelo a quantidade de vítimas fatais por boletim a partir do horário contínuo, do logaritmo do número de veículos e do tipo de via. Isso é uma análise auxiliar de gravidade e não altera a pergunta da Entrega 1. Veículos envolvidos são observados no sinistro: o ajuste não constitui previsão de risco antes do evento.

A amostra fixa tem 12.000 boletins (do recorte de 151.175 sem marcadores `NAO DISPONIVEL`), sendo 11.379 com resposta zero. Todos os candidatos usam as mesmas cinco dobras; o modelo de média aprende só no treino. Os nós das splines são ajustados no treino de cada dobra. O GAM soma duas curvas suaves e um efeito de via, ajustado com REML. Não há interação automática entre os efeitos.

A hora é uma variável **circular** (23h59 e 0h00 são vizinhas); por isso foi incluído o `gam_ciclico`, com base cíclica (`bs = "cc"`) e nós em 0 e 24. As splines naturais comuns tratam 0h e 24h como pontas separadas.

| modelo | rmse_cv5 | erro padrão entre dobras |
|---|---|---|
| media | 0.2457 | 0.0060 |
| reta | 0.2418 | 0.0061 |
| polinomio_grau_5 | 0.2407 | 0.0060 |
| spline_natural_df2 | 0.2409 | 0.0061 |
| spline_natural_df3 | 0.2409 | 0.0061 |
| spline_natural_df4 | 0.2409 | 0.0061 |
| spline_natural_df5 | 0.2410 | 0.0061 |
| spline_natural_df6 | 0.2409 | 0.0061 |
| spline_natural_df7 | 0.2409 | 0.0061 |
| spline_natural_df8 | 0.2408 | 0.0061 |
| ns_df5_apenas_hora | 0.2445 | 0.0060 |
| spline_suavizacao_apenas_hora | 0.2443 | 0.0060 |
| gam_ciclico | 0.2407 | 0.0061 |
| gam | 0.2407 | 0.0060 |

`ns_df5_apenas_hora` e `spline_suavizacao_apenas_hora` usam **só a hora** como preditor; elas são comparáveis entre si, não aos modelos que também têm veículos e tipo de via. A comparação justa da spline de suavização é com a `ns_df5_apenas_hora`.

## Leitura do placar
O menor erro foi do `gam_ciclico` (0,2407), mas a diferença para a reta (0,2418) é de apenas 0,19 erro padrão entre dobras (cada RMSE tem erro padrão de cerca de 0,006). Na prática os modelos com veículos e via **empatam** e todos superam a média (0,2457). O melhor df da spline natural na grade foi 8, que é a borda da grade; df maiores não foram testados. A seleção usa o mesmo conjunto de validação que informa o laboratório; não é estimativa independente do erro após selecionar hiperparâmetros. A resposta tem muitos zeros e a família gaussiana é usada para estudar os métodos da aula, sem recomendar sua adoção operacional para contagens raras.

## Sete figuras e evidências
As figuras ficam em `estrutura/codigos/resultados/aula10/`: polinômio × spline, df baixo × alto, curva de validação, spline de suavização, efeitos parciais do GAM, placar e B-spline × natural nas pontas. A grade estendida de horas da última figura (−2 a 26) serve apenas ao diagnóstico matemático de extrapolação; não são horários reais.

## Exercícios resolvidos (enunciados da Aula 10, pp. 29–30)
**Cálculo**

1. **Spline cúbica com K = 4 nós.** Os 5 polinômios soltos têm 5 × 4 = 20 coeficientes. Cada nó impõe 3 restrições (valor, inclinação e curvatura): 4 × 3 = 12. Sobram 20 − 12 = 8 = K + 4 parâmetros. A spline natural com os 4 nós internos e os 2 de fronteira impõe linearidade fora das fronteiras (4 restrições a mais sobre os 10 parâmetros de uma cúbica com 6 nós), e sobram 6 = K + 2 parâmetros.
2. **f(x) = 100 + 2x + 3(x − 50)₊ − 4(x − 80)₊.** f(40) = 180; f(50) = 200; f(60) = 100 + 120 + 30 = 250; f(100) = 100 + 200 + 150 − 80 = 370. As inclinações são 2 (x < 50), 5 (50 < x < 80) e 1 (x > 80). A curva é contínua em x = 50, pois (x − 50)₊ vale zero ali, mas a inclinação salta de 2 para 5, então não é derivável nesse ponto (é uma spline linear, não cúbica).
3. **Penalização.** O critério é RSS + λ · pedágio. Com RSS 52, 30 e 12 e pedágios 0, 4 e 30: para λ = 0,1, os critérios são 52, 30,4 e 15, e vence a terceira curva; para λ = 1, são 52, 34 e 42, e vence a segunda; para λ = 10, são 52, 70 e 312, e vence a primeira. Quanto maior λ, mais a curva reta (pedágio zero) vence. No cálculo do pedágio ∫₀¹ g″(t)² dt: g₁ = 3 + 2x tem g″ = 0 e pedágio 0; g₂ = x² tem g″ = 2 e pedágio 4; g₃ = x³ tem g″ = 6x e pedágio ∫ 36x² = 12.
4. **GAM.** β̂₀ = 340, f̂_área = −20, f̂_praia = +60 e f̂_idade = +26 dão predição 340 − 20 + 60 + 26 = 406. Com f̂_praia = −11 (imóvel a 2 km), a predição é 340 − 20 − 11 + 26 = 335, uma mudança de −71. Só o termo da praia muda porque o modelo é aditivo: cada f̂ depende apenas da própria variável.

**Conceituais**

5. **Global × por pedaços.** Um polinômio de grau 10 é uma única fórmula: mudar um coeficiente move a curva inteira, e os termos de grau alto crescem rápido nas pontas, onde há poucos dados para segurá-los, por isso a curva oscila. A spline natural com 10 graus de liberdade tem pedaços locais, cada um responde sobretudo aos dados do seu trecho, e fora dos nós de fronteira ela é forçada a ser uma reta.
6. **Os dois botões.** Na spline de regressão o botão é o número de graus de liberdade (nós): mais df, mais flexível. Na spline de suavização o botão é λ: λ menor, mais flexível (também pode ser expresso em df efetivos). A curva de validação cruzada da primeira sai serrilhada porque df é inteiro e os nós se deslocam a cada valor; a da segunda é lisa porque λ varia continuamente.
7. **Aditivo.** O GAM supõe que o efeito de cada preditor se soma aos demais, sem interação. Exemplo imobiliário: o prêmio de ficar perto da praia é maior em imóveis grandes do que em pequenos. O GAM ajusta um único efeito de praia para todos e subestima o prêmio nos grandes e o superestima nos pequenos. Aqui, o efeito da hora poderia depender do tipo de via, e o modelo não captura isso sem uma interação explícita.
8. **O efeito de 1 m².** O GAM não responde com um número: o efeito de aumentar x em uma unidade é f̂(x + 1) − f̂(x) e depende de onde x está (50 m² → 51 m² não é igual a 200 m² → 201 m²). Vale o mesmo para 1 ano de idade. Em MQO simples seria a constante β₁.

[Código reproduzível](../estrutura/codigos/2026-10-25-appa-Atividade09-SplinesModelosAditivos.R) · [Previsões de validação](../estrutura/codigos/resultados/aula10/previsoes-cv.csv).
