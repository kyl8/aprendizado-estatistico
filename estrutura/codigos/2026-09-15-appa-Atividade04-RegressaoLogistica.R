source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# A resposta é fatal ou não fatal dentro dos boletins policiais.
# Variáveis que já descrevem a gravidade ficam fora dos preditores.
# tipo_via/turno = "NAO DISPONIVEL" ficam fora (boletins_modelo): quase só ocorrem em fatais.
set.seed(20260915)
indices_treino <- sample(seq_len(nrow(boletins_modelo)), size = floor(0.8 * nrow(boletins_modelo)))
treino <- boletins_modelo[indices_treino, ]
teste <- boletins_modelo[-indices_treino, ]

modelo <- glm(
  fatal ~ tipo_via + turno + qtd_pedestre + qtd_bicicleta +
    qtd_motocicleta + qtd_automovel + qtd_onibus +
    qtd_caminhao,
  data = treino,
  family = binomial()
)

probabilidades <- predict(modelo, newdata = teste, type = "response")
classe_observada <- teste$fatal

# AUC pela estatística de Mann-Whitney (em double para evitar overflow).
postos <- rank(probabilidades, ties.method = "average")
n_positivos <- as.double(sum(classe_observada == 1))
n_negativos <- as.double(sum(classe_observada == 0))
auc <- (sum(postos[classe_observada == 1]) - n_positivos * (n_positivos + 1) / 2) /
  (n_positivos * n_negativos)

metricas_corte <- function(corte) {
  prevista <- factor(as.integer(probabilidades >= corte), levels = c(0, 1))
  m <- table(observado = factor(classe_observada, levels = c(0, 1)), previsto = prevista)
  tn <- m["0", "0"]; fp <- m["0", "1"]; fn <- m["1", "0"]; tp <- m["1", "1"]
  data.frame(
    corte = corte,
    acuracia = (tp + tn) / sum(m),
    sensibilidade = ifelse(tp + fn > 0, tp / (tp + fn), NA),
    especificidade = ifelse(tn + fp > 0, tn / (tn + fp), NA),
    precisao = ifelse(tp + fp > 0, tp / (tp + fp), NA),
    f1 = ifelse(2 * tp + fp + fn > 0, 2 * tp / (2 * tp + fp + fn), NA),
    tn = tn, fp = fp, fn = fn, tp = tp
  )
}

# Corte 0,5 (padrão) e varredura de cortes; o corte do F1 máximo vem do TREINO,
# para não escolher o limiar olhando o conjunto de teste.
cortes <- seq(0.02, 0.6, by = 0.01)
prob_treino <- predict(modelo, newdata = treino, type = "response")
f1_treino <- sapply(cortes, function(c) {
  p <- prob_treino >= c; y <- treino$fatal
  tp <- sum(p & y == 1); fp <- sum(p & y == 0); fn <- sum(!p & y == 1)
  ifelse(2 * tp + fp + fn > 0, 2 * tp / (2 * tp + fp + fn), 0)
})
corte_otimo <- cortes[which.max(f1_treino)]

matriz_05 <- metricas_corte(0.5)
matriz_otimo <- metricas_corte(corte_otimo)
prop_majoritaria <- max(table(classe_observada)) / length(classe_observada)

metricas <- data.frame(
  registros_treino = nrow(treino),
  registros_teste = nrow(teste),
  acuracia_classe_majoritaria = prop_majoritaria,
  acuracia = matriz_05$acuracia,
  sensibilidade = matriz_05$sensibilidade,
  especificidade = matriz_05$especificidade,
  precisao = matriz_05$precisao,
  auc = auc,
  corte_f1_treino = corte_otimo,
  sensibilidade_corte_f1 = matriz_otimo$sensibilidade,
  especificidade_corte_f1 = matriz_otimo$especificidade,
  precisao_corte_f1 = matriz_otimo$precisao,
  acuracia_corte_f1 = matriz_otimo$acuracia
)

matriz <- as.data.frame.matrix(table(
  observado = factor(classe_observada, levels = c(0, 1)),
  previsto = factor(as.integer(probabilidades >= 0.5), levels = c(0, 1))
))

resumo <- coef(summary(modelo))
coeficientes <- data.frame(
  termo = rownames(resumo),
  coeficiente = resumo[, 1],
  razao_chances = exp(resumo[, 1]),
  p_valor = resumo[, 4],
  row.names = NULL
)

write.csv2(metricas, "estrutura/resultados/2026-09-15-appa-04-MetricasRegressaoLogistica.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv2(coeficientes, "estrutura/resultados/2026-09-15-appa-04-CoeficientesRegressaoLogistica.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv2(matriz, "estrutura/resultados/2026-09-15-appa-04-MatrizConfusao.csv", fileEncoding = "UTF-8")

cat("\nRegressão logística concluída.\n")
print(metricas)
print(matriz)
