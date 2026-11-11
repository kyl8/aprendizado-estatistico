# Estudo retrospectivo: associacao com pico entre boletins, nao risco por veiculo.
source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", local=TRUE, encoding="UTF-8")
source("estrutura/codigos/estudo_pico_funcoes.R", local=TRUE, encoding="UTF-8")
for (pacote in c("rpart","sandwich")) if (!requireNamespace(pacote,quietly=TRUE)) stop(paste("Instale",pacote))
stopifnot(!anyNA(boletins$id_sinistro), !anyDuplicated(boletins$id_sinistro))
data <- as.Date(boletins$data_sinistro, format="%d/%m/%Y")
data_valida <- !is.na(data) & !is.na(boletins$data_sinistro) & format(data,"%d/%m/%Y") == boletins$data_sinistro
minuto <- minutos_horario(boletins$hora_sinistro)
hora_valida <- !is.na(minuto)
via_valida <- !is.na(boletins$tipo_via) & boletins$tipo_via != "NAO DISPONIVEL"
ok <- data_valida & hora_valida & via_valida
dias <- c("Segunda-feira","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Domingo")
dia_calendario <- dias[as.integer(format(data,"%u"))]
divergencias_dia <- sum(data_valida & !is.na(boletins$dia_da_semana) & dia_calendario != boletins$dia_da_semana)
stopifnot(divergencias_dia == 0)
d <- data.frame(data=data[ok], y=pico_horario(boletins$hora_sinistro[ok]), via=as.character(boletins$tipo_via[ok]),
                dia=dia_calendario[ok], regiao=as.character(boletins$regiao_administrativa[ok]))
antes <- nrow(d); d <- d[complete.cases(d), ]; removidos <- antes-nrow(d)
coorte <- data.frame(etapa=c("registros brutos","boletins","data e hora validas","via informada","preditores completos"),
                     n=c(nrow(dados),nrow(boletins),sum(data_valida & hora_valida),sum(ok),nrow(d)))
coorte$excluidos_etapa <- c(NA,-diff(coorte$n))
stopifnot(nrow(d)>10000, all(d$y %in% 0:1), all(d$data >= as.Date("2025-01-01") & d$data <= as.Date("2026-06-30")))
treino <- d[d$data < as.Date("2026-01-01"), ]; teste <- d[d$data >= as.Date("2026-01-01"), ]
for (v in c("via","dia","regiao")) {
  niveis <- sort(unique(treino[[v]])); if (!all(teste[[v]] %in% niveis)) stop(paste("Nivel novo no teste:",v))
  treino[[v]] <- factor(treino[[v]],levels=niveis); teste[[v]] <- factor(teste[[v]],levels=niveis)
}
stopifnot(max(treino$data)<min(teste$data), all(c(0,1) %in% treino$y), all(c(0,1) %in% teste$y))
logistica <- glm(y ~ via+dia+regiao, data=treino, family=binomial())
stopifnot(logistica$converged, all(is.finite(coef(logistica))))
# A poda usa janeiro-setembro/2025 para ajuste e outubro-dezembro para validacao.
interno <- treino[treino$data < as.Date("2025-10-01"), ]; validacao <- treino[treino$data >= as.Date("2025-10-01"), ]
stopifnot(max(interno$data)<min(validacao$data),max(validacao$data)<min(teste$data))
grade_cp <- c(.01,.005,.001,.0005,.0001)
cheia <- rpart::rpart(factor(y) ~ via+dia+regiao,data=interno,method="class",control=rpart::rpart.control(cp=min(grade_cp),xval=0,minbucket=100))
poda <- data.frame(cp=grade_cp,brier_validacao=sapply(grade_cp,function(cp) {
  a <- rpart::prune(cheia,cp=cp); mean((validacao$y-predict(a,validacao,type="prob")[,"1"])^2)
}))
cp <- poda$cp[which.min(poda$brier_validacao)]
arvore <- rpart::rpart(factor(y) ~ via+dia+regiao,data=treino,method="class",control=rpart::rpart.control(cp=min(grade_cp),xval=0,minbucket=100))
arvore <- rpart::prune(arvore,cp=cp)
pred <- data.frame(data=teste$data,y=teste$y,base=mean(treino$y),
                   logistica=as.numeric(predict(logistica,teste,type="response")),
                   arvore=as.numeric(predict(arvore,teste,type="prob")[,"1"]))
metricas <- data.frame(modelo=c("base","logistica","arvore"),t(sapply(pred[,3:5],function(p) metricas_pico(pred$y,p))),row.names=NULL)
reduzido <- glm(y ~ dia+regiao,data=treino,family=binomial())
teste_lr <- anova(reduzido,logistica,test="Chisq")
hipotese <- data.frame(hipotese="via condicionada a dia e regiao",estatistica=teste_lr$Deviance[2],gl=teste_lr$Df[2],p_valor=teste_lr$`Pr(>Chi)`[2])
testes <- drop1(logistica,test="Chisq")
testes <- data.frame(variavel=rownames(testes)[-1],gl=testes$Df[-1],estatistica=testes$LRT[-1],p_valor=testes$`Pr(>Chi)`[-1],row.names=NULL)
testes$p_holm <- p.adjust(testes$p_valor,"holm")
# HC1 agrupada por data permite dependencia entre os boletins do mesmo dia.
cov_dia <- sandwich::vcovCL(logistica,cluster=treino$data,type="HC1",cadjust=TRUE)
stopifnot(all(is.finite(cov_dia)), min(eigen(cov_dia,symmetric=TRUE,only.values=TRUE)$values)>0)
testes_robustos <- do.call(rbind,lapply(c("via","dia","regiao"),function(v) {
  ids <- grep(paste0("^",v),names(coef(logistica)))
  data.frame(variavel=v,t(wald_pico(coef(logistica)[ids],cov_dia[ids,ids,drop=FALSE])))
}))
testes_robustos$p_holm <- p.adjust(testes_robustos$p_valor,"holm")
coeficientes <- coef(summary(logistica))
coeficientes <- data.frame(termo=rownames(coeficientes),coeficientes,razao_chances=exp(coef(logistica)),row.names=NULL,check.names=FALSE)
coeficientes$ic95_inferior <- exp(coeficientes$Estimate-1.96*coeficientes$`Std. Error`)
coeficientes$ic95_superior <- exp(coeficientes$Estimate+1.96*coeficientes$`Std. Error`)
coeficientes$erro_padrao_dia <- sqrt(diag(cov_dia))
coeficientes$ic95_dia_inferior <- exp(coeficientes$Estimate-1.96*coeficientes$erro_padrao_dia)
coeficientes$ic95_dia_superior <- exp(coeficientes$Estimate+1.96*coeficientes$erro_padrao_dia)
# Contrastes de Brier pareados, com bootstrap diario e blocos circulares de sete dias.
ganho_dia <- aggregate(cbind(ganho=(pred$y-pred$base)^2-(pred$y-pred$logistica)^2,
                             ganho_arvore=(pred$y-pred$arvore)^2-(pred$y-pred$logistica)^2,n=rep(1,nrow(pred))),list(data=pred$data),sum)
ganho_dia <- ganho_dia[order(ganho_dia$data), ]
stopifnot(sum(ganho_dia$n)==nrow(pred),all(diff(ganho_dia$data)==1),abs(sum(ganho_dia$ganho)/sum(ganho_dia$n)-(metricas$brier[1]-metricas$brier[2]))<1e-12)
set.seed(20261111); boot <- replicate(1000,{i<-sample.int(nrow(ganho_dia),replace=TRUE);sum(ganho_dia$ganho[i])/sum(ganho_dia$n[i])})
ic <- quantile(boot,c(.025,.975))
incerteza <- data.frame(contraste="Brier base - Brier logistica",estimativa=metricas$brier[1]-metricas$brier[2],ic95_inferior=unname(ic[1]),ic95_superior=unname(ic[2]),repeticoes=length(boot),unidade="dia")
set.seed(20261112); nd <- nrow(ganho_dia)
boot7 <- replicate(1000, {
  inicio <- sample.int(nd,ceiling(nd/7),replace=TRUE)
  i <- as.vector(outer(0:6,inicio,function(a,b) (a+b-1)%%nd+1))[seq_len(nd)]
  c(base=sum(ganho_dia$ganho[i])/sum(ganho_dia$n[i]),arvore=sum(ganho_dia$ganho_arvore[i])/sum(ganho_dia$n[i]))
})
ic7 <- t(apply(boot7,1,quantile,c(.025,.975)))
incerteza_semanal <- data.frame(contraste=c("Brier base - logistica","Brier arvore - logistica"),estimativa=c(metricas$brier[1]-metricas$brier[2],metricas$brier[3]-metricas$brier[2]),ic95_inferior=ic7[,1],ic95_superior=ic7[,2],repeticoes=1000,bloco_dias=7,row.names=NULL)
# Diagnostico no teste: H0 conjunta intercepto=0 e inclinacao=1; sem recalibrar previsoes.
lp <- qlogis(pmin(pmax(pred$logistica,1e-15),1-1e-15))
cal_fit <- glm(pred$y ~ lp,family=binomial())
cov_cal <- sandwich::vcovCL(cal_fit,cluster=pred$data,type="HC1",cadjust=TRUE)
calibracao_teste <- data.frame(intercepto=coef(cal_fit)[1],inclinacao=coef(cal_fit)[2],t(wald_pico(coef(cal_fit),cov_cal,c(0,1))),row.names=NULL)
por_grupo <- function(grupo) do.call(rbind,lapply(sort(unique(grupo)),function(g) {
  i <- grupo==g
  data.frame(grupo=g,n=sum(i),pico=mean(pred$y[i]),t(metricas_pico(pred$y[i],pred$logistica[i])),row.names=NULL)
}))
por_mes <- por_grupo(format(pred$data,"%Y-%m")); por_regiao <- por_grupo(as.character(teste$regiao))
stopifnot(sum(por_mes$n)==nrow(pred),sum(por_regiao$n)==nrow(pred))
auditoria <- data.frame(n_fonte=nrow(dados),n_boletins=nrow(boletins),n_validos=nrow(d),n_excluidos_preditores=removidos,
 n_treino=nrow(treino),n_teste=nrow(teste),inicio_treino=min(treino$data),fim_treino=max(treino$data),inicio_teste=min(teste$data),fim_teste=max(teste$data),
 pico_treino=mean(treino$y),pico_teste=mean(teste$y),cp_arvore=cp,n_ajuste_interno=nrow(interno),n_validacao_interna=nrow(validacao),
 dias_treino=length(unique(treino$data)),dias_teste=nd,ids_duplicados=sum(duplicated(boletins$id_sinistro)),divergencias_dia=divergencias_dia)
out <- "estrutura/codigos/resultados/estudo-pico"; dir.create(out,recursive=TRUE,showWarnings=FALSE)
for (nome in c("coorte","poda","metricas","hipotese","testes","testes_robustos","coeficientes","incerteza","incerteza_semanal","calibracao_teste","por_mes","por_regiao","auditoria","pred")) write.csv(get(nome),file.path(out,paste0(nome,".csv")),row.names=FALSE,fileEncoding="UTF-8")
png(file.path(out,"brier-teste.png"),width=1000,height=650,res=120); barplot(metricas$brier,names.arg=metricas$modelo,ylab="Brier (menor e melhor)",main="Teste temporal: classificacao de pico",col=c("gray60","steelblue","darkseagreen4")); dev.off()
faixas <- cut(pred$logistica,breaks=seq(0,1,.1),include.lowest=TRUE)
cal <- aggregate(cbind(probabilidade=pred$logistica,frequencia=pred$y,n=rep(1,nrow(pred))),list(faixa=faixas),function(x) c(media=mean(x),soma=sum(x)))
cal <- data.frame(faixa=cal$faixa,probabilidade=cal$probabilidade[,"media"],frequencia=cal$frequencia[,"media"],n=cal$n[,"soma"])
stopifnot(sum(cal$n)==nrow(pred))
png(file.path(out,"calibracao-teste.png"),width=1000,height=650,res=120)
plot(cal$probabilidade,cal$frequencia,xlim=c(0,1),ylim=c(0,1),pch=19,cex=sqrt(cal$n/max(cal$n))*2+.5,xlab="Probabilidade media prevista",ylab="Frequencia observada",main="Calibracao no teste; tamanho indica numero de boletins"); abline(0,1,lty=2); dev.off()
write.csv(cal,file.path(out,"calibracao.csv"),row.names=FALSE)
png(file.path(out,"estabilidade-mensal.png"),width=1000,height=650,res=120)
plot(seq_len(nrow(por_mes)),por_mes$auc,type="b",pch=19,xaxt="n",ylim=c(.45,.65),xlab="Mes do teste",ylab="AUC",main="Discriminacao da logistica por mes");axis(1,at=seq_len(nrow(por_mes)),labels=por_mes$grupo);abline(h=.5,lty=2);dev.off()
write.csv(data.frame(pacote=c("R","rpart","sandwich"),versao=c(as.character(getRversion()),as.character(utils::packageVersion("rpart")),as.character(utils::packageVersion("sandwich")))),file.path(out,"versoes.csv"),row.names=FALSE)
print(auditoria);print(coorte);print(metricas);print(testes_robustos);print(incerteza_semanal);print(calibracao_teste)
