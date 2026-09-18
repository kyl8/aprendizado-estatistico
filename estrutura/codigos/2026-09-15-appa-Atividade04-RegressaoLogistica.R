source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# A resposta Ã© fatal ou nÃ£o fatal dentro dos boletins policiais.
# VariÃ¡veis que jÃ¡ descrevem a gravidade ficam fora dos preditores.
set.seed(20260915)
indices_treino <- sample(seq_len(nrow(boletins)), size = floor(0.8 * nrow(boletins)))
treino <- boletins[indices_treino, ]
teste <- boletins[-indices_treino, ]

modelo <- glm(
  fatal ~ tipo_via + turno + qtd_pedestre + qtd_bicicleta +
    qtd_motocicleta + qtd_automovel + qtd_onibus +
    qtd_caminhao + veiculos,
  data = treino,
  family = binomial()
)

probabilidades <- predict(modelo, newdata = teste, type = "response")
classe_prevista <- as.integer(probabilidades >= 0.5)
classe_observada <- teste$fatal

ordem <- order(probabilidades)
postos <- rank(probabilidades, ties.method = "average")
n_positivos <- sum(classe_observada == 1)
n_negativos <- sum(classe_observada == 0)
auc <- (sum(postos[classe_observada == 1]) - n_positivos * (n_positivos + 1) / 2) /
  (n_positivos * n_negativos)

matriz <- table(
  observado = classe_observada,
  previsto = classe_prevista,
  dnn = c("observado", "previsto")
)

tn <- ifelse(!is.na(matriz["0", "0"]), matriz["0", "0"], 0)
fp <- ifelse(!is.na(matriz["0", "1"]), matriz["0", "1"], 0)
fn <- ifelse(!is.na(matriz["1", "0"]), matriz["1", "0"], 0)
tp <- ifelse(!is.na(matriz["1", "1"]), matriz["1", "1"], 0)

metricas <- data.frame(
  registros_treino = nrow(treino),
  registros_teste = nrow(teste),
  acuracia = (tp + tn) / sum(matriz),
  sensibilidade = ifelse(tp + fn > 0, tp / (tp + fn), NA),
  especificidade = ifelse(tn + fp > 0, tn / (tn + fp), NA),
  precisao = ifelse(tp + fp > 0, tp / (tp + fp), NA),
  auc = auc
)

coeficientes <- data.frame(
  termo = rownames(coef(summary(modelo))),
  coeficiente = coef(modelo),
  razao_chances = exp(coef(modelo)),
  p_valor = coef(summary(modelo))[, 4],
  row.names = NULL
)

write.csv2(metricas, "estrutura/resultados/2026-09-15-appa-04-MetricasRegressaoLogistica.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv2(coeficientes, "estrutura/resultados/2026-09-15-appa-04-CoeficientesRegressaoLogistica.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv2(as.data.frame.matrix(matriz), "estrutura/resultados/2026-09-15-appa-04-MatrizConfusao.csv", fileEncoding = "UTF-8")

cat("\nRegressÃ£o logÃ­stica concluÃ­da.\n")
print(metricas)
print(matriz)


