cristal_swp:

call wait_vblank
call lcd_off
ld de, 32*32 ; Taille de la map
ld hl, $9800
call clear_mem
call load_fonts

ld hl, $9920
ld de, texte.inserez_cristal
call display_text

call lcd_on_9800

di ; Désactivation des interruptions

; On va copier la "payload" dans la WRAM de la console
ld bc, 35
ld de, $C000
ld hl, .loop_mem
call copy_mem
jp $C000

; Démonstration de l'injection dans la SRAM, on va donner une GS Ball au joueur
.loop_mem
ld hl, $0148 ; On vérifie si la cartouche fait 2 Mo
ld a, [hl] ; On vérifie si la cartouche fait 2 Mo
cp $6 ; On vérifie si la cartouche fait 2 Mo
jp z, $C00C ; Si c'est le cas on saute à "ok"
jp $C000 ; Si ce n'est pas bon on repart depuis le début

;ok
ld a, $1
call $2FB8

ld hl, $BE3C ; On modifie la valeur principale
ld a, $0B
ld [hl], a

ld hl, $BE44 ; Mais également celle de "backup"
ld [hl], a
call $2FCE

ld a, $11 ; Détection en tant que CGB sinon le jeu ne démarrera pas étant donné qu'on a modifié l'accumulateur
jp $100