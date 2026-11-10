# `estrutura/codigos/` (plural): scripts de atividade

Aqui ficam os scripts de cada atividade da disciplina, no padrão `YYYY-MM-DD-appa-<Nome>.R`, mais a preparação da base e o executor.

- `2026-09-15-appa-PrepararBaseSinistros.R`: lê o CSV, cria `boletins` (151.833) e `boletins_modelo` (151.175, sem `NAO DISPONIVEL`). Todos os outros scripts dão `source()` nele.
- `2026-09-15-appa-Atividade03a` a `Atividade06`, `2026-10-05-appa-Atividade07`, `2026-10-09-appa-Atividade08`, `2026-10-25-appa-Atividade09`: uma atividade por arquivo.
- `2026-10-25-appa-Atividades01_02.R`: diagnóstico e figuras exploratórias.
- `2026-10-02-appa-gerar-base-pico.R`: gera a base da Entrega 1 (`estrutura/banco-de-dados/`).
- `2026-10-25-appa-Atividade05b-RegressaoPoisson.R`: apenas chama `estrutura/codigo/aula05b_poisson.R`.
- `executar_atualizacao.R`: roda todas as etapas na ordem (as desta pasta e as de `estrutura/codigo/`).

Para a outra pasta, veja [`../codigo/README.md`](../codigo/README.md).
