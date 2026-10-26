# Ficha da pergunta — APPA

Fonte: Entrega 1 do grupo, `entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.Rnw`.
Transcrição para leitura dos guias, conferida em 2026-10-25.

| Campo | Registro |
|---|---|
| Grupo | APPA — Arthur Galvão, Pedro Henrique, Ailana |
| Pergunta | Por que os sinistros de trânsito acontecem com mais frequência nos horários de pico? A base permite estimar associações, sem identificar causas. |
| Unidade original | Um boletim de sinistro fatal ou não fatal, após a seleção por tipo de registro. Notificações ficam fora do recorte de boletins. |
| Banco e dimensão | 273372 registros brutos, 50 colunas; 151833 boletins; 151591 eventos com data e horário válidos na Parte D. A preparação original de pico mantém 13 colunas, sendo 12 preditores candidatos e a resposta. |
| Resposta original | `pico`: classificação Pico/Fora do Pico nas janelas da Entrega 1. |
| Preditores e disponibilidade | Via, calendário e características registradas do sinistro. Horário determina a resposta `pico`; não deve ser usado para alegar previsão independente dela. Características posteriores ao sinistro servem à análise descritiva, não à previsão antes do evento. |
| Tarefa e métrica | Classificação na pergunta original. Na extensão Poisson, contagem por mês × dia da semana × hora, RMSE em sinistros, comparado à média e ao MQO nas mesmas dobras. |

A Parte D reconstrói a ficha operacional a partir da Entrega 1 existente, sem inventar uma nova aprovação do grupo.
A leitura integral conferida contou 273372 linhas, uma a mais que os 273.371 citados no README antigo.
O código registra essas dimensões separadamente: os números não representam o mesmo recorte.
