INCLUDE "header/rst.asm"
INCLUDE "header/interrupts.asm"
INCLUDE "header/header.asm" ; En-tête de la cartouche
INCLUDE "system/hram.asm" ; Variables HRAM
INCLUDE "system/wram.asm" ; Variable WRAM

INCLUDE "graphics/fonts.asm" ; Gestion du texte

SECTION "CRISTAL_SWP", ROM0[$150]
main:

 ; On met ça dans la pile pour vérifier la console après avoir nettoyé la RAM :)
push af
push bc

ld a, %00000001
ldh [$FF], a ; Activation de l'interruption V-Blank
ei ; On active les interruptions

; ----- Nettoyage de la mémoire de la WRAM & HRAM ----

ld de, 8*1024
ld hl, $C000 ; WRAM
call clear_mem

ld de, 8*15
ld hl, $FF80 ; HRAM
call clear_mem

; ----- C'est tout propre ^_^ -----

ld a, %11100100 ; Palette DMG
ldh [$47], a

INCLUDE "splash_screen.asm"

INCLUDE "cristal_swp.asm"

INCLUDE "system/routines.asm"
INCLUDE "graphics/lcd.asm"

SECTION "Les tiles et le reste", ROMX[$4000]

INCLUDE "graphics/text/cartswap_strings.asm"

; ----- Tiles, map & palettes -----

INCLUDE "graphics/palettes.asm"
INCLUDE "graphics/tiles.asm"
INCLUDE "graphics/map.asm"