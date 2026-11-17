import {chromium} from 'playwright';
import {strict as assert} from 'node:assert';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {mkdir,writeFile} from 'node:fs/promises';
const capture=process.argv.includes('--capturar');
const review=resolve('../../.impeccable/review');
await mkdir(review,{recursive:true});
const browser=await chromium.launch({executablePath:process.env.CHROME_PATH||(process.platform==='win32'?'C:/Program Files/Google/Chrome/Application/chrome.exe':undefined),headless:true});
const page=await browser.newPage({viewport:{width:1600,height:1000},reducedMotion:'reduce'});
const errors=[],network=[];page.on('pageerror',e=>errors.push(e.message));
await page.route(/^https?:/,route=>{network.push(route.request().url());route.abort();});
const url=pathToFileURL(resolve('apresentacao-final-appa.html')).href;
async function waitIndex(n){await page.waitForFunction(i=>document.querySelector('.slide')?.getAttribute('data-slide-index')===String(i),n);}
async function go(n){await page.goto(`${url}?slide=${n+1}`);await waitIndex(n);await page.evaluate(()=>document.fonts.ready);await page.waitForTimeout(150);}
try{
 await go(0);assert(await page.getByRole('heading',{name:/Sinistros/}).isVisible());
 await page.keyboard.press('ArrowRight');await waitIndex(1);
 await page.getByRole('button',{name:'Próximo slide',exact:true}).click();await waitIndex(2);
 await page.keyboard.press('ArrowLeft');await waitIndex(1);
 await page.getByRole('button',{name:'Abrir notas do apresentador'}).click();assert(await page.getByRole('complementary',{name:'Notas do apresentador'}).isVisible());
 await page.keyboard.press('Escape');assert(!(await page.getByRole('complementary',{name:'Notas do apresentador'}).count()));
 await page.getByRole('button',{name:'Abrir índice de slides'}).click();await page.getByRole('button',{name:/O alvo é uma regra/}).click();await waitIndex(3);
 const hour=page.getByRole('slider',{name:'Horário do boletim'});
 await hour.fill('389');assert((await page.locator('.target-result').textContent()).includes('Fora do pico = 0'));
 await hour.fill('390');assert((await page.locator('.target-result').textContent()).includes('Pico = 1'));
 await go(7);const original=await page.locator('.profile-output>strong').textContent();await page.getByLabel('Dia da semana',{exact:true}).selectOption('Domingo');assert.notEqual(await page.locator('.profile-output>strong').textContent(),original);
 await go(10);assert((await page.locator('.confusion').textContent()).includes('19.718'));
 const threshold=page.getByRole('slider',{name:'Limiar de classificação'});await threshold.fill('0.3');assert(!(await page.locator('.confusion').textContent()).includes('19.718'));
 const fits=[];
 for(let i=0;i<17;i++){
   await go(i);
   const outside=await page.locator('.slide-content').evaluate(el=>{const box=el.getBoundingClientRect();return [...el.querySelectorAll('h1,h2,h3,p,pre,table,.authors,.academic,.cohort,.profile-form,.confusion')].filter(n=>{const r=n.getBoundingClientRect();return r.bottom>box.bottom+1||r.top<box.top-1||r.right>box.right+1||r.left<box.left-1;}).map(n=>n.textContent.slice(0,80));});
   if(outside.length)fits.push({slide:i+1,outside});
   if(capture)await page.screenshot({path:resolve(review,`slide-${String(i+1).padStart(2,'0')}.png`)});
 }
 await go(0);if(capture)await page.screenshot({path:resolve(review,'desktop.png')});
 await page.setViewportSize({width:390,height:844});
 for(const i of [0,3,7,10]){await go(i);assert(await page.locator('.mobile-reading').isVisible());assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));
   if(i===3){const h=page.getByRole('slider',{name:'Horário do boletim no celular',exact:true});await h.fill('390');assert((await page.locator('.target-result').textContent()).includes('06:30'));assert((await page.locator('.mobile-demo output').textContent()).includes('Pico = 1'));await h.fill('1080');}
   if(i===7){const s=page.getByRole('combobox',{name:'Dia da semana no celular',exact:true});assert((await s.boundingBox()).height>=44);await s.selectOption('Domingo');assert.equal(await page.locator('.mobile-demo output').textContent(),await page.locator('.profile-output>strong').textContent());await s.selectOption('Segunda-feira');}
   if(i===10){const t=page.getByRole('slider',{name:'Limiar de classificação no celular',exact:true});assert((await t.boundingBox()).height>=44);await t.fill('.3');assert(!(await page.locator('.confusion').textContent()).includes('19.718'));await t.fill('.5');}
   if(capture)await page.screenshot({path:resolve(review,i===0?'mobile.png':`mobile-${i+1}.png`),fullPage:true});}
 await page.goto(`${url}?slide=invalido`);await waitIndex(0);
 assert.deepEqual(errors,[]);assert.deepEqual(network,[]);
 await writeFile(resolve(review,'ajuste-conteudo.json'),JSON.stringify(fits,null,2));
 assert.deepEqual(fits,[],'Conteudo ultrapassa a area reservada do slide');
 console.log('OK: navegação, índice, notas/Esc, limites do alvo, perfil, limiar, 17 slides, celular, URL inválida e execução sem rede.');
 console.log('Elementos fora da área de conteúdo:',JSON.stringify(fits));
}finally{await browser.close();}
