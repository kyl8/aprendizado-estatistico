# Pendências que dependem do grupo

Itens que não dá para resolver só pelo código: dependem de decisão do grupo, de informação que só os integrantes têm ou de conversa com o professor. Nada aqui foi inventado ou preenchido por suposição.

## 1. Entregas individuais e de grupo (Aula 05b)

- [ ] **Consolidado individual de Arthur e de Ailana.** O guia (`guias-estudo/LEIAME_aula05b.md`) pede `consolidados/<nome>/aula05b_consolidado.md` por aluno. Hoje só existe o de Pedro Henrique, em `consolidados/Pedro_Henrique/`.
- [ ] **Conferir o consolidado do Pedro e o da Parte D com o que de fato aconteceu.** O modelo do guia pede um relato da sessão com o tutor: no individual, "opinião da tutora" e "Teste final: acertou M…/revisar M…"; na Parte D, os campos "presentes" e "digitou". Os arquivos atuais descrevem o conteúdo, não uma sessão real. Só quem participou sabe preencher.

## 2. Decisões com o professor

- [ ] **Pergunta da Entrega 1.** O texto passou de "por que os sinistros acontecem mais no pico?" (pergunta de causa) para "que características estão associadas à ocorrência no pico?" (associação), porque o banco não tem volume de tráfego. Confirmar com o professor se a reformulação é aceita ou se prefere a redação original.
- [ ] **Pergunta A (classificação Pico/Fora do Pico) ou B (contagem por mês × dia × hora).** A oficina (`consolidados/2026-10-25-appa-OficinaDuasPerguntas.md`) propõe a B, mas diz que a troca deve ser discutida com o professor antes de mudar a pergunta oficial.
- [ ] **Reenvio do PDF.** `entregas/finalizada/2026-10-02-appa-entrega-1-pergunta.pdf` foi recompilado após as correções (o texto antigo mostrava "NA sinistros" e listava `turno` como preditor). Se a entrega original já foi avaliada, decidir se reenvia.

## 3. Decisões de modelagem para validar

- [ ] **Recorte `NAO DISPONIVEL`.** Os modelos das Atividades 03 a 07 e 09 e a base de pico excluem 658 boletins com `tipo_via` ou `turno` = `NAO DISPONIVEL` (445 de 447 boletins com via não disponível são fatais; todos os 242 com turno não disponível são fatais). Os números dos relatórios mudaram por isso. O grupo precisa concordar com o recorte.
- [ ] **Leitura dos relatórios reescritos.** Os trechos "Resultado obtido" das Atividades 03a a 09 foram reescritos a partir das saídas do R. Vale uma leitura do grupo para garantir que as conclusões refletem o que vocês entendem.

## 4. Repositório e Git

- [ ] **Autoria dos commits.** Os commits do Pedro desde setembro aparecem como `Pedro <kyl8>`, sem e-mail válido, então o GitHub não os associa à conta. Ajustar `git config user.email` na máquina dele.
- [ ] **CSV de 67 MB** (`estrutura/corpus/2026-08-12-appa-Sinistros_2025_2026.csv`). Está acima do limite de aviso do GitHub (50 MB). Decidir entre Git LFS, manter assim ou baixar a base da fonte (Infosiga) e documentar o caminho. Mudar isso afeta o histórico.
- [ ] **Commit das correções.** Tudo foi alterado no diretório de trabalho e **não foi commitado**. Revisar o `git diff` e commitar pela máquina de vocês.
- [ ] **Regenerar resultados no Windows, se quiserem.** Os resultados foram gerados em Linux (R 4.3.3). As figuras PNG e os últimos dígitos de alguns CSVs diferem ligeiramente das versões feitas no Windows; os números das conclusões não mudam. Os arquivos da 05b, da oficina e da exploratória cujo conteúdo não mudou foram mantidos como estavam no git.
