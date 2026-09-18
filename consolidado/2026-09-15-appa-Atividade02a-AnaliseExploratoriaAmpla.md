# Atividade 02a: análise exploratória ampla

A análise inicial descreve os sinistros de trânsito do Estado de São Paulo e procura diferenças entre volume, gravidade, local e horário.

## Principais achados

- A base reúne 143.332 sinistros não fatais, 8.501 sinistros fatais e 121.538 notificações.
- Boletins policiais representam 151.833 registros. As notificações não devem ser misturadas aos boletins quando a pergunta envolve letalidade.
- Estradas e rodovias têm letalidade de 12,85% entre os boletins, contra 3,74% nas vias urbanas.
- A madrugada concentra a maior letalidade, com 12,26%, enquanto manhã e tarde ficam próximas de 4%.
- Motocicletas aparecem em 51,45% dos registros fatais.
- Faltam coordenadas em 40,82% das linhas. Esse recorte precisa ser informado em análises espaciais.

O relatório detalhado está em [2026-08-25-appa-AnaliseExploratoria.md](2026-08-25-appa-AnaliseExploratoria.md).

## Como a análise foi organizada

Primeiro foram contados registros por tipo. Depois foram comparados os boletins por via, turno, região e perfil dos envolvidos. Por fim, foram conferidos campos ausentes e categorias que significam informação não disponível.

As taxas foram calculadas como número de registros fatais dividido pelo total de boletins do recorte. Essa definição é diferente de dividir fatalidades pelo total da base, que inclui notificações.

## Perguntas que ficam abertas

Os resultados mostram associações fortes, mas ainda não controlam várias características ao mesmo tempo. A regressão pode ajudar a organizar essas associações, desde que o recorte e as suposições sejam explicados.

## Leitura dos resultados

O volume de ocorrências e a gravidade não contam a mesma história. Rodovias têm menos registros, mas uma proporção maior de mortes. Notificações também têm outro nível de preenchimento, por isso a taxa de letalidade deve ser calculada dentro de um recorte bem definido.

## Material

[Aula 03](../materiais-aulas/Aula%2003%20-%20An%C3%A1lise%20Explorat%C3%B3ria%20e%20Vari%C3%A1veis%20Aleat%C3%B3rias.PDF).
