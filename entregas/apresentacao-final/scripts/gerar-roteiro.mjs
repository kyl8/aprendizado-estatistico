import {writeFile} from 'node:fs/promises';
import {lerSlides} from './ler-slides.mjs';
const {slides}=await lerSlides(),main=slides.filter(s=>!s.support);
const tempo=s=>Math.floor(s/60)+':'+String(s%60).padStart(2,'0');
const palavras=s=>(s.match(/\S+/g)||[]).length;
const total=main.reduce((a,s)=>a+s.seconds,0),balance={};
for(const s of main)balance[s.speaker]=(balance[s.speaker]||0)+s.seconds;
if(total<600||total>720)throw Error('Roteiro fora de 10 a 12 minutos');
const out=['# Narrativa e roteiro de ensaio APPA','','**Eixo:** o que a acurácia não conta. A pergunta científica permanece a associação com o alvo pico entre boletins.','','**Tempo principal planejado: '+tempo(total)+'**, incluindo pausas e interações. '+main.length+' slides principais e '+(slides.length-main.length)+' de apoio. O roteiro é proposto para ensaio, não registro de uma apresentação realizada.','','## Distribuição sugerida','',...Object.entries(balance).map(([p,n])=>'- '+p+': '+tempo(n)+'.'),'','As participações incluem método, decisões e interpretação; a troca de pessoa acompanha a pergunta seguinte. Nenhum trecho depende de resposta da turma.','','## Sequência editorial','','| Slide | Responsável | Objetivo / mensagem central | Recurso visual | Tempo |','|---|---|---|---|---|'];
main.forEach((s,i)=>out.push('| '+(i+1)+'. '+s.title+' | '+s.speaker+' | '+s.message+' | '+s.visual+' | '+tempo(s.seconds)+' |'));
out.push('','## Roteiro completo para ensaio','');let start=0;
for(const [i,s] of main.entries()){
 out.push('### '+(i+1)+'. '+s.title,'','**'+s.speaker+' · '+tempo(start)+'–'+tempo(start+s.seconds)+' ('+s.seconds+' s)**','','Fala proposta:','','> '+s.talk,'','Pausa / interação: '+s.action,'','Transição: '+s.transition,'');start+=s.seconds;
}
out.push('## Roteiro compacto','','| Slide | Palavras-chave e observações |','|---|---|');
main.forEach((s,i)=>out.push('| '+(i+1)+' | '+s.note+' |'));
out.push('','## Contingência e ritmo','','Se a turma estiver silenciosa, o apresentador faz a pergunta e continua com a explicação prevista. Não há enquetes ou espera obrigatória. Em HTML, as três experiências usam os controles. Em PDF: narrar 06:29 fora / 06:30 pico; ler o perfil de exemplo; explicar que outro limiar mudaria as classes sem anunciar novos números. A matriz reportada fica em 0,5.','','Os slides de apoio são consultados apenas na arguição. Se o tempo for reduzido, preservar pergunta, unidade, alvo, partição, matriz e limites; encurtar a interação, sem eliminar a advertência sobre exploração do teste.','','## Estimativa de fala e simulação','','O texto principal tem '+palavras(main.map(s=>s.talk).join(' '))+' palavras por contagem de tokens separados por espaço. A 125 palavras/minuto, a leitura sem pausas levaria aproximadamente '+tempo(Math.round(palavras(main.map(s=>s.talk).join(' '))/125*60))+'. Números, gestos e interação exigem tempo adicional, já reservado no orçamento de '+tempo(total)+'. Esse cálculo é uma referência de planejamento; não mede a fala de cada integrante.','','O percurso técnico e o orçamento são verificados por npm test e npm run simular. A simulação do navegador é acelerada, sem áudio ou ensaio humano. A duração oral real precisa ser conferida pelo grupo. Não há evidência de que esse ensaio já ocorreu.','','## Apoio','','| Slide | Conteúdo |','|---|---|');
slides.forEach((s,i)=>{if(s.support)out.push('| '+(i+1)+' | '+s.title+' |');});
out.push('','A preparação para perguntas está em [ARGUICAO_APPA.md](ARGUICAO_APPA.md). A análise das duas estruturas narrativas, das fontes e da versão anterior está em [CURADORIA_APPA.md](../../CURADORIA_APPA.md).','','Este documento é gerado a partir de src/slides.ts por scripts/gerar-roteiro.mjs. Alterações na sequência, fala ou tempo devem ser feitas na fonte e regeneradas.');
await writeFile('NARRATIVA_E_ROTEIRO.md',out.join('\n')+'\n');
console.log('Roteiro gerado: '+tempo(total)+'; distribuicao '+JSON.stringify(balance));
