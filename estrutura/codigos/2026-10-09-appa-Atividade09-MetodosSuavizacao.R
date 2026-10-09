source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# Amostragem para viabilidade computacional, semelhante a Atividade07
set.seed(42)
if(nrow(boletins) > 10000) {
  boletins <- boletins[sample(nrow(boletins), 10000), ]
}

x <- boletins$veiculos
y <- boletins$qtd_gravidade_fatal

# Removendo NA
ok <- !is.na(x) & !is.na(y)
x <- x[ok]
y <- y[ok]

# Funções do slide 31
knn_reg <- function(x0, x, y, k) mean(y[order(abs(x - x0))[1:k]])
nw <- function(x0, x, y, h) { 
  w <- dnorm((x - x0) / h)
  if (sum(w) == 0) return(NA) # Evita divisao por zero
  sum(w * y) / sum(w) 
}
reta <- function(x0, x, y) sum(coef(lm(y ~ x)) * c(1, x0))

set.seed(1)
dobra <- sample(rep(1:5, length = length(y)))
cv_de <- function(prever) {
  mean(sapply(1:5, function(j) {
    tr <- dobra != j
    va <- dobra == j
    mean((y[va] - sapply(x[va], prever, x = x[tr], y = y[tr]))^2, na.rm = TRUE)
  }))
}

erro_reta <- cv_de(reta)
cat("Erro CV (MSE) - Reta:", erro_reta, "\n")

ks <- c(3, 5, 10, 20, 40)
ks <- ks[ks < 0.8 * length(y)]
erros_knn <- sapply(ks, function(k) cv_de(function(x0, x, y) knn_reg(x0, x, y, k)))
melhor_k <- ks[which.min(erros_knn)]
erro_knn <- min(erros_knn)
cat("Erro CV (MSE) - Melhor KNN (k =", melhor_k, "):", erro_knn, "\n")

hs <- sd(x) * c(0.05, 0.1, 0.2, 0.4, 0.8, 1.5, 3.0) 
erros_nw <- sapply(hs, function(h) cv_de(function(x0, x, y) nw(x0, x, y, h)))
melhor_h <- hs[which.min(erros_nw)]
erro_nw <- min(erros_nw, na.rm=TRUE)
cat("Erro CV (MSE) - Melhor Kernel (h =", melhor_h, "):", erro_nw, "\n")

# Salvando a figura
png("estrutura/resultados/2026-10-09-appa-09-Suavizacao.png", width=800, height=600, res=100)
g <- seq(min(x), max(x), length = 200)
plot(x, y, col = "gray60", xlab="Total de Veiculos Envolvidos", ylab="Vitimas Fatais", main="Metodos de Suavizacao - Aula 9")
lines(g, sapply(g, nw, x = x, y = y, h = melhor_h), lwd = 2, col="darkgreen")
dev.off()
