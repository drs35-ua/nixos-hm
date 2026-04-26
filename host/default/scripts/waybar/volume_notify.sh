#!/usr/bin/env bash
vol=$(pamixer --get-volume)
# Crear una barra de 20 caracteres (cada 5% = 1 bloque)
#bar=$(seq -s "█" $((vol / 5)) | sed 's/[0-9]//g')
#space=$(seq -s "░" $((20 - vol / 5)) | sed 's/[0-9]//g')
notify-send -t 800 -r 999 "Volumen ${vol}%"  -h int:value:$vol