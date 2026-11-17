import {chromium} from 'playwright';
import {strict as assert} from 'node:assert';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {mkdir,writeFile,readFile} from 'node:fs/promises';
import {lerSlides} from './ler-slides.mjs';
const {slides,MAIN_SLIDES}=await lerSlides();
const data=JSON.parse(await readFile('src/dados.json','utf8'));
const capture=process.argv.includes('--capturar'),review=resolve('../../.impeccable/review');
await mkdir(review,{recursive:true});
const index=kind=>{const n=slides.findIndex(s=>s.kind===kind);assert(n>=0);return n;};
const browser=await chromium.launch({executablePath:process.env.CHROME_PATH||(process.platform==='win32'?'C:/Program Files/Google/Chrome/Application/chrome.exe':undefined),headless:true});
const page=await browser.newPage({viewport:{width:1600,height:1000},reducedMotion:'reduce'});
const errors=[],network=[],fits=[];
page.on('pageerror',e=>errors.push(e.message));
await page.route(/^https?:/,route=>{network.push(route.request().url());route.abort();});
const url=pathToFileURL(resolve('apresentacao-final-appa.html')).href;
async function waitIndex(n){await page.waitForFunction(i=>document.querySelector('.slide')?.getAttribute('data-slide-index')===String(i),n);}
async function go(n){await page.goto(url+'?slide='+(n+1));await waitIndex(n);await page.evaluate(()=>document.fonts.ready);await page.waitForTimeout(130);}
try{
 assert.equal(MAIN_SLIDES,14);assert.equal(slides.filter(s=>!s.support).reduce((a,s)=>a+s.seconds,0),660);
 assert.equal(data.leitura[1].vp,371);assert.equal(data.leitura[1].fn,19718);
 assert.equal(data.leitura[1].acertos-data.leitura[0].acertos,4);
 await go(0);assert(await page.getByRole('heading',{name:/Acertar a maioria/}).isVisible());
 await page.keyboard.press('ArrowRight');await waitIndex(1);
 await page.getByRole('button',{name:'Próximo slide',exact:true}).click();await waitIndex(2);
 await page.keyboard.press('ArrowLeft');await waitIndex(1);
 await page.getByRole('button',{name:'Abrir notas do apresentador'}).click();assert(await page.getByRole('complementary',{name:'Notas do apresentador'}).isVisible());
 await page.getByText('Fala completa para ensaio',{exact:true}).click();assert((await page.getByRole('complementary',{name:'Notas do apresentador'}).textContent()).includes(slides[1].talk));
 await page.keyboard.press('Escape');assert(!(await page.getByRole('complementary',{name:'Notas do apresentador'}).count()));
 await page.getByRole('button',{name:'Abrir índice de slides'}).click();await page.getByRole('button',{name:/Às 06:29/}).click();await waitIndex(index('target'));
 await page.getByRole('button',{name:'06:29',exact:true}).click();assert((await page.locator('.target-result').textContent()).includes('Fora do pico = 0'));
 await page.getByRole('button',{name:'06:30',exact:true}).click();assert((await page.locator('.target-result').textContent()).includes('Pico = 1'));
 await page.getByRole('slider',{name:'Horário do boletim',exact:true}).fill('511');assert((await page.locator('.target-result').textContent()).includes('Fora do pico = 0'));
 await go(index('profile'));const original=await page.locator('.profile-output>strong').textContent();
 await page.getByLabel('Dia da semana',{exact:true}).selectOption('Domingo');assert.notEqual(await page.locator('.profile-output>strong').textContent(),original);
 await go(index('threshold'));assert((await page.locator('.confusion').textContent()).includes('19.718'));
 await page.getByRole('slider',{name:'Limiar de classificação',exact:true}).fill('.35');assert(!(await page.locator('.confusion').textContent()).includes('19.718'));
 assert(await page.getByRole('heading',{name:/Exploração no teste/}).isVisible());
 await page.getByRole('button',{name:'Voltar a 0,5',exact:true}).click();assert((await page.locator('.confusion').textContent()).includes('19.718'));
 await go(index('missed'));
 const ratio=await page.locator('.peak-bar').evaluate(e=>e.querySelector('i').getBoundingClientRect().width/e.getBoundingClientRect().width);
 assert(Math.abs(ratio-371/20089)<.0001,'Barra de VP deve preservar a proporcao real');
 for(let i=0;i<slides.length;i++){
  await go(i);
  const outside=await page.locator('.slide-content').evaluate(el=>{const box=el.getBoundingClientRect();return [...el.querySelectorAll('h1,h2,h3,p,pre,table,.authors,.academic,.cohort,.profile-form,.confusion,.peak-numbers,.balance,.closing-numbers')].filter(n=>{const r=n.getBoundingClientRect();return r.bottom>box.bottom+1||r.top<box.top-1||r.right>box.right+1||r.left<box.left-1;}).map(n=>n.textContent.slice(0,80));});
  if(outside.length)fits.push({slide:i+1,outside});
  if(capture)await page.screenshot({path:resolve(review,'slide-'+String(i+1).padStart(2,'0')+'.png')});
 }
 await go(0);if(capture)await page.screenshot({path:resolve(review,'desktop.png')});
 await page.setViewportSize({width:1280,height:800});
 for(const kind of ['cover','threshold']){await go(index(kind));if(capture)await page.screenshot({path:resolve(review,'projector-'+kind+'.png')});}
 await page.setViewportSize({width:390,height:844});
 for(const kind of ['cover','target','profile','threshold']){
  await go(index(kind));assert(await page.locator('.mobile-reading').isVisible());assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));
  if(kind==='target'){await page.getByRole('button',{name:'06:30 no celular',exact:true}).click();assert((await page.locator('.target-result').textContent()).includes('06:30'));assert((await page.locator('.mobile-demo output').textContent()).includes('Pico = 1'));}
  if(kind==='profile'){const s=page.getByRole('combobox',{name:'Dia da semana no celular',exact:true});assert((await s.boundingBox()).height>=44);await s.selectOption('Domingo');assert.equal(await page.locator('.mobile-demo output').textContent(),await page.locator('.profile-output>strong').textContent());await s.selectOption('Segunda-feira');}
  if(kind==='threshold'){const t=page.getByRole('slider',{name:'Limiar de classificação no celular',exact:true});assert((await t.boundingBox()).height>=44);await t.fill('.35');assert(!(await page.locator('.confusion').textContent()).includes('19.718'));await page.getByRole('button',{name:'Voltar a 0,5 no celular',exact:true}).click();}
  if(capture)await page.screenshot({path:resolve(review,kind==='cover'?'mobile.png':'mobile-'+kind+'.png'),fullPage:true});
 }
 await page.goto(url+'?slide=invalido');await waitIndex(0);
 assert.deepEqual(errors,[]);assert.deepEqual(network,[]);
 await writeFile(resolve(review,'ajuste-conteudo.json'),JSON.stringify(fits,null,2));
 console.log('Elementos fora da area de conteudo:',JSON.stringify(fits));
 assert.deepEqual(fits,[],'Conteudo ultrapassa a area reservada');
 await writeFile('validacao-apresentacao.json',JSON.stringify({slides:slides.length,principais:MAIN_SLIDES,apoio:slides.length-MAIN_SLIDES,tempo_planejado_segundos:660,
  verificacoes:['navegacao','indice','notas compactas/completas e Esc','fronteiras do alvo','perfil com coeficientes reais','limiar e restauracao','proporcao da barra VP','todos os slides','1280x800','390x844','controles moveis sincronizados','URL invalida','fontes e execucao offline'],
  erros:errors,requisicoes_externas:network,overflow:fits,ensaio_humano_executado:false},null,2)+'\n');
 console.log('OK: '+slides.length+' slides, interacoes, celular, projecao, notas e execucao sem rede.');
}finally{await browser.close();}
