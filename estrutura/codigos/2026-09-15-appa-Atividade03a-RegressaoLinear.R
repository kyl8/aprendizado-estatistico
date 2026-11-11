source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

set.seed(20260915)
# Resposta numérica: quantidade de vítimas fatais por boletim.
# As variáveis de gravidade não entram como preditoras para evitar vazamento.
modelo <- lm(
  qtd_gravidade_fatal ~ tipo_via + turno + qtd_pedestre +
    qtd_bicicleta + qtd_motocicleta + qtd_automovel +
    qtd_onibus + qtd_caminhao ,
  data = boletins_modelo
)

resumo <- summary(modelo)
coeficientes <- data.frame(
  termo = rownames(coef(resumo)),
  coeficiente = as.numeric(coef(resumo)[, 1]),
  erro_padrao = as.numeric(coef(resumo)[, 2]),
  valor_t = as.numeric(coef(resumo)[, 3]),
  p_valor = as.numeric(coef(resumo)[, 4]),
  row.names = NULL
)

write.csv(
  coeficientes,
  "estrutura/codigos/resultados/2026-09-15-appa-03a-CoeficientesRegressaoLinear.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

metricas <- data.frame(
  registros = nrow(model.frame(modelo)),
  r2 = unname(resumo$r.squared),
  r2_ajustado = unname(resumo$adj.r.squared),
  erro_padrao_residual = unname(resumo$sigma),
  aic = AIC(modelo)
)
write.csv(metricas, "estrutura/codigos/resultados/2026-09-15-appa-03a-MetricasRegressaoLinear.csv", row.names = FALSE)

cat("\nRegressão linear concluída.\n")
print(metricas)
cat("\nCoeficientes principais:\n")
print(head(coeficientes, 10), row.names = FALSE)

# Diagnostico dos residuos (Aula 04): residuos padronizados, alavancagem e normalidade.
residuos_padronizados <- rstandard(modelo)
alavancagem_hii <- hatvalues(modelo)
diagnostico <- data.frame(
  max_alavancagem = max(alavancagem_hii),
  limite_2p_n = 2 * length(coef(modelo)) / nrow(model.frame(modelo)),
  n_alavancagem_alta = sum(alavancagem_hii > 2 * length(coef(modelo)) / nrow(model.frame(modelo))),
  n_residuos_abs_gt3 = sum(abs(residuos_padronizados) > 3),
  prop_residuos_abs_gt3 = mean(abs(residuos_padronizados) > 3),
  assimetria_residuos = mean(residuos_padronizados^3),
  curtose_residuos = mean(residuos_padronizados^4)
)
write.csv(diagnostico, "estrutura/codigos/resultados/2026-09-15-appa-03a-DiagnosticoResiduos.csv", row.names = FALSE)
png("estrutura/codigos/resultados/2026-09-15-appa-03a-DiagnosticoResiduos.png", width = 1400, height = 700, res = 120)
par(mfrow = c(1, 2))
amostra_diag <- sample(length(residuos_padronizados), min(20000, length(residuos_padronizados)))
plot(fitted(modelo)[amostra_diag], residuos_padronizados[amostra_diag], pch = 16, cex = .3,
     col = rgb(0, 0, 0, .15), xlab = "Valor ajustado", ylab = "Residuo padronizado",
     main = "Residuos x ajustados (amostra de 20 mil)")
abline(h = 0, col = "firebrick", lty = 2)
qqnorm(residuos_padronizados[amostra_diag], pch = 16, cex = .3, main = "Q-Q normal dos residuos")
qqline(residuos_padronizados[amostra_diag], col = "firebrick")
dev.off()
cat("\nDiagnostico dos residuos:\n")
print(diagnostico)
# Resposta e contagem rara (~94% de zeros): MQO e usado aqui como exercicio da aula;
# a Atividade 05b mostra o modelo adequado (Poisson).
