# Dicionário de Dados Sinistros, 2025 - 2026.

Dicionário descritivo elaborado a partir da estrutura e dos valores observados no arquivo `sinistros_2025-2026.csv`.

## Convenções adotadas

- Base analisada: **273.371 registros** e **50 variáveis**.
- A coluna **classe R** descreve a classe conceitualmente adequada para uso em R, sem executar conversões na base original.
- Em todas as variáveis iniciadas por `qtd_`, valores ausentes (`NA`) são interpretados como **0**.
- Nas variáveis indicadoras `tp_sinistro_*` (exceto `tp_sinistro_primario`), a leitura conceitual adotada é **`TRUE` quando o valor original é `S` e `NA` quando está vazio**.
- As estatísticas de ausência referem-se ao arquivo original. A categoria textual `NAO DISPONIVEL`, quando existente, é diferente de um valor ausente.
- `latitude` e `longitude` usam vírgula como separador decimal.

## Identificação

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `id_sinistro` | `character` | Identificador único do registro de sinistro. | código identificador; Valor único por linha | Sem valores ausentes observados |
| `tipo_registro` | `factor` | Classificação geral do registro quanto ao tipo de ocorrência cadastrada. | categoria; NOTIFICACAO \| SINISTRO FATAL \| SINISTRO NAO FATAL | Sem valores ausentes observados |

## Tempo

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `data_sinistro` | `Date` | Data em que o sinistro ocorreu. | DD/MM/AAAA | Sem valores ausentes observados |
| `ano_sinistro` | `integer` | Ano de ocorrência do sinistro. | AAAA; 2025 \| 2026 | Sem valores ausentes observados |
| `mes_sinistro` | `integer` | Mês de ocorrência do sinistro, com dois dígitos. | MM; 01 a 12 | Sem valores ausentes observados |
| `dia_sinistro` | `integer` | Dia do mês em que o sinistro ocorreu, com dois dígitos. | DD; 01 a 31 | Sem valores ausentes observados |
| `hora_sinistro` | `character` | Horário registrado para a ocorrência do sinistro. | HH:MM; 00:00 a 23:59 | NA = informação ausente/não preenchida |
| `ano_mes_sinistro` | `character` | Competência temporal formada pelo ano e pelo mês do sinistro. | AAAA/MM | Sem valores ausentes observados |
| `dia_da_semana` | `factor` | Dia da semana correspondente à data do sinistro. | categoria; Domingo \| Segunda-feira \| Terça-feira \| Quarta-feira \| Quinta-feira \| Sexta-feira \| Sábado | Sem valores ausentes observados |
| `turno` | `factor` | Faixa do dia associada ao horário do sinistro. | categoria; MADRUGADA \| MANHA \| TARDE \| NOITE \| NAO DISPONIVEL | Sem valores ausentes observados |

## Localização

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `logradouro` | `character` | Nome do logradouro informado para o local do sinistro. | texto livre | NA = informação ausente/não preenchida |
| `numero_logradouro` | `character` | Número ou referência numérica do endereço do sinistro. | endereço / referência | NA = informação ausente/não preenchida |
| `tipo_via` | `factor` | Classificação geral da via onde ocorreu o sinistro. | categoria; VIAS URBANAS \| ESTRADAS E RODOVIAS \| NAO DISPONIVEL | Sem valores ausentes observados |
| `tipo_local` | `factor` | Classificação do local do sinistro quanto ao caráter público ou privado. | categoria; PUBLICO \| PRIVADO \| NAO DISPONIVEL | NA = informação ausente/não preenchida |
| `latitude` | `double` | Latitude geográfica registrada para o sinistro. | graus decimais | NA = informação ausente/não preenchida |
| `longitude` | `double` | Longitude geográfica registrada para o sinistro. | graus decimais | NA = informação ausente/não preenchida |
| `cod_ibge` | `character` | Código IBGE do município associado ao sinistro. | código IBGE municipal | Sem valores ausentes observados |
| `municipio` | `factor` | Município associado ao local do sinistro. | categoria territorial | Sem valores ausentes observados |
| `regiao_administrativa` | `factor` | Região administrativa do Estado de São Paulo associada ao município do sinistro. | categoria territorial | Sem valores ausentes observados |

## Gestão da via

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `administracao` | `factor` | Tipo de entidade responsável pela administração da via. | categoria; CONCESSIONÁRIA \| DER \| DNIT \| PREFEITURA \| NAO DISPONIVEL | Sem valores ausentes observados |
| `conservacao` | `factor` | Responsável ou referência de conservação/manutenção da via, conforme registrado na base. | categoria / código | Sem valores ausentes observados |
| `circunscricao` | `factor` | Esfera de circunscrição da via onde ocorreu o sinistro. | categoria; MUNICIPAL \| ESTADUAL \| FEDERAL \| NAO DISPONIVEL | Sem valores ausentes observados |

## Características do sinistro

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `tp_sinistro_primario` | `factor` | Tipo principal atribuído ao sinistro. | categoria; ATROPELAMENTO \| CHOQUE \| COLISAO \| OUTROS \| NAO DISPONIVEL | Sem valores ausentes observados |

## Envolvidos e veículos

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `qtd_pedestre` | `integer` | Quantidade de pedestres envolvidos no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_bicicleta` | `integer` | Quantidade de bicicletas envolvidas no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_motocicleta` | `integer` | Quantidade de motocicletas envolvidas no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_automovel` | `integer` | Quantidade de automóveis envolvidos no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_onibus` | `integer` | Quantidade de ônibus envolvidos no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_caminhao` | `integer` | Quantidade de caminhões envolvidos no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_veic_outros` | `integer` | Quantidade de veículos de outros tipos envolvidos no sinistro. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_veic_nao_disponivel` | `integer` | Quantidade de veículos cujo tipo não está disponível. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |

## Gravidade

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `qtd_gravidade_fatal` | `integer` | Quantidade de pessoas/vítimas classificadas com gravidade fatal. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_gravidade_grave` | `integer` | Quantidade de pessoas/vítimas classificadas com gravidade grave. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_gravidade_leve` | `integer` | Quantidade de pessoas/vítimas classificadas com gravidade leve. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_gravidade_ileso` | `integer` | Quantidade de pessoas envolvidas classificadas como ilesas. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |
| `qtd_gravidade_nao_disponivel` | `integer` | Quantidade de pessoas/vítimas sem classificação de gravidade disponível. | contagem (n) | NA = 0 (regra de interpretação do projeto; sem alteração da base) |

## Indicadores de tipo de sinistro

| Variável | Classe R | Explicação | Formato/domínio | Ausência |
|---|---|---|---|---|
| `tp_sinistro_atrop_pedestre` | `logical` | Indica ocorrência de atropelamento de pedestre. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_atrop_vitima_fora_veic` | `logical` | Indica ocorrência de atropelamento de vítima fora de veículo. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_colisao_frontal` | `logical` | Indica ocorrência de colisão frontal. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_colisao_traseira` | `logical` | Indica ocorrência de colisão traseira. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_colisao_lateral` | `logical` | Indica ocorrência de colisão lateral. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_colisao_transversal` | `logical` | Indica ocorrência de colisão transversal. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_colisao_outros` | `logical` | Indica ocorrência de outro tipo de colisão não contemplado nos campos específicos. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_choque` | `logical` | Indica ocorrência classificada como choque. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_atrop_animal` | `logical` | Indica ocorrência de atropelamento de animal. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_capotamento` | `logical` | Indica ocorrência de capotamento. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_engavetamento` | `logical` | Indica ocorrência de engavetamento. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_tombamento` | `logical` | Indica ocorrência de tombamento. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_outros` | `logical` | Indica ocorrência de outro tipo de sinistro não contemplado nos indicadores específicos. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |
| `tp_sinistro_nao_disponivel` | `logical` | Indica que o tipo específico do sinistro não está disponível. | TRUE / NA; Original observado: S / vazio | NA = ausência do indicador; S = TRUE conceitualmente |

## Perfil descritivo das variáveis

A tabela abaixo registra cardinalidade e ausência observadas, sem qualquer transformação da base.

| Variável | Distintos não ausentes | Ausentes | Ausentes (%) | Valores observados |
|---|---:|---:|---:|---|
| `id_sinistro` | 273371 | 0 | 0,00 | Ex.: 2509165 \| 2511337 \| 2515570 \| 2517117 \| 2518510 \| 2466647 |
| `tipo_registro` | 3 | 0 | 0,00 | NOTIFICACAO \| SINISTRO FATAL \| SINISTRO NAO FATAL |
| `data_sinistro` | 546 | 0 | 0,00 | Ex.: 01/01/2025 \| 02/01/2025 \| 03/01/2025 \| 04/01/2025 \| 05/01/2025 \| 06/01/2025 |
| `ano_sinistro` | 2 | 0 | 0,00 | 2025 \| 2026 |
| `mes_sinistro` | 12 | 0 | 0,00 | 01 \| 02 \| 03 \| 04 \| 05 \| 06 \| 07 \| 08 \| 09 \| 10 \| 11 \| 12 |
| `dia_sinistro` | 31 | 0 | 0,00 | Ex.: 01 \| 02 \| 03 \| 04 \| 05 \| 06 |
| `hora_sinistro` | 1440 | 242 | 0,09 | Ex.: 05:05 \| 06:33 \| 12:43 \| 01:07 \| 01:16 \| 01:20 |
| `ano_mes_sinistro` | 18 | 0 | 0,00 | 2025/01 \| 2025/02 \| 2025/03 \| 2025/04 \| 2025/05 \| 2025/06 \| 2025/07 \| 2025/08 \| 2025/09 \| 2025/10 \| 2025/11 \| 2025/12 \| 2026/01 \| 2026/02 \| 2026/03 \| 2026/04 \| 2026/05 \| 2026/06 |
| `dia_da_semana` | 7 | 0 | 0,00 | Domingo \| Quarta-feira \| Quinta-feira \| Segunda-feira \| Sexta-feira \| Sábado \| Terça-feira |
| `turno` | 5 | 0 | 0,00 | MADRUGADA \| MANHA \| NAO DISPONIVEL \| NOITE \| TARDE |
| `logradouro` | 63207 | 617 | 0,23 | Ex.: RUA MONTE APRAZIVEL \| AVENIDA PIRES DO RIO \| RUA TEREZINHA DE LIMA BUENO \| ESTRADA MUNICIPAL GUILHERME SCATENA \| RUA VICTORINO \| TRAVESSA PETER SELMER |
| `numero_logradouro` | 11540 | 1101 | 0,40 | Ex.: 32.0 \| 2205.0 \| 136.0 \| 100.0 \| 206.0 \| 246.0 |
| `tipo_via` | 3 | 0 | 0,00 | ESTRADAS E RODOVIAS \| NAO DISPONIVEL \| VIAS URBANAS |
| `tipo_local` | 3 | 5044 | 1,85 | NAO DISPONIVEL \| PRIVADO \| PUBLICO |
| `latitude` | 111915 | 111585 | 40,82 | Ex.: -23,6205977272 \| -23,019292501 \| -23,6163 \| -23,8709274755 \| -23,2867256217 \| -21,47372582 |
| `longitude` | 113311 | 111585 | 40,82 | Ex.: -46,4969351365 \| -48,8595650427 \| -46,6369 \| -46,3322679337 \| -46,7902624932 \| -49,20722475 |
| `cod_ibge` | 645 | 0 | 0,00 | Ex.: 3510609 \| 3550308 \| 3546801 \| 3548906 \| 3505708 \| 3549102 |
| `municipio` | 645 | 0 | 0,00 | Ex.: CARAPICUIBA \| SAO PAULO \| SANTA ISABEL \| SAO CARLOS \| BARUERI \| SAO JOAO DA BOA VISTA |
| `regiao_administrativa` | 16 | 0 | 0,00 | ARAÇATUBA \| BAIXADA SANTISTA \| BARRETOS \| BAURU \| CAMPINAS \| CENTRAL \| FRANCA \| ITAPEVA \| MARÍLIA \| METROPOLITANA DE SÃO PAULO \| PRESIDENTE PRUDENTE \| REGISTRO \| RIBEIRÃO PRETO \| SOROCABA \| SÃO JOSÉ DO RIO PRETO \| SÃO JOSÉ DOS CAMPOS |
| `administracao` | 5 | 0 | 0,00 | CONCESSIONÁRIA \| DER \| DNIT \| NAO DISPONIVEL \| PREFEITURA |
| `conservacao` | 86 | 0 | 0,00 | Ex.: PREFEITURA \| SPVIAS \| 05.04 \| 04.03 \| NAO DISPONIVEL \| NOVO LITORAL |
| `circunscricao` | 4 | 0 | 0,00 | ESTADUAL \| FEDERAL \| MUNICIPAL \| NAO DISPONIVEL |
| `tp_sinistro_primario` | 5 | 0 | 0,00 | ATROPELAMENTO \| CHOQUE \| COLISAO \| NAO DISPONIVEL \| OUTROS |
| `qtd_pedestre` | 7 | 260184 | 95,18 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 |
| `qtd_bicicleta` | 1 | 267815 | 97,97 | 1 |
| `qtd_motocicleta` | 7 | 170861 | 62,50 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 9 |
| `qtd_automovel` | 12 | 171717 | 62,81 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 8 \| 9 \| 10 \| 11 \| 12 |
| `qtd_onibus` | 3 | 266915 | 97,64 | 1 \| 2 \| 3 |
| `qtd_caminhao` | 7 | 263909 | 96,54 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 |
| `qtd_veic_outros` | 7 | 265885 | 97,26 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 |
| `qtd_veic_nao_disponivel` | 4 | 145628 | 53,27 | 1 \| 2 \| 3 \| 4 |
| `qtd_gravidade_fatal` | 7 | 264870 | 96,89 | 1 \| 2 \| 3 \| 4 \| 5 \| 7 \| 12 |
| `qtd_gravidade_grave` | 7 | 257438 | 94,17 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 9 |
| `qtd_gravidade_leve` | 15 | 148564 | 54,35 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 8 \| 9 \| 10 \| 11 \| 12 \| 13 \| 16 \| 21 |
| `qtd_gravidade_ileso` | 13 | 169412 | 61,97 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 8 \| 9 \| 10 \| 11 \| 13 \| 18 |
| `qtd_gravidade_nao_disponivel` | 14 | 268304 | 98,15 | 1 \| 2 \| 3 \| 4 \| 5 \| 6 \| 7 \| 9 \| 12 \| 18 \| 24 \| 34 \| 35 \| 39 |
| `tp_sinistro_atrop_pedestre` | 1 | 248016 | 90,73 | S / vazio |
| `tp_sinistro_atrop_vitima_fora_veic` | 1 | 273248 | 99,96 | S / vazio |
| `tp_sinistro_colisao_frontal` | 1 | 235814 | 86,26 | S / vazio |
| `tp_sinistro_colisao_traseira` | 0 | 273371 | 100,00 | somente vazio |
| `tp_sinistro_colisao_lateral` | 1 | 213760 | 78,19 | S / vazio |
| `tp_sinistro_colisao_transversal` | 1 | 238155 | 87,12 | S / vazio |
| `tp_sinistro_colisao_outros` | 1 | 272714 | 99,76 | S / vazio |
| `tp_sinistro_choque` | 1 | 255907 | 93,61 | S / vazio |
| `tp_sinistro_atrop_animal` | 1 | 272239 | 99,59 | S / vazio |
| `tp_sinistro_capotamento` | 1 | 268198 | 98,11 | S / vazio |
| `tp_sinistro_engavetamento` | 1 | 271844 | 99,44 | S / vazio |
| `tp_sinistro_tombamento` | 1 | 254969 | 93,27 | S / vazio |
| `tp_sinistro_outros` | 1 | 198556 | 72,63 | S / vazio |
| `tp_sinistro_nao_disponivel` | 1 | 219413 | 80,26 | S / vazio |

## Observações específicas

- **`id_sinistro`:** Tratado como identificador, não como medida numérica.
- **`data_sinistro`:** No arquivo original está representada como texto no formato DD/MM/AAAA; o dicionário apenas documenta a classe temporal esperada.
- **`mes_sinistro` e `dia_sinistro`:** Tipados como `integer`; o zero à esquerda é apenas uma forma de exibição do valor.
- **`hora_sinistro`:** Pode estar ausente no arquivo original.
- **`ano_mes_sinistro`:** Campo derivado temporal já presente na fonte; não é recalculado neste dicionário.
- **`logradouro`:** Pode estar ausente.
- **`numero_logradouro`:** Embora muitos valores sejam numéricos, o campo é documentado como `character` por representar parte de um endereço.
- **`tipo_local`:** Além de `NA`, a própria categoria `NAO DISPONIVEL` aparece na fonte.
- **`latitude` e `longitude`:** No arquivo original o separador decimal é vírgula; nenhuma conversão é realizada aqui.
- **`cod_ibge`:** Documentado como `character` por ser um identificador territorial, não uma medida.
- **`regiao_administrativa`:** Foram observadas 16 categorias no arquivo analisado.
- **`conservacao`:** O campo mistura nomes de responsáveis e códigos; os valores são mantidos exatamente como na fonte.
- **`qtd_pedestre`, `qtd_bicicleta`, `qtd_motocicleta`, `qtd_automovel`, `qtd_onibus`, `qtd_caminhao`, `qtd_veic_outros`, `qtd_veic_nao_disponivel`, `qtd_gravidade_fatal`, `qtd_gravidade_grave`, `qtd_gravidade_leve`, `qtd_gravidade_ileso` e `qtd_gravidade_nao_disponivel`:** Regra do projeto: valor ausente (`NA`) deve ser interpretado como 0, sem substituir os valores no arquivo original.
- **`tp_sinistro_atrop_pedestre`, `tp_sinistro_atrop_vitima_fora_veic`, `tp_sinistro_colisao_frontal`, `tp_sinistro_colisao_lateral`, `tp_sinistro_colisao_transversal`, `tp_sinistro_colisao_outros`, `tp_sinistro_choque`, `tp_sinistro_atrop_animal`, `tp_sinistro_capotamento`, `tp_sinistro_engavetamento`, `tp_sinistro_tombamento`, `tp_sinistro_outros` e `tp_sinistro_nao_disponivel`:** Representação conceitual adotada no dicionário: `TRUE` quando o arquivo contém `"S"` e `NA` quando o campo está vazio. Nenhuma recodificação foi aplicada à base original.
- **`tp_sinistro_colisao_traseira`:** Segue a mesma representação conceitual dos demais indicadores (`TRUE` quando há `"S"` e `NA` quando vazio). No arquivo analisado, este campo está totalmente vazio e é mantido por fazer parte da estrutura original.

---
Este dicionário é descritivo: documenta a estrutura observada e as regras de interpretação definidas para o projeto, sem limpar, recodificar ou transformar o conteúdo da base de sinistros.
