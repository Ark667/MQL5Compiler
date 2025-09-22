#!/usr/bin/env bash
set -euo pipefail

WORK="${1:-/work/MQL5/Experts}"
INC="${2:-/work/MQL5}"
LOG="${3:-/work/build/compile.log}"

# Función para convertir rutas Linux -> Windows
linux_to_wine_path() {
    local linux_path="$1"
    # Reemplazar / con \\ y agregar unidad Z:
    echo "Z:${linux_path//\//\\\\}"
}

# Crear directorio de build
mkdir -p "$(dirname "$LOG")"

# Convertir rutas
WIN_WORK=$(linux_to_wine_path "$WORK")
WIN_INC=$(linux_to_wine_path "$INC")
WIN_LOG=$(linux_to_wine_path "$LOG")

echo "🔨 Compilando MQL5: $WORK"
echo "📁 Includes: $INC"
echo "📍 Ruta Windows: $WIN_WORK"

# Debug: mostrar rutas convertidas
echo "DEBUG - Win Work: $WIN_WORK"
echo "DEBUG - Win Inc: $WIN_INC"
echo "DEBUG - Win Log: $WIN_LOG"

# Ejecutar compilador MQL5
if wine /opt/mql/mql64.exe "$WIN_WORK" /i:"$WIN_INC" /log:"$WIN_LOG"; then
    echo "✅ Compilación exitosa"
    
    # Verificar si se creó el archivo compilado
    COMPILED_FILE=$(find "$(dirname "$WORK")" -name "*.ex5" -o -name "*.ex4" | head -1)
    if [ -n "$COMPILED_FILE" ]; then
        echo "📦 Archivo compilado: $COMPILED_FILE"
    else
        echo "⚠️  No se encontraron archivos compilados"
    fi
    
    # Mostrar log si existe
    if [ -f "$LOG" ]; then
        echo "📋 Log de compilación:"
        if command -v iconv >/dev/null 2>&1; then
            iconv -f UTF-16LE -t UTF-8 "$LOG" | head -20
        else
            head -20 "$LOG" 2>/dev/null || echo "(Log disponible en: $LOG)"
        fi
    else
        echo "⚠️  No se generó archivo de log"
    fi
    exit 0
else
    echo "❌ Error en la compilación"
    exit 1
fi