# Atividade 01: dados e variáveis

Esta atividade organiza a base de sinistros usada pelo grupo APPA. O arquivo tem 273.371 registros e 50 variáveis, com ocorrências registradas entre janeiro de 2025 e junho de 2026.

## O que foi feito

- identificação da unidade de análise, que é um registro de sinistro ou notificação;
- classificação das variáveis em qualitativas e quantitativas;
- registro dos formatos, categorias e valores ausentes;
- separação entre valores ausentes e a categoria `NAO DISPONIVEL`;
- observação das regras de leitura das colunas de quantidade e dos indicadores de tipo de sinistro.

O dicionário completo está em [estrutura/corpus/2026-08-11-appa-DicionarioDados.md](../estrutura/corpus/2026-08-11-appa-DicionarioDados.md).

## Cuidados para a análise

`id_sinistro` e `cod_ibge` identificam registros ou municípios. Eles não devem entrar em médias. Datas, horários e categorias também precisam ser convertidos com cuidado antes dos cálculos.

Nas colunas iniciadas por `qtd_`, o vazio foi interpretado como zero para a leitura do projeto. Essa escolha precisa ser informada em qualquer análise que use essas colunas.

## Unidade de análise

Cada linha representa uma ocorrência registrada. Um mesmo acidente pode aparecer com características diferentes conforme o tipo de registro, por isso a base deve ser entendida antes de qualquer contagem.

As variáveis de data permitem recortes por ano, mês, dia da semana e turno. As variáveis de localização permitem comparar municípios, regiões e tipos de via. Já as colunas de quantidade descrevem veículos ou gravidade informados no registro.

## Relação com as próximas atividades

O dicionário serve como referência para escolher fatores, respostas numéricas e respostas binárias. Ele também registra quais campos não devem ser usados sem tratamento, como latitude, longitude e horários ausentes.

## Material

[Aula 01](../materiais-aulas/Aula%2001%20-%20Introdu%C3%A7%C3%A3o%20ao%20Aprendizado%20Estat%C3%ADstico.PDF) e [Aula 02](../materiais-aulas/Aula%2002%20-%20Dados%20e%20Vari%C3%A1veis.PDF).
