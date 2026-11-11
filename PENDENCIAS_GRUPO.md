# Pendências do APPA — Teoria do Aprendizado Estatístico

Conferência de 11/11/2026 com [Danilo, versão `5c8198e`](https://github.com/danilopradooficial/teoriaaprendizadoestatistico/tree/5c8198e).

## 1. Atividade 10 — Árvores de decisão e random forest (Aula 11)

O PDF da aula foi incorporado. Faltam código aplicado ao banco APPA, árvore/poda, bagging/floresta,
erro OOB, importância das variáveis, comparação justa com as mesmas partições e relatório com exercícios.
O exemplo portuário do Danilo não é resultado do banco de sinistros.

## 2. Atividade 11 — Agrupamento e PCA (Aula 12)

O PDF da aula foi incorporado. Faltam escolha dos preditores, padronização, k-médias,
silhueta, hierárquico, PCA/variância explicada, gráficos e relatório com exercícios no APPA.
A resposta não deve entrar na matriz usada para formar grupos ou componentes.

## 3. PDF final diferente dos fontes

O `.Rnw` e o `.tex` foram corrigidos na atualização de 06/11, mas o PDF versionado ainda contém
a pergunta causal antiga, `turno` entre os preditores e **151591 observações / 12 preditores**.
Os fontes e a ficha atuais usam **151175 observações / 11 preditores**. Falta recompilar e conferir
o PDF final; se já foi entregue, confirmar com o professor a necessidade de reenvio.

## 4. Decisões do grupo e do professor

- Confirmar a redação por associação e a manutenção da pergunta A (Pico/Fora do Pico) ou adoção da proposta B (contagens) da oficina. A mudança da pergunta oficial ainda não está documentada como aprovada.
- Confirmar o recorte que exclui os 658 boletins com via/turno `NAO DISPONIVEL`; esse recorte altera a população estudada.
- Completar as entregas individuais dos demais integrantes e os registros reais da sessão com a tutora, se exigidos pelo professor. O conteúdo resolvido não substitui a avaliação individual.

## Conferido nesta atualização

As correções já estão commitadas no `main`; o aviso antigo de patch sem commit estava desatualizado.
O pipeline completo de 12 etapas executou sem erro. Os 35 resultados novos ou desatualizados e a base de pico foram regenerados; as métricas agora acompanham as correções dos scripts e dos relatórios de 06/11.
Os guias de Poisson coincidem com os atuais do Danilo após normalizar quebras de linha.
As pastas com o nome do aluno foram novamente removidas; os arquivos e links ficam diretamente
em `consolidados/` e `resolucoes/`. Os arquivos `.tex`, `.Rnw` e PDFs foram preservados.
