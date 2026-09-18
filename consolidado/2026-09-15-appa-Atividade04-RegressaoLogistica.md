# Atividade 04: regressão logística

A regressão logística é adequada quando a resposta tem duas classes. Neste projeto, o recorte mais direto é classificar se um boletim é fatal ou não fatal.

O ajuste foi implementado em [2026-09-15-appa-Atividade04-RegressaoLogistica.R](../estrutura/codigos/2026-09-15-appa-Atividade04-RegressaoLogistica.R). Notificações ficaram fora do modelo.

## Definição da resposta

Criar uma variável binária a partir de `tipo_registro`, usando os boletins fatais como uma classe e os boletins não fatais como outra. Notificações ficam fora desse ajuste porque têm origem e preenchimento diferentes.

## Variáveis candidatas

Tipo de via, turno, região administrativa, presença de pedestre, motocicleta, caminhão e as demais quantidades de veículos. A escolha final deve considerar valores ausentes e possíveis variáveis que já revelem diretamente a gravidade.

## Interpretação

O modelo estima uma probabilidade entre zero e um. Os coeficientes podem ser convertidos em razão de chances, mas a interpretação deve respeitar o recorte dos boletins e a qualidade da base.

O ajuste é reproduzível pelo script da atividade e os coeficientes ficam na pasta `estrutura/resultados`.

## Avaliação necessária

A proporção de registros fatais é pequena em relação aos não fatais. A acurácia sozinha pode esconder um modelo que sempre escolhe a classe majoritária. O relatório deve mostrar matriz de confusão, sensibilidade, especificidade e, se possível, uma curva ROC.

Também é preciso separar treinamento e teste e definir o ponto de corte da probabilidade. Esse ponto muda o equilíbrio entre encontrar casos fatais e evitar falsos alarmes.

## Resultado obtido

Com ponto de corte 0,5, a acurácia foi 0,9471, mas a sensibilidade foi apenas 0,0818. A especificidade foi 0,9995, a precisão foi 0,9161 e a AUC foi 0,7704. A matriz teve 28.619 verdadeiros negativos, 13 falsos positivos, 1.593 falsos negativos e 142 verdadeiros positivos.

A acurácia alta esconde a quantidade de casos fatais que o modelo não encontrou. O resultado foi calculado no conjunto de teste, separado antes do ajuste. Para uso sério, será preciso ajustar o ponto de corte e avaliar outros limiares.

## Material

[Aula 05](../materiais-aulas/Aula%2005%20-%20Classifica%C3%A7%C3%A3o%20e%20Regress%C3%A3o%20Log%C3%ADstica.PDF).
