splash_screen:
	call wait_vblank
	call lcd_off

	; Maintenant qu'on a coupé l'écran on peut écrire librement dans la mémoire vidéo

	; ----- Nettoyage de la mémoire vidéo -----
	ld de, 4*40
	ld hl, $FE00 ; Table OAM
	call clear_mem

	ld de, 32*32 ; Taille de la map
	ld hl, $9800
	call clear_mem
	
	ld bc, 16*32
	ld de, $8010
	ld hl, splash_tiles
	call copy_mem

	ld b, 13
	ld c, 4
	ld de, $98E4
	ld hl, splash_map
	call load_map

	; Palette GBC
	ld b, 8
	ld hl, splash_pal
	call load_pal_bg

	call lcd_on_9800

	ld bc, $3C ; 1 sec
	call delay_frames