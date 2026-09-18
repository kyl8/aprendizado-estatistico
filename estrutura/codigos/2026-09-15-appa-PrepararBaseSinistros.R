# Leitura comum da base usada nas atividades de modelagem.

arquivo_base <- file.path("estrutura", "corpus", "2026-08-12-appa-Sinistros_2025_2026.csv")
if (!file.exists(arquivo_base)) {
  arquivo_base <- file.path("..", "corpus", "2026-08-12-appa-Sinistros_2025_2026.csv")
}

# A base possui alguns bytes fora do UTF-8. Ler as linhas como latin1
# permite preservar a estrutura das 50 colunas sem interromper a leitura.
linhas_base <- readLines(arquivo_base, encoding = "latin1", warn = FALSE)
linhas_base <- linhas_base[nzchar(trimws(linhas_base))]
dados <- read.csv2(
  textConnection(linhas_base),
  stringsAsFactors = FALSE,
  na.strings = c("", "NA"),
  fill = TRUE,
  quote = "",
  comment.char = ""
)

boletins <- dados[dados$tipo_registro %in% c("SINISTRO FATAL", "SINISTRO NAO FATAL"), ]
boletins$fatal <- as.integer(boletins$tipo_registro == "SINISTRO FATAL")

colunas_qtd <- c(
  "qtd_pedestre", "qtd_bicicleta", "qtd_motocicleta",
  "qtd_automovel", "qtd_onibus", "qtd_caminhao",
  "qtd_veic_outros", "qtd_veic_nao_disponivel",
  "qtd_gravidade_fatal", "qtd_gravidade_grave",
  "qtd_gravidade_leve", "qtd_gravidade_ileso",
  "qtd_gravidade_nao_disponivel"
)

for (coluna in colunas_qtd) {
  boletins[[coluna]] <- as.numeric(boletins[[coluna]])
  boletins[[coluna]][is.na(boletins[[coluna]])] <- 0
}

boletins$tipo_via <- factor(boletins$tipo_via)
boletins$turno <- factor(boletins$turno)
boletins$regiao_administrativa <- factor(boletins$regiao_administrativa)

boletins$veiculos <- with(
  boletins,
  qtd_motocicleta + qtd_automovel + qtd_onibus +
    qtd_caminhao + qtd_veic_outros
)

dir.create(file.path("estrutura", "resultados"), showWarnings = FALSE, recursive = TRUE)

cat("Registros totais:", nrow(dados), "\n")
cat("Boletins analisados:", nrow(boletins), "\n")
cat("Fatais:", sum(boletins$fatal), "\n")
