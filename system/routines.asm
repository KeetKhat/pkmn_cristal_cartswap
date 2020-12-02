; ----- Gestion de la mémoire -----

; DE = Compteur d'itération
; HL = Adresse mémoire
clear_mem:
	xor a ; A = 0
	ld [hli], a ; On efface le premier octet et on incrémente
	dec de ; On décremente DE
	ld a, d
	or e ; On vérifie si DE est égal à 0
	jp nz, clear_mem ; S'il n'est pas égal à zéro, on retourne au label "clear_mem"
	ret

; BC = Compteur (Nombre d'octets à copier)
; DE = Adresse de destination
; HL = Adresse qui pointe vers les octets à copier
copy_mem:
	ld a, [hli] ; On met le premier octet dans A et on incrémente HL
	ld [de], a ; On copie A dans l'adresse de destination
	inc de ; On incrémente l'adresse de destination
	dec bc ; On décremente le compteur
	ld a, b
	or c ; On vérifie si BC est égal à 0
	jp nz, copy_mem ; Si ce n'est pas le cas on retourne au label "copy_mem"
	ret

; A = $11 = GBC
; A = $01 = DMG
; A = $FF = Pocket (On ne fera aucune distinction entre DMG et Pocket dans le code ci-dessous)
; B = 0 = !GBA
; B = 1 = GBA
check_console:
	cp $11 ; Quand un GBC démarre il inscrit $11 dans l'accumulateur, on se sert donc de ça pour déterminer si le jeu est lancé sur un GBC ou non
	jp z, .gbc
	xor a
	ld [console_type], a
	ret
.gbc
	ld a, b
	cp $1 ; Un GBA iscrit un bit dans le registre B quand il démarre
	jp z, .gba
	ld a, $1
	ld [console_type], a
	ret
.gba
	ld a, $2
	ld [console_type], a
	ret

; HL = Adresse de destination de la map
; DE = Label vers la chaîne de caractère
display_text:
	ld a, [de]
	ld [hli], a
	inc de
	and a
	jp nz, display_text
	ret