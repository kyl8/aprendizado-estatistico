# Análise Exploratória - Sinistralidade

## 1. Visão geral da base

| Indicador | Valor |
| :--- | ---: |
| Período | 01/01/2025 a 30/06/2026 |
| Meses observados | 18 |
| Registros | 273.371 |
| Colunas | 50 |
| Municípios | 645 |

### Tipos de registro

| Tipo | Registros | Percentual |
| :--- | ---: | ---: |
| SINISTRO NAO FATAL | 143.332 | 52,43% |
| NOTIFICACAO | 121.538 | 44,46% |
| SINISTRO FATAL | 8.501 | 3,11% |
| **Boletins policiais (fatal + não fatal)** | **151.833** | **55,54%** |

---

## 2. Classificação das variáveis

| Variável | Tipo | Subtipo |
| :--- | :--- | :--- |
| `id_sinistro` | Qualitativa | Nominal — identificador |
| `tipo_registro` | Qualitativa | Nominal |
| `data_sinistro` | Quantitativa | Temporal |
| `ano_sinistro` | Quantitativa | Temporal discreta |
| `mes_sinistro` | Quantitativa | Temporal discreta |
| `dia_sinistro` | Quantitativa | Temporal discreta |
| `hora_sinistro` | Quantitativa | Temporal |
| `ano_mes_sinistro` | Quantitativa | Temporal |
| `dia_da_semana` | Qualitativa | Nominal |
| `turno` | Qualitativa | Ordinal |
| `logradouro` | Qualitativa | Nominal |
| `numero_logradouro` | Qualitativa | Nominal — referência de endereço |
| `tipo_via` | Qualitativa | Nominal |
| `tipo_local` | Qualitativa | Nominal |
| `latitude` | Quantitativa | Contínua |
| `longitude` | Quantitativa | Contínua |
| `cod_ibge` | Qualitativa | Nominal — identificador territorial |
| `municipio` | Qualitativa | Nominal |
| `regiao_administrativa` | Qualitativa | Nominal |
| `administracao` | Qualitativa | Nominal |
| `conservacao` | Qualitativa | Nominal |
| `circunscricao` | Qualitativa | Nominal |
| `tp_sinistro_primario` | Qualitativa | Nominal |
| `qtd_pedestre` | Quantitativa | Discreta |
| `qtd_bicicleta` | Quantitativa | Discreta |
| `qtd_motocicleta` | Quantitativa | Discreta |
| `qtd_automovel` | Quantitativa | Discreta |
| `qtd_onibus` | Quantitativa | Discreta |
| `qtd_caminhao` | Quantitativa | Discreta |
| `qtd_veic_outros` | Quantitativa | Discreta |
| `qtd_veic_nao_disponivel` | Quantitativa | Discreta |
| `qtd_gravidade_fatal` | Quantitativa | Discreta |
| `qtd_gravidade_grave` | Quantitativa | Discreta |
| `qtd_gravidade_leve` | Quantitativa | Discreta |
| `qtd_gravidade_ileso` | Quantitativa | Discreta |
| `qtd_gravidade_nao_disponivel` | Quantitativa | Discreta |
| `tp_sinistro_atrop_pedestre` | Qualitativa | Binária |
| `tp_sinistro_atrop_vitima_fora_veic` | Qualitativa | Binária |
| `tp_sinistro_colisao_frontal` | Qualitativa | Binária |
| `tp_sinistro_colisao_traseira` | Qualitativa | Binária |
| `tp_sinistro_colisao_lateral` | Qualitativa | Binária |
| `tp_sinistro_colisao_transversal` | Qualitativa | Binária |
| `tp_sinistro_colisao_outros` | Qualitativa | Binária |
| `tp_sinistro_choque` | Qualitativa | Binária |
| `tp_sinistro_atrop_animal` | Qualitativa | Binária |
| `tp_sinistro_capotamento` | Qualitativa | Binária |
| `tp_sinistro_engavetamento` | Qualitativa | Binária |
| `tp_sinistro_tombamento` | Qualitativa | Binária |
| `tp_sinistro_outros` | Qualitativa | Binária |
| `tp_sinistro_nao_disponivel` | Qualitativa | Binária |

### Resumo

| Tipo de variável | Quantidade |
| :--- | ---: |
| Quantitativas | 21 |
| Qualitativas | 29 |
| **Total** | **50** |

> Os campos temporais foram classificados como quantitativos por representarem posição no tempo e permitirem ordenação e operações temporais. Identificadores como `id_sinistro`, `cod_ibge` e `numero_logradouro` permanecem qualitativos, mesmo quando possuem aparência numérica, pois não representam medidas.

---

## 3. Boletins x notificações

![Composição do Dataset por Tipo de Registro](https://i.imgur.com/UplJCTY.png)


| Indicador | Boletins policiais | Notificações |
| :--- | ---: | ---: |
| Registros | 151.833 | 121.538 |
| Veículos discriminados | Sim | Não |
| `qtd_veic_nao_disponivel = 1` | — | 100% |
| `tipo_local = NAO DISPONIVEL` | — | 95,41% |
| Sem coordenadas | ~9–11% | 80,48% |
| Georreferenciamento — fatais | 89,19% | — |
| Georreferenciamento — não fatais | 91,03% | — |

### Efeito no cálculo de letalidade

| Forma de cálculo | Taxa de letalidade |
| :--- | ---: |
| Apenas boletins policiais | **5,60%** |
| Base completa, incluindo notificações | **3,11%** |

---

## 4. Tipo de via

![Comparativo de Letalidade: Rodovias vs. Vias Urbanas](https://i.imgur.com/IAQJcvJ.png)


### Distribuição geral

| Tipo de via | Registros |
| :--- | ---: |
| VIAS URBANAS | 236.227 |
| ESTRADAS E RODOVIAS | 36.697 |
| NAO DISPONIVEL | 447 |

### Letalidade — apenas boletins policiais

| Tipo de via | Sinistros (BO) | Fatais | Letalidade |
| :--- | ---: | ---: | ---: |
| Vias urbanas | 125.107 | 4.679 | **3,74%** |
| Estradas e rodovias | 26.279 | 3.377 | **12,85%** |
| Não disponível | 447 | 445 | 99,55% |

| Comparação | Valor |
| :--- | ---: |
| Letalidade rodoviária / urbana | **3,43x** |
| Participação das rodovias nos BOs | **17,31%** |
| Participação das rodovias nos fatais | **41,92%** |

---

## 5. Horário e turno

![Taxa de Letalidade por Turno da Ocorrência](https://i.imgur.com/1r5TvLY.png)


### Letalidade por turno — boletins policiais

| Turno | Ocorrências | Fatais | Letalidade |
| :--- | ---: | ---: | ---: |
| Madrugada | 13.722 | 1.682 | **12,26%** |
| Noite | 42.997 | 2.849 | **6,63%** |
| Tarde | 50.399 | 1.993 | **3,95%** |
| Manhã | 44.473 | 1.735 | **3,90%** |

### Comparações de horário

| Indicador | Valor |
| :--- | ---: |
| Letalidade na madrugada | **12,26%** |
| Letalidade na manhã | **3,90%** |
| Letalidade na tarde | **3,95%** |
| Madrugada / manhã | **3,14x** |
| Madrugada / tarde | **3,10x** |
| Domingo de madrugada | **12,91%** |
| Faixa de 02h00–04h00 | **8,10% de letalidade bruta** |

---

## 6. Distribuição regional

| Região Administrativa | Registros | Percentual |
| :--- | ---: | ---: |
| Região Metropolitana de São Paulo | 107.302 | 39,25% |
| Campinas | 43.907 | 16,06% |
| São José dos Campos | 17.988 | 6,58% |
| Sorocaba | 17.500 | 6,40% |

### Volume mensal

| Período | Faixa aproximada de registros/mês |
| :--- | ---: |
| 2025 | 15.000–17.000 |
| Jan–Jun/2026 | 12.000–15.000 |

---

## 7. Combinações de veículos e usuários

![Vulnerabilidade Modal: Taxa de Letalidade por Configuração](https://i.imgur.com/rHSLVJi.png)


| Configuração | Ocorrências | Fatais | Letalidade |
| :--- | ---: | ---: | ---: |
| Pedestre + Caminhão / Ônibus | 1.313 | 326 | **24,83%** |
| Ciclista + Caminhão / Ônibus | 468 | 83 | **17,74%** |
| Motocicleta + Caminhão | 3.149 | 533 | **16,93%** |
| Pedestre + Automóvel | 5.719 | 879 | **15,37%** |
| Automóvel + Caminhão | 3.585 | 446 | **12,44%** |
| Pedestre + Motocicleta | 3.895 | 455 | **11,68%** |
| Motocicleta Única | 32.196 | 2.028 | **6,30%** |
| Ciclista + Automóvel | 3.148 | 161 | **5,11%** |
| Automóvel + Automóvel | 11.751 | 377 | **3,21%** |
| Motocicleta + Automóvel | 60.124 | 1.252 | **2,08%** |

---

## 8. Motocicletas

| Indicador | Valor |
| :--- | ---: |
| Ocorrências fatais com motocicleta | 4.374 |
| Total de ocorrências fatais | 8.501 |
| Participação das motos nos fatais | **51,45%** |
| Moto + automóvel | **2,08%** |
| Moto + caminhão | **16,93%** |
| Moto + caminhão / moto + automóvel | **8,1x** |
| Motocicleta única — ocorrências | 32.196 |
| Motocicleta única — fatais | 2.028 |
| Motocicleta única — letalidade | **6,30%** |

---

## 9. Pedestres e ciclistas

### Pedestres

| Configuração | Letalidade |
| :--- | ---: |
| Pedestre + Caminhão / Ônibus | **24,83%** |
| Pedestre + Automóvel | **15,37%** |
| Pedestre + Motocicleta | **11,68%** |

### Ciclistas

| Configuração | Letalidade |
| :--- | ---: |
| Ciclista + Caminhão / Ônibus | **17,74%** |
| Ciclista + Automóvel | **5,11%** |

---

## 10. Qualidade e disponibilidade dos dados

| Indicador | Valor |
| :--- | ---: |
| Coordenadas válidas | 161.786 |
| Coordenadas ausentes | 111.585 |
| Coordenadas ausentes | 40,82% |
| `hora_sinistro` ausente | 242 |
| `hora_sinistro` ausente | 0,09% |
| `logradouro` ausente | 617 |
| `logradouro` ausente | 0,23% |
| `numero_logradouro` ausente | 1.101 |
| `numero_logradouro` ausente | 0,40% |
| `tp_sinistro_colisao_traseira` ausente | 273.371 |
| `tp_sinistro_colisao_traseira` ausente | 100% |

---

![Matriz de Priorização das Oportunidades Analíticas](https://i.imgur.com/E02p6eq.png)
