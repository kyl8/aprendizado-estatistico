source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

set.seed(20260915)
indices_treino <- sample(seq_len(nrow(boletins)), size = floor(0.8 * nrow(boletins)))
treino <- boletins[indices_treino, ]
teste <- boletins[-indices_treino, ]

modelo <- lm(
  qtd_gravidade_fatal ~ tipo_via + turno + qtd_pedestre +
    qtd_bicicleta + qtd_motocicleta + qtd_automovel +
    qtd_onibus + qtd_caminhao + veiculos,
  data = treino
)

previsoes <- predict(modelo, newdata = teste)
erros <- teste$qtd_gravidade_fatal - previsoes
metricas <- data.frame(
  treino = nrow(treino),
  teste = nrow(teste),
  mae = mean(abs(erros)),
  rmse = sqrt(mean(erros^2)),
  r2_teste = 1 - sum(erros^2) / sum((teste$qtd_gravidade_fatal - mean(treino$qtd_gravidade_fatal))^2)
)

amostra <- data.frame(
  observado = teste$qtd_gravidade_fatal,
  previsto = pmax(0, previsoes),
  erro = erros
)

write.csv2(metricas, "estrutura/resultados/2026-09-15-appa-03b-MetricasPrevisao.csv", row.names = FALSE)
write.csv2(amostra, "estrutura/resultados/2026-09-15-appa-03b-Previsoes.csv", row.names = FALSE)

cat("\nPrevisão concluída.\n")
print(metricas)
