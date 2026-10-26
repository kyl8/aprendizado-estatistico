# R | entrega1_duas_perguntas.R | executar na raiz de aprendizado-estatistico.
if (.Platform$OS.type == "windows") invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8")) # Habilita as fontes UTF-8.
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", encoding = "UTF-8") # Carrega os boletins reais.
hh <- suppressWarnings(as.numeric(substr(boletins$hora_sinistro, 1, 2))); mm <- suppressWarnings(as.numeric(substr(boletins$hora_sinistro, 4, 5))) # Valida a construcao do horario.
minutos <- 60 * hh + mm # Calcula minutos desde a meia-noite.
ok <- !is.na(hh) & hh >= 0 & hh <= 23 & !is.na(mm) & mm >= 0 & mm <= 59 # Exclui horarios invalidos.
y <- as.integer((minutos >= 390 & minutos <= 510) | (minutos >= 690 & minutos <= 810) | (minutos >= 1020 & minutos <= 1170)) # Aplica a definicao original de pico.
d <- data.frame(y = y, tipo_via = boletins$tipo_via, dia = factor(boletins$dia_da_semana), regiao = boletins$regiao_administrativa) # Exclui hora e turno para nao dar a resposta ao modelo.
d <- droplevels(d[ok & complete.cases(d), ]) # Usa somente linhas completas para a ficha candidata.
set.seed(1); dobra <- sample(rep(1:5, length.out = nrow(d))) # Declara uma unica particao.
p <- pb <- numeric(nrow(d)) # Reserva probabilidades e linha de base.
for (j in 1:5) { # Ajusta e valida cinco vezes.
  tr <- d[dobra != j, ]; va <- d[dobra == j, ] # Separa respostas de treino e validacao.
  p[dobra == j] <- predict(glm(y ~ tipo_via + dia + regiao, family = binomial, data = tr), va, type = "response") # Ajusta apenas fatores conhecidos antes da janela.
  pb[dobra == j] <- mean(tr$y) # Aprende a frequencia de pico apenas no treino.
} # Conclui a validacao da candidata A.
auc <- function(y, p) { n1 <- as.double(sum(y == 1)); n0 <- as.double(sum(y == 0)); (sum(rank(p)[y == 1]) - n1 * (n1 + 1) / 2) / (n1 * n0) } # Usa double para evitar overflow com mais de cem mil boletins.
met <- data.frame(modelo = c("media_probabilidade", "glm_logistica"), Brier = c(mean((d$y - pb)^2), mean((d$y - p)^2)), AUC = c(auc(d$y, pb), auc(d$y, p)), acuracia = c(mean((pb >= .5) == d$y), mean((p >= .5) == d$y))) # Compara desempenho com a mesma metrica de probabilidade.
out <- "estrutura/resultados/entrega1"; dir.create(out, recursive = TRUE, showWarnings = FALSE) # Cria a pasta das evidencias da oficina.
write.csv(met, file.path(out, "candidataA-classificacao-cv5.csv"), row.names = FALSE, fileEncoding = "UTF-8") # Salva o placar real da primeira candidata.
write.csv(data.frame(n = nrow(d), p_colunas = 3, parametros_glm = length(coef(glm(y ~ tipo_via + dia + regiao, family = binomial, data = d))), pico = sum(d$y == 1), fora_pico = sum(d$y == 0), acuracia_classe_majoritaria = max(table(d$y)) / nrow(d), campos_ausentes = sum(is.na(d))), file.path(out, "diagnostico-candidataA.csv"), row.names = FALSE) # Resume tamanho, parametros, balanco e ausencias.
write.csv(data.frame(variavel = names(boletins), ausentes = colSums(is.na(boletins))), file.path(out, "faltantes-banco.csv"), row.names = FALSE, fileEncoding = "UTF-8") # Executa o diagnostico de completude antes de selecionar preditores.
write.csv(data.frame(d, dobra, probabilidade_base = pb, probabilidade_glm = p), file.path(out, "candidataA-previsoes-cv5.csv"), row.names = FALSE, fileEncoding = "UTF-8") # Guarda evidencia para recalcular as metricas.
stopifnot(all(is.finite(p)), all(p >= 0 & p <= 1)) # Confere o dominio das probabilidades.
stopifnot(all(is.finite(met$AUC)), all(met$AUC >= 0 & met$AUC <= 1)) # Confere a metrica no banco completo.
cat("Candidata A: pico sem hora ou turno nos preditores.\n"); print(met) # Mostra resultados sem confundir unidades entre perguntas.
