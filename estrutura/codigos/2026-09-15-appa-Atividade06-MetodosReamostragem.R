source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# Validação cruzada para os mesmos candidatos da Atividade 05.
set.seed(20260915)
k <- 5
dobras <- sample(rep(seq_len(k), length.out = nrow(boletins)))

formulas <- list(
  m1_tipo_via_turno = qtd_gravidade_fatal ~ tipo_via + turno,
  m2_veiculos = qtd_gravidade_fatal ~ tipo_via + turno + qtd_pedestre +
    qtd_motocicleta + qtd_automovel + qtd_onibus + qtd_caminhao,
  m3_interacoes = qtd_gravidade_fatal ~ tipo_via * turno + qtd_pedestre +
    qtd_motocicleta + qtd_automovel + qtd_onibus + qtd_caminhao + veiculos
)

cv_lm <- function(formula) {
  erros <- sapply(seq_len(k), function(dobra) {
    treino <- boletins[dobras != dobra, ]
    validacao <- boletins[dobras == dobra, ]
    modelo <- lm(formula, data = treino)
    mean((validacao$qtd_gravidade_fatal - predict(modelo, validacao))^2)
  })
  c(mse_cv5 = mean(erros), rmse_cv5 = sqrt(mean(erros)))
}

cv_resultados <- as.data.frame(do.call(rbind, lapply(formulas, cv_lm)))
cv_resultados$modelo <- rownames(cv_resultados)
rownames(cv_resultados) <- NULL
cv_resultados <- cv_resultados[, c("modelo", "mse_cv5", "rmse_cv5")]

# Bootstrap do coeficiente de motocicletas no modelo com veículos.
modelo_base <- lm(formulas$m2_veiculos, data = boletins)
coef_observado <- coef(modelo_base)[["qtd_motocicleta"]]
set.seed(20260915)
B <- 300
coef_bootstrap <- replicate(B, {
  indices <- sample.int(nrow(boletins), nrow(boletins), replace = TRUE)
  coef(lm(formulas$m2_veiculos, data = boletins[indices, ]))[["qtd_motocicleta"]]
})
intervalo <- quantile(coef_bootstrap, c(0.025, 0.975), na.rm = TRUE)

bootstrap_resultados <- data.frame(
  coeficiente_observado = coef_observado,
  erro_padrao_bootstrap = sd(coef_bootstrap, na.rm = TRUE),
  ic_95_inferior = intervalo[[1]],
  ic_95_superior = intervalo[[2]],
  replicacoes = B
)

write.csv2(cv_resultados, "estrutura/resultados/2026-09-15-appa-06-ValidacaoCruzada.csv", row.names = FALSE)
write.csv2(bootstrap_resultados, "estrutura/resultados/2026-09-15-appa-06-BootstrapMotocicleta.csv", row.names = FALSE)
write.csv2(data.frame(coeficiente = coef_bootstrap), "estrutura/resultados/2026-09-15-appa-06-CoeficientesBootstrap.csv", row.names = FALSE)

cat("\nValidação cruzada:\n")
print(cv_resultados)
cat("\nBootstrap do coeficiente de motocicletas:\n")
print(bootstrap_resultados)
