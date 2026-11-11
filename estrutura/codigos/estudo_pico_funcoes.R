minutos_horario <- function(x) {
  valido <- !is.na(x) & grepl("^[0-9]{2}:[0-9]{2}$", x)
  h <- suppressWarnings(as.integer(substr(x, 1, 2)))
  m <- suppressWarnings(as.integer(substr(x, 4, 5)))
  valido <- valido & !is.na(h) & h <= 23 & !is.na(m) & m <= 59
  ifelse(valido, 60 * h + m, NA_integer_)
}
pico_horario <- function(x) {
  m <- minutos_horario(x)
  ifelse(is.na(m), NA_integer_, as.integer((m >= 390 & m <= 510) | (m >= 690 & m <= 810) | (m >= 1020 & m <= 1170)))
}
auc_pico <- function(y, p) {
  stopifnot(length(y) == length(p), length(y) > 0, all(y %in% 0:1), all(is.finite(p)))
  n1 <- as.double(sum(y == 1)); n0 <- as.double(sum(y == 0))
  if (n1 == 0 || n0 == 0) return(NA_real_)
  (sum(rank(p)[y == 1]) - n1 * (n1 + 1) / 2) / (n1 * n0)
}
metricas_pico <- function(y, p, limiar = .5) {
  stopifnot(length(y) == length(p), length(y) > 0, all(y %in% 0:1), all(is.finite(p)), all(p >= 0 & p <= 1))
  classe <- p >= limiar; positivo <- y == 1
  tp <- sum(classe & positivo); tn <- sum(!classe & !positivo)
  sens <- if (sum(positivo)) tp / sum(positivo) else NA_real_
  esp <- if (sum(!positivo)) tn / sum(!positivo) else NA_real_
  seguro <- pmin(pmax(p, 1e-15), 1-1e-15)
  c(brier = mean((y-p)^2), auc = auc_pico(y,p), acuracia = mean(classe == positivo),
    sensibilidade = sens, especificidade = esp, acuracia_balanceada = (sens+esp)/2,
    log_loss = -mean(y*log(seguro)+(1-y)*log1p(-seguro)))
}
wald_pico <- function(beta, covariancia, nulo = rep(0, length(beta))) {
  stopifnot(length(beta) == length(nulo), nrow(covariancia) == length(beta), all(is.finite(covariancia)))
  diferenca <- beta-nulo
  estatistica <- as.numeric(crossprod(diferenca, solve(covariancia, diferenca)))
  c(estatistica = estatistica, gl = length(beta), p_valor = pchisq(estatistica, length(beta), lower.tail=FALSE),
    log_p_valor = pchisq(estatistica, length(beta), lower.tail=FALSE, log.p=TRUE))
}
