# Narrativa e roteiro de ensaio APPA

**Eixo:** o que a acurácia não conta. A pergunta científica permanece a associação com o alvo pico entre boletins.

**Tempo principal planejado: 11:00**, incluindo pausas e interações. 14 slides principais e 5 de apoio. O roteiro é proposto para ensaio, não registro de uma apresentação realizada.

## Distribuição sugerida

- Arthur Galvão: 3:40.
- Pedro Henrique: 4:40.
- Ailana Pereira Gonsalez: 2:40.

As participações incluem método, decisões e interpretação; a troca de pessoa acompanha a pergunta seguinte. Nenhum trecho depende de resposta da turma.

## Sequência editorial

| Slide | Responsável | Objetivo / mensagem central | Recurso visual | Tempo |
|---|---|---|---|---|
| 1. Acertar a maioria não é identificar o pico | Arthur Galvão | A acurácia precisa ser interpretada junto com os tipos de erro. | Capa acadêmica e barra proporcional de acertos/total. | 0:25 |
| 2. Dos 20.089 boletins de pico, identificamos 371 | Arthur Galvão | A sensibilidade mostra o que a acurácia total esconde. | 371 VP e 19.718 FN em barra proporcional ao total de pico. | 0:45 |
| 3. Estamos classificando boletins já registrados | Arthur Galvão | Pertencer ao pico entre boletins é diferente de risco por viagem. | Pergunta e relação entre boletim, características e classificação. | 0:40 |
| 4. O arquivo bruto e o banco do modelo têm tamanhos diferentes | Arthur Galvão | O recorte resulta de filtros explícitos; as exclusões não são neutras quanto à gravidade. | Fluxo de seleção, notificações e duas etapas de exclusão. | 0:50 |
| 5. Às 06:29 é uma classe; às 06:30, outra | Arthur Galvão | A fronteira é uma decisão operacional, não uma detecção de congestionamento. | Relógio e botões 06:29/06:30, com três janelas. | 1:00 |
| 6. Três características entram; a hora entrega a resposta | Pedro Henrique | Via, dia e região descrevem contexto; hora e turno revelam o alvo. | Três preditoras e relação hora → pico. | 0:50 |
| 7. Montamos o modelo em 2025 e testamos em 2026 | Pedro Henrique | A ordem temporal não transforma um teste conhecido em validação prospectiva. | Linha do tempo com períodos, contagens e condição retrospectiva. | 0:45 |
| 8. A logística produz a probabilidade; o limiar produz a classe | Pedro Henrique | Consultar outro perfil no mesmo ajuste não estima uma intervenção causal. | Três seletores, probabilidade, curva logística e classe em 0,5. | 1:05 |
| 9. Em 0,5, poucos boletins recebem a classe pico | Pedro Henrique | Explorar o teste não seleciona validamente outro limiar para reportar desempenho. | Matriz observada × prevista, limiar e retorno explícito a 0,5. | 1:10 |
| 10. A logística soma quatro acertos à referência | Pedro Henrique | 371 acertos positivos adicionais menos 367 negativos perdidos deixam saldo de quatro. | Totais e decomposição +371 −367 = +4, sem eixo ampliado. | 0:50 |
| 11. Quanto as probabilidades melhoraram? | Ailana Pereira Gonsalez | As métricas descrevem aspectos diferentes das mesmas probabilidades. | Tabela de erros e valor de AUC. | 0:55 |
| 12. A razão de chances descreve uma associação condicionada | Ailana Pereira Gonsalez | A OR se refere a pertencer ao pico entre boletins, ajustando por dia e região. | Razão de chances, intervalo e referência em 1. | 0:45 |
| 13. O alcance depende do recorte, da regra e do protocolo | Ailana Pereira Gonsalez | Limitações se conectam às decisões; não são uma lista genérica de ressalvas. | Exclusões → população; janelas → alvo; teste conhecido → alcance temporal. | 0:35 |
| 14. O que os acertos mostram | Ailana Pereira Gonsalez | A contribuição da etapa é interpretar a execução e seus limites. | Dois denominadores, pergunta inicial e acesso ao material. | 0:25 |

## Roteiro completo para ensaio

### 1. Acertar a maioria não é identificar o pico

**Arthur Galvão · 0:00–0:25 (25 s)**

Fala proposta:

> O nosso trabalho usa regressão logística para classificar boletins em horários de pico. Ele chegou a 59,43% de acertos. Só que esse número, sozinho, não explica quais boletins foram identificados. É por essa diferença que vamos começar.

Pausa / interação: Pausar dois segundos depois do número. Não pedir votação à turma.

Transição: Vamos olhar só para os boletins que realmente eram de pico.

### 2. Dos 20.089 boletins de pico, identificamos 371

**Arthur Galvão · 0:25–1:10 (45 s)**

Fala proposta:

> Aqui eu olho só os boletins que aconteceram no pico. Eram 20.089. O modelo achou 371, que são a parte pequena da barra. Os outros 19.718 ficaram no lado errado. Esse 1,85% fala só dos boletins de pico.

Pausa / interação: Apontar total e segmentos, reservando cinco segundos à barra.

Transição: Para entender esses números, vamos voltar à pergunta do estudo.

### 3. Estamos classificando boletins já registrados

**Arthur Galvão · 1:10–1:50 (40 s)**

Fala proposta:

> A pergunta é: que características dos sinistros registrados estão associadas ao pertencimento aos horários de pico? A unidade é um boletim, não um veículo que está circulando. A base reúne hora, calendário e contexto do evento, por isso permite essa aplicação. Mas não temos as viagens sem sinistro nem o fluxo de veículos. Então o ajuste não prevê se alguém vai sofrer um acidente e não mede risco por viagem.

Pausa / interação: Pausa breve depois da distinção entre boletim e veículo.

Transição: Agora mostro quais registros entraram na análise.

### 4. O arquivo bruto e o banco do modelo têm tamanhos diferentes

**Arthur Galvão · 1:50–2:40 (50 s)**

Fala proposta:

> O arquivo começa com 273.371 registros. Ao selecionar boletins fatais e não fatais, ficam 151.833; as notificações ficam fora. Depois saem 242 sem data ou hora válida e 416 sem tipo de via entre os restantes. Chegamos a 151.175. Esse filtro tem uma consequência: 656 dos 658 excluídos são fatais. Não tratamos a retirada como neutra em relação ao perfil dos registros. Usamos todos os boletins que atendem às regras nesse arquivo, sem afirmar que representem aleatoriamente o trânsito paulista.

Pausa / interação: Percorrer o fluxo e reservar cinco segundos à concentração das exclusões.

Transição: Com a base pronta, faltava definir quais horários seriam pico.

### 5. Às 06:29 é uma classe; às 06:30, outra

**Arthur Galvão · 2:40–3:40 (60 s)**

Fala proposta:

> Aqui dá para ver uma decisão anterior ao modelo. Às 06:29, o boletim fica fora do pico. Um minuto depois, às 06:30, ele entra no pico. A mudança acontece porque adotamos uma regra com extremos inclusivos. Ela também inclui 11:30 a 13:30 e 17:00 a 19:30. Essas janelas vêm da Entrega 1. Não temos medição de congestionamento para dizer que elas descrevem igualmente todas as regiões. O exemplo deixa claro o que o alvo significa.

Pausa / interação: Clicar 06:29, pausar, clicar 06:30 e indicar as outras janelas. Cerca de 20 segundos de interação; não aguardar resposta da turma.

Transição: Pedro explica quais informações o modelo usa para classificar os boletins.

### 6. Três características entram; a hora entrega a resposta

**Pedro Henrique · 3:40–4:30 (50 s)**

Fala proposta:

> Tipo de via representa o contexto viário, dia da semana representa o calendário e região situa o registro no território. São três variáveis categóricas; as categorias geram 22 indicadores e um intercepto. A hora fica fora porque foi usada para construir a resposta. O turno também revela parte dela. Se entrassem, o ajuste receberia informação sobre o próprio alvo. Esse conjunto é a especificação que estamos demonstrando, não uma comprovação de que essas sejam as três melhores entradas possíveis.

Pausa / interação: Distinguir três variáveis da quantidade de coeficientes.

Transição: Depois de escolher as informações, separamos os dois períodos.

### 7. Montamos o modelo em 2025 e testamos em 2026

**Pedro Henrique · 4:30–5:15 (45 s)**

Fala proposta:

> Primeiro usamos os boletins de 2025 para montar o modelo. Depois, conferimos as respostas nos boletins do primeiro semestre de 2026. Mantivemos o mesmo modelo e a mesma regra de decisão. Como já tínhamos explorado 2026, o teste descreve o que aconteceu nesse período.

Pausa / interação: Indicar o corte entre os anos.

Transição: Vou usar um exemplo para mostrar como o modelo dá uma probabilidade.

### 8. A logística produz a probabilidade; o limiar produz a classe

**Pedro Henrique · 5:15–6:20 (65 s)**

Fala proposta:

> Escolhemos uma logística porque a resposta tem duas categorias e o modelo permite interpretar probabilidades e coeficientes. Estes controles usam o ajuste real de 2025. Se trocamos o dia da semana e mantemos via e região, consultamos outro perfil no mesmo modelo. A probabilidade muda, mas isso não significa que mudar o dia cause uma mudança no trânsito. Ela se refere ao pertencimento ao pico entre boletins com essas características. Depois aplicamos 0,5 para converter a probabilidade em classe.

Pausa / interação: Mudar Segunda-feira para Domingo e retornar. Reservar cerca de 20 segundos à interação.

Transição: Agora vamos ver o que acontece quando aplicamos o corte.

### 9. Em 0,5, poucos boletins recebem a classe pico

**Pedro Henrique · 6:20–7:30 (70 s)**

Fala proposta:

> Olhem primeiro a linha de baixo. São os boletins que aconteceram no pico. Na direita, estão os 371 que o modelo identificou. Na esquerda, os 19.718 que ele colocou fora do pico por engano. A regra do artigo usa 0,5. Se eu mudar o controle, os números mudam porque estou usando outra regra sobre os mesmos boletins.

Pausa / interação: Aponte a linha de baixo. Se quiser demonstrar, mova para 0,35 e clique em Voltar a 0,5.

Transição: Vamos comparar esses acertos com a regra de marcar tudo como fora do pico.

### 10. A logística soma quatro acertos à referência

**Pedro Henrique · 7:30–8:20 (50 s)**

Fala proposta:

> A referência usa a frequência de pico no treino, abaixo de 0,5. Ela classifica todos como fora do pico e acerta os 29.420 negativos do teste. A logística chega a 29.424 acertos. Recupera 371 positivos, mas perde 367 negativos que a referência acertava. O saldo é de quatro boletins, não quatro pontos percentuais. As previsões não são iguais; a acurácia quase empata porque soma tipos diferentes de acerto.

Pausa / interação: Ler a decomposição e pausar depois do saldo. Dez segundos para apontar os termos.

Transição: Ailana compara o erro das probabilidades e fecha com os limites do modelo.

### 11. Quanto as probabilidades melhoraram?

**Ailana Pereira Gonsalez · 8:20–9:15 (55 s)**

Fala proposta:

> Antes de dizer pico ou fora do pico, o modelo dá uma probabilidade. O RMSE mede o erro dessas probabilidades. Quanto menor, melhor. O erro caiu de cerca de 0,491 para 0,487. É uma melhora pequena. A AUC responde outra pergunta: se o modelo costuma dar pontuação maior aos boletins de pico.

Pausa / interação: Aponte os dois números da coluna RMSE. Explique Brier e AUC se perguntarem.

Transição: Além do erro, o modelo permite comparar os perfis dos boletins.

### 12. A razão de chances descreve uma associação condicionada

**Ailana Pereira Gonsalez · 9:15–10:00 (45 s)**

Fala proposta:

> Para vias urbanas em relação a estradas e rodovias, a razão de chances ajustada é 0,9663. O intervalo com agrupamento por data vai de 0,9328 a 1,0010. São as chances de pertencer ao pico, mantendo dia e região no ajuste. Esse número não é uma probabilidade nem indica que uma via proteja contra sinistros. Os testes e o relatório completo estão no apoio. Um valor de p também não mede relevância prática ou causalidade.

Pausa / interação: Apontar 1 como referência e explicar o contraste antes do intervalo.

Transição: Essa comparação tem alguns limites importantes.

### 13. O alcance depende do recorte, da regra e do protocolo

**Ailana Pereira Gonsalez · 10:00–10:35 (35 s)**

Fala proposta:

> O recorte perdeu registros sobretudo fatais. As janelas não foram validadas com fluxo de veículos. E o teste já era conhecido. Além disso, boletins com as mesmas três características recebem a mesma probabilidade, mesmo quando os horários diferem. São condições da análise. Não medimos se acrescentar uma variável resolveria o problema e não avaliamos uma intervenção de segurança viária.

Pausa / interação: Pausa curta entre as três condições.

Transição: Com esses limites em mente, voltamos ao número do início.

### 14. O que os acertos mostram

**Ailana Pereira Gonsalez · 10:35–11:00 (25 s)**

Fala proposta:

> O modelo acertou a maioria quando contamos todos os boletins. Quando olhamos só para quem estava no pico, ele deixou passar quase todos. Por isso o total de acertos, sozinho, dá uma visão incompleta.

Pausa / interação: Pausar antes das perguntas. O tempo principal termina aqui.

Transição: Os próximos slides ficam para as perguntas.

## Roteiro compacto

| Slide | Palavras-chave e observações |
|---|---|
| 1 | 59,43% entre todos os boletins. Abrir a pergunta sobre quem foi identificado. |
| 2 | Leia só os boletins de pico. De 20.089, o modelo achou 371. A parte pequena da barra mostra isso. |
| 3 | Unidade: boletim. Não há viagens sem sinistro nem fluxo de veículos. |
| 4 | 121.538 notificações fora; 242 sem data/hora válida; 416 sem via. Dos 658 excluídos, 656 fatais. |
| 5 | Clicar 06:29 e 06:30. Extremos inclusivos; regra da Entrega 1, sem validação por fluxo. |
| 6 | 3 fatores, 22 indicadores + intercepto. Conjunto demonstrado, sem alegar que sejam as melhores entradas. |
| 7 | Esquerda: 2025, para montar o modelo. Direita: primeiro semestre de 2026, para conferir o resultado. |
| 8 | pico ~ via + dia + regiao. Mudar segunda para domingo e voltar. Mesmos coeficientes de 2025. |
| 9 | Comece pela linha de baixo. Aí estão os boletins que realmente eram de pico. Aponte 19.718 perdidos e 371 identificados. |
| 10 | Referência: 29.420 acertos. Logística: 29.424. Quatro boletins não são quatro pontos percentuais. |
| 11 | Leia primeiro o RMSE. Quanto menor, menor o erro das probabilidades. A melhora foi pequena. |
| 12 | Via: OR 0,9663; IC por data 0,9328–1,0010. Não é probabilidade ou risco de sinistro. |
| 13 | 656 excluídos fatais. Janelas sem fluxo. Teste conhecido. Mesmos X recebem o mesmo p. |
| 14 | Todos: 59,43%. Só os de pico: 371 de 20.089. A diferença é o grupo contado. |

## Contingência e ritmo

Se a turma estiver silenciosa, o apresentador faz a pergunta e continua com a explicação prevista. Não há enquetes ou espera obrigatória. Em HTML, as três experiências usam os controles. Em PDF: narrar 06:29 fora / 06:30 pico; ler o perfil de exemplo; explicar que outro limiar mudaria as classes sem anunciar novos números. A matriz reportada fica em 0,5.

Os slides de apoio são consultados apenas na arguição. Se o tempo for reduzido, preservar pergunta, unidade, alvo, partição, matriz e limites; encurtar a interação, sem eliminar a advertência sobre exploração do teste.

## Estimativa de fala e simulação

O texto principal tem 846 palavras por contagem de tokens separados por espaço. A 125 palavras/minuto, a leitura sem pausas levaria aproximadamente 6:46. Números, gestos e interação exigem tempo adicional, já reservado no orçamento de 11:00. Esse cálculo é uma referência de planejamento; não mede a fala de cada integrante.

O percurso técnico e o orçamento são verificados por npm test e npm run simular. A simulação do navegador é acelerada, sem áudio ou ensaio humano. A duração oral real precisa ser conferida pelo grupo. Não há evidência de que esse ensaio já ocorreu.

## Apoio

| Slide | Conteúdo |
|---|---|
| 15 | Apoio · especificação e relatório do R |
| 16 | Apoio · hipóteses e incerteza têm suposições |
| 17 | Apoio · calibração e variação mensal |
| 18 | Apoio · PCA e Poisson estão em tarefas separadas |
| 19 | Apoio · fontes e materiais reproduzíveis |

A preparação para perguntas está em [ARGUICAO_APPA.md](ARGUICAO_APPA.md). A análise das duas estruturas narrativas, das fontes e da versão anterior está em [CURADORIA_APPA.md](../../CURADORIA_APPA.md).

Este documento é gerado a partir de src/slides.ts por scripts/gerar-roteiro.mjs. Alterações na sequência, fala ou tempo devem ser feitas na fonte e regeneradas.
