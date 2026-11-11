# Estudo principal: associacao com pico entre boletins, nao risco por veiculo.
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", local=TRUE, encoding="UTF-8")
if (!requireNamespace("rpart", quietly=TRUE)) stop("Instale rpart.")
data <- as.Date(boletins$data_sinistro, format="%d/%m/%Y")
hh <- suppressWarnings(as.integer(substr(boletins$hora_sinistro,1,2)))
mm <- suppressWarnings(as.integer(substr(boletins$hora_sinistro,4,5)))
minuto <- 60*hh+mm
ok <- !is.na(data) & !is.na(hh) & hh>=0 & hh<=23 & !is.na(mm) & mm>=0 & mm<=59 &
      !is.na(boletins$tipo_via) & boletins$tipo_via != "NAO DISPONIVEL"
y <- as.integer((minuto>=390 & minuto<=510) | (minuto>=690 & minuto<=810) | (minuto>=1020 & minuto<=1170))
d <- data.frame(data=data[ok], y=y[ok], via=as.character(boletins$tipo_via[ok]),
                dia=as.character(boletins$dia_da_semana[ok]), regiao=as.character(boletins$regiao_administrativa[ok]))
antes <- nrow(d); d <- d[complete.cases(d), ]; removidos <- antes-nrow(d)
stopifnot(nrow(d)>10000, all(d$y %in% 0:1), all(d$data >= as.Date("2025-01-01") & d$data <= as.Date("2026-06-30")))
treino <- d[d$data < as.Date("2026-01-01"), ]; teste <- d[d$data >= as.Date("2026-01-01"), ]
for (v in c("via","dia","regiao")) {
  niveis <- sort(unique(treino[[v]])); if (!all(teste[[v]] %in% niveis)) stop(paste("Nivel novo no teste:",v))
  treino[[v]] <- factor(treino[[v]],levels=niveis); teste[[v]] <- factor(teste[[v]],levels=niveis)
}
stopifnot(max(treino$data)<min(teste$data), all(c(0,1) %in% treino$y), all(c(0,1) %in% teste$y))
set.seed(20261111)
logistica <- glm(y ~ via+dia+regiao, data=treino, family=binomial())
stopifnot(logistica$converged, all(is.finite(coef(logistica))))
arvore <- rpart::rpart(factor(y) ~ via+dia+regiao, data=treino, method="class", control=rpart::rpart.control(cp=0.0001,xval=5,minbucket=100))
cp <- arvore$cptable[which.min(arvore$cptable[,"xerror"]),"CP"]
arvore <- rpart::prune(arvore, cp=cp)
pred <- data.frame(data=teste$data, y=teste$y, base=mean(treino$y),
                   logistica=as.numeric(predict(logistica,teste,type="response")),
                   arvore=as.numeric(predict(arvore,teste,type="prob")[,"1"]))
stopifnot(all(is.finite(as.matrix(pred[,3:5]))), all(as.matrix(pred[,3:5])>=0), all(as.matrix(pred[,3:5])<=1))
auc <- function(y,p) { n1<-sum(y==1); n0<-sum(y==0); (sum(rank(p)[y==1])-n1*(n1+1)/2)/(n1*n0) }
stopifnot(auc(c(0,1),c(0,1))==1, auc(c(0,1),c(.5,.5))==.5)
avaliar <- function(p) {
  classe <- p>=.5; positivo <- pred$y==1
  c(brier=mean((pred$y-p)^2), auc=auc(pred$y,p), acuracia=mean(classe==positivo),
    sensibilidade=sum(classe & positivo)/sum(positivo), especificidade=sum(!classe & !positivo)/sum(!positivo))
}
metricas <- data.frame(modelo=c("base","logistica","arvore"), t(sapply(pred[,3:5], avaliar)), row.names=NULL)
# H0: os coeficientes de via sao zero, condicionados a dia e regiao; teste apenas no treino.
reduzido <- glm(y ~ dia+regiao, data=treino, family=binomial())
teste_lr <- anova(reduzido,logistica,test="Chisq")
hipotese <- data.frame(hipotese="via condicionada a dia e regiao", estatistica=teste_lr$Deviance[2], gl=teste_lr$Df[2], p_valor=teste_lr$`Pr(>Chi)`[2])
testes <- drop1(logistica, test="Chisq")
testes <- data.frame(variavel=rownames(testes)[-1], gl=testes$Df[-1], estatistica=testes$LRT[-1], p_valor=testes$`Pr(>Chi)`[-1], row.names=NULL)
coeficientes <- coef(summary(logistica))
coeficientes <- data.frame(termo=rownames(coeficientes), coeficientes, razao_chances=exp(coef(logistica)), row.names=NULL, check.names=FALSE)
coeficientes$ic95_inferior <- exp(coeficientes$Estimate-1.96*coeficientes$`Std. Error`)
coeficientes$ic95_superior <- exp(coeficientes$Estimate+1.96*coeficientes$`Std. Error`)
# Bootstrap por dia no teste: diferenca pareada Brier base menos logistica.
ganho_dia <- aggregate(cbind(ganho=(pred$y-pred$base)^2-(pred$y-pred$logistica)^2, n=rep(1,nrow(pred))), list(data=pred$data), sum)
stopifnot(sum(ganho_dia$n)==nrow(pred), abs(sum(ganho_dia$ganho)/sum(ganho_dia$n) - (metricas$brier[1]-metricas$brier[2])) < 1e-12)
set.seed(20261111); boot <- replicate(1000, { i<-sample.int(nrow(ganho_dia),replace=TRUE); sum(ganho_dia$ganho[i])/sum(ganho_dia$n[i]) })
ic <- quantile(boot,c(.025,.975))
incerteza <- data.frame(contraste="Brier base - Brier logistica", estimativa=metricas$brier[1]-metricas$brier[2], ic95_inferior=unname(ic[1]), ic95_superior=unname(ic[2]), repeticoes=length(boot), unidade="dia")
auditoria <- data.frame(n_fonte=nrow(dados), n_boletins=nrow(boletins), n_validos=nrow(d), n_excluidos_preditores=removidos,
                        n_treino=nrow(treino), n_teste=nrow(teste), inicio_treino=min(treino$data), fim_treino=max(treino$data),
                        inicio_teste=min(teste$data), fim_teste=max(teste$data), pico_treino=mean(treino$y), pico_teste=mean(teste$y), cp_arvore=cp)
out <- "estrutura/codigos/resultados/estudo-pico"; dir.create(out,recursive=TRUE,showWarnings=FALSE)
for (nome in c("metricas","hipotese","testes","coeficientes","incerteza","auditoria","pred")) write.csv(get(nome),file.path(out,paste0(nome,".csv")),row.names=FALSE,fileEncoding="UTF-8")
png(file.path(out,"brier-teste.png"),width=1000,height=650,res=120); barplot(metricas$brier,names.arg=metricas$modelo,ylab="Brier (menor e melhor)",main="Teste temporal: classificacao de pico",col=c("gray60","steelblue","darkseagreen4")); dev.off()
png(file.path(out,"calibracao-teste.png"),width=1000,height=650,res=120)
faixas <- cut(pred$logistica,breaks=seq(0,1,0.1),include.lowest=TRUE)
cal <- aggregate(cbind(probabilidade=pred$logistica,frequencia=pred$y),list(faixa=faixas),mean)
plot(cal$probabilidade,cal$frequencia,xlim=c(0,1),ylim=c(0,1),pch=19,xlab="Probabilidade media prevista",ylab="Frequencia observada",main="Calibracao: teste temporal"); abline(0,1,lty=2); dev.off()
write.csv(cal,file.path(out,"calibracao.csv"),row.names=FALSE)
print(auditoria); print(metricas); print(testes); print(incerteza); print(coeficientes[grepl("^via",coeficientes$termo),])
