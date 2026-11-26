# Usa knitr e o LaTeX instalado (pdflatex + biber); so substitui o PDF apos compilacao completa.
stopifnot(requireNamespace("knitr", quietly = TRUE))
tinytex_bin <- file.path(Sys.getenv("APPDATA"), "TinyTeX", "bin", "windows")
if (nzchar(Sys.getenv("APPDATA")) && dir.exists(tinytex_bin)) {
  Sys.setenv(PATH = paste(tinytex_bin, Sys.getenv("PATH"), sep = .Platform$path.sep))
}
raiz <- if (file.exists("entregas/entrega-2/artigo-final.Rnw")) "." else "../.."
pasta <- normalizePath(file.path(raiz, "entregas/entrega-2"))
anterior <- getwd()
setwd(pasta)
knitr::knit("artigo-final.Rnw", output = "artigo-final.tex", encoding = "UTF-8", quiet = TRUE)
temporario <- tempfile("appa-entrega2-")
dir.create(temporario)
stopifnot(
  all(file.copy(c("artigo-final.tex", "referencias.bib"), temporario)),
  file.copy("figuras", temporario, recursive = TRUE)
)
setwd(temporario)
rodar <- function(programa, args) {
  exe <- Sys.which(programa)
  if (!nzchar(exe)) stop("Programa ausente: ", programa)
  log <- paste0(programa, "-", length(list.files(pattern = paste0("^", programa))), ".txt")
  status <- system2(exe, args, stdout = log, stderr = log)
  if (status != 0L) stop(paste(tail(readLines(log, warn = FALSE), 40), collapse = "\n"))
}
rodar("pdflatex", c("-interaction=nonstopmode", "-halt-on-error", "artigo-final.tex"))
rodar("biber", "artigo-final")
rodar("pdflatex", c("-interaction=nonstopmode", "-halt-on-error", "artigo-final.tex"))
rodar("pdflatex", c("-interaction=nonstopmode", "-halt-on-error", "artigo-final.tex"))
linhas <- readLines("artigo-final.log", warn = FALSE)
if (any(grepl("undefined references|undefined citations|There were undefined|Citation .* undefined|Empty bibliography", linhas, useBytes = TRUE))) {
  stop("Referencias ou citacoes nao resolvidas; veja ", temporario)
}
stopifnot(
  file.info("artigo-final.pdf")$size > 10000,
  file.copy("artigo-final.pdf", file.path(pasta, "artigo-final.pdf"), overwrite = TRUE)
)
setwd(anterior)
cat("PDF compilado: ", file.path(pasta, "artigo-final.pdf"), "\nDiagnosticos: ", temporario, "\n", sep = "")
