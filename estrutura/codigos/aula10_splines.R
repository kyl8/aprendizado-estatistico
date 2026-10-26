# R | aula10_splines.R | R 4.3+ | executar na raiz de aprendizado-estatistico.
if (.Platform$OS.type == "windows") invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8")) # Habilita a leitura dos scripts do grupo.
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", encoding = "UTF-8") # Carrega o mesmo banco APPA das outras atividades.
if (!requireNamespace("mgcv", quietly = TRUE)) stop("Instale mgcv.") # Exige o pacote de modelos aditivos.
hora <- suppressWarnings(as.numeric(substr(boletins$hora_sinistro, 1, 2)) + as.numeric(substr(boletins$hora_sinistro, 4, 5)) / 60) # Cria horario continuo para suavizacao.
d <- data.frame(y = boletins$qtd_gravidade_fatal, x = hora, x2 = log1p(boletins$veiculos), tipo_via = boletins$tipo_via) # Define resposta auxiliar de gravidade e tres preditores.
d <- d[complete.cases(d) & is.finite(d$x) & d$x >= 0 & d$x < 24, ] # Remove horarios ausentes ou invalidos.
set.seed(20261025); d <- droplevels(d[sample(nrow(d), min(12000, nrow(d))), ]) # Usa amostra reproduzivel para o laboratorio.
set.seed(1); dobra <- sample(rep(1:5, length.out = nrow(d))) # Compartilha as mesmas cinco dobras.
rmse <- function(y, p) sqrt(mean((y - p)^2)) # Mantem a unidade da resposta.
cv <- function(ajusta) { # Aplica um candidato sem consultar respostas da validacao.
  p <- numeric(nrow(d)) # Reserva todas as previsoes fora da amostra.
  for (j in 1:5) p[dobra == j] <- ajusta(d[dobra != j, ], d[dobra == j, ]) # Ajusta apenas no treino da dobra.
  stopifnot(all(is.finite(p))) # Rejeita previsoes ausentes.
  list(rmse = rmse(d$y, p), previsao = p) # Devolve metrica e evidencia.
} # Fecha a validacao comum.
resultados <- list(media = cv(function(tr, va) rep(mean(tr$y), nrow(va))), reta = cv(function(tr, va) predict(lm(y ~ x + x2 + tipo_via, tr), va)), polinomio_grau_5 = cv(function(tr, va) predict(lm(y ~ poly(x, 5) + x2 + tipo_via, tr), va))) # Define linha de base e modelos globais.
dfs <- 2:8 # Declara candidatos antes da selecao.
for (df in dfs) resultados[[paste0("spline_natural_df", df)]] <- cv(function(tr, va) predict(lm(y ~ splines::ns(x, df = df) + x2 + tipo_via, tr), va)) # Ajusta os nos somente com dados de treino.
resultados$spline_suavizacao <- cv(function(tr, va) predict(smooth.spline(tr$x, tr$y), va$x)$y) # Compara a spline univariada penalizada.
resultados$gam <- cv(function(tr, va) predict(mgcv::gam(y ~ s(x, k = 10) + s(x2, k = 5) + tipo_via, data = tr, method = "REML"), va)) # Soma duas curvas e um fator de via.
metricas <- data.frame(modelo = names(resultados), rmse_cv5 = vapply(resultados, `[[`, numeric(1), "rmse")) # Consolida os candidatos.
erros_ns <- metricas$rmse_cv5[match(paste0("spline_natural_df", dfs), metricas$modelo)] # Isola os resultados da spline natural.
melhor_df <- dfs[which.min(erros_ns)] # Escolhe a flexibilidade na validacao do laboratorio.
m_ns <- lm(y ~ splines::ns(x, df = melhor_df) + x2 + tipo_via, d) # Ajusta a curva escolhida para visualizacao.
m_poly <- lm(y ~ poly(x, 5) + x2 + tipo_via, d) # Ajusta o polinomio de comparacao.
m_gam <- mgcv::gam(y ~ s(x, k = 10) + s(x2, k = 5) + tipo_via, data = d, method = "REML") # Ajusta o GAM para examinar curvas parciais.
out <- "estrutura/resultados/aula10"; dir.create(out, recursive = TRUE, showWarnings = FALSE) # Cria a pasta de figuras do mesmo escopo da referencia.
fig <- function(nome, desenho) { png(file.path(out, nome), width = 1100, height = 750, res = 120); force(desenho); dev.off() } # Exporta graficos R completos.
g <- seq(0, 24, length.out = 250) # Define a grade do horario.
novo <- data.frame(x = g, x2 = median(d$x2), tipo_via = factor(names(sort(table(d$tipo_via), decreasing = TRUE))[1], levels = levels(d$tipo_via))) # Fixa os outros preditores.
fig("01-polinomio-vs-natural.png", { a <- predict(m_poly, novo); b <- predict(m_ns, novo); plot(g, a, type = "l", ylim = range(a, b), xlab = "Hora do sinistro", ylab = "Media de vitimas fatais prevista", col = "firebrick", lwd = 2, main = "Polinomio global e spline por trechos"); lines(g, b, col = "steelblue", lwd = 2); legend("topright", c("Polinomio grau 5", paste("Natural df", melhor_df)), col = c("firebrick", "steelblue"), lty = 1) }) # Mostra as curvas na escala da media, com os demais preditores fixos.
fig("02-ns-df-baixo-alto.png", { a <- predict(lm(y ~ splines::ns(x, df = 2) + x2 + tipo_via, d), novo); b <- predict(lm(y ~ splines::ns(x, df = 8) + x2 + tipo_via, d), novo); plot(g, a, ylim = range(a, b), type = "l", lwd = 2, col = "steelblue", xlab = "Hora do sinistro", ylab = "Media prevista", main = "Flexibilidade: poucos e muitos graus de liberdade"); lines(g, b, lwd = 2, col = "firebrick"); legend("topright", c("df = 2", "df = 8"), col = c("steelblue", "firebrick"), lty = 1) }) # Inclui toda a amplitude das duas curvas, inclusive valores negativos gaussianos.
fig("03-cv-ns-df.png", { plot(dfs, erros_ns, type = "b", pch = 16, xlab = "Graus de liberdade", ylab = "RMSE CV(5)", main = "Escolha de df nas mesmas dobras"); points(melhor_df, min(erros_ns), pch = 19, col = "firebrick", cex = 1.7) }) # Evidencia a escolha numerica.
fig("04-smooth-spline.png", { sp <- smooth.spline(d$x, d$y); plot(g, predict(sp, g)$y, type = "l", lwd = 3, col = "steelblue", xlab = "Hora do sinistro", ylab = "Media prevista", main = "Spline de suavizacao: penalidade de curvatura") }) # Mostra a spline penalizada.
fig("05-gam-curvas-parciais.png", { par(mfrow = c(1, 2)); plot(m_gam, select = 1, shade = TRUE, residuals = FALSE, xlab = "Hora do sinistro", main = "Efeito parcial do horario"); plot(m_gam, select = 2, shade = TRUE, residuals = FALSE, xlab = "log(1 + veiculos)", main = "Efeito parcial dos veiculos") }) # Nomeia os efeitos e suas bandas de incerteza.
fig("06-placar-cv.png", { par(mar = c(10, 4, 3, 1)); barplot(metricas$rmse_cv5, names.arg = metricas$modelo, las = 2, col = "steelblue", ylab = "RMSE CV(5)", main = "APPA: comparacao de candidatos") }) # Inclui a linha de base no placar.
fig("07-bs-vs-ns-pontas.png", { mg <- lm(y ~ splines::bs(x, df = 5) + x2 + tipo_via, d); mn <- lm(y ~ splines::ns(x, df = 5) + x2 + tipo_via, d); ext <- novo; ext$x <- seq(-2, 26, length.out = nrow(novo)); plot(ext$x, suppressWarnings(predict(mg, ext)), type = "l", col = "firebrick", lwd = 2, xlab = "Hora estendida apenas para diagnostico", ylab = "Media prevista", main = "Nas pontas: B-spline e spline natural"); lines(ext$x, predict(mn, ext), col = "steelblue", lwd = 2); abline(v = c(0, 24), lty = 2); legend("topright", c("B-spline", "Natural"), col = c("firebrick", "steelblue"), lty = 1) }) # Ilustra extrapolacao sem tratar horas invalidas como operacao real.
write.csv(metricas, "estrutura/resultados/2026-10-25-appa-09-MetricasSplines.csv", row.names = FALSE, fileEncoding = "UTF-8") # Atualiza o resultado principal.
write.csv(data.frame(d, dobra, lapply(resultados, `[[`, "previsao")), file.path(out, "previsoes-cv.csv"), row.names = FALSE, fileEncoding = "UTF-8") # Registra dados e previsoes da amostra.
write.csv(data.frame(n = nrow(d), melhor_df = melhor_df, y_media = mean(d$y), y_zeros = sum(d$y == 0), modelo_menor_erro = metricas$modelo[which.min(metricas$rmse_cv5)]), file.path(out, "auditoria.csv"), row.names = FALSE) # Explicita o desequilibrio da resposta auxiliar.
writeLines(capture.output(summary(m_gam)), file.path(out, "gam-resumo.txt")) # Registra graus efetivos e incerteza.
file.copy(file.path(out, "05-gam-curvas-parciais.png"), "estrutura/resultados/2026-10-25-appa-09-SplinesGAM.png", overwrite = TRUE) # Preserva o caminho historico da figura.
print(metricas) # Mostra o placar real da execucao.
