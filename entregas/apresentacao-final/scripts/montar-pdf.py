"""Monta o PDF com frames renderizados pelo Remotion, sem redesenhar os slides."""
from pathlib import Path
import fitz
import sys

n = int(sys.argv[1])
assert 0 < n < 1000
frames = [Path('.capturas') / f'slide-{i:02}.jpg' for i in range(1,n+1)]
assert all(p.is_file() for p in frames), 'Faltam frames renderizados'
doc = fitz.open()
for frame in frames:
    page = doc.new_page(width=960,height=540)
    page.insert_image(page.rect,filename=str(frame))
doc.set_metadata(dict(title='APPA - Sinistros em horários de pico',author='Arthur Galvão; Pedro Henrique; Ailana Pereira Gonsalez',
    subject='Demonstração de regressão logística - Teoria do Aprendizado Estatístico',creator='Remotion; montagem dos frames em PDF com PyMuPDF'))
doc.save('apresentacao-final-appa.pdf',garbage=4,deflate=True)
print(f'PDF exportado a partir de {n} frames Remotion.')
