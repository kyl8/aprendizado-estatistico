# R | executar_atualizacao.R | executar na raiz do repositorio.
# Reexecuta TODAS as etapas na ordem. Dependencias: glmnet, mgcv.
if (.Platform$OS.type == "windows") invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8"))
etapas <- c(
  "estrutura/codigos/2026-10-25-appa-Atividades01_02.R",
  "estrutura/codigos/2026-09-15-appa-Atividade03a-RegressaoLinear.R",
  "estrutura/codigos/2026-09-15-appa-Atividade03b-Previsao.R",
  "estrutura/codigos/2026-09-15-appa-Atividade04-RegressaoLogistica.R",
  "estrutura/codigos/2026-09-15-appa-Atividade05-AvaliacaoSelecaoModelos.R",
  "estrutura/codigos/2026-09-15-appa-Atividade06-MetodosReamostragem.R",
  "estrutura/codigos/2026-10-05-appa-Atividade07-ExpansaoRegularizacao.R",
  "estrutura/codigos/2026-10-09-appa-Atividade08-MetodosSuavizacao.R",
  "estrutura/codigos/2026-10-02-appa-gerar-base-pico.R",
  "estrutura/codigo/2026-10-25-appa-OficinaDuasPerguntas.R",
  "estrutura/codigo/aula05b_poisson.R",
  "estrutura/codigos/2026-10-25-appa-Atividade09-SplinesModelosAditivos.R"
)
for (e in etapas) {
  cat("\n=== ", e, " ===\n", sep = "")
  source(e, local = new.env(parent = globalenv()), encoding = "UTF-8")
}
