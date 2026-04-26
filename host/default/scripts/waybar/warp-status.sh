#!/usr/bin/env bash

# Ruta al ejecutable de warp-cli
WARP_CLI="/run/current-system/sw/bin/warp-cli"

# Obtener el estado actual
STATUS=$($WARP_CLI status 2>/dev/null | grep -oP '(?<=Status update: )[^ ]*')

# Determinar clase CSS e ícono según el estado
if [[ "$STATUS" == "Connected" ]]; then
    CLASS="connected"
    TEXT=""   # Ícono de VPN conectado
elif [[ "$STATUS" == "Disconnected" ]]; then
    CLASS="disconnected"
    TEXT=""   # Ícono de VPN desconectado
elif [[ "$STATUS" == "Connecting" ]]; then
    CLASS="connecting"
    TEXT="󱑋"   # Ícono de carga/conectando
else
    CLASS="unknown"
    TEXT="󰅗 WARP"   # Ícono de error
fi

# Salida en formato JSON para Waybar
echo "{\"text\": \"$TEXT\", \"class\": \"$CLASS\", \"alt\": \"$STATUS\"}"