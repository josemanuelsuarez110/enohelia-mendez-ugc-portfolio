#!/usr/bin/env bash
# add-direct-brands.sh — Añadir bloque "Direct Collaborations" con KIKO MILANO LIPS y MORPHE
set -euo pipefail

REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

BRANCH="feat/add-direct-brands"
BASE="main"
PR_TITLE="feat(content): añadir colaboraciones directas (KIKO MILANO LIPS, MORPHE)"

echo "==> [0/8] Verificando estado"
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

echo "==> [1/8] Creando rama $BRANCH"
git checkout -b "$BRANCH"

echo "==> [2/8] Añadiendo bloque direct a messages/en.json"
python3 - << 'PYEOF'
import json
path = "messages/en.json"
with open(path, encoding="utf-8") as f:
    data = json.load(f)
data["brands"]["platforms"]["direct"] = {
    "name": "Direct Collaborations",
    "description": "Direct partnerships with brands",
    "brands": {
        "kikoLips": {"name": "KIKO MILANO LIPS", "category": "Lips"},
        "morphe": {"name": "MORPHE", "category": "Makeup Brushes"}
    }
}
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
print("OK: bloque direct añadido a en.json")
PYEOF

echo "==> [3/8] Añadiendo bloque direct a messages/es.json"
python3 - << 'PYEOF'
import json
path = "messages/es.json"
with open(path, encoding="utf-8") as f:
    data = json.load(f)
data["brands"]["platforms"]["direct"] = {
    "name": "Colaboraciones directas",
    "description": "Alianzas directas con marcas",
    "brands": {
        "kikoLips": {"name": "KIKO MILANO LIPS", "category": "Labiales"},
        "morphe": {"name": "MORPHE", "category": "Brochas de maquillaje"}
    }
}
with open(path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
print("OK: bloque direct añadido a es.json")
PYEOF

echo "==> [4/8] Actualizando page.tsx con la nueva plataforma"
sed -i 's/const platformKeys = \["nurilounge", "picky", "influenster"\] as const;/const platformKeys = ["nurilounge", "picky", "influenster", "direct"] as const;/' "app/[locale]/page.tsx"

# Verificar que el cambio se aplicó
if grep -q '"nurilounge", "picky", "influenster", "direct"' "app/[locale]/page.tsx"; then
  echo "OK: platformKeys actualizado"
else
  echo "AVISO: no se encontró el patrón exacto, revisar page.tsx"
fi

echo "==> [5/8] Verificando JSON"
node -e "JSON.parse(require('fs').readFileSync('messages/en.json','utf8')); JSON.parse(require('fs').readFileSync('messages/es.json','utf8')); console.log('JSON válido')"

echo "==> [6/8] Verificando lint"
npm run lint 2>&1 | tail -10

echo "==> [7/8] Verificando build"
rm -rf .next node_modules/.cache
npm run build 2>&1 | tail -20

echo "==> [8/8] Estado final"
git status --short

echo ""
echo "===================================================="
echo "✅ Colaboraciones directas añadidas"
echo "===================================================="
echo ""
echo "Siguiente:"
echo "  git add -A"
echo "  git commit -m \"$PR_TITLE\""
echo "  git push -u origin $BRANCH"
echo "  gh pr create --title \"$PR_TITLE\" --base $BASE --body \"Añade bloque Direct Collaborations con KIKO MILANO LIPS (Lips) y MORPHE (Makeup Brushes).\""
