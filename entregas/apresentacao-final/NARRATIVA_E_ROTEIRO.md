# Narrativa e roteiro de ensaio APPA

**Eixo:** o que a acurácia não conta. A pergunta científica permanece a associação com o alvo pico entre boletins.

**Tempo principal planejado: 11:00**, incluindo pausas e interações. 14 slides principais e 5 de apoio. O roteiro é proposto para ensaio, não registro de uma apresentação realizada.

## Distribuição sugerida

- Arthur Galvão: 3:30.
- Ailana Pereira Gonsalez: 4:00.
- Pedro Henrique: 3:30.

As participações incluem método, decisões e interpretação; a troca de pessoa acompanha a pergunta seguinte. Nenhum trecho depende de resposta da turma.

## Sequência editorial

| Slide | Responsável | Objetivo / mensagem central | Recurso visual | Tempo |
|---|---|---|---|---|
| 1. Acertar a maioria não é identificar o pico | Arthur Galvão | A acurácia precisa ser interpretada junto com os tipos de erro. | Capa acadêmica e barra proporcional de acertos/total. | 0:25 |
| 2. Dos 20.089 boletins de pico, identificamos 371 | Ailana Pereira Gonsalez | A sensibilidade mostra o que a acurácia total esconde. | 371 VP e 19.718 FN em barra proporcional ao total de pico. | 0:45 |
| 3. Estamos classificando boletins já registrados | Pedro Henrique | Pertencer ao pico entre boletins é diferente de risco por viagem. | Pergunta e relação entre boletim, características e classificação. | 0:40 |
| 4. O arquivo bruto e o banco do modelo têm tamanhos diferentes | Arthur Galvão | O recorte resulta de filtros explícitos; as exclusões não são neutras quanto à gravidade. | Fluxo de seleção, notificações e duas etapas de exclusão. | 0:50 |
| 5. Às 06:29 é uma classe; às 06:30, outra | Pedro Henrique | A fronteira é uma decisão operacional, não uma detecção de congestionamento. | Relógio e botões 06:29/06:30, com três janelas. | 1:00 |
| 6. Três características entram; a hora entrega a resposta | Arthur Galvão | Via, dia e região descrevem contexto; hora e turno revelam o alvo. | Três preditoras e relação hora → pico. | 0:50 |
| 7. O ajuste usa 2025; a avaliação usa 2026 | Ailana Pereira Gonsalez | A ordem temporal não transforma um teste conhecido em validação prospectiva. | Linha do tempo com períodos, contagens e condição retrospectiva. | 0:45 |
| 8. A logística produz a probabilidade; o limiar produz a classe | Pedro Henrique | Consultar outro perfil no mesmo ajuste não estima uma intervenção causal. | Três seletores, probabilidade, curva logística e classe em 0,5. | 1:05 |
| 9. Em 0,5, poucos boletins recebem a classe pico | Ailana Pereira Gonsalez | Explorar o teste não seleciona validamente outro limiar para reportar desempenho. | Matriz observada × prevista, limiar e retorno explícito a 0,5. | 1:10 |
| 10. A logística soma quatro acertos à referência | Arthur Galvão | 371 acertos positivos adicionais menos 367 negativos perdidos deixam saldo de quatro. | Totais e decomposição +371 −367 = +4, sem eixo ampliado. | 0:50 |
| 11. Ordenação e erro de probabilidade são outras medidas | Ailana Pereira Gonsalez | As métricas descrevem aspectos diferentes das mesmas probabilidades. | ROC com escala completa e Brier com origem comum em zero. | 0:55 |
| 12. A razão de chances descreve uma associação condicionada | Pedro Henrique | A OR se refere a pertencer ao pico entre boletins, ajustando por dia e região. | Razão de chances, intervalo e referência em 1. | 0:45 |
| 13. O alcance depende do recorte, da regra e do protocolo | Arthur Galvão | Limitações se conectam às decisões; não são uma lista genérica de ressalvas. | Exclusões → população; janelas → alvo; teste conhecido → alcance temporal. | 0:35 |
| 14. Agora os 59,43% têm denominador e contexto | Ailana Pereira Gonsalez | A contribuição da etapa é interpretar a execução e seus limites. | Dois denominadores, pergunta inicial e acesso ao material. | 0:25 |

## Roteiro completo para ensaio

### 1. Acertar a maioria não é identificar o pico

**Arthur Galvão · 0:00–0:25 (25 s)**

Fala proposta:

> O nosso trabalho usa regressão logística para classificar boletins em horários de pico. Ele chegou a 59,43% de acertos. Só que esse número, sozinho, não explica quais boletins foram identificados. É por essa diferença que vamos começar.

Pausa / interação: Pausar dois segundos depois do número. Não pedir votação à turma.

Transição: Ailana mostra o que acontece quando olhamos apenas os boletins de pico.

### 2. Dos 20.089 boletins de pico, identificamos 371

**Ailana Pereira Gonsalez · 0:25–1:10 (45 s)**

Fala proposta:

> Quando separamos os boletins que realmente pertencem às janelas de pico, temos 20.089 registros. O modelo identificou 371 e deixou 19.718 na classe fora do pico. A parte pequena da barra representa 1,85% dos positivos. Não é uma contradição com os 59,43%: estamos usando outro denominador. Para entender essa diferença, precisamos voltar ao que a base registra e ao que chamamos de pico.

Pausa / interação: Apontar total e segmentos, reservando cinco segundos à barra.

Transição: Pedro delimita a pergunta que esse banco permite fazer.

### 3. Estamos classificando boletins já registrados

**Pedro Henrique · 1:10–1:50 (40 s)**

Fala proposta:

> A pergunta é: que características dos sinistros registrados estão associadas ao pertencimento aos horários de pico? A unidade é um boletim, não um veículo que está circulando. A base reúne hora, calendário e contexto do evento, por isso permite essa aplicação. Mas não temos as viagens sem sinistro nem o fluxo de veículos. Então o ajuste não prevê se alguém vai sofrer um acidente e não mede risco por viagem.

Pausa / interação: Pausa breve depois da distinção entre boletim e veículo.

Transição: Arthur mostra quais registros chegaram ao ajuste.

### 4. O arquivo bruto e o banco do modelo têm tamanhos diferentes

**Arthur Galvão · 1:50–2:40 (50 s)**

Fala proposta:

> O arquivo começa com 273.371 registros. Ao selecionar boletins fatais e não fatais, ficam 151.833; as notificações ficam fora. Depois saem 242 sem data ou hora válida e 416 sem tipo de via entre os restantes. Chegamos a 151.175. Esse filtro tem uma consequência: 656 dos 658 excluídos são fatais. Não tratamos a retirada como neutra em relação ao perfil dos registros. Usamos todos os boletins que atendem às regras nesse arquivo, sem afirmar que representem aleatoriamente o trânsito paulista.

Pausa / interação: Percorrer o fluxo e reservar cinco segundos à concentração das exclusões.

Transição: Pedro mostra como a resposta foi definida antes do ajuste.

### 5. Às 06:29 é uma classe; às 06:30, outra

**Pedro Henrique · 2:40–3:40 (60 s)**

Fala proposta:

> Aqui dá para ver uma decisão anterior ao modelo. Às 06:29, o boletim fica fora do pico. Um minuto depois, às 06:30, ele entra no pico. A mudança acontece porque adotamos uma regra com extremos inclusivos. Ela também inclui 11:30 a 13:30 e 17:00 a 19:30. Essas janelas vêm da Entrega 1. Não temos medição de congestionamento para dizer que elas descrevem igualmente todas as regiões. O exemplo deixa claro o que o alvo significa.

Pausa / interação: Clicar 06:29, pausar, clicar 06:30 e indicar as outras janelas. Cerca de 20 segundos de interação; não aguardar resposta da turma.

Transição: Arthur explica por que a mesma hora não pode entrar como preditora.

### 6. Três características entram; a hora entrega a resposta

**Arthur Galvão · 3:40–4:30 (50 s)**

Fala proposta:

> Tipo de via representa o contexto viário, dia da semana representa o calendário e região situa o registro no território. São três variáveis categóricas; as categorias geram 22 indicadores e um intercepto. A hora fica fora porque foi usada para construir a resposta. O turno também revela parte dela. Se entrassem, o ajuste receberia informação sobre o próprio alvo. Esse conjunto é a especificação que estamos demonstrando, não uma comprovação de que essas sejam as três melhores entradas possíveis.

Pausa / interação: Distinguir três variáveis da quantidade de coeficientes.

Transição: Ailana apresenta outra decisão: a separação dos períodos.

### 7. O ajuste usa 2025; a avaliação usa 2026

**Ailana Pereira Gonsalez · 4:30–5:15 (45 s)**

Fala proposta:

> Os 101.666 boletins de 2025 servem para ajustar os coeficientes. Depois aplicamos esse mesmo ajuste aos 49.509 boletins de janeiro a junho de 2026. O corte respeita a ordem das datas e o limiar reportado continua em 0,5. Mas há um limite: os dados de 2026 já tinham sido explorados nas atividades anteriores. Chamamos a avaliação de retrospectiva. Ela não é uma experiência prospectiva com registros que ninguém tinha visto.

Pausa / interação: Indicar o corte entre os anos.

Transição: Pedro usa um perfil para separar probabilidade e classe.

### 8. A logística produz a probabilidade; o limiar produz a classe

**Pedro Henrique · 5:15–6:20 (65 s)**

Fala proposta:

> Escolhemos uma logística porque a resposta tem duas categorias e o modelo permite interpretar probabilidades e coeficientes. Estes controles usam o ajuste real de 2025. Se trocamos o dia da semana e mantemos via e região, consultamos outro perfil no mesmo modelo. A probabilidade muda, mas isso não significa que mudar o dia cause uma mudança no trânsito. Ela se refere ao pertencimento ao pico entre boletins com essas características. Depois aplicamos 0,5 para converter a probabilidade em classe.

Pausa / interação: Mudar Segunda-feira para Domingo e retornar. Reservar cerca de 20 segundos à interação.

Transição: Ailana mostra o efeito dessa conversão na matriz de confusão.

### 9. Em 0,5, poucos boletins recebem a classe pico

**Ailana Pereira Gonsalez · 6:20–7:30 (70 s)**

Fala proposta:

> As linhas mostram a classe observada e as colunas, a prevista. Em 0,5, somente 738 boletins recebem previsão de pico. Desses, 371 são positivos corretos e 367 são falsos positivos. Já os 19.718 falsos negativos são boletins de pico que ficaram na previsão fora do pico. Podemos mover o limiar e ver as contagens mudarem. Isso é uma exploração dos mesmos dados de teste, não uma escolha válida de um novo limiar para anunciar um resultado melhor. Para os números do artigo, voltamos a 0,5.

Pausa / interação: Ler a orientação da matriz. Alterar para 0,35, pausar e usar Voltar a 0,5. Cerca de 18 segundos de interação.

Transição: Arthur compara essa matriz com o palpite constante.

### 10. A logística soma quatro acertos à referência

**Arthur Galvão · 7:30–8:20 (50 s)**

Fala proposta:

> A referência usa a frequência de pico no treino, abaixo de 0,5. Ela classifica todos como fora do pico e acerta os 29.420 negativos do teste. A logística chega a 29.424 acertos. Recupera 371 positivos, mas perde 367 negativos que a referência acertava. O saldo é de quatro boletins, não quatro pontos percentuais. As previsões não são iguais; a acurácia quase empata porque soma tipos diferentes de acerto.

Pausa / interação: Ler a decomposição e pausar depois do saldo. Dez segundos para apontar os termos.

Transição: Ailana distingue essas contagens das medidas sobre probabilidades.

### 11. Ordenação e erro de probabilidade são outras medidas

**Ailana Pereira Gonsalez · 8:20–9:15 (55 s)**

Fala proposta:

> Antes de converter a saída em classe, avaliamos as probabilidades. A AUC de 0,5757 descreve a ordenação dos escores; não quer dizer 57,57% de acertos. O Brier é o erro quadrático médio dessas probabilidades: 0,237184, contra 0,241157 da referência. As barras usam a mesma escala. Essa diferença é pequena na escala do erro e não comprova utilidade operacional. São leituras complementares à matriz, não formas de esconder os falsos negativos.

Pausa / interação: Indicar a diagonal da ROC e a origem comum das barras; cerca de cinco segundos.

Transição: Pedro mostra o alcance de uma associação estimada pelo modelo.

### 12. A razão de chances descreve uma associação condicionada

**Pedro Henrique · 9:15–10:00 (45 s)**

Fala proposta:

> Para vias urbanas em relação a estradas e rodovias, a razão de chances ajustada é 0,9663. O intervalo com agrupamento por data vai de 0,9328 a 1,0010. São as chances de pertencer ao pico, mantendo dia e região no ajuste. Esse número não é uma probabilidade nem indica que uma via proteja contra sinistros. Os testes e o relatório completo estão no apoio. Um valor de p também não mede relevância prática ou causalidade.

Pausa / interação: Apontar 1 como referência e explicar o contraste antes do intervalo.

Transição: Arthur reúne as condições que limitam essa leitura.

### 13. O alcance depende do recorte, da regra e do protocolo

**Arthur Galvão · 10:00–10:35 (35 s)**

Fala proposta:

> O recorte perdeu registros sobretudo fatais. As janelas não foram validadas com fluxo de veículos. E o teste já era conhecido. Além disso, boletins com as mesmas três características recebem a mesma probabilidade, mesmo quando os horários diferem. São condições da análise. Não medimos se acrescentar uma variável resolveria o problema e não avaliamos uma intervenção de segurança viária.

Pausa / interação: Pausa curta entre as três condições.

Transição: Ailana retorna ao número com que começamos.

### 14. Agora os 59,43% têm denominador e contexto

**Ailana Pereira Gonsalez · 10:35–11:00 (25 s)**

Fala proposta:

> Voltando ao início: 59,43% resume os acertos entre todos os boletins. Já 371 de 20.089 mostra o que aconteceu com os de pico. O aprendizado desta aplicação está em explicar essas leituras, as decisões que as produziram e seus limites. Artigo e código permitem conferir o percurso.

Pausa / interação: Pausar antes das perguntas. O tempo principal termina aqui.

Transição: Os próximos slides são apoio para a arguição, fora dos 11 minutos.

## Roteiro compacto

| Slide | Palavras-chave e observações |
|---|---|
| 1 | 59,43% entre todos os boletins. Abrir a pergunta sobre quem foi identificado. |
| 2 | Denominador: 20.089 boletins de pico. VP 371; FN 19.718; sensibilidade 1,85%. |
| 3 | Unidade: boletim. Não há viagens sem sinistro nem fluxo de veículos. |
| 4 | 121.538 notificações fora; 242 sem data/hora válida; 416 sem via. Dos 658 excluídos, 656 fatais. |
| 5 | Clicar 06:29 e 06:30. Extremos inclusivos; regra da Entrega 1, sem validação por fluxo. |
| 6 | 3 fatores, 22 indicadores + intercepto. Conjunto demonstrado, sem alegar que sejam as melhores entradas. |
| 7 | 101.666 treino; 49.509 teste; coeficientes fixos; limiar 0,5. Dados de 2026 já explorados. |
| 8 | pico ~ via + dia + regiao. Mudar segunda para domingo e voltar. Mesmos coeficientes de 2025. |
| 9 | 738 previstos pico: 371 VP + 367 FP. FN 19.718. Mover a 0,35 e restaurar 0,5. |
| 10 | Referência: 29.420 acertos. Logística: 29.424. Quatro boletins não são quatro pontos percentuais. |
| 11 | AUC 0,5757 não é acurácia. Brier 0,237184 versus 0,241157. Sem promessa de eficácia operacional. |
| 12 | Via: OR 0,9663; IC por data 0,9328–1,0010. Não é probabilidade ou risco de sinistro. |
| 13 | 656 excluídos fatais. Janelas sem fluxo. Teste conhecido. Mesmos X recebem o mesmo p. |
| 14 | Todos os boletins: 59,43%. Entre positivos: 371/20.089. Encerrar e abrir arguição. |

## Contingência e ritmo

Se a turma estiver silenciosa, o apresentador faz a pergunta e continua com a explicação prevista. Não há enquetes ou espera obrigatória. Em HTML, as três experiências usam os controles. Em PDF: narrar 06:29 fora / 06:30 pico; ler o perfil de exemplo; explicar que outro limiar mudaria as classes sem anunciar novos números. A matriz reportada fica em 0,5.

Os slides de apoio são consultados apenas na arguição. Se o tempo for reduzido, preservar pergunta, unidade, alvo, partição, matriz e limites; encurtar a interação, sem eliminar a advertência sobre exploração do teste.

## Estimativa de fala e simulação

O texto principal tem 956 palavras por contagem de tokens separados por espaço. A 125 palavras/minuto, a leitura sem pausas levaria aproximadamente 7:39. Números, gestos e interação exigem tempo adicional, já reservado no orçamento de 11:00. Esse cálculo é uma referência de planejamento; não mede a fala de cada integrante.

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
