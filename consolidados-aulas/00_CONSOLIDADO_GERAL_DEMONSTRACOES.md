# Aplicações de ferramentas estatísticas em registros de sinistros de trânsito
## Relatório consolidado das demonstrações

**Disciplina:** Teoria do Aprendizado Estatístico

**Grupo:** APPA — Arthur Galvão, Pedro Henrique e Ailana

**Apoio à elaboração:** ChatGPT

Este relatório documenta a preparação dos dados, a definição das variáveis e a aplicação de ferramentas da disciplina a registros de sinistros de trânsito de São Paulo. São apresentados os procedimentos de ajuste, a separação entre treino e teste e as saídas obtidas nas execuções. O escopo é demonstrativo e exploratório, sem estabelecer conclusões definitivas sobre o fenômeno.

## 1. Motivação e pergunta de trabalho

Registros de sinistros permitem examinar a distribuição temporal e as características dos eventos documentados. Esse contexto oferece uma aplicação para ferramentas de classificação, regressão de contagem e análise não supervisionada, relacionadas ao estudo da mobilidade e da fiscalização.

A demonstração principal utiliza a seguinte pergunta:

> Que características registradas dos sinistros estão associadas à ocorrência nos horários de pico?

O banco contém eventos registrados, sem informação sobre o volume de veículos que circularam sem sinistro. A aplicação, portanto, examina o perfil dos boletins e não estima risco por veículo ou por viagem. As análises não identificam efeitos causais.

## 2. Fonte, unidade de observação e recorte dos dados

A fonte é a base Infosiga/SP disponível no repositório, com registros de janeiro de 2025 a junho de 2026. O arquivo bruto possui 273.371 registros e 50 colunas. A classificação utiliza como unidade de observação um boletim de sinistro fatal ou não fatal; notificações não integram esse recorte.

| Etapa de preparação | Registros mantidos | Critério |
|---|---:|---|
| Base original | 273.371 | Todos os tipos de registro do arquivo. |
| Seleção de boletins | 151.833 | Sinistros fatais ou não fatais. |
| Validação de data e hora | 151.591 | Exclusão de 242 boletins sem essas informações válidas. |
| Seleção para classificação de pico | 151.175 | Exclusão adicional de 416 com tipo de via indisponível. |

Não houve exclusão adicional por ausência nas três preditoras selecionadas. Na leitura utilizada, a auditoria não identificou IDs de sinistro duplicados nem divergências entre o dia da semana informado e o calendário. As exclusões delimitam a população descrita pela aplicação.

O [dicionário de dados](../estrutura/corpus/2026-08-11-appa-DicionarioDados.md) descreve os campos da fonte; o [fluxo de seleção](../estrutura/codigos/resultados/estudo-pico/coorte.csv) registra os totais por etapa.

## 3. Variável-alvo

A variável-alvo da classificação é **`pico`**, definida a partir do horário registrado no boletim:

| Valor | Definição operacional |
|---|---|
| 1 — Pico | Horário entre 06:30 e 08:30, entre 11:30 e 13:30 ou entre 17:00 e 19:30, incluindo os extremos. |
| 0 — Fora do pico | Horário fora das janelas estabelecidas. |

As janelas são uma regra adotada para construir a resposta, não um resultado estimado pelos modelos. O horário é utilizado nessa preparação e retirado do conjunto de preditoras.

## 4. Variáveis preditoras

A demonstração atual utiliza **três preditoras categóricas**, comuns à regressão logística e à árvore de classificação:

| Preditora | Campo de origem | Nome no código | Representação na aplicação |
|---|---|---|---|
| **Tipo de via** | `tipo_via` | `via` | Vias urbanas ou estradas e rodovias. |
| **Dia da semana** | Data do boletim, conferida com `dia_da_semana` | `dia` | Categorias do calendário semanal. |
| **Região administrativa** | `regiao_administrativa` | `regiao` | Agrupamento geográfico informado na fonte, incluindo a Baixada Santista. |

Na regressão logística, a especificação é `y ~ via + dia + regiao`, em que `y` representa `pico`. As categorias são tratadas como fatores no R. Uma preditora categórica pode corresponder a vários coeficientes; a quantidade de variáveis não equivale à quantidade de parâmetros estimados.

### 4.1. Seleção em relação à preparação original

A preparação da Entrega 1 continha 11 variáveis candidatas: tipo de via, tipo de sinistro, dia da semana, indicador de fatalidade, quantidades de automóveis, motocicletas, ônibus, caminhões, pedestres e bicicletas, e total de veículos.

O conjunto empregado na demonstração atual é restrito às três variáveis da tabela. Região administrativa, já utilizada na oficina das perguntas, integra essa especificação. Os exercícios anteriores mantêm seus próprios alvos e conjuntos de variáveis e não constituem ajustes equivalentes ao exemplo atual.

### 4.2. Variáveis excluídas do ajuste de pico

Hora e turno ficam fora da modelagem porque determinam ou revelam diretamente parte da resposta. Fatalidade, tipo de sinistro e quantidades de envolvidos não integram essa especificação; são características do evento utilizadas em outras atividades. A data completa organiza a partição temporal, enquanto apenas o dia da semana entra como preditora.

## 5. Ferramentas aplicadas

| Ferramenta ou procedimento | Referência nos materiais | Aplicação |
|---|---|---|
| Linha de base | Avaliação de modelos | Probabilidade constante igual à frequência de pico no treino. |
| Regressão logística | Aula 05 | Estimação de probabilidades para o alvo binário. |
| Árvore de classificação e poda | Aula 11 | Particionamento dos perfis e ajuste da complexidade. |
| Treino, validação e teste | Aula 06 | Separação das etapas de ajuste e avaliação. |
| Bootstrap | Aula 07 | Reamostragem para exemplificar a variabilidade dos resultados. |

O [mapa de ferramentas](FERRAMENTAS-E-DEMONSTRACOES.md) relaciona os materiais às demais aplicações existentes: regressão linear, regularização, suavização, splines/GAM, floresta, agrupamento e PCA. Essas atividades não foram todas ajustadas ao mesmo alvo de pico e seus resultados não compõem um único placar comparativo.

## 6. Protocolo de treino, validação e teste

| Partição | Período | Boletins | Finalidade |
|---|---|---:|---|
| Treino principal | Janeiro–dezembro/2025 | 101.666 | Ajuste da logística, da linha de base e da árvore final da demonstração. |
| Teste | Janeiro–junho/2026 | 49.509 | Aplicação dos ajustes e cálculo das métricas. |
| Ajuste interno da árvore | Janeiro–setembro/2025 | 76.266 | Construção da árvore para comparação dos parâmetros de poda. |
| Validação interna da árvore | Outubro–dezembro/2025 | 25.400 | Avaliação da grade de complexidade. |

As partições internas da árvore são subdivisões do treino principal. A grade de poda contém `cp` de 0,01; 0,005; 0,001; 0,0005 e 0,0001. Na execução registrada, o menor Brier de validação ocorreu em `cp = 0,0001`; a árvore foi então reajustada em todo o treino principal com esse parâmetro. A escolha está na borda da grade e não representa uma busca exaustiva.

O limiar de classificação foi fixado em 0,5 e não foi escolhido pelo teste. Os níveis das variáveis categóricas são definidos no treino e conferidos no teste. A divisão respeita a ordem das datas; como a base já foi explorada em atividades anteriores, a aplicação tem caráter retrospectivo.

## 7. Saídas da classificação

| Ajuste | Brier | AUC | Acurácia | Sensibilidade ao pico |
|---|---:|---:|---:|---:|
| Frequência do treino | 0,241157 | 0,5000 | 0,5942 | 0,0000 |
| Regressão logística | 0,237184 | 0,5757 | 0,5943 | 0,0185 |
| Árvore de classificação | 0,237563 | 0,5682 | 0,5944 | 0,0539 |

O Brier registra o erro quadrático das probabilidades; a AUC descreve a ordenação dos escores; acurácia e sensibilidade dependem das classes produzidas pelo limiar adotado. As medidas representam aspectos distintos da mesma execução. A tabela documenta a aplicação, sem definir uma ferramenta final para o trabalho ou atestar eficácia operacional.

O [relatório de classificação](2026-11-11-appa-EstudoPicoRelatorio.md) contém gráficos, coeficientes, diagnósticos e links para as saídas completas. As [métricas](../estrutura/codigos/resultados/estudo-pico/metricas.csv) e [probabilidades registradas](../estrutura/codigos/resultados/estudo-pico/pred.csv) permitem conferir os cálculos.

## 8. Aplicações complementares: contagem e análise não supervisionada

| Aplicação | Unidade e alvo | Variáveis utilizadas |
|---|---|---|
| Classificação de pico | Um boletim; alvo `pico` 0/1. | Tipo de via, dia da semana e região. |
| Poisson e quase-Poisson | Uma data × hora; alvo número de boletins na célula. | Hora do dia e dia da semana. |
| PCA e agrupamento | Um boletim na amostra; sem variável-alvo no ajuste. | Quantidades de pedestres, motocicletas, automóveis, ônibus e caminhões, padronizadas. |

### 8.1. Contagem com Poisson

Na regressão de contagem, o horário pode integrar as preditoras porque a resposta é o número de eventos, e não o indicador de pico definido pela própria hora. A grade completa possui 13.104 células de calendário, incluindo zeros: 8.760 de treino em 2025 e 4.344 de teste em 2026. O RMSE registrado foi 7,2988 para a média do treino e 5,2220 para Poisson. Essa medida tem unidade diferente do Brier da classificação e não permite uma comparação direta entre as duas tarefas.

O [guia 05b](../materiais-tutora/GUIA_ESTUDO_aula05b.md) identifica Poisson como tema extra, não dado em aula. A aplicação e o ajuste de quase-Poisson estão documentados no [relatório de contagem temporal](2026-11-11-appa-ContagemTemporalRelatorio.md).

### 8.2. PCA e agrupamento

PCA, K-médias e agrupamento hierárquico correspondem à Aula 12. A PCA resume as variáveis em componentes; os métodos de agrupamento utilizam suas características para formar grupos. O alvo `pico` não integra a matriz usada nesses ajustes. As saídas estão no [relatório das atividades 10/11](2026-11-11-appa-Atividades10_11.md).

## 9. Demonstrações de testes de hipótese e incerteza

Para o ajuste de pico, uma hipótese examinada é **H₀:** os coeficientes de tipo de via são zero, ajustando por dia e região; a alternativa considera que pelo menos um deles difere de zero. A execução convencional registrou p-valor de 0,0515; o procedimento agrupado por data registrou 0,0572. Os valores são apresentados como saídas dos procedimentos, condicionadas às respectivas suposições, sem encerrar uma conclusão sobre a pergunta de pesquisa.

A revisão inclui, como complementos, covariância HC1 agrupada por data, testes conjuntos de Wald, correção de Holm, diagnóstico de calibração e bootstrap por blocos semanais. Essas técnicas estão distinguidas das ferramentas identificadas nos PDFs das aulas no mapa de materiais. Os relatórios específicos registram a especificação dos testes, os intervalos e suas limitações.

## 10. Documentação e reprodutibilidade

| Documento ou arquivo | Conteúdo |
|---|---|
| [Ficha da pergunta](00_FICHA_PERGUNTA.md) | Registro da pergunta e das variáveis. |
| [Mapa de ferramentas](FERRAMENTAS-E-DEMONSTRACOES.md) | Correspondência entre os materiais da disciplina e as aplicações. |
| [Relatório de classificação](2026-11-11-appa-EstudoPicoRelatorio.md) | Procedimentos e saídas da aplicação ao alvo pico. |
| [Código da classificação](../estrutura/codigos/2026-11-11-appa-EstudoPico.R) | Preparação, ajustes, métricas e diagnósticos. |
| [Relatório de contagem temporal](2026-11-11-appa-ContagemTemporalRelatorio.md) | Aplicação de Poisson e quase-Poisson. |
| [Código da contagem](../estrutura/codigos/2026-11-11-appa-ContagemTemporal.R) | Construção da grade, ajustes e saídas. |
| [Atividades 10/11](2026-11-11-appa-Atividades10_11.md) | Árvores, floresta, agrupamento e PCA. |
| [Verificações de código](../estrutura/codigos/testar_estudo_pico.R) | Testes das regras do alvo e das métricas. |

Os scripts são executados a partir da raiz do repositório. O comando `Rscript estrutura/codigos/executar_atualizacao.R` reproduz as atividades na ordem, incluindo as demonstrações atuais.
