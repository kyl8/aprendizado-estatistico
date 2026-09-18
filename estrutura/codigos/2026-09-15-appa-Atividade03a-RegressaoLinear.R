source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# Resposta numérica: quantidade de vítimas fatais por boletim.
# As variáveis de gravidade não entram como preditoras para evitar vazamento.
modelo <- lm(
  qtd_gravidade_fatal ~ tipo_via + turno + qtd_pedestre +
    qtd_bicicleta + qtd_motocicleta + qtd_automovel +
    qtd_onibus + qtd_caminhao + veiculos,
  data = boletins
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

write.csv2(
  coeficientes,
  "estrutura/resultados/2026-09-15-appa-03a-CoeficientesRegressaoLinear.csv",
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
write.csv2(metricas, "estrutura/resultados/2026-09-15-appa-03a-MetricasRegressaoLinear.csv", row.names = FALSE)

cat("\nRegressão linear concluída.\n")
print(metricas)
cat("\nCoeficientes principais:\n")
print(head(coeficientes, 10), row.names = FALSE)
