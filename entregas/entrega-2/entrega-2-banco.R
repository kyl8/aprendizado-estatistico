# Entrega 2: um unico modelo, regressao logistica; execute na raiz do repositorio.
preparar_entrega2 <- function(raiz) {
  anterior <- getwd(); on.exit(setwd(anterior), add=TRUE); setwd(raiz)
  source("estrutura/codigos/2026-09-15-appa-PrepararBaseSinistros.R", local=TRUE, encoding="UTF-8")
  source("estrutura/codigos/estudo_pico_funcoes.R", local=TRUE, encoding="UTF-8")
  stopifnot(requireNamespace("sandwich", quietly=TRUE), !anyNA(boletins$id_sinistro), !anyDuplicated(boletins$id_sinistro))
  data <- as.Date(boletins$data_sinistro, "%d/%m/%Y")
  data_ok <- !is.na(data) & !is.na(boletins$data_sinistro) & format(data,"%d/%m/%Y")==boletins$data_sinistro
  hora_ok <- !is.na(minutos_horario(boletins$hora_sinistro))
  via_ok <- !is.na(boletins$tipo_via) & boletins$tipo_via != "NAO DISPONIVEL"
  dias <- c("Segunda-feira","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Domingo")
  dia <- dias[as.integer(format(data,"%u"))]
  stopifnot(sum(data_ok & !is.na(boletins$dia_da_semana) & dia!=boletins$dia_da_semana)==0)
  ok <- data_ok & hora_ok & via_ok
  banco <- data.frame(data=data[ok], pico=pico_horario(boletins$hora_sinistro[ok]),
    via=as.character(boletins$tipo_via[ok]), dia=dia[ok], regiao=as.character(boletins$regiao_administrativa[ok]))
  completas <- complete.cases(banco)
  ids_incluidos <- boletins$id_sinistro[ok][completas]
  banco <- banco[completas, ]
  banco$particao <- ifelse(banco$data < as.Date("2026-01-01"), "treino", "teste")
  treino <- banco[banco$particao=="treino",c("pico","via","dia","regiao","data")]
  teste <- banco[banco$particao=="teste",c("pico","via","dia","regiao","data")]
  for (v in c("via","dia","regiao")) {
    niveis <- sort(unique(treino[[v]]))
    stopifnot(all(teste[[v]] %in% niveis))
    treino[[v]] <- factor(treino[[v]],levels=niveis)
    teste[[v]] <- factor(teste[[v]],levels=niveis)
  }
  stopifnot(max(treino$data)<min(teste$data), all(banco$pico %in% 0:1),
    min(banco$data)==as.Date("2025-01-01"), max(banco$data)==as.Date("2026-06-30"))
  modelo <- glm(pico ~ via + dia + regiao, data=treino, family=binomial(link="logit"))
  stopifnot(modelo$converged, all(is.finite(coef(modelo))))
  prob <- as.numeric(predict(modelo, teste, type="response"))
  base <- rep(mean(treino$pico), nrow(teste))
  metricas <- data.frame(modelo=c("Referencia constante","Regressao logistica"),
    rbind(metricas_pico(teste$pico,base),metricas_pico(teste$pico,prob)),row.names=NULL)
  confusao <- as.data.frame(table(observado=factor(teste$pico,levels=0:1),
    previsto=factor(as.integer(prob>=.5),levels=0:1)))
  names(confusao)[3] <- "n"
  # Decomposicao descritiva das mesmas previsoes; nao e novo ajuste ou limiar.
  leitura_classificacao <- do.call(rbind,lapply(list(base=base,logistica=prob),function(p) {
    previsto <- p>=.5; real <- teste$pico==1
    vp<-sum(previsto & real);vn<-sum(!previsto & !real)
    fp<-sum(previsto & !real);fn<-sum(!previsto & real)
    data.frame(n=nrow(teste),pico=sum(real),fora=sum(!real),vp=vp,vn=vn,fp=fp,fn=fn,
      acertos=vp+vn,previstos_pico=vp+fp,acuracia=(vp+vn)/length(real),sensibilidade=vp/sum(real))
  }))
  leitura_classificacao$modelo <- rownames(leitura_classificacao);rownames(leitura_classificacao)<-NULL
  excluido <- !boletins$id_sinistro %in% ids_incluidos
  exclusoes <- do.call(rbind,lapply(c(0L,1L),function(fatal) {
    i<-boletins$fatal==fatal
    data.frame(tipo=if(fatal==1L)'Fatal' else 'Nao fatal',antes=sum(i),excluidos=sum(i & excluido),mantidos=sum(i & !excluido))
  }))
  auditoria_curadoria <- data.frame(item=c('ids_iguais_recorte_historico','notificacoes_fora','ids_duplicados','divergencias_dia'),
    valor=c(as.integer(setequal(ids_incluidos,boletins_modelo$id_sinistro)),sum(dados$tipo_registro=='NOTIFICACAO'),
      sum(duplicated(boletins$id_sinistro)),sum(data_ok & !is.na(boletins$dia_da_semana) & dia!=boletins$dia_da_semana)))
  stopifnot(leitura_classificacao$vp[2]==371,leitura_classificacao$fn[2]==19718,
    leitura_classificacao$acertos[2]-leitura_classificacao$acertos[1]==4,
    abs(leitura_classificacao$acuracia[2]-metricas$acuracia[2])<1e-12,
    sum(exclusoes$excluidos)==nrow(boletins)-nrow(banco))
  coorte <- data.frame(etapa=c("Registros na fonte","Boletins fatais e nao fatais","Data e hora validas","Via informada","Preditoras completas"),
    n=c(nrow(dados),nrow(boletins),sum(data_ok & hora_ok),sum(ok),nrow(banco)))
  particoes <- data.frame(particao=c("Treino","Teste"),
    inicio=c(min(treino$data),min(teste$data)),fim=c(max(treino$data),max(teste$data)),
    n=c(nrow(treino),nrow(teste)),pico=c(sum(treino$pico),sum(teste$pico)),
    proporcao_pico=c(mean(treino$pico),mean(teste$pico)))
  cov_dia <- sandwich::vcovCL(modelo,cluster=treino$data,type="HC1",cadjust=TRUE)
  stopifnot(all(is.finite(cov_dia)),min(eigen(cov_dia,symmetric=TRUE,only.values=TRUE)$values)>0)
  coeficientes <- data.frame(termo=names(coef(modelo)),beta=coef(modelo),
    erro_padrao_dia=sqrt(diag(cov_dia)),razao_chances=exp(coef(modelo)),row.names=NULL)
  coeficientes$ic95_inferior <- exp(coeficientes$beta-1.96*coeficientes$erro_padrao_dia)
  coeficientes$ic95_superior <- exp(coeficientes$beta+1.96*coeficientes$erro_padrao_dia)
  testes <- do.call(rbind,lapply(c("via","dia","regiao"),function(v) {
    ids <- grep(paste0("^",v),names(coef(modelo)))
    data.frame(variavel=v,t(wald_pico(coef(modelo)[ids],cov_dia[ids,ids,drop=FALSE])))
  }))
  testes$p_holm <- p.adjust(testes$p_valor,"holm")
  reduzido <- glm(pico ~ dia + regiao, data=treino, family=binomial())
  lr <- anova(reduzido,modelo,test="Chisq")
  hipotese_via <- data.frame(procedimento=c("Razao de verossimilhancas","Wald HC1 por data"),
    estatistica=c(lr$Deviance[2],testes$estatistica[1]),gl=c(lr$Df[2],testes$gl[1]),
    p_valor=c(lr$`Pr(>Chi)`[2],testes$p_valor[1]))
  ganho <- aggregate(cbind(ganho=(teste$pico-base)^2-(teste$pico-prob)^2,n=rep(1,nrow(teste))),list(data=teste$data),sum)
  ganho <- ganho[order(ganho$data), ]; nd <- nrow(ganho)
  stopifnot(all(diff(ganho$data)==1),sum(ganho$n)==nrow(teste))
  set.seed(20261112)
  boot <- replicate(1000, {
    inicio <- sample.int(nd,ceiling(nd/7),replace=TRUE)
    i <- as.vector(outer(0:6,inicio,function(a,b) (a+b-1)%%nd+1))[seq_len(nd)]
    sum(ganho$ganho[i])/sum(ganho$n[i])
  })
  ic <- quantile(boot,c(.025,.975))
  incerteza <- data.frame(contraste="Brier referencia - logistica",estimativa=metricas$brier[1]-metricas$brier[2],
    ic95_inferior=unname(ic[1]),ic95_superior=unname(ic[2]),repeticoes=1000,bloco_dias=7)
  faixas <- cut(prob,seq(0,1,.1),include.lowest=TRUE)
  calibracao <- do.call(rbind,lapply(levels(droplevels(faixas)),function(f) {
    i <- faixas==f
    data.frame(faixa=f,n=sum(i),probabilidade=mean(prob[i]),frequencia=mean(teste$pico[i]))
  }))
  lp <- qlogis(pmin(pmax(prob,1e-15),1-1e-15))
  cal_modelo <- glm(teste$pico ~ lp,family=binomial())
  cal_cov <- sandwich::vcovCL(cal_modelo,cluster=teste$data,type="HC1",cadjust=TRUE)
  diagnostico_calibracao <- data.frame(intercepto=coef(cal_modelo)[1],inclinacao=coef(cal_modelo)[2],
    t(wald_pico(coef(cal_modelo),cal_cov,c(0,1))),row.names=NULL)
  por_mes <- do.call(rbind,lapply(sort(unique(format(teste$data,"%Y-%m"))),function(m) {
    i <- format(teste$data,"%Y-%m")==m
    data.frame(mes=m,n=sum(i),t(metricas_pico(teste$pico[i],prob[i])),row.names=NULL)
  }))
  # Assercoes de integracao: esta entrega reproduz a especificacao principal ja documentada.
  anterior_metricas <- read.csv("estrutura/codigos/resultados/estudo-pico/metricas.csv")
  anterior_metricas <- anterior_metricas[anterior_metricas$modelo=="logistica",-1]
  stopifnot(nrow(banco)==151175,nrow(treino)==101666,nrow(teste)==49509,
    max(abs(as.numeric(metricas[2,-1])-as.numeric(anterior_metricas)))<1e-10,
    sum(confusao$n)==nrow(teste),sum(calibracao$n)==nrow(teste),nobs(modelo)==nrow(treino))
  saida <- "entregas/entrega-2"; res <- file.path(saida,"resultados"); figs <- file.path(saida,"figuras")
  dir.create(res,recursive=TRUE,showWarnings=FALSE);dir.create(figs,recursive=TRUE,showWarnings=FALSE)
  write.csv(banco,file.path(saida,"entrega-2-sinistros.csv"),row.names=FALSE,fileEncoding="UTF-8")
  for (nm in c("coorte","particoes","metricas","confusao","coeficientes","testes","hipotese_via","incerteza","calibracao","diagnostico_calibracao","por_mes","leitura_classificacao","exclusoes","auditoria_curadoria"))
    write.csv(get(nm),file.path(res,paste0(nm,".csv")),row.names=FALSE,fileEncoding="UTF-8")
  write.csv(data.frame(pacote=c("R","sandwich","knitr"),versao=c(as.character(getRversion()),
    as.character(utils::packageVersion("sandwich")),if(requireNamespace("knitr",quietly=TRUE)) as.character(utils::packageVersion("knitr")) else NA)),
    file.path(res,"versoes.csv"),row.names=FALSE)
  relatorio <- capture.output({op<-options(width=95,OutDec="."); print(summary(modelo));options(op)})
  relatorio <- sub("[ \t]+$","",relatorio)
  relatorio <- head(relatorio,max(which(nzchar(relatorio))))
  writeLines(enc2utf8(relatorio),file.path(res,"relatorio-logistica.txt"),useBytes=TRUE)
  png(file.path(figs,"roc-calibracao.png"),width=2000,height=950,res=190)
  par(mfrow=c(1,2),mar=c(4.3,4.4,2.6,1),las=1,cex=.88)
  ord <- order(prob,decreasing=TRUE); ys<-teste$pico[ord]; ps<-prob[ord]; fim<-!duplicated(ps,fromLast=TRUE)
  plot(c(0,cumsum(ys==0)[fim]/sum(ys==0),1),c(0,cumsum(ys==1)[fim]/sum(ys==1),1),type="l",lwd=2.5,col="#2549a8",
    xlab="1 - Especificidade",ylab="Sensibilidade",main="Ordenacao: curva ROC",xlim=0:1,ylim=0:1)
  abline(0,1,lty=2,col="gray55")
  plot(calibracao$probabilidade,calibracao$frequencia,xlim=0:1,ylim=0:1,pch=19,col="#2549a8",
    cex=.8+2*sqrt(calibracao$n/max(calibracao$n)),xlab="Probabilidade media prevista",ylab="Frequencia observada",main="Calibracao por faixas")
  abline(0,1,lty=2,col="gray55");dev.off()
  png(file.path(figs,"auc-mensal.png"),width=1600,height=750,res=190)
  par(mar=c(4.2,4.4,2,1),las=1)
  plot(seq_len(nrow(por_mes)),por_mes$auc,type="b",pch=19,lwd=2,col="#2549a8",xaxt="n",ylim=c(.45,.65),
    xlab="Mes de 2026",ylab="AUC",main="Logistica no teste temporal")
  axis(1,seq_len(nrow(por_mes)),labels=substr(por_mes$mes,6,7));abline(h=.5,lty=2,col="gray55");dev.off()
  png(file.path(figs,"acuracia-e-sensibilidade.png"),width=1800,height=850,res=190)
  par(mar=c(4.5,12,2,2),las=1)
  v<-c(metricas$acuracia[2],metricas$sensibilidade[2])*100
  pos<-barplot(rbind(v,100-v),horiz=TRUE,col=c('#235f6c','#d9dee3'),border=NA,xlim=c(0,100),
    names.arg=c('Acertos entre todos\nos 49.509 boletins','Identificados entre os\n20.089 boletins de pico'),
    xlab='Percentual dentro do denominador indicado (0 a 100%)',space=.65)
  text(100,pos,labels=c(sprintf('29.424 / 49.509 = %.2f%%',v[1]),sprintf('371 / 20.089 = %.2f%%',v[2])),pos=2,cex=.95)
  dev.off()
  cat("Entrega 2: verificacoes de integracao OK\n");print(particoes);print(metricas)
  list(banco=banco,treino=treino,teste=teste,modelo=modelo,prob=prob,metricas=metricas,confusao=confusao,
    coorte=coorte,particoes=particoes,coeficientes=coeficientes,testes=testes,hipotese_via=hipotese_via,
    incerteza=incerteza,calibracao=calibracao,diagnostico_calibracao=diagnostico_calibracao,por_mes=por_mes,relatorio=relatorio,
    leitura_classificacao=leitura_classificacao,exclusoes=exclusoes,auditoria_curadoria=auditoria_curadoria)
}
raiz_entrega2 <- if (dir.exists("estrutura/corpus")) "." else if (dir.exists("../../estrutura/corpus")) "../.." else stop("Execute na raiz ou em entregas/entrega-2.")
entrega2 <- preparar_entrega2(normalizePath(raiz_entrega2))
