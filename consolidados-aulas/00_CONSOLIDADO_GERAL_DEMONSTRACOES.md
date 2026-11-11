# Consolidado geral das demonstrações — Estatística APPA

**Grupo:** Arthur Galvão, Pedro Henrique e Ailana. **Apoio:** ChatGPT.

Este é o documento de leitura principal do trabalho nesta etapa. Reúne problema, pergunta, banco, alvo, preditoras, ferramentas, treino/teste e saídas. “Consolidado” significa que a organização está reunida aqui: **o objetivo continua sendo demonstrar as aplicações, sem fechar uma conclusão sobre o trânsito ou escolher uma ferramenta definitiva para o artigo.**

## 1. Motivação, problema e pergunta

O contexto é a organização da mobilidade e da fiscalização a partir de registros de sinistros. Para praticar as ferramentas da disciplina, usamos uma pergunta sobre o perfil dos boletins em períodos de pico:

> Que características registradas dos sinistros estão associadas à ocorrência nos horários de pico?

A pergunta orienta o exemplo. O banco registra eventos que aconteceram; não informa quantos veículos circularam sem sofrer sinistro. Por isso, a demonstração trata do perfil dos registros e não de risco por veículo, de causas de acidentes ou de uma previsão de que um sinistro vai acontecer.

## 2. Sobre o banco de dados

**Fonte:** base Infosiga/SP disponível no repositório, com registros de janeiro de 2025 a junho de 2026. [Dicionário de dados](../estrutura/corpus/2026-08-11-appa-DicionarioDados.md).

| Etapa | Quantidade | O que representa |
|---|---:|---|
| Arquivo bruto | 273.371 registros, 50 colunas | Inclui tipos de registro diferentes. |
| Boletins de sinistros | 151.833 | Apenas sinistros fatais ou não fatais; notificações ficam fora. |
| Data e hora válidas | 151.591 | Exclusão de 242 boletins sem essas informações válidas. |
| Demonstração principal de pico | 151.175 | Exclusão adicional de 416 com tipo de via indisponível. |

**Unidade da classificação:** uma linha é um boletim. Esses números são recortes diferentes da mesma fonte, não bases contraditórias. A [auditoria](../estrutura/codigos/resultados/estudo-pico/coorte.csv) registra as etapas de seleção.

## 3. Qual é o target, ou variável-alvo?

O alvo da demonstração principal é **`pico`**, uma variável binária:

| Valor | Significado |
|---|---|
| 1 — Pico | O horário do boletim está em uma das janelas abaixo. |
| 0 — Fora do pico | O horário está fora dessas janelas. |

As janelas adotadas são **06:30–08:30**, **11:30–13:30** e **17:00–19:30**, incluindo os extremos. São a definição operacional do exercício, não uma descoberta feita pelo modelo.

Exemplo apenas didático: um boletim às 07:15 recebe `pico = 1`; um às 15:00 recebe `pico = 0`. O horário é usado para construir esse rótulo; depois, ele fica fora das preditoras.

## 4. Quais são nossas preditoras?

**Na demonstração atual de classificação, são estas três:**

| Preditora | Campo de origem | Nome no script | Tipo | Papel no exemplo |
|---|---|---|---|---|
| **Tipo de via** | `tipo_via` | `via` | Categórica | Diferenciar boletins de vias urbanas e de estradas/rodovias. |
| **Dia da semana** | Data do boletim, conferida com `dia_da_semana` | `dia` | Categórica | Representar o calendário semanal, de segunda a domingo. |
| **Região administrativa** | `regiao_administrativa` | `regiao` | Categórica | Representar o agrupamento geográfico informado na base, como Baixada Santista. |

Uma preditora é uma informação entregue ao ajuste para produzir uma probabilidade ou classificação. Isso não significa que ela seja causa do alvo ou que tenha um efeito comprovado.

No código, a fórmula é:

```r
y ~ via + dia + regiao
```

`y` representa o alvo `pico`. O R trata as três preditoras como fatores. Cada variável pode gerar vários coeficientes para suas categorias; **quantidade de preditoras e quantidade de coeficientes não são a mesma coisa**.

### Por que a ficha anterior falava em 11 preditoras?

A preparação da Entrega 1 tinha **11 variáveis candidatas**: tipo de via, tipo de sinistro, dia da semana, indicador de fatalidade, quantidades de automóveis, motocicletas, ônibus, caminhões, pedestres e bicicletas, e total de veículos.

Essa era uma lista de possibilidades da preparação original. **Não é a lista usada na demonstração atual.** O exemplo atual usa o conjunto mais restrito de três variáveis acima; região administrativa já aparecia na oficina das perguntas e foi mantida nesse exemplo. Os relatórios históricos preservam seus próprios conjuntos de variáveis.

### O que fica fora deste ajuste?

- **Hora:** determina o alvo pela definição das janelas; colocá-la como preditora entregaria a regra ao modelo.
- **Turno:** também deriva do horário e pode revelar diretamente parte do alvo.
- **Fatalidade, tipo de sinistro e quantidades de envolvidos:** não entram nesta demonstração de pico. São características do evento e aparecem em outros exercícios da disciplina.
- **Data completa:** organiza a separação entre treino e teste; apenas o dia da semana entra como preditora neste ajuste.

## 5. Quais ferramentas foram aplicadas ao alvo `pico`?

| Ferramenta | Material | O que demonstramos |
|---|---|---|
| Frequência de pico no treino | Linha de base da avaliação | Produzir uma probabilidade constante para comparar as saídas. |
| **Regressão logística** | Aula 05 | Ajustar probabilidades para um alvo binário com as três preditoras. |
| **Árvore de classificação** | Aula 11 | Ajustar divisões entre perfis e demonstrar escolha de poda. |
| Treino, validação e teste | Aula 06 | Aprender parâmetros em uma parte dos dados e aplicar em outra. |
| Bootstrap | Aula 07 | Exemplificar reamostragem e registro de incerteza. |

A lista completa de ferramentas e seus exercícios está no [mapa dos materiais](FERRAMENTAS-E-DEMONSTRACOES.md). Regressão linear, regularização, suavização, splines/GAM e floresta também têm aplicações no repositório, mas não foram todas ajustadas a este mesmo alvo de pico.

## 6. Como foram feitos treino e teste?

| Parte | Período | Boletins | Uso |
|---|---|---:|---|
| Treino principal | Janeiro–dezembro/2025 | 101.666 | Ajustar logística, frequência da base e árvore final do exemplo. |
| Teste | Janeiro–junho/2026 | 49.509 | Aplicar os ajustes e registrar suas saídas. |
| Ajuste interno da árvore | Janeiro–setembro/2025 | 76.266 | Construir a árvore antes da escolha de poda. |
| Validação interna da árvore | Outubro–dezembro/2025 | 25.400 | Comparar os parâmetros de poda da grade. |

As duas últimas linhas são partes do treino principal, não dados adicionais. A poda escolhida na validação interna foi `cp = 0,0001`, dentro da grade examinada. O limiar usado para transformar probabilidade em classe foi **0,5**. O teste não foi usado para escolher esse limiar.

A divisão respeita a ordem das datas. Como a mesma base já foi explorada em atividades anteriores, trata-se de uma demonstração retrospectiva.

## 7. O que aparece no relatório da aplicação?

| Ajuste | Brier | AUC | Acurácia | Sensibilidade ao pico |
|---|---:|---:|---:|---:|
| Frequência do treino | 0,241157 | 0,5000 | 0,5942 | 0,0000 |
| Logística | 0,237184 | 0,5757 | 0,5943 | 0,0185 |
| Árvore | 0,237563 | 0,5682 | 0,5944 | 0,0539 |

Esses números são saídas da execução registrada. **Brier** mede erro das probabilidades; **AUC**, a ordenação dos escores; **acurácia e sensibilidade**, as classes produzidas com o limiar adotado. A discussão da demonstração consiste em explicar essas medidas e mostrar por que elas descrevem aspectos diferentes do ajuste, sem declarar uma ferramenta definitiva.

O [relatório de pico](2026-11-11-appa-EstudoPicoRelatorio.md) reúne gráficos, coeficientes e links para as tabelas completas. Os arquivos de resultados permitem reproduzir os cálculos.

## 8. Onde entram Poisson e PCA?

São **outras demonstrações**, com papéis diferentes:

| Demonstração | Unidade e alvo | Variáveis utilizadas |
|---|---|---|
| Classificação de pico | Um boletim; alvo `pico` 0/1 | Tipo de via, dia da semana e região. |
| **Poisson/quase-Poisson** | Uma data × hora; alvo número de boletins na célula | Hora do dia e dia da semana. |
| **PCA e agrupamento** | Um boletim na amostra; não há alvo no ajuste | Quantidades de pedestres, motocicletas, automóveis, ônibus e caminhões, padronizadas. |

No Poisson, hora pode entrar porque o alvo é uma contagem, não o rótulo de pico definido pela própria hora. A grade tem 13.104 células, incluindo zeros; 2025 fornece 8.760 células de treino e 2026, 4.344 de teste. O RMSE registrado foi 7,2988 para a média e 5,2220 para Poisson. São valores do exemplo de contagem, não um placar comparável ao Brier da classificação.

O [guia 05b](../materiais-tutora/GUIA_ESTUDO_aula05b.md) marca Poisson como **tema extra, não dado em aula**. Sua aplicação está no [relatório de contagem temporal](2026-11-11-appa-ContagemTemporalRelatorio.md).

PCA, K-médias e agrupamento hierárquico correspondem à Aula 12. Na PCA, as variáveis são resumidas em componentes; no agrupamento, são usadas para formar grupos. Não se entrega `pico` ao ajuste dessas ferramentas. A aplicação está nas [atividades 10/11](2026-11-11-appa-Atividades10_11.md).

## 9. Como entram os testes de hipótese?

Um exemplo de formulação é: **H₀:** os coeficientes de tipo de via são zero, ajustando por dia e região; **H₁:** pelo menos um deles difere de zero. A demonstração registra a especificação, a estatística, o p-valor e as suposições, sem encerrar aqui uma conclusão sobre a pergunta de pesquisa.

Na execução, o p-valor convencional para via foi 0,0515; no complemento agrupado por data, 0,0572. Esses valores servem para mostrar a saída dos procedimentos; não são probabilidades de a hipótese ser verdadeira nem uma declaração de certeza sobre o trânsito.

HC1 agrupada por data, Wald agrupado, Holm, diagnóstico conjunto de calibração e bootstrap por blocos semanais foram acrescentados com IA. Estão identificados como **complementos opcionais**, não como procedimentos que identificamos nos PDFs das aulas. O relatório específico apresenta as tabelas e limitações.

## 10. Como apresentar o trabalho nesta etapa?

Seguir esta sequência: motivação e problema; pergunta usada como contexto; banco e unidade; alvo; preditoras; ferramenta e material; preparação; treino e teste; execução; tabelas e gráficos; discussão do procedimento.

Uma descrição possível é: “Aplicamos regressão logística e árvore ao alvo pico, usando tipo de via, dia da semana e região. Ajustamos com registros de 2025 e registramos as saídas em 2026. Também demonstramos contagem com Poisson e exploração com PCA em tarefas próprias.”

O fechamento da apresentação é o registro do que foi demonstrado e das questões para discussão. A etapa atual não termina com uma conclusão definitiva sobre o problema, eficácia operacional ou causalidade.

## 11. Arquivos para consultar e reproduzir

- [Ficha da pergunta](00_FICHA_PERGUNTA.md).
- [Mapa das ferramentas e materiais](FERRAMENTAS-E-DEMONSTRACOES.md).
- [Relatório da demonstração de pico](2026-11-11-appa-EstudoPicoRelatorio.md) e [código](../estrutura/codigos/2026-11-11-appa-EstudoPico.R).
- [Relatório de contagem temporal](2026-11-11-appa-ContagemTemporalRelatorio.md) e [código](../estrutura/codigos/2026-11-11-appa-ContagemTemporal.R).
- [Relatório de árvores, floresta, agrupamento e PCA](2026-11-11-appa-Atividades10_11.md).
- [Testes das regras e métricas](../estrutura/codigos/testar_estudo_pico.R).

Todos os scripts são executados a partir da raiz do repositório. O comando `Rscript estrutura/codigos/executar_atualizacao.R` reproduz as atividades na ordem, incluindo as demonstrações atuais.
