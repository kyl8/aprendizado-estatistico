"""Monta o PDF com frames renderizados pelo Remotion, sem redesenhar os slides."""
from pathlib import Path
import fitz

frames = sorted(Path('.capturas').glob('slide-*.jpg'))
assert len(frames) == 17, f'Esperados 17 slides; encontrados {len(frames)}'
doc = fitz.open()
for frame in frames:
    page = doc.new_page(width=960,height=540)
    page.insert_image(page.rect,filename=str(frame))
doc.set_metadata(dict(title='APPA - Sinistros em horários de pico',author='Arthur Galvão; Pedro Henrique; Ailana Pereira Gonsalez',
    subject='Demonstração de regressão logística - Teoria do Aprendizado Estatístico',creator='Remotion; montagem dos frames em PDF com PyMuPDF'))
doc.save('apresentacao-final-appa.pdf',garbage=4,deflate=True)
print('PDF exportado a partir de 17 frames Remotion.')
