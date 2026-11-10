source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# Aula 09: reta, KNN e kernel (Nadaraya-Watson) com um unico preditor.
# Amostra para viabilidade computacional (sem sobrescrever `boletins`).
set.seed(42)
amostra <- boletins_modelo[sample(nrow(boletins_modelo), min(10000, nrow(boletins_modelo))), ]
x <- amostra$veiculos
y <- amostra$qtd_gravidade_fatal
ok <- !is.na(x) & !is.na(y)
x <- x[ok]; y <- y[ok]

knn_reg <- function(x0, x, y, k) {
  # veiculos e inteiro: ha muitos empates; todos os vizinhos empatados na distancia
  # do k-esimo entram na media (nada de desempate arbitrario por indice).
  d <- abs(x - x0)
  limite <- sort(d)[k]
  mean(y[d <= limite])
}
nw <- function(x0, x, y, h) {
  w <- dnorm((x - x0) / h)
  if (sum(w) == 0) return(NA_real_)
  sum(w * y) / sum(w)
}
reta <- function(x0, x, y) sum(coef(lm(y ~ x)) * c(1, x0))

set.seed(1)
dobra <- sample(rep(1:5, length = length(y)))
# CV que devolve NA se QUALQUER ponto de validacao ficar sem previsao; assim todos os
# hiperparametros sao comparados no mesmo conjunto de pontos.
cv_de <- function(prever) {
  mean(sapply(1:5, function(j) {
    tr <- dobra != j; va <- dobra == j
    p <- sapply(x[va], prever, x = x[tr], y = y[tr])
    mean((y[va] - p)^2)
  }))
}

erro_media <- mean(sapply(1:5, function(j) mean((y[dobra == j] - mean(y[dobra != j]))^2)))
erro_reta <- cv_de(reta)

ks <- c(3, 5, 10, 20, 40, 80, 160)
erros_knn <- sapply(ks, function(k) cv_de(function(x0, x, y) knn_reg(x0, x, y, k)))
melhor_k <- ks[which.min(erros_knn)]

hs <- sd(x) * c(0.05, 0.1, 0.2, 0.4, 0.8, 1.5, 3.0)
erros_nw <- sapply(hs, function(h) cv_de(function(x0, x, y) nw(x0, x, y, h)))
validos <- !is.na(erros_nw)
melhor_h <- hs[validos][which.min(erros_nw[validos])]

placar <- data.frame(
  metodo = c("media", "reta", paste0("knn_k", ks), paste0("kernel_h", round(hs, 3))),
  mse_cv5 = c(erro_media, erro_reta, erros_knn, erros_nw)
)
placar$rmse_cv5 <- sqrt(placar$mse_cv5)
resumo <- data.frame(
  n = length(y), pontos_x_distintos = length(unique(x)),
  mse_media = erro_media, mse_reta = erro_reta,
  melhor_k = melhor_k, mse_knn = min(erros_knn),
  melhor_h = melhor_h, mse_kernel = min(erros_nw, na.rm = TRUE)
)
write.csv2(placar, "estrutura/resultados/2026-10-09-appa-08-PlacarSuavizacao.csv", row.names = FALSE)
write.csv2(resumo, "estrutura/resultados/2026-10-09-appa-08-ResumoSuavizacao.csv", row.names = FALSE)

cat("MSE CV - media:", erro_media, "\n")
cat("MSE CV - Reta:", erro_reta, "\n")
cat("MSE CV - Melhor KNN (k =", melhor_k, "):", min(erros_knn), "\n")
cat("MSE CV - Melhor Kernel (h =", melhor_h, "):", min(erros_nw, na.rm = TRUE), "\n")

png("estrutura/resultados/2026-10-09-appa-08-Suavizacao.png", width = 800, height = 600, res = 100)
g <- seq(min(x), max(x), length = 200)
plot(jitter(x), jitter(y, amount = .05), col = rgb(.4, .4, .4, .3), pch = 16, cex = .5,
     xlab = "Total de veiculos envolvidos", ylab = "Vitimas fatais",
     main = "Metodos de suavizacao - Aula 9")
lines(g, sapply(g, reta, x = x, y = y), lwd = 2, col = "firebrick")
lines(g, sapply(g, function(a) knn_reg(a, x, y, melhor_k)), lwd = 2, col = "steelblue")
lines(g, sapply(g, nw, x = x, y = y, h = melhor_h), lwd = 2, col = "darkgreen")
legend("topright", c("Reta", paste("KNN k =", melhor_k), paste("Kernel h =", round(melhor_h, 3))),
       col = c("firebrick", "steelblue", "darkgreen"), lwd = 2, bty = "n")
dev.off()
