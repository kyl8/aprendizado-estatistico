# Curadoria acadêmica e criativa do APPA

**Escopo:** Entrega 2, apresentação final, falas e preparação para arguição. **Base preservada:** commit `c9b00fe`. **Branch:** `curadoria/appa-2026-11-18`. **Prazo informado:** 18/11/2026. Integrantes: Arthur Galvão, Pedro Henrique e Ailana Pereira Gonsalez. Professor: João Paulo Ferreira de Mello.

## 1. Diagnóstico sintético

O material anterior já executava uma logística reproduzível e identificava limitações importantes. A principal fragilidade era a distância entre a organização dos documentos e a interpretação dos resultados: o público percorria uma sequência de etapas antes de encontrar o contraste que torna este trabalho específico. A curadoria coloca esse contraste no centro: **59,43% de acertos totais coexistem com apenas 371 identificações entre 20.089 boletins de pico**. Não se trata de trocar a pergunta de pesquisa nem de procurar um resultado mais favorável.

| Prioridade | Problema e evidência anterior | Consequência | Solução executada nesta branch |
|---|---|---|---|
| P0 | O efeito das exclusões não era quantificado por gravidade; o artigo só registrava 242 + 416 retiradas. Auditoria do CSV: 656 dos 658 excluídos são fatais. | O leitor pode tomar o recorte como neutro em relação ao perfil dos registros. | Tabela `resultados/exclusoes.csv`, explicação no artigo e resposta específica na arguição. O recorte e o modelo são preservados. |
| P0 | A matriz já continha 29.053 VN, 367 FP, 19.718 FN e 371 VP, mas a comparação em acurácia com a referência aparecia só arredondada. | 59,43% pode ser lido como detecção razoável do pico. | Decomposição reproduzível: referência tem 29.420 acertos, logística 29.424; 371 novos acertos positivos e 367 perdas negativas dão saldo de quatro acertos. |
| P0 | Referências à seleção histórica por via/turno misturavam-se à descrição da seleção atual por data/hora/via. | Mesmo total pode sugerir procedimentos intercambiáveis sem conferência dos IDs. | Auditoria confirma os mesmos IDs neste arquivo; documentação diferencia a regra atual da descrição histórica. |
| P1 | Slides 1–9 anteriores seguem identificação, pergunta, banco, alvo, preditoras, ferramenta, partição, perfil e relatório. O contraste central só aparece nos slides 10–11. | A apresentação lembra uma lista de tarefas de laboratório. | Narrativa orientada pelo problema da acurácia; decisões metodológicas passam a explicar os números iniciais. |
| P1 | `slides.ts` continha instruções como “mostrar” e “explicar”, sem fala completa ou tempo. | Não prepara transições nem a distribuição de esforço entre integrantes. | Roteiro completo para ensaio, notas compactas e 11 minutos planejados, incluindo interações. |
| P1 | Wald, Holm e diagnósticos ocupavam slides centrais com várias saídas simultâneas. | Detalhes avançados competem com o entendimento de alvo, erro e probabilidades. | Permanecem no artigo e em cinco slides de apoio, sem simular que sejam exigências adicionais do professor. |
| P1 | Introdução e fechamento do artigo descreviam sobretudo a existência da demonstração; repetiam ressalvas. | O raciocínio específico do projeto fica menos visível que a estrutura do modelo. | Introdução, decisões e discussão reescritas; relações entre denominadores, limiar, referência e alcance dos coeficientes explicitadas. |
| P1 | Eixos e rótulos de algumas visualizações da apresentação eram pequenos; o console tinha números fixos no texto de implementação. | Projeção e futuras atualizações ficam vulneráveis a leitura difícil e divergência. | Gráficos com denominadores próximos aos valores, contraste direto VP/FN e dados importados do R; detalhes técnicos no apoio. |
| P2 | Comentários, nomes locais de classes e pequenas variações estéticas poderiam ser uniformizados. | Efeito pequeno sobre entendimento ou rigor. | Não motivaram troca de framework, fontes, paleta ou arquitetura. |

## 2. Reconstrução do contexto

**Pergunta registrada.** A Entrega 1 e a ficha tratam de características dos sinistros associadas ao pertencimento a horários de pico. O documento histórico também contém motivações gerais sobre trânsito, mas não traz uma entrevista ou relato pessoal que permita inventar uma história de escolha do grupo.

**Justificativa utilizada na revisão.** O arquivo disponível contém hora, data e contexto viário/geográfico do mesmo boletim, permitindo construir uma resposta binária e examinar como três características se relacionam com ela. Essa é uma justificativa metodológica do uso do banco, não uma alegação de conhecimento sobre fluxo ou prevenção de acidentes.

**Unidade.** Um boletim fatal ou não fatal selecionado no arquivo local. Notificações ficam fora. Não há observações de viagens sem sinistro ou exposição em veículos-quilômetro para estimar risco por veículo.

**Decisões registradas e preservadas.** Três janelas com extremos inclusivos; fatores `via`, `dia`, `regiao`; exclusão de hora/turno; logística aditiva; ajuste em 2025; teste retrospectivo em janeiro–junho de 2026; limiar 0,5. As interpretações são condicionadas ao recorte e à especificação. A seleção editorial de uma narrativa não é registrada como decisão histórica tomada pelo grupo antes de conhecer os dados.

**Resultados.** Há uma execução reproduzível, discriminação limitada e baixa sensibilidade no limiar reportado. A existência de um Brier menor que o da referência não demonstra utilidade operacional. Não houve validação prospectiva, coleta de novas observações ou comprovação de domínio individual pelos integrantes.

**Dificuldades documentadas.** Leitura Latin-1, campos entre aspas com ponto e vírgula, registro fantasma corrigido na preparação, níveis categóricos, distinção entre alvos dos exercícios, exclusões e exploração prévia do teste. São fatos rastreáveis no repositório, não cenas inventadas de um processo de descoberta.

## 3. O que é requisito e o que é escolha

| Fonte | O que está documentado | Uso nesta revisão |
|---|---|---|
| `entregas/entrega-2/modelo-professor/artigo-final.Rnw` | Identificação, resumo, introdução, dados, pergunta/modelo, resultados, discussão, conclusão, bibliografia e relatório de um modelo. | Estrutura e normalização preservadas; texto e interpretação próprios. |
| Oficina `enunciado-entrega-meio-semestre.pdf`, páginas 5–12 | Ficha da pergunta, linha de base, diagnóstico, vazamento, balanço, duas perguntas e CV para a etapa de 09/10. | Fundamenta contexto e leitura crítica; suas exigências datadas não são automaticamente atribuídas à entrega de 18/11. |
| Materiais das Aulas 05–07 e mapa de ferramentas | Logística, avaliação, treino/teste e reamostragem. | Vinculam a aplicação às ferramentas estudadas. |
| Pedido de curadoria e orientações do solicitante | 10–12 minutos, uma ferramenta principal, interpretação demonstrativa, três integrantes e narrativa menos rígida. | Critérios editoriais desta revisão. A crítica de semelhança é relato do grupo, não transcrição de orientação formal. |

O modelo genérico do professor ajusta no banco inteiro. O projeto mantém a adaptação já documentada para ajuste só em 2025. HC1, Wald, Holm e bootstrap em blocos são complementos do projeto, não novas exigências docentes nem comprovação de atendimento integral a uma norma externa.

## 4. Duas estruturas narrativas avaliadas

**A — Percurso cronológico da aplicação.** Pergunta → fonte → alvo → preditoras → logística → treino/teste → relatório → resultados → limites. Favorece referência técnica, mas preserva o ritmo enumerativo criticado e demora a tornar visível a questão principal. Continua adequada à organização acadêmica do artigo.

**B — Acurácia sob exame.** Um número aparentemente confortável → quem foi identificado e quem ficou de fora → o que o banco permite perguntar → decisões que produziram o alvo e o ajuste → retorno à matriz e à referência → probabilidades, coeficientes e limites. **Escolhida para a exposição.** Parte de resultados comprovados; não fabrica surpresa vivida pelo grupo ou uma disputa entre modelos. A pergunta científica permanece a mesma.

A escolha se apoia em títulos que enunciam a mensagem, redução de sobrecarga e continuidade oral, como discutido por [Naegle (2021)](https://pmc.ncbi.nlm.nih.gov/articles/PMC8638955/). O percurso combina explicação conduzida e exploração delimitada, em vez de abandonar a história a controles, seguindo a distinção estudada por [Segel e Heer (2010)](https://idl.cs.washington.edu/files/2010-Narrative-InfoVis.pdf).

## 5. Curadoria slide a slide da versão anterior

| Anterior | Decisão | Destino e razão |
|---|---|---|
| 1. Sinistros em horários de pico | Substituir | Capa acadêmica abre a questão da leitura dos acertos, preservando nomes e identidade visual. |
| 2. A pergunta que orienta o estudo | Reposicionar | A pergunta retorna após o contraste inicial, com unidade e limite da fonte. |
| 3. Do arquivo bruto ao recorte | Melhorar | Fluxo explicita notificações e exclusões; não chama o recorte de amostra aleatória. |
| 4. O alvo é uma regra de horário | Melhorar | Botões 06:29/06:30 tornam a fronteira verificável sem precisão manual de um slider. |
| 5. Três preditoras entram no modelo | Melhorar | Conecta cada entrada à exclusão de hora/turno e à definição do alvo. |
| 6. Uma ferramenta: regressão logística | Fundir | Integra a explicação do ajuste à experiência do perfil; fórmula detalhada vai para apoio. |
| 7. Treinar no passado, aplicar depois | Manter | Preserva partição; torna exploração prévia do teste uma condição visível. |
| 8. Um perfil entra, uma probabilidade sai | Fundir | Mesma experiência explica probabilidade e classe; coeficientes reais são preservados. |
| 9. O relatório do R acompanha o ajuste | Transferir para material de apoio | Relatório completo fica no artigo; a interpretação de uma razão de chances ganha mensagem própria no percurso. |
| 10. Probabilidades avaliadas em 2026 | Melhorar | Distingue medidas de probabilidade, ordenação e classe; não amplia visualmente a diferença de Brier. |
| 11. O limiar muda a classificação | Reposicionar | A contagem de pico abre a narrativa e a matriz retorna depois do método; limiar 0,5 continua reportado. |
| 12. Calibração e variação entre meses | Transferir para material de apoio | Mantém diagnósticos disponíveis sem comprimir a exposição principal. |
| 13. Testes de hipótese como demonstração | Transferir para material de apoio | Tabela técnica permanece disponível na arguição e no artigo. |
| 14. O que precisa acompanhar a leitura | Melhorar | Limites são conectados às decisões, incluindo o perfil das exclusões. |
| 15. Da pergunta à demonstração reproduzível | Substituir | Fechamento retorna ao número inicial e sintetiza o alcance da execução. |
| 16. Referências e arquivos do trabalho | Reposicionar | Fontes essenciais acompanham as mensagens; lista consultável fica no apoio. |
| 17. Apoio: onde estão PCA e Poisson | Manter | Continua fora do modelo principal, disponível para perguntas. |

A nova sequência, tempos e falas estão em [NARRATIVA_E_ROTEIRO.md](entregas/apresentacao-final/NARRATIVA_E_ROTEIRO.md). O número de slides decorre do conteúdo e do orçamento de 11 minutos, não da contagem anterior. O apoio não integra esse tempo.

## 6. Pesquisa externa e aplicação concreta

| Fonte verificada | Papel | Orientação aplicada |
|---|---|---|
| [Naegle, 2021; DOI 10.1371/journal.pcbi.1009554](https://pmc.ncbi.nlm.nih.gov/articles/PMC8638955/) | Comunicação | Títulos informativos, mensagem central, transições ensaiáveis e PDF de contingência; detalhes técnicos saem do percurso principal. Não é base para inferência estatística. |
| [Rougier, Droettboom e Bourne, 2014; DOI 10.1371/journal.pcbi.1003833](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003833) | Visualização | Denominadores junto das barras, rótulos diretos, escala comum e mais espaço para dados na projeção. Tabelas completas ficam no artigo. |
| [Segel e Heer, 2010; DOI 10.1109/TVCG.2010.179](https://idl.cs.washington.edu/files/2010-Narrative-InfoVis.pdf) | Narrativa de dados | Percurso guiado com três explorações de propósito explícito; cada interação retorna à linha argumentativa. |
| [Kapoor et al., 2024; REFORMS; DOI 10.1126/sciadv.adk3452](https://pmc.ncbi.nlm.nih.gov/articles/PMC11092361/) | Relato científico | População, filtros, seleção de entradas, partição, referência e proveniência das saídas explicitadas. Usado como referência de transparência, sem certificação de cumprimento de todos os itens. |
| [Lones, 2024; DOI 10.1016/j.patter.2024.101046](https://pmc.ncbi.nlm.nih.gov/articles/PMC11573893/) | Avaliação | Teste conhecido identificado, dependência temporal discutida, múltiplas métricas e ausência de seleção de limiar com o teste. |
| [OMS e parceiros, 2010; ISBN 9789241598965](https://www.who.int/publications/i/item/9789241598965) | Dados de segurança viária | Diferencia registros de eventos e medidas de exposição; o trabalho não estima risco por veículo ou viagem. |
| [Documentação oficial de métricas do scikit-learn](https://scikit-learn.org/stable/modules/model_evaluation.html) | Conceitos de avaliação | Distingue probabilidade e decisão de classe. Implementação permanece em R, sem alegar uso de scikit-learn na análise. |
| [Portal oficial Infosiga](https://dadosabertos.sp.gov.br/dataset/sinistros-infosiga) | Fonte e versionamento | Portal descreve atualização mensal; a reprodução usa o arquivo versionado no repositório, sem substituí-lo por uma versão atual do portal. |

Os quatro trabalhos indicados no pedido foram localizados e consultados em fontes primárias ou repositórios dos artigos. Alguns resolvedores DOI falharam; a leitura foi feita nos textos disponíveis em PLOS/PMC e nos metadados bibliográficos oficiais. Não houve pesquisa de campo, entrevista ou teste de compreensão com o grupo.

## 7. Auditoria cruzada das afirmações

Todos os CSVs abaixo estão em `entregas/entrega-2/resultados/`, produzidos por `entregas/entrega-2/entrega-2-banco.R`. As probabilidades também são conferidas por `preparar-dados.py`, perfil a perfil, com tolerância de 10⁻¹².

| Afirmação | Arquivo | Local no artigo | Local na exposição | Leitura oral |
|---|---|---|---|---|
| 273.371 → 151.833 → 151.591 → 151.175 | `coorte.csv` | Dados / fluxo | Fluxo de seleção | São etapas diferentes, não contagens concorrentes. |
| 656 fatais e 2 não fatais excluídos | `exclusoes.csv` | Dados / exclusões e discussão | Limites; apoio na arguição | A retirada concentra-se em boletins fatais; não se presume neutralidade. |
| 101.666 treino; 49.509 teste | `particoes.csv` | Partição temporal | Treino/teste | Cronologia é respeitada; exploração prévia impede chamar de teste prospectivo independente. |
| 29.424 acertos; 59,43% | `leitura_classificacao.csv` / `metricas.csv` | Leitura das classes | Capa e comparação | Denominador são todos os 49.509 boletins. |
| 371 VP; 19.718 FN; sensibilidade 1,85% | `confusao.csv` / `leitura_classificacao.csv` | Matriz e figura | Contraste inicial e interação do limiar | Denominador são os 20.089 boletins de pico. |
| 29.420 acertos da referência; saldo de quatro | `leitura_classificacao.csv` | Comparação com a referência | Comparação por contagens | Ganham-se 371 acertos positivos e perdem-se 367 acertos negativos. |
| AUC 0,5757; Brier 0,237184 | `metricas.csv` | Probabilidades | Ordenação e erro das probabilidades | São aspectos diferentes; não comprovam utilidade operacional. |
| OR de via 0,9663; IC por data 0,9328–1,0010 | `coeficientes.csv` | Associação condicionada | Interpretação de coeficiente | Chances de pertencer ao pico entre boletins, não risco de sofrer sinistro. |
| Wald de via p = 0,0572; convencional 0,0515 | `testes.csv` / `hipotese_via.csv` | Testes de hipótese | Apoio | Procedimentos e suposições diferentes; não probabilidades de H₀. |
| Intervalo bootstrap do contraste Brier | `incerteza.csv` | Incerteza | Apoio / arguição | Intervalo do contraste no esquema circular de sete dias. |

## 8. Integridade e limites desta curadoria

Nenhuma nova ferramenta foi selecionada. As adições quantitativas são decomposições e auditorias dos registros/previsões existentes, não novos resultados de treinamento. O alvo, preditoras, partições e limiar reportado permanecem fixos. Os CSVs numéricos anteriores foram identificados por hash antes da revisão para conferir sua preservação ao final.

O ensaio aqui fornecido é um roteiro proposto, não comprovação de que os integrantes já o dominaram ou o apresentaram. A simulação técnica e a estimativa de duração são distinguidas de um ensaio humano. A curadoria e a implementação receberam apoio de IA. O histórico anterior permanece recuperável no Git; a branch de curadoria não substitui silenciosamente `main`.

## 9. Registro de implementação e validação

### Alterações entregues

- Artigo: introdução específica, decisões reproduzíveis, composição das exclusões, comparação por contagens, denominadores, discussão e fechamento demonstrativo. As seis seções acadêmicas, o relatório completo do R e a bibliografia foram preservados; três referências metodológicas verificadas foram acrescentadas.
- R: três tabelas de auditoria e uma figura de acurácia/sensibilidade. A fórmula, os registros selecionados, as probabilidades e o limiar reportado não mudaram.
- Apresentação: reorganização de 17 slides anteriores em 14 principais e cinco de apoio, com títulos informativos e composições próprias para seleção, fronteira, perfil, matriz, saldo de acertos e limites. Mantidos React/Remotion, identidade visual, teclado, índice, notas e modo offline.
- Falas: roteiro completo e compacto gerados da mesma fonte dos slides, transições, pausas e participação substantiva dos três integrantes. Preparação para 18 perguntas de arguição.
- Reprodução: exportação e testes deixaram de depender da quantidade antiga de slides. Na inspeção do PDF, o relógio permaneceu inicialmente em 18:00 porque a composição mantinha propriedades padrão. O exportador passou a resolver a composição com as propriedades de cada página; o PDF corrigido foi conferido em 06:30, com o perfil e a matriz originais.

### Verificações executadas

| Verificação | Execução e resultado |
|---|---|
| R e integração | `Rscript entregas/entrega-2/entrega-2-banco.R` e `Rscript estrutura/codigos/testar_estudo_pico.R`: passaram. Asserções de contagens, partições, métricas e decomposição dos quatro acertos passaram. |
| Artigo a partir da fonte | `Rscript entregas/entrega-2/compilar-entrega-2.R`: executado com knitr, pdflatex, BibTeX e abnTeX2. PDF recompilado de nove páginas; referências resolvidas pelo compilador. |
| Integridade dos números | SHA-256 dos oito CSVs anteriores (`metricas`, `coeficientes`, `confusao`, `testes`, `particoes`, `coorte`, `incerteza`, `diagnostico_calibracao`) iguais aos hashes registrados antes da revisão. Nenhum CSV anterior de resultados consta como alterado no Git. |
| Bibliografia | As seis chaves citadas no Rnw correspondem às seis entradas do `.bib`, sem entrada órfã ou citação sem referência. Fontes externas e aplicação descritas na seção 6. |
| Dados da apresentação | `npm run dados`: 49.509 probabilidades conferidas com os coeficientes reais, com tolerância de 10⁻¹². |
| Build | `npm run build`: TypeScript e empacotamento concluídos; HTML com código, dados, estilos e fontes incorporados, aproximadamente 0,94 MB. |
| Navegador | `node scripts/verificar.mjs --capturar`: 19 slides, navegação, índice, notas, Escape, fronteiras, perfil, limiar, restauração, proporção real da barra, URL inválida e adaptação móvel passaram. Sem erros de JavaScript, requisições externas ou conteúdo fora da área reservada. Capturas em 1600×1000, 1280×800 e 390×844. |
| Exportação | `npm run pdf`: 19 frames renderizados por Remotion e reunidos em PDF. PDF final aberto e inspecionado após a correção do horário. |
| Roteiro | `npm run roteiro`: 956 palavras na fala principal, 660 segundos planejados; Arthur 210 s, Pedro 210 s, Ailana 240 s. |
| Simulação | `npm run simular`: percorreu os 14 slides e as três interações sem rede/erros. Execução técnica acelerada de aproximadamente um segundo, com orçamento lógico de 11 minutos. Não mede duração oral. |
| Inspeção visual | Apresentação funcionando no Chrome e capturas dos 19 slides, estados móveis e projetor examinados; nove páginas do artigo renderizadas e examinadas. Segunda revisão em contexto separado, com apoio de IA, retornou `ship` no escopo dessas evidências; confirmou também o PDF corrigido. |
| Documentação e links | Links Markdown locais verificados; documentação de acesso e reprodução atualizada. Identidade e tokens conferidos com a implementação final. |

Os relatórios do navegador e da simulação estão versionados em [validacao-apresentacao.json](entregas/apresentacao-final/validacao-apresentacao.json) e [simulacao-percurso.json](entregas/apresentacao-final/simulacao-percurso.json). As capturas locais de revisão permanecem fora do versionamento, como previsto no `.gitignore`; os PDFs e o HTML entregues estão versionados.

### Segunda leitura e limites remanescentes

A segunda leitura conferiu linguagem, redundâncias, densidade, escalas, definições e correspondência entre artigo, gráficos e fala. O detalhe técnico foi transferido para apoio; não foram acrescentadas animações decorativas, novo método principal, novos resultados de treinamento ou alegações de eficácia. Os avisos do detector visual foram avaliados: a fonte pertence à identidade preservada e a borda superior da linha temporal é aplicada a blocos quadrados, não a cartões arredondados.

P0 e P1 foram implementados e verificados no escopo acima. P2 não justificou mudança de framework, identidade ou arquitetura. O R emitiu avisos de locale `C.UTF-8` indisponível no Windows; as execuções terminaram, as contagens foram preservadas e a extração de texto do PDF não encontrou caracteres de substituição. Não houve teste em projetor físico, pesquisa com a audiência ou ensaio oral dos integrantes. A legibilidade foi examinada em renderização de 1280×800; a duração real requer ensaio do grupo. Não há validação prospectiva, aprovação docente, comprovante de envio ou apresentação realizada presumidos.
