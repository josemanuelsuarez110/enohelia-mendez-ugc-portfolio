#!/usr/bin/env bash
# add-im-from.sh — Añadir I'M FROM a marcas vía Nurilounge
set -euo pipefail

REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

BRANCH="feat/add-im-from"
BASE="main"
PR_TITLE="feat(content): añadir I'M FROM a colaboraciones vía Nurilounge"

echo "==> [0/7] Verificando estado"
if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: cambios sin commitear. Abortando."
  git status --short
  exit 1
fi
git checkout "$BASE"
git pull origin "$BASE" --no-edit

if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  git branch -D "$BRANCH"
fi

echo "==> [1/7] Creando rama $BRANCH"
git checkout -b "$BRANCH"

echo "==> [2/7] Añadiendo I'M FROM a messages/en.json"
python3 - << 'PYEOF'
import json
path = "messages/en.json"
with open(path, encoding="utf-8") as f:
    data = json.load(f)
data["brands"]["platforms"]["nurilounge"]["brands"]["imfrom"] = {
    "name": "I'M FROM",
    "category": "Skincare"
}
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
print("OK: I'M FROM añadido a en.json")
PYEOF

echo "==> [3/7] Añadiendo I'M FROM a messages/es.json"
python3 - << 'PYEOF'
import json
path = "messages/es.json"
with open(path, encoding="utf-8") as f:
    data = json.load(f)
data["brands"]["platforms"]["nurilounge"]["brands"]["imfrom"] = {
    "name": "I'M FROM",
    "category": "Cuidado de la piel"
}
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
print("OK: I'M FROM añadido a es.json")
PYEOF

echo "==> [4/7] Verificando JSON"
node -e "JSON.parse(require('fs').readFileSync('messages/en.json','utf8')); JSON.parse(require('fs').readFileSync('messages/es.json','utf8')); console.log('JSON válido')"

echo "==> [5/7] Verificando lint"
npm run lint 2>&1 | tail -10

echo "==> [6/7] Verificando build"
rm -rf .next node_modules/.cache
npm run build 2>&1 | tail -20

echo "==> [7/7] Estado final"
git status --short

echo ""
echo "===================================================="
echo "✅ I'M FROM añadido"
echo "===================================================="
echo ""
echo "Siguiente:"
echo "  git add -A"
echo "  git commit -m \"$PR_TITLE\""
echo "  git push -u origin $BRANCH"
echo "  gh pr create --title \"$PR_TITLE\" --base $BASE --body \"Añade I'M FROM (Skincare) a las colaboraciones vía Nurilounge.\""
