# Resolução individual — Aula 05b — Regressão de Poisson
**Aluno:** Pedro Henrique · **Grupo:** APPA · **Data:** 2026-10-25 · apoio: ChatGPT.
**Solicitante:** Grupo APPA — Arthur Galvão, Pedro Henrique e Ailana.
Caderno de resoluções: conceitos, checkpoints, teste e exemplos de Poisson.

## Diagnóstico
Uma contagem assume valores inteiros não negativos; sua média prevista pode ser fracionária.
Tenho $e^0=1$ e $\log 1=0$. Na logística, $e^{\beta}$ multiplica as chances;
na Poisson, multiplica a média condicional. O `glm(..., binomial)` ajusta resposta binária.

## M1 — Contagens
Para quatro ligações diárias, calculo $P(Y=0)=e^{-4}=0{,}018316$ e
$\operatorname{Var}(Y)=4$. A reta pode prever números negativos, incompatíveis com contagens.

## M2 — Ligação logarítmica
Com $\log\lambda=1+0{,}3x$, obtenho $\lambda(0)=e^1=2{,}7183$,
$\lambda(2)=e^{1{,}6}=4{,}9530$. Cada quarto multiplica a média por
$e^{0{,}3}=1{,}34986$: aumento de $34{,}99\%$, mantendo os outros preditores fixos.

## M3 — Ajuste e previsão
O ajuste dá aproximadamente $(1{,}5738;-0{,}5217;0{,}0653)$.
Para três quilômetros e cinco fotos, uso os coeficientes completos no script;
com os arredondados, $\eta=1{,}5738-3(0{,}5217)+5(0{,}0653)=0{,}3352$ e
$\hat\lambda=e^{0{,}3352}=1{,}3982$ visita.
`predict()` dá a escala do log; `type="response"` dá visitas esperadas.

## M4 — Exposição e offset
O anúncio C teve $9/45=0{,}2$ visita/dia; D teve $5/10=0{,}5$: D é mais procurado.
Uma taxa de $0{,}3$ por dia em doze dias produz $3{,}6$ visitas.
Uso $\log(\text{dias})$ com coeficiente fixo igual a um: `offset(log(dias))`.

## M5 — Sobredispersão
Com $\hat\phi=2{,}25$, multiplico o erro padrão por $\sqrt{2{,}25}=1{,}5$:
$0{,}05\times1{,}5=0{,}075$. A razão cai de $0{,}12/0{,}05=2{,}4$
para $0{,}12/0{,}075=1{,}6$. Quase-Poisson mantém coeficientes e previsões,
mas corrige erros padrão. No exemplo executado, $\hat\phi\approx3{,}37$.

## M6 — Validação
O placar reproduzido é média $3{,}990111$, MQO $2{,}386974$ e Poisson $1{,}757921$.
Levo Poisson neste exemplo: menor erro fora da amostra e previsões positivas
porque $e^\eta>0$. Não corto as previsões negativas do MQO para melhorar seu placar.

## Teste final resolvido

| Módulo | Minha resposta |
|---|---|
| 1 | $P(Y=0)=e^{-0{,}5}=0{,}60653$; variância $0{,}5$. |
| 2 | Dez anos multiplicam por $e^{-0{,}1\times10}=0{,}367879$: queda de $63{,}21\%$. |
| 3 | $e^{2{,}3}=9{,}97418$: aproximadamente dez visitas esperadas. |
| 4 | $15\times0{,}4=6$ visitas; offset $\log15=2{,}70805$. |
| 5 | Erro corrigido $0{,}10\sqrt4=0{,}20$; $|z|=0{,}30/0{,}20=1{,}5$. |
| 6 | Poisson: RMSE $3{,}2$ ante $3{,}9$ e $5{,}1$, com contagens previstas positivas. |

## Conferência computacional
As sementes reproduzem as somas $836$, $775$ e $550$. Os CSVs `TeoriaPrevisoes`,
`TeoriaMetricas`, `TeoriaCoeficientes` e `TeoriaConferencia` guardam as evidências sem
arredondar os cálculos internos. Executo `Rscript estrutura/codigo/aula05b_poisson.R` na raiz.
