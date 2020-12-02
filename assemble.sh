#!/bin/bash

echo "===== CRISTAL_SWP ====="
rgbasm -o "cristal_cartswap.obj" "main.asm"
echo "Création  des fichiers map et sym"
rgblink -p 0x0 -m "cristal_cartswap.map" -n "cristal_cartswap.sym" -o "cristal_cartswap.gbc" "cristal_cartswap.obj"
echo "Correction du header"
rgbfix -s -v -c -j -l 0x33 -r 0 -p 0 -t "CRISTAL_SWP" "cristal_cartswap.gbc"
echo "Assemblage"
