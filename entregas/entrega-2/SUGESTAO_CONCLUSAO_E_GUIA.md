# Guia de Conclusão Humana e Edição Final — Artigo Entrega 2 (Grupo APPA)

Este documento reúne os pontos deixados intencionalmente em aberto em [artigo-final.Rnw](artigo-final.Rnw) para preenchimento humano pelos integrantes do **Grupo APPA**, além de uma sugestão-base pronta de **Considerações Finais** para adaptação.

---

## 1. Checklist exato do que falta preencher no `.Rnw`

Procure pelas marcações abaixo em `entregas/entrega-2/artigo-final.Rnw`:

1. **Identificação dos autores e notas de rodapé (linhas 204–220 de `artigo-final.Rnw`):**
   - `Pedro Henrique [Completar sobrenome]` → inserir o sobrenome completo do Pedro Henrique.
   - `[Completar RA]` → preencher o RA de cada integrante (Arthur Galvão, Pedro Henrique e Ailana Pereira Gonsalez).
   - `[Completar e-mail institucional]` → preencher o e-mail `@fatec.sp.gov.br` (ou institucional utilizado pelo grupo) de cada integrante.
2. **Bloco de discussão aplicada no final da Seção 5 (`DISCUSSÃO`, linhas 621–624 de `artigo-final.Rnw`):**
   - Localizar `\pendenciahumana{Discussão aplicada a ser completada pelo grupo...}` e substituir toda a caixa `\pendenciahumana{...}{...}` por **1 a 2 parágrafos** redigidos pelo grupo.
3. **Seção 6 (`CONSIDERAÇÕES FINAIS`, linhas 630–640 de `artigo-final.Rnw`):**
   - Localizar `\pendenciahumana{Seção 6 deixada em aberto para redação humana}{...}` e substituir toda a caixa `\pendenciahumana{...}{...}` pelo texto final das Considerações Finais (3 a 4 parágrafos, usando como referência a sugestão-base na Seção 3 abaixo).

> **Atenção:** Após editar `artigo-final.Rnw`, **sempre recompile o PDF** (Seção 4) para que `artigo-final.tex` e `artigo-final.pdf` fiquem sincronizados antes de enviar o e-mail final ao professor.

---

## 2. Orientação para o parágrafo de discussão aplicada (Seção 5)

Ao substituir a caixa da Seção 5, mantenham coerência com a apresentação (`entregas/apresentacao-final/`) e explorem:

- **Leitura territorial aplicada:** enquanto dias úteis elevam as chances de o boletim ocorrer nas faixas fixadas de pico (com razões de chances entre 1,48 na sexta-feira e 1,85 na terça-feira em comparação ao domingo), regiões altamente urbanizadas — como a Região Metropolitana de São Paulo (OR = 0,7795) e a Baixada Santista (OR = 0,8284) — apresentam menor proporção relativa estritamente nas janelas fixadas de pico em comparação à referência (Araçatuba), padrão compatível com maior dispersão temporal fora dessas faixas.
- **Decisão prática de limiar vs. contexto:** para um gestor de mobilidade ou fiscalização, usar mecanicamente o ponto de corte padrão τ = 0,5 desperdiça quase toda a detecção (apenas 371 de 20.089 boletins de pico). Mesmo que se reduza o limiar em exercícios exploratórios, variáveis exclusivamente contextuais (`via`, `dia` e `regiao`) concentram 98,51% das probabilidades estimadas abaixo de 0,5 (faixa de 0,2834 a 0,5178) e não substituem contagens de fluxo viário, características do trecho ou histórico horário de corredores específicos.

---

## 3. Sugestão de Conclusão Base (para reescrever/adaptar na Seção 6)

> *Adapte o texto abaixo com a redação própria do grupo, mantendo todos os números exatamente idênticos aos da Seção 4 (se colar diretamente em `artigo-final.Rnw`, lembre-se de escapar `%` como `\%` e `--` para intervalos no LaTeX):*

Este trabalho investigou em que medida características registradas de sinistros de trânsito — especificamente tipo de via, dia da semana e região administrativa — associam-se à ocorrência dentro das janelas operacionais de horário de pico no Estado de São Paulo, empregando a regressão logística como ferramenta principal supervisionada sobre 151.175 boletins policiais válidos do Infosiga-SP (2025–2026). A escolha de manter hora e turno fora do conjunto de preditores eliminou o vazamento estrutural da variável-alvo, permitindo avaliar honestamente quanto sinal temporal permanece contido apenas no contexto viário, semanal e geográfico.

Na validação temporal retrospectiva sobre o primeiro semestre de 2026 (`n = 49.509`), os resultados evidenciaram a necessidade de analisar denominadores e regras de pontuação de forma conjunta. Sob o limiar fixo de 0,5, a regressão logística atingiu 59,43% de acurácia (29.424 acertos), superando em apenas quatro acertos a referência constante de treino (59,42%; 29.420 acertos; diferença compatível com ruído amostral, McNemar p = 0,9121), ao passo que identificou somente 371 dos 20.089 boletins ocorridos no pico (sensibilidade de 1,85%). O escore de Brier (0,237184 contra 0,241157 da referência) e a AUC de 0,5757 indicam existência de sinal discriminativo modesto — impulsionado sobretudo pelos dias úteis de segunda a quinta-feira (OR entre 1,71 e 1,85) e por variações regionais confirmadas por testes agrupados por data —, porém insuficiente para separar com precisão os boletins de pico a partir dessas três covariáveis isoladas.

Do ponto de vista metodológico, o estudo reforça duas cautelas essenciais na análise de dados públicos de segurança viária. Em primeiro lugar, a auditoria das exclusões mostrou que 656 dos 658 registros descartados por ausência de horário ou via eram fatais, indicando que a limpeza não é neutra quanto à gravidade. Em segundo lugar, a ausência de denominadores de fluxo veicular e de viagens sem sinistro impede qualquer inferência causal ou afirmação sobre risco individual de circular nos horários de pico.

Como desdobramentos futuros, recomenda-se a realização de validação prospectiva em safras inéditas do Infosiga-SP, o pareamento dos boletins com medições externas de volume de tráfego e velocidade média por corredor viário, bem como a investigação controlada de termos de interação entre dia da semana e região ou de modelos baseados em árvores e contagem horária em protocolos experimentais independentes.

---

## 4. Como recompilar o PDF após preencher as lacunas

### Opção A — Localmente na raiz do repositório (R + TinyTeX/LaTeX)

```powershell
Rscript entregas/entrega-2/compilar-entrega-2.R
```

O script executa `knitr::knit()` sobre `artigo-final.Rnw`, gera `artigo-final.tex`, compila com `pdflatex` + `biber` (necessário para as citações e referências pela ABNT NBR 10520:2023 e NBR 6023:2018) e atualiza `entregas/entrega-2/artigo-final.pdf`.

### Opção B — Via Overleaf (se preferir editar diretamente no navegador)

1. Subir os arquivos `artigo-final.tex`, `referencias.bib` e a pasta `figuras/` de `entregas/entrega-2/`.
2. Nas configurações do projeto no Overleaf (*Menu → Compiler*), selecionar **pdfLaTeX** e garantir o uso de **Biber** para bibliografia (padrão do Overleaf quando `\usepackage[backend=biber]{biblatex}` está no preâmbulo).
3. Editar o texto diretamente nas caixas `\pendenciahumana` correspondentes em `artigo-final.tex` (e espelhar depois em `artigo-final.Rnw`, caso queira manter a reprodutibilidade pelo R).
