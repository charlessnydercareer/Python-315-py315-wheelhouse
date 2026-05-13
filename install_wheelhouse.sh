#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${WHEELHOUSE_DEST:-$HOME/.cache/py315-wheels}"
WHEELS_DIR="${REPO_ROOT}/wheels"

if [[ ! -d "$WHEELS_DIR" ]]; then
  echo "error: missing wheels/ directory" >&2
  exit 1
fi

mkdir -p "$DEST"

shopt -s nullglob
wheels=( "$WHEELS_DIR"/*.whl )
shopt -u nullglob

if [[ "${#wheels[@]}" -eq 0 ]]; then
  echo "error: no .whl files under wheels/" >&2
  exit 1
fi

for w in "${wheels[@]}"; do
  cp -f "$w" "$DEST/"
done

echo "Installed ${#wheels[@]} wheel(s) to $DEST"
