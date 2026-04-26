#!/usr/bin/env bash

WARP_CLI="/run/current-system/sw/bin/warp-cli"

# Función para enviar notificación
notify() {
    local status="$1"
    local icon=""
    local message=""

    if [[ "$status" == "Connected" ]]; then
        message="Conectado a Cloudflare"
    else
        message="Desconectado de Cloudflare"
    fi

    # Usar notify-send si está disponible (requiere libnotify)
    if command -v notify-send &>/dev/null; then
        notify-send -t 2000 -u normal "WARP" "$message"
    else
        echo "WARP: $message"  # Fallback a terminal
    fi
}

# Obtener el estado actual
CURRENT_STATUS=$($WARP_CLI status 2>/dev/null | grep -oP '(?<=Status update: )[^ ]*')

# Alternar estado
if [[ "$CURRENT_STATUS" == "Connected" ]]; then
    $WARP_CLI disconnect
    sleep 0.5  # Pequeña pausa para asegurar que el cambio se aplique
    notify "Disconnected"
else
    $WARP_CLI connect
    sleep 0.5
    notify "Connected"
fi