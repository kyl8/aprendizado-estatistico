# Análise Exploratória de Dados: Sinistralidade Viária no Estado de São Paulo (2025–2026)

---

## 1. Estrutura e Escopo do Dataset

O conjunto de dados `sinistros_2025-2026.csv` registra ocorrências de trânsito em vias municipais e rodovias do Estado de São Paulo entre **1º de janeiro de 2025 e 30 de junho de 2026** (18 meses de observação contínua). A base totaliza **273.371 registros** e **50 colunas**, combinando dados de atendimentos operacionais e boletins de ocorrência da Polícia Civil/Militar e concessionárias.

### 1.1. Dicionário e Classificação das Variáveis

* **Identificadores e Tipo de Registro:**
  * `id_sinistro`: Identificador alfanumérico único por linha (273.371 valores distintos, 0 ausentes).
  * `tipo_registro`: Variável categórica com três classes: `SINISTRO NAO FATAL` (143.332 registros / 52,43%), `NOTIFICACAO` (121.538 registros / 44,46%) e `SINISTRO FATAL` (8.501 registros / 3,11%).

* **Atributos Temporais:**
  * `data_sinistro`: Data da ocorrência (DD/MM/AAAA, 546 datas distintas).
  * `ano_sinistro`: 2025 (190.244 registros) ou 2026 (83.127 registros).
  * `mes_sinistro`: Mês da ocorrência (01 a 12).
  * `dia_sinistro`: Dia do mês (01 a 31).
  * `hora_sinistro`: Horário registrado (HH:MM; 242 ausentes / 0,09%).
  * `ano_mes_sinistro`: Competência temporal (AAAA/MM, 18 meses).
  * `dia_da_semana`: Dia da semana correspondente (7 categorias).
  * `turno`: Faixa horária (`MADRUGADA`, `MANHA`, `TARDE`, `NOITE`, `NAO DISPONIVEL`).

* **Atributos Espaciais e Territoriais:**
  * `logradouro`: Nome do logradouro informado (617 ausentes / 0,23%).
  * `numero_logradouro`: Numeração predial ou marco métrico (1.101 ausentes / 0,40%).
  * `tipo_via`: `VIAS URBANAS` (236.227), `ESTRADAS E RODOVIAS` (36.697) e `NAO DISPONIVEL` (447).
  * `tipo_local`: `PUBLICO` (136.460), `NAO DISPONIVEL` (130.877), `PRIVADO` (990) e 5.044 ausentes (1,85%).
  * `latitude` e `longitude`: Coordenadas em graus decimais (161.786 válidos, 111.585 ausentes / 40,82%).
  * `cod_ibge`: Código IBGE do município (645 municípios paulistas).
  * `municipio`: Nome do município da ocorrência.
  * `regiao_administrativa`: Região Administrativa do Estado de São Paulo (16 regiões).

* **Jurisdição e Gestão Viária:**
  * `administracao`: Órgão gestor (`PREFEITURA`: 235.071; `CONCESSIONÁRIA`: 18.506; `DER`: 15.341; `DNIT`: 491; `NAO DISPONIVEL`: 3.962).
  * `circunscricao`: Esfera administrativa (`MUNICIPAL`: 231.504; `ESTADUAL`: 35.404; `FEDERAL`: 5.358; `NAO DISPONIVEL`: 1.105).
  * `conservacao`: Mantenedora do trecho (lotes DER ou concessionárias).

* **Contagens de Modais Envolvidos (`qtd_*`):**
  * Conforme as convenções do projeto, valores ausentes (`NA`) representam contagem **0**.
  * `qtd_pedestre`, `qtd_bicicleta`, `qtd_motocicleta`, `qtd_automovel`, `qtd_onibus`, `qtd_caminhao`, `qtd_veic_outros`, `qtd_veic_nao_disponivel`.

* **Desfecho e Gravidade das Vítimas (`qtd_gravidade_*`):**
  * `qtd_gravidade_fatal`, `qtd_gravidade_grave`, `qtd_gravidade_leve`, `qtd_gravidade_ileso`, `qtd_gravidade_nao_disponivel`.

* **Tipologia do Sinistro:**
  * `tp_sinistro_primario`: Categoria principal (`COLISAO`, `OUTROS`, `NAO DISPONIVEL`, `ATROPELAMENTO`, `CHOQUE`).
  * 14 indicadores binários (`tp_sinistro_*`): `S` indica `TRUE`; campo vazio (`NA`) indica ausência do evento.

---

## 2. Características Estruturais e Particionamento dos Dados

![Composição do Dataset por Tipo de Registro](https://i.imgur.com/UplJCTY.png)

### 2.1. Dualidade Metodológica: Boletins Formais vs. Notificações

A base é composta por dois fluxos de registro heterogêneos:

1. **Boletins de Ocorrência Policiais (`SINISTRO FATAL` e `SINISTRO NAO FATAL` — 151.833 registros / 55,47%):**
   * Detalhamento completo dos veículos envolvidos e categorização da gravidade das vítimas.
   * Georreferenciamento superior a 90% (89,19% em fatais e 91,03% em não fatais).
2. **Notificações Operacionais (`NOTIFICACAO` — 121.538 registros / 44,53%):**
   * 100% das linhas possuem `qtd_veic_nao_disponivel = 1` e ausência de contagem dos modais específicos.
   * 95,41% das linhas apresentam `tipo_local` como `NAO DISPONIVEL`.
   * 80,48% dos registros não possuem coordenadas geográficas.

> **Implicação Metodológica:** O cálculo de taxas de letalidade e severidade deve ser restrito aos Boletins de Ocorrência Policiais (N = 151.833). Incluir notificações no denominador reduz artificialmente a letalidade global de 5,60% para 3,11%, enviesando a análise em favor de vias municipais.

### 2.2. Distribuição Espacial e Temporal

* **Volume por Região Administrativa:** A Região Metropolitana de São Paulo concentra 39,25% das ocorrências (107.302 registros), seguida por Campinas com 16,06% (43.907), São José dos Campos com 6,58% (17.988) e Sorocaba com 6,40% (17.500).
* **Distribuição Temporal:** Estabilidade na série histórica mensal, oscilando entre 15.000 e 17.000 sinistros/mês em 2025 e entre 12.000 e 15.000 sinistros/mês no primeiro semestre de 2026.

---

## 3. Padrões, Interações e Fatores de Risco

### 3.1. Letalidade por Tipo de Via: Vias Urbanas vs. Rodovias

![Comparativo de Letalidade: Rodovias vs. Vias Urbanas](https://i.imgur.com/IAQJcvJ.png)

A tabela abaixo apresenta a distribuição de severidade nos Boletins de Ocorrência Policiais:

| Tipo de Via | Total de Sinistros (BO) | Sinistros Fatais | Taxa de Letalidade (%) |
| :--- | :---: | :---: | :---: |
| **Vias Urbanas** | 125.107 | 4.679 | **3,74%** |
| **Estradas e Rodovias** | 26.279 | 3.377 | **12,85%** |
| **Não Disponível** | 447 | 445 | *99,55% (ruído cadastral)* |

* **Constatação:** As rodovias respondem por 17,31% dos sinistros registrados em BO, mas concentram **41,92% das vítimas fatais**. A taxa de letalidade rodoviária (**12,85%**) é **3,43 vezes superior** à urbana (**3,74%**), refletindo maiores velocidades médias de impacto.

---

### 3.2. Variação Temporal e o Risco Noturno

![Taxa de Letalidade por Turno da Ocorrência](https://i.imgur.com/1r5TvLY.png)

A severidade dos sinistros apresenta forte dependência do horário e dia da semana:

| Turno | Total Ocorrências (BO) | Sinistros Fatais | Taxa de Letalidade (%) |
| :--- | :---: | :---: | :---: |
| **Madrugada (00h00 às 05h59)** | 13.722 | 1.682 | **12,26%** |
| **Noite (18h00 às 23h59)** | 42.997 | 2.849 | **6,63%** |
| **Tarde (12h00 às 17h59)** | 50.399 | 1.993 | **3,95%** |
| **Manhã (06h00 às 11h59)** | 44.473 | 1.735 | **3,90%** |

* A letalidade na **Madrugada (12,26%)** é mais de três vezes superior à observada nos turnos diurnos (~3,9%).
* O pico absoluto de letalidade ocorre aos **domingos de madrugada (12,91%)**.
* Por hora de ocorrência, a faixa das **02h00 às 04h00** atinge **8,10% de letalidade bruta**, período caracterizado por tráfego desimpedido, redução de fiscalização ostensiva e maior incidência de fadiga e alcoolemia.

---

### 3.3. Matriz de Conflito Modal e Vulnerabilidade Física

![Vulnerabilidade Modal: Taxa de Letalidade por Configuração](https://i.imgur.com/rHSLVJi.png)

A análise combinatória de modais envolvidos nos Boletins de Ocorrência revela a assimetria na absorção de energia cinética:

| Configuração de Conflito | Total de Ocorrências (BO) | Ocorrências Fatais | Taxa de Letalidade (%) |
| :--- | :---: | :---: | :---: |
| **Pedestre + Caminhão / Ônibus** | 1.313 | 326 | **24,83%** |
| **Ciclista + Caminhão / Ônibus** | 468 | 83 | **17,74%** |
| **Motocicleta + Caminhão** | 3.149 | 533 | **16,93%** |
| **Pedestre + Automóvel** | 5.719 | 879 | **15,37%** |
| **Automóvel + Caminhão** | 3.585 | 446 | **12,44%** |
| **Pedestre + Motocicleta** | 3.895 | 455 | **11,68%** |
| **Motocicleta Única (Queda/Choque)** | 32.196 | 2.028 | **6,30%** |
| **Ciclista + Automóvel** | 3.148 | 161 | **5,11%** |
| **Automóvel + Automóvel** | 11.751 | 377 | **3,21%** |
| **Motocicleta + Automóvel** | 60.124 | 1.252 | **2,08%** |

* **Motocicletas:** Estão presentes em **51,45% de todas as ocorrências fatais** no Estado (4.374 de 8.501 mortes).
* **Sinistros de Veículo Único (Motos):** Quedas e choques isolados de moto somam 32.196 casos e 2.028 óbitos (**6,30% de letalidade**), gerando mais mortes absolutas do que as colisões moto-carro (1.252 mortes).
* **Incompatibilidade de Massa:** A colisão entre moto e caminhão apresenta letalidade de **16,93%**, um risco 8,1 vezes maior que a colisão entre moto e automóvel (**2,08%**).
* **Vulnerabilidade de Pedestres:** Atropelamentos por caminhões ou ônibus resultam em óbito em **24,83%** dos casos registrados (1 óbito para cada 4 ocorrências).

---

## 4. Anomalias e Casos Críticos Identificados

1. **Variável `tp_sinistro_colisao_traseira` 100% Nula:**
   * Apresenta **273.371 valores ausentes (`NaN`)**. A ausência completa decorre de falha no pipeline de extração upstream, com provável redirecionamento desses registros para `tp_sinistro_outros` ou `tp_sinistro_colisao_outros`.
2. **Coordenadas Geográficas com Erro de Registro:**
   * Coordenadas que extrapolam os limites do Estado de São Paulo, como `ID 2509165` (Sales, registrado com latitude `-0.746` e longitude `-48.023`, no Pará) e `ID 2511337` (Serra Negra, registrado com latitude `-20.059` e longitude `-40.193`, no Oceano Atlântico).
3. **Concentrações Artificiais de Numeração de Logradouro:**
   * O valor `numero_logradouro = 1.0` ocorre em 31.179 linhas e `100.0` em 23.303 linhas. Esses valores operam como *placeholders* preenchidos quando não há numeração predial definida no local do sinistro.
4. **Sinistros com Múltiplas Vítimas:**
   * Ocorrências com até **12 vítimas fatais**, **21 vítimas leves** e **39 vítimas com gravidade não informada**, correspondendo a desastres com ônibus de passageiros em rodovias ou engavetamentos múltiplos.

---

## 5. Limitações e Vieses Metodológicos

* **Viés de Notificação por Órgão Gestor:** As Prefeituras concentram a maior parte dos registros de `NOTIFICACAO` (ocorrências sem vítimas reportadas), enquanto concessionárias e DER reportam quase exclusivamente via boletins com apuração de gravidade. Comparações diretas de taxas brutas entre rodovias e municípios sem controle de fluxo geram viés de seleção.
* **Truncamento de Severidade:** O preenchimento nulo das variáveis de gravidade nas 121.538 notificações impossibilita aferir a proporção real de feridos leves em ocorrências operacionais urbanas.
* **Ausência de Denominador de Exposição:** O dataset não contém dados de Volume Médio Diário de Veículos (VMD), quilômetros transitados ou extensão de malha viária. Municípios maiores (São Paulo, Guarulhos, Campinas) lideram os volumes brutos em função da dimensão de suas frotas e populações.

---

## 6. Hipóteses Investigáveis

### Hipótese 1: O Efeito da Velocidade Operacional na Madrugada
* **Padrão:** Queda no volume total de sinistros acompanhada por aumento de 3,4x na taxa de letalidade durante a madrugada (12,26% vs. 3,90% no período diurno).
* **Racional:** A redução do fluxo veicular elimina a restrição imposta pelo congestionamento, propiciando velocidades de impacto significativamente superiores aos limites da via.
* **Procedimento de Teste:** Estimar a velocidade de impacto através de modelos de energia por deformação modal e cruzar os registros com a localização e horário de funcionamento de radares de velocidade.

### Hipótese 2: Diferencial de Registro entre Vias Concedidas e Malha DER
* **Padrão:** Rodovias concedidas apresentam maior taxa de letalidade registrada em relação a trechos sob gestão direta do DER.
* **Racional:** Concessionárias dispõem de monitoramento por CFTV em tempo real e equipes de APH próprias, alcançando 100% de captura de sinistros graves, enquanto trechos sob gestão direta do DER sofrem subnotificação de eventos sem óbito imediato no local.
* **Procedimento de Teste:** Teste de hipótese pareado controlando por classe geométrica de rodovia (pista simples vs. dupla) e faixas de tráfego VMD equivalentes.

---

## 7. Potencial de Modelagem e Métodos Aplicáveis

1. **Análise Espacial de Padrões Pontuais (*Spatial Point Patterns*):**
   * *Kernel Density Estimation* (KDE) 2D ponderado pela gravidade e cálculo de estatística Gi* de Getis-Ord para identificação de *hotspots* viários.
2. **Modelos de Escolha Discreta para Severidade:**
   * Regressão Logística Multinomial e modelos *Ordered Probit* para estimar a probabilidade de gravidade das vítimas a partir dos atributos da via, horário e modais.
3. **Machine Learning para Triagem Pré-Hospitalar:**
   * Classificação Supervisionada (LightGBM, XGBoost) para predizer a probabilidade de vítimas graves com base em atributos preliminares do chamado operacional.
4. **Avaliação de Impacto Regulatório:**
   * Séries temporais interrompidas e Diferenças em Diferenças (DiD) para avaliar intervenções de engenharia de tráfego (ex.: Faixas Azuis para motocicletas e readequações de velocidade).

---

## 8. Priorização das Oportunidades Analíticas

![Matriz de Priorização das Oportunidades Analíticas](https://i.imgur.com/E02p6eq.png)

A tabela abaixo sintetiza as cinco principais oportunidades analíticas derivadas do dataset:

| Ranking | Pergunta de Pesquisa | Variáveis Utilizadas | Método Sugerido | Dificuldade | Valor Estratégico |
| :---: | :--- | :--- | :--- | :---: | :---: |
| **1** | Quais micro-corredores concentram a maior densidade de atropelamentos fatais de pedestres e ciclistas? | `latitude`, `longitude`, `qtd_pedestre`, `qtd_bicicleta`, `qtd_gravidade_fatal`, `tipo_via`, `logradouro` | *Kernel Density Estimation* (KDE) 2D e Spatial Scan Statistics (SaTScan / Gi*) | Média-Alta | **Máximo** |
| **2** | Qual é o multiplicador de risco de óbito em colisões de motos e pedestres com veículos de carga? | `qtd_motocicleta`, `qtd_pedestre`, `qtd_caminhao`, `qtd_onibus`, `qtd_automovel`, `is_fatal`, `tipo_via` | Regressão Logística Binária com interações modais de 2ª e 3ª ordem | Média | **Altíssimo** |
| **3** | Como predizer a probabilidade de vítimas em estado crítico a partir de dados preliminares do chamado? | `turno`, `dia_da_semana`, `tipo_via`, `administracao`, contagens modais, `tp_sinistro_primario` | Gradient Boosting (LightGBM / XGBoost) com calibração de probabilidade | Alta | **Altíssimo** |
| **4** | Qual o impacto do tráfego desimpedido e alcoolemia na letalidade da madrugada nos fins de semana? | `hora_sinistro`, `turno`, `dia_da_semana`, `is_fatal`, `tipo_via` | Decomposição de Séries Temporais e Modelo de Diferenças em Diferenças (DiD) | Baixa-Média | **Alto** |
| **5** | Quais municípios apresentam taxas anômalas indicativas de subnotificação de sinistros não fatais? | `municipio`, `cod_ibge`, `tipo_registro`, população municipal IBGE | Detecção de Outliers Multivariada (Isolation Forest / Taxas padronizadas por 100k hab.) | Baixa | **Médio-Alto** |

---

## 9. Conclusão

A análise exploratória do dataset `sinistros_2025-2026.csv` evidencia três assimetrias estruturais na segurança viária do Estado de São Paulo:

1. **Assimetria de Massa:** Usuários vulneráveis (pedestres e motociclistas) apresentam taxas de letalidade de até **24,83%** quando em conflito com veículos de grande porte (caminhões e ônibus).
2. **Assimetria Temporal:** O período da madrugada concentra letalidade de **12,26%**, mais de três vezes superior à média diurna (**3,90%**), com pico aos domingos (**12,91%**).
3. **Assimetria de Malha:** As rodovias concentram **41,92% dos óbitos** do Estado com taxa de letalidade de **12,85%**, enquanto as vias urbanas concentram o volume de ocorrências com ferimentos leves e médios (**3,74%** de letalidade).

Do ponto de vista metodológico, o particionamento entre **Boletins de Ocorrência Policiais** e **Notificações Operacionais** é requisito obrigatório para evitar viés de seleção e assegurar a robustez de modelos preditivos e inferenciais.
