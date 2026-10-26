# R | aula05b_poisson.R | R 4.3+ | executar na raiz de aprendizado-estatistico.
if (.Platform$OS.type == "windows") Sys.setlocale("LC_CTYPE", "English_United States.utf8") # Habilita UTF-8 no Windows.
dir.create("estrutura/resultados", recursive = TRUE, showWarnings = FALSE) # Cria a pasta das evidencias.
prefixo <- "estrutura/resultados/2026-10-25-appa-05b-" # Centraliza os nomes das saidas.
salvar <- function(x, nome) write.csv(x, paste0(prefixo, nome, ".csv"), row.names = FALSE, fileEncoding = "UTF-8") # Exporta tabelas sem indice.
rmse <- function(y, p) sqrt(mean((y - p)^2)) # Mede erro na unidade da resposta.
set.seed(2026); n <- 200 # Reproduz exatamente a primeira celula do guia.
anuncios <- data.frame(dist = round(runif(n, 0.1, 5), 1), fotos = sample(2:20, n, replace = TRUE)) # Cria os anuncios.
lambda <- exp(1.6 - 0.5 * anuncios$dist + 0.06 * anuncios$fotos) # Guarda a verdade simulada.
anuncios$visitas <- rpois(n, lambda) # Sorteia visitas em trinta dias.
set.seed(11) # Reproduz a sobredispersao do modulo cinco.
anuncios$visitas_od <- rpois(n, lambda * rgamma(n, shape = 2, rate = 2)) # Mistura taxas para aumentar a variancia.
set.seed(7) # Reproduz o exemplo de exposicao variavel.
an2 <- data.frame(dist = round(runif(n, 0.1, 5), 1), fotos = sample(2:20, n, replace = TRUE)) # Cria outros anuncios.
an2$dias <- round(runif(n, 5, 15) + 9 * an2$dist) # Define tempo no ar correlacionado a distancia.
an2$visitas <- rpois(n, an2$dias * exp(-1.8 - 0.5 * an2$dist + 0.06 * an2$fotos)) # Sorteia a contagem no periodo.
somas <- c(sum(anuncios$visitas), sum(anuncios$visitas_od), sum(an2$visitas)) # Confere o gerador do guia.
stopifnot(identical(as.numeric(somas), c(836, 775, 550))) # Impede resultados de uma base diferente.
m <- glm(visitas ~ dist + fotos, family = poisson, data = anuncios) # Ajusta o modulo tres.
sem <- glm(visitas ~ dist + fotos, family = poisson, data = an2) # Ignora exposicao para comparacao.
com <- glm(visitas ~ dist + fotos + offset(log(dias)), family = poisson, data = an2) # Corrige o tempo de observacao.
mp <- glm(visitas_od ~ dist + fotos, family = poisson, data = anuncios) # Ajusta contagens sobredispersas.
mq <- glm(visitas_od ~ dist + fotos, family = quasipoisson, data = anuncios) # Corrige apenas a incerteza.
phi_teoria <- sum(residuals(mp, type = "pearson")^2) / df.residual(mp) # Calcula dispersao de Pearson.
stopifnot(max(abs(coef(mp) - coef(mq))) < 1e-8) # Confere igualdade de coeficientes.
set.seed(1); dobra <- sample(rep(1:5, length = n)) # Usa as mesmas dobras prescritas na teoria.
pred_teoria <- matrix(NA_real_, n, 3, dimnames = list(NULL, c("media", "mqo", "poisson"))) # Guarda previsoes fora da amostra.
for (j in 1:5) { # Percorre as cinco validacoes.
  tr <- anuncios[dobra != j, ]; va <- anuncios[dobra == j, ] # Separa treino e validacao.
  pred_teoria[dobra == j, 1] <- mean(tr$visitas) # Aprende a media apenas no treino.
  pred_teoria[dobra == j, 2] <- predict(lm(visitas ~ dist + fotos, data = tr), va) # Preserva previsoes negativas da reta.
  pred_teoria[dobra == j, 3] <- predict(glm(visitas ~ dist + fotos, family = poisson, data = tr), va, type = "response") # Preve contagens.
} # Termina a validacao da teoria.
placar_teoria <- data.frame(modelo = colnames(pred_teoria), rmse_cv5 = apply(pred_teoria, 2, function(p) rmse(anuncios$visitas, p))) # Resume o placar.
salvar(placar_teoria, "TeoriaMetricas") # Registra os tres valores de conferencia.
salvar(data.frame(anuncios, dobra, pred_teoria), "TeoriaPrevisoes") # Permite recalcular cada erro.
salvar(data.frame(termo = names(coef(m)), beta = coef(m), multiplicador = exp(coef(m))), "TeoriaCoeficientes") # Registra os efeitos.
conferencia <- data.frame(item = c("soma_visitas", "soma_visitas_od", "soma_an2", "phi_sobredispersao", "fator_erro_padrao", "previsao_1km_12fotos", "previsao_3km_5fotos", "dist_sem_offset", "dist_com_offset", "previsao_20dias", "mqo_negativas_cv"), valor = c(somas, phi_teoria, sqrt(phi_teoria), predict(m, data.frame(dist = 1, fotos = 12), type = "response"), predict(m, data.frame(dist = 3, fotos = 5), type = "response"), exp(coef(sem)["dist"]), exp(coef(com)["dist"]), predict(com, data.frame(dist = 1, fotos = 12, dias = 20), type = "response"), sum(pred_teoria[, 2] < 0))) # Junta os checkpoints numericos.
salvar(conferencia, "TeoriaConferencia") # Exporta verificacoes da teoria.
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", encoding = "UTF-8") # Le os dados reais do grupo.
stopifnot(nrow(dados) > 200000, nrow(boletins) > 10000) # Impede ajuste sobre leitura parcial ou vazia.
data_evento <- as.Date(boletins$data_sinistro, format = "%d/%m/%Y") # Interpreta a data do evento.
hora_evento <- suppressWarnings(as.integer(substr(boletins$hora_sinistro, 1, 2))) # Extrai a hora conhecida no calendario.
minuto_evento <- suppressWarnings(as.integer(substr(boletins$hora_sinistro, 4, 5))) # Identifica horarios invalidos.
ok <- !is.na(data_evento) & !is.na(hora_evento) & hora_evento >= 0 & hora_evento <= 23 & !is.na(minuto_evento) & minuto_evento >= 0 & minuto_evento <= 59 # Seleciona eventos com horario e data validos.
datas <- data_evento[ok]; horas <- hora_evento[ok] # Mantem alinhamento das observacoes.
inicio <- as.Date("2025-01-01"); fim <- as.Date("2026-06-30") # Declara o periodo informado na fonte e na ficha.
stopifnot(all(datas >= inicio & datas <= fim)) # Confere que o recorte cabe no periodo.
calendario <- seq(inicio, fim, by = "day") # Inclui os dias sem sinistro.
meses <- unique(format(calendario, "%Y/%m")) # Garante todos os dezoito meses.
eventos <- data.frame(mes = factor(format(datas, "%Y/%m"), levels = meses), dia = factor(format(datas, "%u"), levels = as.character(1:7)), hora = factor(horas, levels = as.character(0:23))) # Define as unidades de contagem.
cont <- as.data.frame(table(eventos$mes, eventos$dia, eventos$hora)) # Preserva todas as combinacoes e os zeros.
names(cont) <- c("mes", "dia", "hora", "n") # Nomeia a resposta de contagem.
exposicao <- table(factor(format(calendario, "%Y/%m"), levels = meses), factor(format(calendario, "%u"), levels = as.character(1:7))) # Conta dias observados por mes e dia da semana.
cont$exposicao <- mapply(function(mes, dia) exposicao[as.character(mes), as.character(dia)], cont$mes, cont$dia) # Cada celula tem uma hora por dia exposto.
stopifnot(sum(cont$n) == sum(ok), all(cont$exposicao > 0), all(cont$n >= 0), all(cont$n == floor(cont$n))) # Valida conservacao dos eventos e resposta inteira.
formula_contagem <- n ~ mes + dia + hora + offset(log(exposicao)) # Usa apenas calendario conhecido antes dos eventos.
modelo_poisson <- glm(formula_contagem, family = poisson, data = cont) # Ajusta o modelo da parte D.
phi <- sum(residuals(modelo_poisson, type = "pearson")^2) / df.residual(modelo_poisson) # Mede sobredispersao real.
modelo_quasi <- glm(formula_contagem, family = quasipoisson, data = cont) # Calcula erros padrao adequados.
stopifnot(max(abs(coef(modelo_poisson) - coef(modelo_quasi))) < 1e-7) # Confere a equivalencia das medias.
set.seed(1); cont$dobra <- sample(rep(1:5, length = nrow(cont))) # Divide uma unica vez todos os modelos.
pred <- matrix(NA_real_, nrow(cont), 3, dimnames = list(NULL, c("media", "mqo", "poisson"))) # Guarda previsoes fora da amostra.
for (j in 1:5) { # Valida cada celula uma vez.
  tr <- cont[cont$dobra != j, ]; va <- cont[cont$dobra == j, ] # Separa treino e validacao compartilhados.
  pred[cont$dobra == j, 1] <- mean(tr$n) # Linha de base sem consultar a validacao.
  pred[cont$dobra == j, 2] <- predict(lm(n ~ mes + dia + hora + exposicao, data = tr), va) # MQO usa a mesma informacao de calendario.
  pred[cont$dobra == j, 3] <- predict(glm(formula_contagem, family = poisson, data = tr), va, type = "response") # Poisson preve a escala correta.
} # Fecha as dobras do grupo.
stopifnot(all(is.finite(pred)), all(pred[, 3] > 0)) # Nao aceita previsoes incompletas.
metricas <- data.frame(modelo = colnames(pred), rmse_cv5 = apply(pred, 2, function(p) rmse(cont$n, p)), previsoes_negativas = colSums(pred < 0), dispersao_pearson = c(NA, NA, phi)) # Mantem o placar auditavel.
coeficientes <- data.frame(termo = names(coef(modelo_quasi)), coeficiente = unname(coef(modelo_quasi)), razao_taxas = exp(unname(coef(modelo_quasi))), erro_padrao_poisson = coef(summary(modelo_poisson))[, 2], erro_padrao_quasi = coef(summary(modelo_quasi))[, 2], row.names = NULL) # Exporta multiplicadores e incerteza.
salvar(cont, "ContagensSinistros") # Salva as unidades, os zeros, exposicao e dobra.
salvar(metricas, "MetricasPoisson") # Atualiza o placar anteriormente calculado com vazamento.
salvar(coeficientes, "CoeficientesPoisson") # Salva coeficientes sem inventar medidas.
salvar(data.frame(cont, pred), "PrevisoesPoisson") # Registra previsoes de todos os modelos.
salvar(data.frame(registros_fonte = nrow(dados), boletins = nrow(boletins), eventos_validos = sum(ok), excluidos = sum(!ok), celulas = nrow(cont), zeros = sum(cont$n == 0), dias_calendario = length(calendario), phi = phi), "AuditoriaGrupo") # Explica as diferentes contagens de linhas.
png(paste0(prefixo, "ObservadoPrevistoPoisson.png"), width = 1100, height = 750, res = 120) # Abre a figura final.
plot(cont$n, pred[, 3], pch = 16, cex = .5, col = rgb(.05, .35, .45, .25), xlab = "Sinistros observados por mes x dia x hora", ylab = "Previsao Poisson fora da amostra", main = "APPA: validacao cruzada das contagens") # Compara observacoes e previsoes reais.
abline(0, 1, lty = 2, col = "firebrick", lwd = 2); dev.off() # Desenha a referencia e conclui a figura.
print(placar_teoria); print(metricas); print(tail(coeficientes)) # Mostra a evidencia no terminal.
writeLines(capture.output(sessionInfo()), paste0(prefixo, "SessionInfo.txt")) # Registra versao e ambiente.
