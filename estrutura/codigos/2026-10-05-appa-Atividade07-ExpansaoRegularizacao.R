# Aula 08: expansao de atributos e regularizacao.
# Requer glmnet: install.packages("glmnet")

if (!requireNamespace("glmnet", quietly = TRUE)) {
  stop("Instale o pacote glmnet antes de executar este script.")
}

source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")
dir.create("estrutura/resultados", showWarnings = FALSE, recursive = TRUE)

# Amostra fixa para manter a atividade reproduzivel e a CV viavel no computador local.
set.seed(20261005)
n_amostra <- min(50000L, nrow(boletins))
indice <- sample(seq_len(nrow(boletins)), n_amostra)
dados <- boletins[indice, ]

dados_modelo <- data.frame(
  y = dados$qtd_gravidade_fatal,
  log_pedestre = log1p(dados$qtd_pedestre),
  log_bicicleta = log1p(dados$qtd_bicicleta),
  log_motocicleta = log1p(dados$qtd_motocicleta),
  log_automovel = log1p(dados$qtd_automovel),
  log_onibus = log1p(dados$qtd_onibus),
  log_caminhao = log1p(dados$qtd_caminhao),
  log_veiculos = log1p(dados$veiculos),
  motocicleta_2 = log1p(dados$qtd_motocicleta)^2,
  veiculos_2 = log1p(dados$veiculos)^2,
  moto_x_pedestre = log1p(dados$qtd_motocicleta) * log1p(dados$qtd_pedestre),
  tipo_via = dados$tipo_via,
  turno = dados$turno
)

X <- model.matrix(y ~ ., data = dados_modelo)[, -1]
y <- dados_modelo$y

set.seed(20261005)
lasso <- glmnet::cv.glmnet(X, y, alpha = 1, nfolds = 5)
ridge <- glmnet::cv.glmnet(X, y, alpha = 0, nfolds = 5)
elastic <- glmnet::cv.glmnet(X, y, alpha = 0.5, nfolds = 5)

indice_min <- which.min(lasso$cvm)
indice_1se <- which.min(abs(lasso$lambda - lasso$lambda.1se))
coef_1se <- as.matrix(coef(lasso, s = "lambda.1se"))
selecionados <- data.frame(
  termo = rownames(coef_1se),
  coeficiente = as.numeric(coef_1se[, 1]),
  row.names = NULL
)
selecionados <- selecionados[selecionados$termo != "(Intercept)" & selecionados$coeficiente != 0, ]
selecionados <- selecionados[order(abs(selecionados$coeficiente), decreasing = TRUE), ]

placar <- data.frame(
  modelo = c("Ridge", "Lasso_lambda_min", "Lasso_lambda_1se", "Elastic_Net"),
  alpha = c(0, 1, 1, 0.5),
  lambda = c(ridge$lambda.min, lasso$lambda.min, lasso$lambda.1se, elastic$lambda.min),
  mse_cv = c(min(ridge$cvm), min(lasso$cvm), lasso$cvm[indice_1se], min(elastic$cvm)),
  rmse_cv = sqrt(c(min(ridge$cvm), min(lasso$cvm), lasso$cvm[indice_1se], min(elastic$cvm))),
  preditores_ativos = c(NA_integer_, lasso$nzero[indice_min], lasso$nzero[indice_1se], NA_integer_)
)

png("estrutura/resultados/2026-10-05-appa-07-CvLasso.png", width = 1100, height = 800, res = 130)
plot(lasso, main = "Lasso: erro por lambda na validacao cruzada")
abline(v = log(lasso$lambda.min), col = "#0c6170", lwd = 2)
abline(v = log(lasso$lambda.1se), col = "#c45c26", lwd = 2, lty = 2)
legend("topright", c("lambda.min", "lambda.1se"), col = c("#0c6170", "#c45c26"), lty = c(1, 2), lwd = 2, bty = "n")
dev.off()

png("estrutura/resultados/2026-10-05-appa-07-CaminhosRegularizacao.png", width = 1400, height = 700, res = 120)
par(mfrow = c(1, 2))
plot(glmnet::glmnet(X, y, alpha = 0), xvar = "lambda", main = "Ridge")
plot(glmnet::glmnet(X, y, alpha = 1), xvar = "lambda", main = "Lasso")
dev.off()

write.csv2(placar, "estrutura/resultados/2026-10-05-appa-07-ModelosRegularizados.csv", row.names = FALSE)
write.csv2(selecionados, "estrutura/resultados/2026-10-05-appa-07-VariaveisLasso.csv", row.names = FALSE)

cat("Amostra:", n_amostra, "boletins\n")
cat("Colunas do modelo:", ncol(X), "\n")
print(placar)
cat("\nVariaveis ativas no Lasso 1se:\n")
print(selecionados)
