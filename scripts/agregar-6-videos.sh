#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
log()  { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
err()  { echo -e "${RED}✗${NC} $1"; exit 1; }

[ -f "package.json" ] && [ -d "app" ] || err "No estás en la raíz del repo"
cd "$(pwd)"

PAGE_FILE="app/[locale]/page.tsx"
ES_FILE="messages/es.json"
EN_FILE="messages/en.json"

[ ! -f "$PAGE_FILE" ] && err "No existe: $PAGE_FILE"
[ ! -f "$ES_FILE" ]   && err "No existe: $ES_FILE"
[ ! -f "$EN_FILE" ]   && err "No existe: $EN_FILE"

# -------------------------------------------------------------
# 0. Backup
# -------------------------------------------------------------
BACKUP_DIR=".backup-videos-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp "$PAGE_FILE" "$BACKUP_DIR/page.tsx.bak"
cp "$ES_FILE"   "$BACKUP_DIR/es.json.bak"
cp "$EN_FILE"   "$BACKUP_DIR/en.json.bak"
log "Backup en: $BACKUP_DIR"

# -------------------------------------------------------------
# 1. Verificar ffmpeg
# -------------------------------------------------------------
command -v ffmpeg >/dev/null 2>&1 || err "ffmpeg no instalado. Corre: sudo apt install ffmpeg"
log "ffmpeg: $(ffmpeg -version | head -1 | cut -d' ' -f3)"

# -------------------------------------------------------------
# 2. Preguntar ruta de videos originales
# -------------------------------------------------------------
echo ""
echo "==============================================="
echo "📁 ¿Dónde están los 6 videos nuevos?"
echo "==============================================="
echo ""
echo "Ejemplo: /home/jose/Videos/ugc-nuevos"
echo ""
read -p "Ruta: " SRC_DIR

[ -d "$SRC_DIR" ] || err "No existe la carpeta: $SRC_DIR"

# Listar los mp4 que hay
echo ""
echo "Videos encontrados en $SRC_DIR:"
ls -lh "$SRC_DIR"/*.mp4 2>/dev/null || err "No hay archivos .mp4 en $SRC_DIR"
echo ""

# Contar
VIDEO_COUNT=$(ls "$SRC_DIR"/*.mp4 2>/dev/null | wc -l)
log "Encontrados $VIDEO_COUNT videos"

if [ "$VIDEO_COUNT" -lt 6 ]; then
  warn "Se esperaban 6 videos, pero hay $VIDEO_COUNT"
  read -p "¿Continuar con los que hay? (s/n): " CONT
  [ "$CONT" = "s" ] || exit 0
fi

# -------------------------------------------------------------
# 3. Ordenar: el script asume que están nombrados en orden
# -------------------------------------------------------------
echo ""
echo "⚠️  IMPORTANTE: los archivos deben estar ordenados así:"
echo "   1º → 9WISHES"
echo "   2º → I'M FROM"
echo "   3º → PIXI"
echo "   4º → KIKO MILANO"
echo "   5º → NIVEA"
echo "   6º → HEAD & SHOULDERS"
echo ""
echo "Si el orden es distinto, renombra los archivos antes de continuar."
echo ""
read -p "¿Continuar? (s/n): " CONT
[ "$CONT" = "s" ] || exit 0

# -------------------------------------------------------------
# 4. Optimizar y copiar videos
# -------------------------------------------------------------
mkdir -p public/videos/originales

echo ""
log "Optimizando videos (esto puede tardar unos minutos)..."

BRAND_KEYS=("9wishes" "imFrom" "pixi" "kikoMilano" "nivea" "headShoulders")
BRAND_NAMES=("9WISHES" "I'M FROM" "PIXI" "KIKO MILANO" "NIVEA" "HEAD & SHOULDERS")

i=0
for video in $(ls "$SRC_DIR"/*.mp4 | sort); do
  if [ $i -ge 6 ]; then break; fi

  NUM=$((i + 4))
  PADDED=$(printf "%02d" $NUM)

  TARGET="public/videos/ugc-${PADDED}-web.mp4"
  POSTER="public/videos/ugc-${PADDED}-poster.jpg"
  ORIGINAL="public/videos/originales/ugc-${PADDED}.mp4"

  echo ""
  echo "  → Video $((i+1)): $(basename "$video") → ugc-${PADDED}-web.mp4"

  # Copiar original
  cp "$video" "$ORIGINAL"

  # Optimizar para web (vertical 720x1280, ~3MB)
  ffmpeg -y -i "$video" \
    -c:v libx264 -crf 28 -preset slow \
    -vf "scale=720:1280:force_original_aspect_ratio=decrease,pad=720:1280:(ow-iw)/2:(oh-ih)/2" \
    -c:a aac -b:a 128k \
    -movflags +faststart \
    -loglevel error \
    "$TARGET"

  # Generar poster (frame en el segundo 1)
  ffmpeg -y -i "$TARGET" -ss 00:00:01 -vframes 1 \
    -loglevel error "$POSTER"

  # Verificar
  TARGET_SIZE=$(du -h "$TARGET" | cut -f1)
  log "    Generado: $TARGET ($TARGET_SIZE)"

  i=$((i + 1))
done

log "6 videos optimizados"

# -------------------------------------------------------------
# 5. Actualizar page.tsx con los 6 nuevos videoKeys
# -------------------------------------------------------------
log "Actualizando videoKeys en page.tsx..."

python3 << 'PYEOF'
import re

path = "app/[locale]/page.tsx"
src = open(path, encoding="utf-8").read()

new_videoKeys = '''const videoKeys = [
  { src: "/videos/ugc-01-web.mp4", poster: "/videos/ugc-01-poster.jpg", brandKey: "lavoir" },
  { src: "/videos/ugc-02-web.mp4", poster: "/videos/ugc-02-poster.jpg", brandKey: "boostion" },
  { src: "/videos/ugc-03-web.mp4", poster: "/videos/ugc-03-poster.jpg", brandKey: "flouren" },
  { src: "/videos/ugc-04-web.mp4", poster: "/videos/ugc-04-poster.jpg", brandKey: "9wishes" },
  { src: "/videos/ugc-05-web.mp4", poster: "/videos/ugc-05-poster.jpg", brandKey: "imFrom" },
  { src: "/videos/ugc-06-web.mp4", poster: "/videos/ugc-06-poster.jpg", brandKey: "pixi" },
  { src: "/videos/ugc-07-web.mp4", poster: "/videos/ugc-07-poster.jpg", brandKey: "kikoMilano" },
  { src: "/videos/ugc-08-web.mp4", poster: "/videos/ugc-08-poster.jpg", brandKey: "nivea" },
  { src: "/videos/ugc-09-web.mp4", poster: "/videos/ugc-09-poster.jpg", brandKey: "headShoulders" },
] as const;'''

# Reemplazar el bloque videoKeys completo
src = re.sub(
    r'const videoKeys = \[.*?\] as const;',
    new_videoKeys,
    src,
    count=1,
    flags=re.DOTALL
)

open(path, "w", encoding="utf-8").write(src)
print("  videoKeys actualizado a 9 videos")
PYEOF

log "page.tsx actualizado"

# -------------------------------------------------------------
# 6. Añadir marcas a los archivos de traducción
# -------------------------------------------------------------
log "Añadiendo marcas a es.json y en.json..."

python3 << 'PYEOF'
import json

brands_to_add = {
    "9wishes":      "9WISHES",
    "imFrom":       "I'M FROM",
    "pixi":         "PIXI",
    "kikoMilano":   "KIKO MILANO",
    "nivea":        "NIVEA",
    "headShoulders": "HEAD & SHOULDERS",
}

# ES
with open("messages/es.json", encoding="utf-8") as f:
    es = json.load(f)
es.setdefault("work", {}).setdefault("brands", {}).update(brands_to_add)
with open("messages/es.json", "w", encoding="utf-8") as f:
    json.dump(es, f, ensure_ascii=False, indent=2)
print("  es.json actualizado")

# EN
with open("messages/en.json", encoding="utf-8") as f:
    en = json.load(f)
en.setdefault("work", {}).setdefault("brands", {}).update(brands_to_add)
with open("messages/en.json", "w", encoding="utf-8") as f:
    json.dump(en, f, ensure_ascii=False, indent=2)
print("  en.json actualizado")
PYEOF

log "Traducciones actualizadas"

# -------------------------------------------------------------
# 7. Resumen
# -------------------------------------------------------------
echo ""
echo "==============================================="
echo -e "${GREEN}✓ 6 videos agregados${NC}"
echo "==============================================="
echo ""
echo "Videos en public/videos/:"
ls -lh public/videos/ugc-0[4-9]-web.mp4
echo ""
echo "Posters generados:"
ls -lh public/videos/ugc-0[4-9]-poster.jpg
echo ""
echo "Archivos modificados:"
echo "  - $PAGE_FILE"
echo "  - $ES_FILE"
echo "  - $EN_FILE"
echo ""
echo "Backup en: $BACKUP_DIR"
echo ""
echo "Próximo paso:"
echo "  npm run dev"
echo "  Revisa http://localhost:3000/es"
echo ""
echo "Si todo se ve bien:"
echo "  git add ."
echo "  git commit -m 'feat(work): agregar 6 videos UGC (9WISHES, I\'M FROM, PIXI, KIKO MILANO, NIVEA, HEAD & SHOULDERS)'"
echo "  git push origin main"
echo ""
