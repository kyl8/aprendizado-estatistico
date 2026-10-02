setwd("c:/Users/Arthur/Documents/IA_workspace/programacao/aprendizado-estatistico")
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R")

# Converte hora_sinistro em minutos desde 00:00
horas <- substr(boletins$hora_sinistro, 1, 2)
minutos <- substr(boletins$hora_sinistro, 4, 5)
minutos_totais <- as.numeric(horas) * 60 + as.numeric(minutos)

# Definicao de pico:
# Manha: 06:30 a 08:30 (390 a 510)
# Almoco: 11:30 a 13:30 (690 a 810)
# Noite: 17:00 a 19:30 (1020 a 1170)
eh_pico <- (minutos_totais >= 390 & minutos_totais <= 510) |
           (minutos_totais >= 690 & minutos_totais <= 810) |
           (minutos_totais >= 1020 & minutos_totais <= 1170)

boletins$pico <- factor(ifelse(eh_pico, "Pico", "Fora do Pico"))

# Seleciona preditores essenciais para o modelo inferencial
colunas_modelo <- c(
  "pico", "tipo_via", "tp_sinistro_primario", "turno",
  "dia_da_semana", "fatal", "qtd_automovel", "qtd_motocicleta",
  "qtd_onibus", "qtd_caminhao", "qtd_pedestre", "qtd_bicicleta", "veiculos"
)

dados_pico <- boletins[!is.na(boletins$pico), colunas_modelo]
dados_pico$tipo_via <- as.factor(dados_pico$tipo_via)
dados_pico$tp_sinistro_primario <- as.factor(dados_pico$tp_sinistro_primario)
dados_pico$dia_da_semana <- as.factor(dados_pico$dia_da_semana)

dir.create("estrutura/banco-de-dados", showWarnings = FALSE, recursive = TRUE)
saveRDS(dados_pico, "estrutura/banco-de-dados/sinistros_pico.rds")
write.csv(dados_pico[1:5000, ], "estrutura/banco-de-dados/sinistros_pico_amostra.csv", row.names = FALSE)

cat("Dados processados com sucesso!\n")
cat("Total de linhas:", nrow(dados_pico), "\n")
cat("Distribuicao da resposta 'pico':\n")
print(table(dados_pico$pico))
cat("Proporcao:\n")
print(prop.table(table(dados_pico$pico)))
