"""Importa saidas executadas em R; nao ajusta ou substitui o modelo do artigo."""
import csv
import hashlib
import json
import math
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
RESULTS = HERE.parent / 'entrega-2' / 'resultados'

def rows(path):
    with path.open(encoding='utf-8-sig', newline='') as stream:
        return list(csv.DictReader(stream))

def numeric(records):
    return [{k: float(v) if v and _is_number(v) else v for k, v in row.items()} for row in records]

def _is_number(value):
    try:
        float(value)
        return True
    except ValueError:
        return False

pred_file = REPO / 'estrutura/codigos/resultados/estudo-pico/pred.csv'
pred = rows(pred_file)
y = [int(row['y']) for row in pred]
p = [float(row['logistica']) for row in pred]
metrics = numeric(rows(RESULTS / 'metricas.csv'))
assert len(y) == 49509
assert abs(sum((a-b)**2 for a, b in zip(y,p))/len(y)-metrics[1]['brier']) < 1e-12

thresholds = []
for k in range(10, 91, 5):
    threshold = k/100
    tp = sum(a == 1 and b >= threshold for a,b in zip(y,p))
    fp = sum(a == 0 and b >= threshold for a,b in zip(y,p))
    fn, tn = sum(y)-tp, len(y)-sum(y)-fp
    thresholds.append(dict(limiar=threshold,tp=tp,fp=fp,fn=fn,tn=tn,
        sensibilidade=tp/(tp+fn),especificidade=tn/(tn+fp),acuracia=(tp+tn)/len(y)))
assert next(t for t in thresholds if t['limiar']==.5)['tp'] == 371

# Pontos ROC em todos os escores distintos (os fatores geram poucos perfis).
counts = {}
for a,b in zip(y,p):
    counts.setdefault(b,[0,0])[a] += 1
roc, tp, fp = [[0,0]], 0, 0
for score in sorted(counts, reverse=True):
    n0,n1 = counts[score]; tp += n1; fp += n0
    roc.append([fp/(len(y)-sum(y)),tp/sum(y)])
roc.append([1,1])
coefficients = numeric(rows(RESULTS / 'coeficientes.csv'))
bank = rows(HERE.parent / 'entrega-2' / 'entrega-2-sinistros.csv')
betas = {c['termo']: c['beta'] for c in coefficients}
test_bank = [row for row in bank if row['particao'] == 'teste']
assert len(test_bank) == len(pred)
for record, observed, probability in zip(test_bank, y, p):
    assert int(record['pico']) == observed
    score = betas['(Intercept)'] + sum(betas.get(key+record[key], 0) for key in ('via','dia','regiao'))
    assert abs(1/(1+math.exp(-score))-probability) < 1e-12
levels = {key: sorted({row[key] for row in bank}) for key in ('via','dia','regiao')}
data = dict(coorte=numeric(rows(RESULTS/'coorte.csv')),particoes=numeric(rows(RESULTS/'particoes.csv')),
    leitura=numeric(rows(RESULTS/'leitura_classificacao.csv')),exclusoes=numeric(rows(RESULTS/'exclusoes.csv')),
    metricas=metrics,coeficientes=coefficients,testes=numeric(rows(RESULTS/'testes.csv')),
    calibracao=numeric(rows(RESULTS/'calibracao.csv')),mensal=numeric(rows(RESULTS/'por_mes.csv')),
    incerteza=numeric(rows(RESULTS/'incerteza.csv')),roc=roc,limiares=thresholds,niveis=levels,
    relatorio=(RESULTS/'relatorio-logistica.txt').read_text(encoding='utf-8-sig'),
    diagnostico=numeric(rows(RESULTS/'diagnostico_calibracao.csv')),
    proveniencia=dict(modelo='pico ~ via + dia + regiao; binomial(logit)',
        fonte='entregas/entrega-2/resultados/',
        sha256_banco=hashlib.sha256((HERE.parent/'entrega-2'/'entrega-2-sinistros.csv').read_bytes()).hexdigest()))
(HERE/'src').mkdir(exist_ok=True)
(HERE/'src'/'dados.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print('Dados importados: 151.175 boletins, 49.509 probabilidades conferidas, um modelo.')
