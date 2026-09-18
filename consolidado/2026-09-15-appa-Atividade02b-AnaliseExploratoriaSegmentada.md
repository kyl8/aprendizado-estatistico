# Atividade 02b: análise exploratória segmentada

Depois da visão geral, os registros foram comparados por tipo de via, turno, região administrativa e combinação de usuários e veículos.

## Recortes usados

- boletins policiais, para comparar a letalidade;
- vias urbanas e estradas ou rodovias;
- madrugada, manhã, tarde e noite;
- motocicletas, pedestres e ciclistas em combinação com outros veículos;
- regiões administrativas e evolução mensal.

## Resultado

O maior contraste aparece entre o horário e o tipo de via. A madrugada tem 3,14 vezes a letalidade da manhã. Entre as combinações observadas, pedestre com caminhão ou ônibus chega a 24,83%, enquanto motocicleta com automóvel fica em 2,08%.

Essas comparações ajudam a escolher variáveis para os modelos seguintes, mas não provam sozinhas que uma variável causa a gravidade do sinistro.

## Cuidados com os grupos

Uma porcentagem alta em um grupo pequeno pode oscilar bastante. Por isso, além da taxa, é preciso mostrar a quantidade de ocorrências e de registros fatais. Também não se deve comparar diretamente uma taxa de boletins com uma taxa calculada na base completa.

O recorte por horário depende de `hora_sinistro`. As linhas sem horário precisam ser mantidas na descrição da base, mas não devem ser forçadas para um turno arbitrário.

## Material

[Aula 03](../materiais-aulas/Aula%2003%20-%20An%C3%A1lise%20Explorat%C3%B3ria%20e%20Vari%C3%A1veis%20Aleat%C3%B3rias.PDF) e [relatório exploratório](2026-08-25-appa-AnaliseExploratoria.md).
