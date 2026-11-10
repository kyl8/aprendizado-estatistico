# Leitura comum da base usada nas atividades de modelagem.
if (.Platform$OS.type == "windows") invisible(Sys.setlocale("LC_CTYPE", "English_United States.utf8"))

# Execute sempre a partir da raiz do repositorio.
arquivo_base <- file.path("estrutura", "corpus", "2026-08-12-appa-Sinistros_2025_2026.csv")
stopifnot(file.exists(arquivo_base))

# A fonte e Latin-1: a conversao na conexao preserva as 50 colunas e os acentos.
# Tres linhas (logradouro) trazem ";" dentro de campo entre aspas; por isso as aspas
# duplas precisam ser respeitadas (quote = "\""). Com quote = "" essas linhas
# desalinhavam as colunas e geravam um registro fantasma (273.372 em vez de 273.371).
dados <- read.csv2(
  arquivo_base,
  fileEncoding = "latin1",
  stringsAsFactors = FALSE,
  na.strings = c("", "NA"),
  quote = "\"",
  comment.char = ""
)
stopifnot(ncol(dados) == 50, !anyNA(dados$tipo_registro))

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

# Convencao do Infosiga: campo de quantidade em branco = nenhum envolvido (0).
# (qtd_gravidade_fatal fica em branco exatamente nos boletins nao fatais.)
for (coluna in colunas_qtd) {
  boletins[[coluna]] <- as.numeric(boletins[[coluna]])
  boletins[[coluna]][is.na(boletins[[coluna]])] <- 0
}

boletins$tipo_via <- factor(boletins$tipo_via)
boletins$turno <- factor(boletins$turno)
boletins$regiao_administrativa <- factor(boletins$regiao_administrativa)

# veiculos = motocicleta + automovel + onibus + caminhao + outros.
# Nao inclui bicicleta, pedestre nem qtd_veic_nao_disponivel (decisao do grupo).
boletins$veiculos <- with(
  boletins,
  qtd_motocicleta + qtd_automovel + qtd_onibus +
    qtd_caminhao + qtd_veic_outros
)

# Recorte para os modelos: tipo_via/turno = "NAO DISPONIVEL" quase so ocorrem em boletins
# fatais (445 de 447 em tipo_via), ou seja, sao artefato de registro e vazam a resposta.
boletins_modelo <- boletins[boletins$tipo_via != "NAO DISPONIVEL" & boletins$turno != "NAO DISPONIVEL", ]
boletins_modelo$tipo_via <- droplevels(boletins_modelo$tipo_via)
boletins_modelo$turno <- droplevels(boletins_modelo$turno)

cat("Registros totais:", nrow(dados), "\n")
cat("Boletins analisados:", nrow(boletins), "\n")
cat("Fatais:", sum(boletins$fatal), "\n")
cat("Boletins para modelagem (sem NAO DISPONIVEL):", nrow(boletins_modelo), "\n")

# Persistencia da base tratada (ignorada pelo git)
dir.create(file.path("estrutura", "resultados"), showWarnings = FALSE, recursive = TRUE)
saveRDS(boletins, file = 'estrutura/resultados/sinistros_prontos.rds')
