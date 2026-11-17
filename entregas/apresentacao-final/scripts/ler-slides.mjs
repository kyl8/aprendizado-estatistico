import {readFile} from 'node:fs/promises';
import {transform} from 'esbuild';
export async function lerSlides(){
 const source=await readFile(new URL('../src/slides.ts',import.meta.url),'utf8');
 const {code}=await transform(source,{loader:'ts',format:'esm'});
 return import('data:text/javascript;base64,'+Buffer.from(code).toString('base64'));
}
