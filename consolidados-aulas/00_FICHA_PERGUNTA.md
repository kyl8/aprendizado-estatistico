# Ficha da pergunta — APPA
**Apoio:** ChatGPT.
**Solicitante:** Grupo APPA — Arthur Galvão, Pedro Henrique e Ailana.

Fonte: Entrega 1 do grupo, `entregas/entrega-1/2026-10-02-appa-entrega-1-pergunta.Rnw`.
Transcrição para leitura dos guias, conferida em 2026-10-25.

| Campo | Registro |
|---|---|
| Grupo | APPA — Arthur Galvão, Pedro Henrique, Ailana |
| Pergunta | Que características registradas dos sinistros estão associadas à ocorrência nos horários de pico? A base permite estimar associações, sem identificar causas. |
| Unidade original | Um boletim de sinistro fatal ou não fatal, após a seleção por tipo de registro. Notificações ficam fora do recorte de boletins. |
| Banco e dimensão | 273371 registros brutos, 50 colunas; 151833 boletins; 151591 eventos com data e horário válidos na Parte D. A preparação de pico (sem `turno` e sem tipo de via "NAO DISPONIVEL") mantém 12 colunas, sendo 11 preditores candidatos e a resposta, em 151175 boletins. |
| Resposta original | `pico`: classificação Pico/Fora do Pico nas janelas da Entrega 1. |
| Preditores e disponibilidade | Via, calendário e características registradas do sinistro. Horário determina a resposta `pico`; não deve ser usado para alegar previsão independente dela. Características posteriores ao sinistro servem à análise descritiva, não à previsão antes do evento. |
| Tarefa e métrica | Classificação na pergunta original. Na extensão Poisson, contagem por mês × dia da semana × hora, RMSE em sinistros, comparado à média e ao MQO nas mesmas dobras. |

A Parte D reconstrói a ficha operacional a partir da Entrega 1 existente e registra a análise auxiliar de contagem.
Em 11/11/2026, o solicitante informou que as confirmações estavam resolvidas; mantém-se a pergunta A por associação e o recorte de 151175 boletins. A alternativa de contagem permanece exploratória. Essa anotação registra a informação do solicitante, não uma transcrição de decisão do professor.
A leitura anterior contava 273372 linhas por causa de um registro fantasma: três logradouros têm ";" dentro de aspas e a leitura sem aspas desalinhava as colunas. Com as aspas respeitadas, a base tem 273371 registros, como informava o README antigo.
O código registra essas dimensões separadamente: os números não representam o mesmo recorte.
