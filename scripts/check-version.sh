#!/usr/bin/env bash
set -euo pipefail

echo "== Wine =="
wine --version || { echo "Wine no disponible"; exit 1; }

echo "== MetaEditor =="
if [[ -f /opt/mql/metaeditor64.exe ]]; then
  # Extrae solo "Product Version: x.y.z.build"
  METAEDITOR_VERSION="$(exiftool /opt/mql/metaeditor64.exe \
    | sed -n 's/^Product Version[[:space:]]*:[[:space:]]*//p' \
    | head -n1)"
  if [[ -n "${METAEDITOR_VERSION:-}" ]]; then
    echo "${METAEDITOR_VERSION}"
  else
    echo "No se pudo extraer la versión de MetaEditor (exiftool sin salida)."
  fi
else
  echo "metaeditor64.exe no encontrado en /opt/mql/metaeditor64.exe"
  exit 1
fi