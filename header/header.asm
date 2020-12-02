SECTION "Entry point", ROM0[$100]
nop
jp main ; $150

SECTION "Header", ROM0[$104]

REPT $150 - $104 ; On remplit tout avec des zéros, RGBFIX va corriger l'en-tête pour nous ^_^
	DB 0
ENDR