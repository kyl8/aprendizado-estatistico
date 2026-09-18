source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

set.seed(20260915)
indices_treino <- sample(seq_len(nrow(boletins)), size = floor(0.7 * nrow(boletins)))
treino <- boletins[indices_treino, ]
teste <- boletins[-indices_treino, ]

# Três candidatos com complexidade crescente.
m1 <- lm(qtd_gravidade_fatal ~ tipo_via + turno, data = treino)
m2 <- lm(qtd_gravidade_fatal ~ tipo_via + turno + qtd_pedestre +
           qtd_motocicleta + qtd_automovel + qtd_onibus + qtd_caminhao,
         data = treino)
m3 <- lm(qtd_gravidade_fatal ~ tipo_via * turno + qtd_pedestre +
           qtd_motocicleta + qtd_automovel + qtd_onibus + qtd_caminhao + veiculos,
         data = treino)

avaliar <- function(modelo, nome) {
  previsto_treino <- predict(modelo, treino)
  previsto_teste <- predict(modelo, teste)
  erro <- teste$qtd_gravidade_fatal - previsto_teste
  data.frame(
    modelo = nome,
    rmse_treino = sqrt(mean((treino$qtd_gravidade_fatal - previsto_treino)^2)),
    rmse_teste = sqrt(mean(erro^2)),
    mae_teste = mean(abs(erro)),
    r2_teste = 1 - sum(erro^2) / sum((teste$qtd_gravidade_fatal - mean(treino$qtd_gravidade_fatal))^2)
  )
}

avaliacoes <- rbind(
  avaliar(m1, "m1_tipo_via_turno"),
  avaliar(m2, "m2_veiculos"),
  avaliar(m3, "m3_interacoes")
)
vencedor <- avaliacoes$modelo[which.min(avaliacoes$rmse_teste)]
avaliacoes$vencedor <- avaliacoes$modelo == vencedor

write.csv2(avaliacoes, "estrutura/resultados/2026-09-15-appa-05-AvaliacoesModelos.csv", row.names = FALSE)
write.csv2(data.frame(modelo_escolhido = vencedor, treino = nrow(treino), teste = nrow(teste)),
           "estrutura/resultados/2026-09-15-appa-05-ModeloEscolhido.csv", row.names = FALSE)

cat("Modelo escolhido:", vencedor, "\n")
print(avaliacoes)
