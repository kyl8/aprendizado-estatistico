# Preparação para arguição

Respostas propostas para estudo. Elas não comprovam que os integrantes já dominam o conteúdo. Cada pessoa deve localizar os números no arquivo indicado e explicar o raciocínio com suas palavras. O material recebeu apoio de IA.

## 1. Por que escolheram essas três janelas de pico?

São a definição operacional registrada na Entrega 1: 06:30–08:30, 11:30–13:30 e 17:00–19:30, com extremos inclusivos. Não encontramos no material uma medição de fluxo que as valide como pico de congestionamento de todo o estado. Preservamos a regra para manter a mesma resposta e explicitamos esse limite. Não atribuímos as janelas a uma norma ou exigência do professor sem documento.

**Conferir:** artigo, seção sobre alvo; função `pico_horario()` em `estrutura/codigos/estudo_pico_funcoes.R`; Entrega 1. **Evitar:** “Esses são os horários oficiais em todo o estado”.

## 2. Então o modelo prevê acidentes?

Não. Ele classifica boletins já registrados quanto ao pertencimento a essas janelas. A probabilidade é condicionada ao fato de observarmos um boletim com determinadas características. Sem viagens sem sinistro e sem exposição ao tráfego, não estimamos risco de um veículo sofrer sinistro nem comparamos risco por viagem entre horários.

**Conferir:** pergunta, unidade e discussão no artigo; dicionário do CSV; manual de sistemas de dados da OMS citado no artigo.

## 3. Se a hora define o alvo, por que retirá-la?

Porque receber a hora permitiria reconstruir a resposta pela própria regra. O propósito do ajuste é examinar associações com outras características. Turno também revela parte da resposta. Usamos a hora para produzir o rótulo, mas não como entrada da fórmula.

**Conferir:** `pico ~ via + dia + regiao` em `entrega-2-banco.R`; oficina do professor, exemplo de vazamento. **Evitar:** afirmar que toda variável temporal é proibida; o dia da semana tem outro papel.

## 4. Por que via, dia e região? São as melhores preditoras?

Via descreve contexto viário, dia descreve o calendário e região localiza o registro. A especificação é simples e interpretável para a demonstração. Não demonstramos que sejam as melhores variáveis, não as selecionamos pela métrica de 2026 e não fizemos uma comparação validada de todas as combinações. A preparação histórica tinha outros candidatos, mas este ajuste usa somente esses três fatores.

**Conferir:** ficha da pergunta e seção de preditoras. **Evitar:** usar um p-valor baixo como prova de importância prática ou superioridade de uma entrada.

## 5. Como três preditoras produzem 23 coeficientes?

Há duas categorias de via, sete de dia e 16 de região. Com uma referência por fator, são 1 + 6 + 15 = 22 indicadores, mais o intercepto. As referências do ajuste são estradas e rodovias, domingo e Araçatuba. Três variáveis não significam três parâmetros.

**Conferir:** `coeficientes.csv`, relatório do R e níveis usados no treino. **Exercício:** localizar qual termo é a comparação de vias urbanas com estradas/rodovias.

## 6. Por que não usar uma árvore ou todos os métodos estudados?

O alvo é binário, e a logística permite examinar probabilidades e razões de chances em uma especificação explícita. Essa é a ferramenta principal escolhida. As atividades anteriores conservam árvore, PCA e Poisson em tarefas próprias. Não alegamos que a logística ganhou uma competição geral ou que um método diferente resolveria as limitações.

**Conferir:** mapa de ferramentas; scripts complementares no slide de apoio. PCA não usa alvo na matriz; Poisson usa contagem por data × hora.

## 7. O que saiu do banco e qual o efeito das exclusões?

Dos 273.371 registros, 121.538 notificações ficam fora da unidade de boletim escolhida. Dos 151.833 boletins, 242 saem por data/hora inválida e 416 por via indisponível entre os restantes. O recorte final tem 151.175. A auditoria encontrou 656 fatais e dois não fatais entre os 658 excluídos; por isso não presumimos que o filtro seja neutro quanto ao perfil dos registros. Não imputamos uma hora desconhecida para fabricar uma resposta.

**Conferir:** `coorte.csv`, `exclusoes.csv` e `auditoria_curadoria.csv`. A comparação por IDs confirmou, neste arquivo, equivalência com o recorte histórico por via/turno; o total igual foi conferido, não apenas presumido.

## 8. Por que separar treino e teste por ano?

O ajuste usa 2025 e é aplicado a janeiro–junho de 2026, preservando a ordem cronológica. Níveis categóricos e a frequência de referência vêm do treino. Isso evita misturar os períodos no ajuste reportado, mas não elimina dependência entre registros nem transforma uma base conhecida em teste prospectivo. Os dados de 2026 já haviam sido explorados.

**Conferir:** `particoes.csv` e código da partição. **Evitar:** “O modelo foi validado para o futuro” ou “Nenhum dado de teste jamais foi visto”.

## 9. Como 59,43% de acurácia coexistem com 1,85% de sensibilidade?

Acurácia divide VP + VN por todos os 49.509 boletins: (371 + 29.053)/49.509. Sensibilidade divide VP pelos 20.089 positivos observados: 371/(371 + 19.718). O primeiro denominador mistura as classes; o segundo olha apenas para pico. Não há contradição matemática.

**Conferir:** `confusao.csv` e `leitura_classificacao.csv`. **Exercício:** identificar linhas observadas e colunas previstas sem consultar o roteiro.

## 10. A logística superou a referência?

Na acurácia deste teste e limiar, o saldo é de quatro acertos: 29.424 contra 29.420. A referência classifica todos fora do pico, pois usa uma probabilidade de treino abaixo de 0,5. A logística recupera 371 positivos e perde 367 negativos. Essa comparação não demonstra utilidade operacional ou superioridade geral.

**Conferir:** `leitura_classificacao.csv`. Quatro boletins correspondem a cerca de 0,0081 ponto percentual, não quatro pontos percentuais.

## 11. Por que o limiar é 0,5? Por que não baixar para recuperar mais positivos?

É o limiar fixo da especificação reportada, não um valor otimizado por custos ou pelo teste. Baixá-lo altera a troca entre erros; a interação permite observar isso nos mesmos registros. Escolher um novo valor depois de olhar 2026 e divulgar o resultado como teste independente seria inadequado. Outra decisão exigiria finalidade, custos e um protocolo de desenvolvimento separado, sem refazer a narrativa para favorecer o número.

**Conferir:** `metricas_pico()`, `limiares` do JSON e nota da experiência 3. **Evitar:** “O melhor limiar encontrado foi 0,35”; não houve essa seleção.

## 12. A AUC de 0,5757 é porcentagem de acertos?

Não. Ela resume a ordenação dos escores entre positivos e negativos, considerando empates. Não depende do único corte 0,5 usado na matriz. Este estudo não estimou um intervalo específico para a AUC. O valor reporta a execução; não garante desempenho em outro período.

**Conferir:** `auc_pico()` e `metricas.csv`. A interpretação de 0,5 como ordenação aleatória não é uma regra para substituir a avaliação das demais medidas.

## 13. O que o Brier mede? Um valor menor prova que o modelo é útil?

É a média de (y − p)², calculada sobre probabilidades. A logística teve 0,237184 e a referência, 0,241157. A diferença é cerca de 0,003972 na escala do Brier. Há um intervalo para esse contraste sob bootstrap circular de sete dias, mas um ganho de erro probabilístico não demonstra, sozinho, benefício prático ou boa detecção em um limiar.

**Conferir:** `metricas.csv`, `incerteza.csv` e código da reamostragem. **Evitar:** chamar o Brier de acurácia, risco viário ou ganho percentual sem definir a transformação.

## 14. Como interpretar a razão de chances de via?

A estimativa pontual de 0,9663 compara vias urbanas a estradas/rodovias nas chances de um boletim pertencer ao pico, ajustando por dia e região. O IC por data é aproximadamente 0,9328–1,0010. Não corresponde à probabilidade de sinistro, a uma variação em pontos percentuais ou a um efeito causal de mudar a via.

**Conferir:** `coeficientes.csv`; localizar o termo `viaVIAS URBANAS`. OR é exp(beta); coeficiente e razão de chances têm escalas diferentes.

## 15. O que significam os p-valores de 0,0515 e 0,0572?

São saídas de procedimentos distintos para o termo via: razão de verossimilhanças convencional e Wald com covariância agrupada por data. O `summary(modelo)` também apresenta testes de Wald convencionais por coeficiente; essa saída não deve ser confundida com o teste de razão de verossimilhanças. Os p-valores não são probabilidades de a hipótese nula ser verdadeira. O agrupamento permite dependência dentro do dia, mas não elimina dependência entre dias ou localidades. Holm considera os três testes conjuntos registrados, não todas as escolhas exploratórias já feitas no projeto.

**Conferir:** `hipotese_via.csv`, `testes.csv` e `sandwich::vcovCL` no script. **Evitar:** tratar a posição em torno de 0,05 como certeza sobre o fenômeno.

## 16. O que explica a baixa sensibilidade?

O que verificamos diretamente é que as probabilidades, cortadas em 0,5, geram só 738 previsões positivas. As três entradas são categóricas e o modelo é aditivo: boletins com o mesmo perfil recebem a mesma probabilidade. Essas são propriedades do ajuste. Não isolamos empiricamente uma causa do desempenho, e os positivos são 40,58% do teste, portanto não basta atribuir tudo a uma classe extremamente rara.

**Conferir:** `particoes.csv`, `leitura_classificacao.csv` e fórmula. Hipóteses sobre clima, comportamento ou congestionamento exigiriam dados e estudo adicionais.

## 17. Quais foram as decisões próprias e o que mudou na curadoria?

São explicitados o alvo operacional, o conjunto de entradas, a prevenção de vazamento, a separação temporal, a referência e a leitura dos erros. A curadoria não alterou o ajuste para tornar os números mais favoráveis: verificou e explicou o saldo de acertos, auditou exclusões e organizou a comunicação em torno dessas evidências. O código e a redação tiveram apoio de IA; o roteiro é uma preparação para que cada integrante confira e explique as decisões, não uma comprovação de aprendizado independente.

**Conferir:** `CURADORIA_APPA.md`, diferenças da branch e roteiro. Não atribuir a uma pessoa uma decisão histórica ou uma sessão de trabalho que não esteja documentada.

## 18. O que o estudo permite concluir e o que exigiria outro trabalho?

Permite registrar o comportamento desta especificação e discutir associações condicionadas aos boletins selecionados. A execução mostra a diferença entre acurácia, sensibilidade e medidas de probabilidade. Não demonstra causas, eficácia de uma intervenção, risco por veículo ou validade prospectiva. Outra utilização exigiria novo protocolo e dados compatíveis com a pergunta, incluindo exposição quando o objetivo for risco.

**Conferir:** discussão e conclusão da etapa no artigo. Encerrar com o alcance demonstrado, sem prometer que outro modelo certamente seria melhor.
