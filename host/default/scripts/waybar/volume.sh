#!/usr/bin/env bash

# Obtiene el volumen actual (solo el número)
volume=$(pamixer --get-volume)

# Formatea el número con tres dígitos (añade ceros a la izquierda)
# Ejemplos: 5 -> "005", 45 -> "045", 100 -> "100"
printf "%03d" $volume