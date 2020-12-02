SECTION "HRAM Variables", HRAM

vblank_flag EQU $FF80
frame_counter EQU $FF81

; 0 = DMG/Pocket
; 1 = GBC
; 2 = GBA
console_type EQU $FF82