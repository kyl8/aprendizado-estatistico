# R | executar_atualizacao.R | executar na raiz do repositorio.
if (.Platform$OS.type == "windows") invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8")) # Habilita UTF-8.
source("estrutura/codigos/2026-10-25-appa-Atividades01_02.R", local = new.env(parent = globalenv()), encoding = "UTF-8") # Reexecuta a etapa com os dados proprios.
source("estrutura/codigo/entrega1_duas_perguntas.R", local = new.env(parent = globalenv()), encoding = "UTF-8") # Reexecuta a etapa com os dados proprios.
source("estrutura/codigo/aula05b_poisson.R", local = new.env(parent = globalenv()), encoding = "UTF-8") # Reexecuta a etapa com os dados proprios.
source("estrutura/codigos/aula10_splines.R", local = new.env(parent = globalenv()), encoding = "UTF-8") # Reexecuta a etapa com os dados proprios.
