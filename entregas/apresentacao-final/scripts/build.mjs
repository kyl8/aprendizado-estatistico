import {build} from 'esbuild';
import {readFile,writeFile} from 'node:fs/promises';
const result=await build({entryPoints:['src/main.tsx'],bundle:true,minify:true,format:'iife',write:false,outfile:'bundle/app.js',
  loader:{'.woff2':'dataurl','.woff':'dataurl','.ttf':'dataurl'},define:{'process.env.NODE_ENV':'"production"'},legalComments:'eof'});
const js=result.outputFiles.find(f=>f.path.endsWith('.js')).text.replaceAll('</script','<\\/script');
const css=result.outputFiles.find(f=>f.path.endsWith('.css')).text;
const shell=await readFile('index.html','utf8');
const html=shell.replace('<script type="module" src="/src/main.tsx"></script>',()=>`<style>${css}</style><script>${js}</script>`);
await writeFile('apresentacao-final-appa.html',html.replace(/[ \t]+$/gm,''));
console.log(`HTML offline gerado (${(html.length/1024/1024).toFixed(2)} MB). Fontes, código e dados incorporados.`);
