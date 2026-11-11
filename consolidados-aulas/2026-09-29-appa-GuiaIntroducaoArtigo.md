# Guia Tecnico de Apoio para a Introducao

Este documento estabelece as definicoes metodologicas, a formulacao da pergunta de pesquisa, as hipoteses testaveis e os componentes essenciais para a redacao da Introducao do artigo na disciplina de Teoria do Aprendizado Estatistico (grupo APPA).

---

## 1. Ficha Tecnica e Enquadramento Metodologico

* **Tema:** Modelagem inferencial dos fatores associados a maior frequencia e concentracao de sinistros viarios nos horarios de pico.
* **Objeto Central:** Investigar as causas sistemicas, viarias e de conflito de modais que explicam por que os sinistros tendem a ocorrer com maior frequencia nos horarios de pico pendular (trabalho e escola).
* **Base de Dados:** 151.833 boletins policiais de sinistros de transito do Estado de Sao Paulo (Infosiga SP), com recorte analitico na Baixada Santista.
* **Delimitacao da Disciplina:** O trabalho ancora-se estritamente no escopo de **Aprendizado Estatistico (Regressao Logistica, Modelos Lineares Generalizados, Selecao de Modelos e Reamostragem via Bootstrap e Validacao Cruzada)**.
* **Nota Metodologica:** A variavel de sazonalidade foi excluida da modelagem por pertencer a Series Temporais, preservando foco exclusivo na dinamica horaria e nas caracteristicas estruturais do trafego.
* **Norma Terminologica:** Emprego obrigatorio do termo tecnico "sinistro de transito" (ABNT NBR 10697), em substituicao ao termo leigo "acidente".

---

## 2. A Pergunta Central de Pesquisa

> **"Por que os sinistros de transito tendem a acontecer com mais frequencia nos horarios de pico?"**

---

## 3. Fundamentacao Teorica do Fenomeno (O Que Explica a Frequencia no Pico)

Para fundamentar teoricamente a resposta a essa pergunta na introducao e na revisao, o grupo deve articular os seguintes fatores comprovados pela engenharia de trafego:

1. **Exposicao Combinatoria ao Risco:** O volume maximo de veiculos e pessoas em circulacao simultanea multiplica exponencialmente os pontos potenciais de cruzamento e conflito de trajetorias.
2. **Reducao do Tempo de Reacao (*Headway* Critico):** No transito denso, os motoristas reduzem a distancia em relacao ao veiculo da frente, eliminando a margem de erro para frenagens bruscas (gerando alta frequencia de colisoes traseiras e engavetamentos).
3. **Fatores Humanos e Pressao Temporal:** Compromissos com horario fixo (trabalho e escola) aumentam a pressa, a impaciencia e comportamentos de risco (avanco de sinal amarelo/vermelho e mudancas intempestivas de faixa), combinados a fadiga matinal ou cansaço ao final do expediente.
4. **Heterogeneidade de Modais em Espaco Saturado:** Convivencia forcada e atrito entre veiculos pesados (onibus e caminhoes), automoveis de passeio, motocicletas em corredores viarios e travessias de pedestres e ciclistas.
5. **Instabilidade de Fluxo e Ondas de Choque ("Efeito Sanfona"):** Em vias saturadas, pequenas frenagens no inicio da fila propagam-se como ondas de desaceleracao brusca para os veiculos de tras.

---

## 4. Definicao de Target ($Y$) e Preditoras ($X$) no Aprendizado Estatistico

Para responder a pergunta atraves de modelos de classificacao e inferencia:

### Abordagem Principal: Classificacao da Ocorrencia no Pico (Assinatura do Pico)
* **Target ($Y$):** `is_pico` (Binaria: 0 ou 1)
  * `1` = Ocorrencia registrada em horario de pico pendular (06:30–08:30, 11:30–13:30 ou 17:00–19:30).
  * `0` = Ocorrencia registrada fora dos horarios de pico (entrepicos diurnos ou madrugada).
* **Variaveis Preditoras ($X$):**
  * `tipo_via`: Vias Urbanas vs. Estradas e Rodovias.
  * `tp_sinistro_primario`: Tipo de ocorrencia (colisao lateral, colisao traseira, choque, atropelamento).
  * Composicao de modais: `qtd_automovel`, `qtd_motocicleta`, `qtd_onibus`, `qtd_caminhao`, `qtd_pedestre`, `qtd_bicicleta`, `veiculos`.
  * `dia_da_semana`: Controle para diferenciar dias uteis (onde o pico de trabalho ocorre) de finais de semana.
  * `fatal` / severidade: Permite avaliar a relacao inversa entre alta frequencia de ocorrencias e menor proporcao de fatalidade no transito lento.
* **Interpretacao Inferencial:** Os coeficientes da regressao logistica evidenciarao quais fatores e tipos de modais elevam significativamente as chances relativas de um sinistro ocorrer no pico, revelando a "assinatura" da alta frequencia.

### Abordagem Complementar: Severidade Condicional ao Horario de Pico
* **Target ($Y$):** `fatal` (0 ou 1).
* **Preditora Central:** `faixa_horario` (Pico Manha, Almoco, Noite vs. Entrepico e Madrugada) e termos de interacao com modais (`faixa_horario * modais_vulneraveis`), demonstrando por que o aumento de frequencia no pico nao se traduz em aumento proporcional de letalidade para automoveis, mas agrava o risco para pedestres e ciclistas.

---

## 5. Hipoteses Testaveis de Trabalho

* **H1 (Densidade e Conflito de Modais):** A probabilidade de um sinistro pertencer ao horario de pico e impulsionada pela sobrecarga de veiculos de passeio e motocicletas em vias urbanas, associada a manobras de mudanca de faixa e disputas de cruzamento.
* **H2 (Atrito em Modais Ativos):** A concentracao de pedestres e ciclistas em horarios de entrada e saida escolar/comercial eleva significativamente a chance de sinistros com modais ativos nas faixas de pico matutino e vespertino em comparacao aos horarios de entrepico.
* **H3 (Predominancia de Tipos de Colisao):** Devido a reducao da distancia de seguimento (*headway*) e ao efeito sanfona do transito saturado, as colisoes traseiras e laterais apresentam chances relativas substancialmente maiores de ocorrer no pico em relacao a choques e capotamentos (mais frequentes em pistas livres).

---

## 6. Objetivos para a Redacao da Introducao

### Objetivo Geral
Investigar, por meio de modelos estatisticos inferenciais, os fatores determinantes que explicam a maior frequencia e concentracao de sinistros de transito nos horarios de pico, analisando a influencia da infraestrutura viaria e a composicao dos modais envolvidos.

### Objetivos Especificos
1. Parametrizar e classificar os registros de sinistros em janelas de pico pendular (matutino, intermediario e vespertino) e periodos de controle (entrepicos e madrugada).
2. Ajustar modelos de regressao logistica para identificar quais tipos de sinistro e perfis de veiculos aumentam a razao de chances de ocorrencia durante os horarios de pico.
3. Testar a hipotese da relacao inversa entre volume e severidade, demonstrando o comportamento da gravidade em funcao do congestionamento de pico.
4. Aplicar tecnicas de avaliacao de modelos e reamostragem (validacao cruzada e bootstrap) para certificar a estabilidade e a significancia dos fatores associados a concentracao no pico.

---

## 7. Direcionamento para Redacao: Blocos Obrigatorios

Ao redigir a introducao, estruture o raciocinio nesta sequencia logica:

1. **Abertura / Cenario Geral:** A seguranca viaria como prioridade de mobilidade urbana e saude publica, introduzindo a terminologia tecnica de sinistro de transito (NBR 10697).
2. **A Problemática da Concentracao Horaria:** Apresentar a constatacao empirica de que os sinistros se concentram intensamente nos horarios de pico pendular (inicio da manha e fim de tarde).
3. **A Lacuna de Conhecimento:** Explicar que apenas apontar que "ha mais acidentes no pico porque ha mais carros" e insuficiente: e necessario investigar os mecanismos estatisticos e operacionais (tipos de manobra, modais conflitantes e pressao viaria) que explicam essa alta frequencia.
4. **Enquadramento Metodologico:** Destacar a abordagem por Aprendizado Estatistico Inferencial (modelagem logistica e metodos de reamostragem) para isolar o papel de cada preditora.
5. **Pergunta e Hipoteses:** Declarar textualmente a pergunta de pesquisa (*"Por que os sinistros de transito tendem a acontecer com mais frequencia nos horarios de pico?"*) e as hipoteses a serem testadas.
6. **Objetivos e Relevancia Aplicada:** Fechar a secao com os objetivos da pesquisa e a contribuicao dos resultados para intervencoes semaforicas, fiscalizacao de cruzamentos e gestao de trafego urbano.
