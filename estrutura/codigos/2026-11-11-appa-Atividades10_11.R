# Analises exploratorias das aulas 11 e 12 sobre os boletins APPA.
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", local = TRUE, encoding = "UTF-8")
if (!requireNamespace("rpart", quietly = TRUE)) stop("Instale o pacote rpart.")
if (!requireNamespace("randomForest", quietly = TRUE)) stop("Instale o pacote randomForest.")
if (!requireNamespace("cluster", quietly = TRUE)) stop("Instale o pacote cluster.")
set.seed(20261111)
d <- boletins_modelo[sample(nrow(boletins_modelo), min(10000, nrow(boletins_modelo))), ]
d <- data.frame(y = d$qtd_gravidade_fatal, via = d$tipo_via, turno = d$turno,
                pedestre = d$qtd_pedestre, moto = d$qtd_motocicleta,
                automovel = d$qtd_automovel, onibus = d$qtd_onibus, caminhao = d$qtd_caminhao)
d <- droplevels(d[complete.cases(d), ])
set.seed(1); fold <- sample(rep(1:5, length.out = nrow(d)))
pred <- matrix(NA_real_, nrow(d), 3, dimnames = list(NULL, c("media", "arvore", "floresta")))
for (j in 1:5) {
  tr <- d[fold != j, ]; va <- d[fold == j, ]
  tree <- rpart::rpart(y ~ ., data = tr, control = rpart::rpart.control(cp = 0.001, xval = 5))
  cp <- tree$cptable[which.min(tree$cptable[, "xerror"]), "CP"]
  tree <- rpart::prune(tree, cp = cp)
  set.seed(100 + j)
  forest <- randomForest::randomForest(y ~ ., data = tr, ntree = 150, mtry = 3, importance = TRUE)
  pred[fold == j, ] <- cbind(mean(tr$y), predict(tree, va), predict(forest, va))
}
stopifnot(all(is.finite(pred)))
out <- "estrutura/resultados/aulas11_12"; dir.create(out, recursive = TRUE, showWarnings = FALSE)
met <- data.frame(modelo = colnames(pred), rmse_cv5 = apply(pred, 2, function(p) sqrt(mean((d$y-p)^2))))
write.csv(met, file.path(out, "arvores_metricas.csv"), row.names = FALSE)
write.csv(data.frame(d, fold, pred), file.path(out, "arvores_previsoes.csv"), row.names = FALSE)
set.seed(42); sample_ids <- sample(nrow(d), min(1500, nrow(d)))
x <- d[sample_ids, c("pedestre", "moto", "automovel", "onibus", "caminhao")]
x <- x[, vapply(x, sd, numeric(1)) > 0, drop = FALSE]
z <- scale(x); pca <- prcomp(z, center = FALSE, scale. = FALSE)
ks <- 2:8
sil <- sapply(ks, function(k) { set.seed(100 + k); m <- kmeans(z, centers = k, nstart = 25); mean(cluster::silhouette(m$cluster, dist(z))[, 3]) })
k <- ks[which.max(sil)]; set.seed(100 + k); km <- kmeans(z, centers = k, nstart = 25)
write.csv(data.frame(k = ks, silhueta = sil), file.path(out, "agrupamento_silhueta.csv"), row.names = FALSE)
write.csv(data.frame(componente = seq_along(pca$sdev), proporcao = pca$sdev^2 / sum(pca$sdev^2)), file.path(out, "pca_variancia.csv"), row.names = FALSE)
write.csv(data.frame(x, grupo = km$cluster, pc1 = pca$x[,1], pc2 = pca$x[,2]), file.path(out, "agrupamento_observacoes.csv"), row.names = FALSE)
png(file.path(out, "pca_grupos.png"), width = 900, height = 650); plot(pca$x[,1:2], col = km$cluster, pch = 16, cex = .5, xlab = "PC1", ylab = "PC2"); dev.off()
print(met); print(data.frame(k = ks, silhueta = sil))
# Ajustes finais na amostra completa: OOB e importancia sao exploratorios,
# enquanto o placar CV acima mede previsoes fora de cada dobra.
p <- ncol(d) - 1
mtries <- sort(unique(c(2, 3, p)))
oob <- do.call(rbind, lapply(mtries, function(m) {
  set.seed(200 + m)
  fit <- randomForest::randomForest(y ~ ., data = d, ntree = 150, mtry = m, importance = TRUE)
  data.frame(mtry = m, tipo = if (m == p) "bagging" else "floresta", mse_oob = tail(fit$mse, 1))
}))
write.csv(oob, file.path(out, "floresta_oob.csv"), row.names = FALSE)
best_mtry <- oob$mtry[which.min(oob$mse_oob)]
set.seed(200 + best_mtry)
fit <- randomForest::randomForest(y ~ ., data = d, ntree = 150, mtry = best_mtry, importance = TRUE)
imp <- randomForest::importance(fit, type = 1)
write.csv(data.frame(variavel = rownames(imp), aumento_mse = imp[, 1]), file.path(out, "floresta_importancia.csv"), row.names = FALSE)
hc <- hclust(dist(z), method = "complete")
hg <- cutree(hc, k = k)
write.csv(data.frame(grupo_kmeans = km$cluster, grupo_hierarquico = hg), file.path(out, "agrupamento_comparacao.csv"), row.names = FALSE)
write.csv(data.frame(variavel = rownames(pca$rotation), pca$rotation), file.path(out, "pca_cargas.csv"), row.names = FALSE)
png(file.path(out, "silhueta.png"), 900, 650); plot(ks, sil, type = "b", xlab = "k", ylab = "Silhueta media"); dev.off()
png(file.path(out, "pca_variancia.png"), 900, 650); barplot(pca$sdev^2 / sum(pca$sdev^2), xlab = "Componente", ylab = "Proporcao da variancia"); dev.off()
png(file.path(out, "dendrograma.png"), 1100, 700); plot(hclust(dist(z[1:80, ]), method = "complete"), labels = FALSE, main = "Ligacao completa: 80 observacoes", xlab = "", sub = ""); dev.off()
png(file.path(out, "importancia.png"), 900, 650); barplot(sort(imp[, 1]), horiz = TRUE, las = 1, xlab = "Aumento percentual de MSE OOB"); dev.off()
print(oob); print(imp); print(pca$sdev^2 / sum(pca$sdev^2))

# Modelos adicionais no mesmo conjunto e nas mesmas dobras para comparacao justa.
if (!requireNamespace("mgcv", quietly = TRUE)) stop("Instale o pacote mgcv.")
extra <- matrix(NA_real_, nrow(d), 2, dimnames = list(NULL, c("linear", "gam")))
for (j in 1:5) {
  tr <- d[fold != j, ]; va <- d[fold == j, ]
  extra[fold == j, "linear"] <- predict(lm(y ~ ., data = tr), va)
  extra[fold == j, "gam"] <- predict(mgcv::gam(y ~ via + turno + pedestre + s(moto, k=4) + s(automovel, k=4) + onibus + caminhao, data = tr, method = "REML"), va)
}
stopifnot(all(is.finite(extra)))
met <- rbind(met, data.frame(modelo = colnames(extra), rmse_cv5 = apply(extra, 2, function(p) sqrt(mean((d$y-p)^2)))))
write.csv(met, file.path(out, "arvores_metricas.csv"), row.names = FALSE)
write.csv(aggregate(x, list(grupo = km$cluster), mean), file.path(out, "agrupamento_centros.csv"), row.names = FALSE)
write.csv(aggregate(d$y[sample_ids], list(grupo = km$cluster), function(y) c(n = length(y), media = mean(y))), file.path(out, "agrupamento_resposta.csv"), row.names = FALSE)
set.seed(1); tree_full <- rpart::rpart(y ~ ., data = d, control = rpart::rpart.control(cp = 0.001, xval = 5))
tree_full <- rpart::prune(tree_full, cp = tree_full$cptable[which.min(tree_full$cptable[, "xerror"]), "CP"])
writeLines(trimws(capture.output(print(tree_full)), which = "right"), file.path(out, "arvore_resumo.txt"))
# A figura corta ramos profundos apenas para leitura; as metricas usam a arvore completa podada.
nos <- as.integer(rownames(tree_full$frame))
cortar <- nos[nos >= 8 & nos < 16 & tree_full$frame$var != "<leaf>"]
tree_plot <- if (length(cortar)) rpart::snip.rpart(tree_full, toss = cortar) else tree_full
png(file.path(out, "arvore.png"), 1200, 800); plot(tree_plot, uniform = TRUE, margin = .1); text(tree_plot, cex = 1.1); dev.off()
png(file.path(out, "resposta_grupos.png"), 900, 650); boxplot(d$y[sample_ids] ~ km$cluster, xlab = "Grupo", ylab = "Quantidade de vitimas fatais"); dev.off()
print(met); print(aggregate(x, list(grupo = km$cluster), mean)); print(aggregate(d$y[sample_ids], list(grupo = km$cluster), mean)); print(tree_full)
