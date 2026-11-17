import {bundle} from '@remotion/bundler';
import {renderStill,selectComposition,openBrowser} from '@remotion/renderer';
import {mkdir} from 'node:fs/promises';
import {resolve} from 'node:path';
import {spawnSync} from 'node:child_process';
const executable=process.env.CHROME_PATH||(process.platform==='win32'?'C:/Program Files/Google/Chrome/Application/chrome.exe':undefined);
await mkdir('.capturas',{recursive:true});
const serveUrl=await bundle({entryPoint:resolve('src/remotion.tsx')});
const browser=await openBrowser('chrome',{browserExecutable:executable});
try{
 const composition=await selectComposition({serveUrl,id:'APPA',puppeteerInstance:browser});
 const total=composition.durationInFrames/300;
 for(let i=0;i<total;i++){
   await renderStill({serveUrl,composition,puppeteerInstance:browser,inputProps:{slideIndex:i,reducedMotion:true,interactive:false},
     frame:i*300+60,imageFormat:'jpeg',jpegQuality:95,output:resolve(`.capturas/slide-${String(i+1).padStart(2,'0')}.jpg`)});
   console.log(`Slide ${i+1}/${total}`);
 }
}finally{await browser.close({silent:true});}
const result=spawnSync('python',['scripts/montar-pdf.py'],{stdio:'inherit'});if(result.status!==0)process.exit(result.status??1);
