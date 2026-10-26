# Leitura comum da base usada nas atividades de modelagem.
if (.Platform$OS.type == "windows") invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8"))

arquivo_base <- file.path("estrutura", "corpus", "2026-08-12-appa-Sinistros_2025_2026.csv")
if (!file.exists(arquivo_base)) {
  arquivo_base <- file.path("..", "corpus", "2026-08-12-appa-Sinistros_2025_2026.csv")
}

# A fonte e Latin-1: a conversao na conexao preserva as 50 colunas e os acentos.
# Evita perder a marcacao do encoding ao passar por uma conexao de texto.
dados <- read.csv2(
  arquivo_base,
  fileEncoding = "latin1",
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

# Persistência da base tratada exigida pelos scripts subsequentes
dir.create('estrutura/resultados', showWarnings = FALSE, recursive = TRUE)
saveRDS(boletins, file = 'estrutura/resultados/sinistros_prontos.rds')
