# Consolidado — Teoria do Aprendizado Estatístico — Aula 05b — Parte D — 2026-10-25
*Guia versão 1 · apoio: ChatGPT · aplicação ao banco do APPA.*
**Grupo:** APPA · **Solicitante:** Grupo APPA — Arthur Galvão, Pedro Henrique e Ailana.

## Antes de tudo: ficha e teoria
APPA investiga a concentração de sinistros nos horários de pico.
O banco bruto tem 273372 linhas e 50 colunas; o recorte de boletins tem 151833.
O consolidado teórico cobre M1–M6, com checkpoints, teste e exemplos resolvidos.

## 1. O que foi feito
- **M7:** escolhemos o caso 2: cada boletim é um evento. Contamos mês × dia da semana × hora,
  totalizando 3024 células e 151591 eventos válidos. Excluímos 242
  boletins sem data/horário válido. A tabela contém todas as combinações, inclusive possíveis zeros;
  nesta execução houve 0 células com zero. Isso é plausível na agregação estadual.
- **Exposição:** número de dias daquele dia da semana no mês: quatro ou cinco dias por célula.
  O calendário completo de janeiro de 2025 a junho de 2026 tem 546 dias.
  Usamos `offset(log(exposicao))`, medido em horas observáveis daquele horário no calendário.
- **M8:** ajustamos `n ~ mes + dia + hora + offset(log(exposicao))`. Todos os preditores são de
  calendário, conhecidos antes da contagem. A dispersão foi $\hat\phi=3,999$;
  usamos quase-Poisson para erros padrão. Coeficientes e previsões coincidem com os do Poisson.
- **Leitura do efeito:** às 18h, a contagem esperada por dia exposto multiplica por
  $3,411$ em relação às 0h, fixados mês e dia da semana
  (aumento de $241,1\%$). É associação no registro, sem exposição de tráfego.
- **M9:** comparamos média estimada só no treino, MQO sem truncagem e Poisson nas mesmas cinco dobras.

| modelo | RMSE CV(5) | previsões negativas |
|---|---|---|
| media | 27,024 | 0 |
| mqo | 14,229 | 6 |
| poisson | 13,713 | 0 |

**Decisão:** adotamos Poisson nesta pergunta auxiliar: menor RMSE e média prevista positiva.
As dobras aleatórias avaliam células intercambiáveis do período; não estimam desempenho para meses futuros.
O MQO recebe a exposição como preditor comum; o Poisson usa a relação multiplicativa do offset.

## Checkpoints e verificação final
- **C7:** uma linha é mês × dia × hora; há 3024 linhas, exposições variáveis e zeros preservados.
- **C8:** $e^{\beta}$ é uma razão; o efeito das 18h e a dispersão acima saíram do R, não do exemplo do guia.
- **C9:** a escolha usa os três números e informa a pergunta auxiliar, sem alterar a classificação original.
- **V7:** sem zeros, a média é inflada e o nível das previsões muda.
- **V8:** uma razão $0{,}8$ significa contagem esperada $20\%$ menor, mantendo os demais preditores.
- **V9:** quase-Poisson não entra novamente no placar porque suas previsões são iguais às da Poisson.

## 2. Como o grupo trabalhou — opinião da tutora
Organizamos a aplicação em preparação das contagens, ajuste do modelo e comparação por validação
cruzada. Definimos uma linha como mês × dia da semana × hora e conferimos a exposição pelo calendário,
mantendo todas as combinações. Na interpretação, separamos a razão multiplicativa dos coeficientes
da variação nas contagens e verificamos a sobredispersão antes de usar quase-Poisson nos erros padrão.

Comparamos média, MQO e Poisson nas mesmas cinco dobras, com a linha de base estimada apenas no treino.
Adotamos Poisson para a pergunta auxiliar pelo menor RMSE e pelas previsões positivas. Registramos
o limite da validação por células do mesmo período e mantivemos a distinção entre frequência de
sinistros e risco por veículo.

**Verificação final:** M7–M9, checkpoints, contagens, coeficientes e placar documentados.

## 3. Observações para a frente
- **Para o trabalho:** a contagem acrescenta uma análise auxiliar; não identifica a causa dos sinistros
  nem mede risco por veículo, pois não existe fluxo de tráfego como exposição no banco.
- **Perguntas guardadas:** validação temporal e interações hora × dia, para continuação após a entrega.
- **Produzido:** [código](../estrutura/codigo/aula05b_poisson.R), ficha, contagens, previsões,
  coeficientes, auditoria e gráfico em `estrutura/resultados/2026-10-25-appa-05b-*`.
