# Atividade 09 — Splines e modelos aditivos (Aula 10)
**APPA · 2026-10-25.** Reexecução no banco de sinistros, seguindo o escopo de modelos, gráficos e exercícios da referência.

## Pergunta auxiliar e protocolo
Modelo a quantidade de vítimas fatais por boletim a partir do horário contínuo, do logaritmo
do número de veículos e do tipo de via. Isso é uma análise auxiliar de gravidade e não altera
a pergunta de classificação Pico/Fora do Pico da Entrega 1. Veículos envolvidos são observados
no sinistro: o ajuste não constitui previsão de risco antes do evento.

A amostra fixa tem 12000 boletins, sendo 11339 com resposta zero.
Todos os candidatos usam as mesmas cinco dobras; o modelo de média aprende só no treino.
Os nós das splines são ajustados no treino de cada dobra. O GAM soma duas curvas suaves e
um efeito de via, ajustado com REML. Não há interação automática entre os efeitos.

| modelo | rmse_cv5 |
|---|---|
| media | 0.251862773690026 |
| reta | 0.242937238614963 |
| polinomio_grau_5 | 0.241907565545342 |
| spline_natural_df2 | 0.241979267778444 |
| spline_natural_df3 | 0.24195409950527 |
| spline_natural_df4 | 0.241888695605158 |
| spline_natural_df5 | 0.241874721066152 |
| spline_natural_df6 | 0.241878942223162 |
| spline_natural_df7 | 0.24175953571294 |
| spline_natural_df8 | 0.241727605390076 |
| spline_suavizacao | 0.249857628972813 |
| gam | 0.241456482118828 |

O melhor df da spline natural foi 8; o menor erro da grade foi de gam.
A seleção usa o mesmo conjunto de validação que informa o laboratório; não é estimativa independente
do erro após selecionar hiperparâmetros. A resposta tem muitos zeros e a família gaussiana é usada
aqui para estudar os métodos da aula, sem recomendar sua adoção operacional para contagens raras.

## Sete figuras e evidências
As figuras ficam em `estrutura/resultados/aula10/`: polinômio × spline, df baixo × alto,
curva de validação, spline de suavização, efeitos parciais do GAM, placar e B-spline × natural nas pontas.
A grade estendida de horas da última figura serve apenas ao diagnóstico matemático de extrapolação.

## Exercícios resolvidos
1. **Parâmetros:** uma cúbica por intervalos, com $K$ nós, tem $K+4$ parâmetros após impor continuidade
   da função e das duas primeiras derivadas; as duas restrições naturais nas pontas deixam $K+2$.
2. **Truncamentos:** em $100+2x+3(x-50)_+-4(x-80)_+$, obtenho $180$, $200$, $250$ e $370$
   para $x=40,50,60,100$. Cada dobradiça entra somente à direita de seu nó.
3. **Penalização:** minimizo $RSS+\lambda\int(f''(x))^2dx$. Por exemplo, com RSS $80$, curvatura $6$
   e $\lambda=5$, o critério vale $110$. Um concorrente com RSS $90$ e curvatura $2$ vale $100$ e vence.
4. **GAM:** somo intercepto e contribuições centradas das curvas. Com intercepto $1{,}2$, efeitos
   $0{,}4$ e $-0{,}1$, a previsão na escala de ligação identidade é $1{,}5$.
5. **Global × pedaços:** um polinômio global move a curva inteira ao mudar um coeficiente;
   a base de spline permite ajustes locais, ligados por restrições de continuidade.
6. **Dois botões:** df/nós controlam a dimensão da base; $\lambda$ controla o custo da curvatura.
   Uma base ampla pode produzir ajuste liso se a penalidade for forte.
7. **Aditividade:** $f_1(x_1)+f_2(x_2)$ não permite que a forma de $f_1$ dependa de $x_2$;
   para isso é necessário incluir interação explicitamente.
8. **Uma unidade:** o efeito de aumentar $x$ em uma unidade é $f(x+1)-f(x)$ e varia com a posição;
   em MQO simples ele seria a constante $\beta_1$.

[Código reproduzível](../estrutura/codigos/aula10_splines.R) ·
[Previsões de validação](../estrutura/resultados/aula10/previsoes-cv.csv).
