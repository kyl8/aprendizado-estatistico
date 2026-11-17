import {chromium} from 'playwright';
import {strict as assert} from 'node:assert';
import {resolve} from 'node:path';
import {pathToFileURL} from 'node:url';
import {writeFile} from 'node:fs/promises';
import {lerSlides} from './ler-slides.mjs';
const {slides}=await lerSlides();
const main=slides.filter(s=>!s.support);
const browser=await chromium.launch({executablePath:process.env.CHROME_PATH||(process.platform==='win32'?'C:/Program Files/Google/Chrome/Application/chrome.exe':undefined),headless:true});
const page=await browser.newPage({viewport:{width:1600,height:1000},reducedMotion:'reduce'});
const external=[],errors=[],steps=[];
page.on('pageerror',e=>errors.push(e.message));
await page.route(/^https?:/,route=>{external.push(route.request().url());route.abort();});
const started=performance.now();let clock=0;
try{
 await page.goto(pathToFileURL(resolve('apresentacao-final-appa.html')).href);
 await page.evaluate(()=>document.fonts.ready);
 for(const [i,s] of main.entries()){
  await page.waitForFunction(n=>document.querySelector('.slide')?.getAttribute('data-slide-index')===String(n),i);
  assert.equal(await page.locator('.slide').getAttribute('data-slide-kind'),s.kind);
  if(s.kind==='target'){
   await page.getByRole('button',{name:'06:29',exact:true}).click();
   assert((await page.locator('.target-result').textContent()).includes('Fora do pico = 0'));
   await page.getByRole('button',{name:'06:30',exact:true}).click();
   assert((await page.locator('.target-result').textContent()).includes('Pico = 1'));
  }
  if(s.kind==='profile'){
   const old=await page.locator('.profile-output>strong').textContent();
   await page.getByLabel('Dia da semana',{exact:true}).selectOption('Domingo');
   assert.notEqual(await page.locator('.profile-output>strong').textContent(),old);
   await page.getByLabel('Dia da semana',{exact:true}).selectOption('Segunda-feira');
  }
  if(s.kind==='threshold'){
   await page.getByRole('slider',{name:'Limiar de classificação',exact:true}).fill('.35');
   assert(await page.getByRole('heading',{name:/Exploração no teste/}).isVisible());
   await page.getByRole('button',{name:'Voltar a 0,5',exact:true}).click();
   assert((await page.locator('.confusion').textContent()).includes('19.718'));
  }
  steps.push({slide:i+1,kind:s.kind,speaker:s.speaker,start_seconds:clock,end_seconds:clock+s.seconds});
  clock+=s.seconds;
  if(i<main.length-1)await page.getByRole('button',{name:'Próximo slide',exact:true}).click();
 }
 assert(clock>=600&&clock<=720);assert.equal(errors.length,0);assert.equal(external.length,0);
 const report={mode:'simulacao tecnica acelerada, sem audio ou ensaio humano',planned_seconds:clock,actual_technical_seconds:Math.round((performance.now()-started)/100)/10,role_seconds:main.reduce((o,s)=>(o[s.speaker]=(o[s.speaker]||0)+s.seconds,o),{}),external_requests:external,browser_errors:errors,steps};
 await writeFile('simulacao-percurso.json',JSON.stringify(report,null,2)+'\n');
 console.log(JSON.stringify(report));
}finally{await browser.close();}
