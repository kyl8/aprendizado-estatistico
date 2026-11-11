source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# Treino / validação / teste (60/20/20): o modelo é ESCOLHIDO na validação
# e o erro de teste é reportado uma única vez, só para o modelo escolhido.
set.seed(20260915)
n <- nrow(boletins_modelo)
grupo <- sample(c("treino", "validacao", "teste"), n, replace = TRUE, prob = c(0.6, 0.2, 0.2))
treino <- boletins_modelo[grupo == "treino", ]
validacao <- boletins_modelo[grupo == "validacao", ]
teste <- boletins_modelo[grupo == "teste", ]

# Três candidatos com complexidade crescente (mesmos preditores das Atividades 03 e 04).
f1 <- qtd_gravidade_fatal ~ tipo_via + turno
f2 <- qtd_gravidade_fatal ~ tipo_via + turno + qtd_pedestre + qtd_bicicleta +
  qtd_motocicleta + qtd_automovel + qtd_onibus + qtd_caminhao
f3 <- qtd_gravidade_fatal ~ tipo_via * turno + qtd_pedestre + qtd_bicicleta +
  qtd_motocicleta + qtd_automovel + qtd_onibus + qtd_caminhao
m1 <- lm(f1, data = treino); m2 <- lm(f2, data = treino); m3 <- lm(f3, data = treino)

erros <- function(modelo, dados) {
  e <- dados$qtd_gravidade_fatal - predict(modelo, dados)
  c(rmse = sqrt(mean(e^2)), mae = mean(abs(e)),
    r2 = 1 - sum(e^2) / sum((dados$qtd_gravidade_fatal - mean(dados$qtd_gravidade_fatal))^2))
}
modelos <- list(m1_tipo_via_turno = m1, m2_veiculos = m2, m3_interacoes = m3)
avaliacoes <- do.call(rbind, lapply(names(modelos), function(nome) {
  tr <- erros(modelos[[nome]], treino); va <- erros(modelos[[nome]], validacao)
  data.frame(modelo = nome, rmse_treino = tr[["rmse"]], rmse_validacao = va[["rmse"]],
             mae_validacao = va[["mae"]], r2_validacao = va[["r2"]])
}))
vencedor <- avaliacoes$modelo[which.min(avaliacoes$rmse_validacao)]
avaliacoes$vencedor <- avaliacoes$modelo == vencedor

# Erro de teste: apenas para o modelo escolhido na validação.
te <- erros(modelos[[vencedor]], teste)
final <- data.frame(modelo_escolhido = vencedor, treino = nrow(treino), validacao = nrow(validacao),
                    teste = nrow(teste), rmse_teste = te[["rmse"]], mae_teste = te[["mae"]], r2_teste = te[["r2"]])

write.csv2(avaliacoes, "estrutura/codigos/resultados/2026-09-15-appa-05-AvaliacoesModelos.csv", row.names = FALSE)
write.csv2(final, "estrutura/codigos/resultados/2026-09-15-appa-05-ModeloEscolhido.csv", row.names = FALSE)

cat("Modelo escolhido na validação:", vencedor, "\n")
print(avaliacoes)
print(final)
