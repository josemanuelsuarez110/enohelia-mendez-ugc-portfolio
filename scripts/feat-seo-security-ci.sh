#!/usr/bin/env bash
# feat-seo-security-ci.sh v3
# PR #1: SEO + Seguridad + CI + Fix ESLint (flat config nativo Next 16)
set -euo pipefail

REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

BRANCH="feat/seo-security-ci"
BASE="main"
PR_TITLE="feat: SEO profesional, headers de seguridad y CI"

echo "==> [0/12] Verificando estado del repo"
if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: hay cambios sin commitear. Abortando."
  git status --short
  exit 1
fi
git checkout "$BASE"
git pull origin "$BASE" --no-edit

# Limpiar rama previa si existe
if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  echo "==> Rama $BRANCH ya existe, eliminándola para empezar limpio"
  git branch -D "$BRANCH"
fi

echo "==> [1/12] Creando rama $BRANCH"
git checkout -b "$BRANCH"

echo "==> [2/12] Fix .gitignore"
if ! grep -q "^\.vercel" .gitignore 2>/dev/null; then
  {
    echo ""
    echo "# Vercel"
    echo ".vercel"
    echo ""
    echo "# Build outputs"
    echo ".next"
    echo "out"
    echo "build"
  } >> .gitignore
fi

echo "==> [3/12] Fix eslint.config.mjs (flat config nativo Next 16)"
cat > eslint.config.mjs << 'EOF'
import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";

const eslintConfig = defineConfig([
  ...nextVitals,
  globalIgnores([
    ".next/**",
    "out/**",
    "build/**",
    "next-env.d.ts",
    ".vercel/**",
    "node_modules/**",
  ]),
]);

export default eslintConfig;
EOF

echo "==> [4/12] Fix apostrofes en app/page.tsx"
python3 - app/page.tsx << 'PYEOF'
import sys

path = sys.argv[1]
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

replacements = [
    ("Let's Work Together", "Let&apos;s Work Together"),
    ("Let's Create Together", "Let&apos;s Create Together"),
    ("I'm a UGC creator", "I&apos;m a UGC creator"),
    ("doesn't feel like", "doesn&apos;t feel like"),
    ("Hi, I'm Enohelia", "Hi, I&apos;m Enohelia"),
    ("Brands I've Worked With", "Brands I&apos;ve Worked With"),
    ("Let's Create", "Let&apos;s Create"),
]

for old, new in replacements:
    content = content.replace(old, new)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("OK: apostrofes corregidos")
PYEOF

echo "==> [5/12] Reescribiendo app/layout.tsx"
cat > app/layout.tsx << 'EOF'
import type { Metadata } from "next";
import "./globals.css";

const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";
const SITE_NAME = "Enohelia Mendez";
const SITE_TITLE = "Enohelia Mendez | UGC Creator";
const SITE_DESCRIPTION =
  "UGC creator specializing in beauty, skincare, lifestyle and wellness content. Authentic short-form video for brands that want real results.";

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: { default: SITE_TITLE, template: "%s | Enohelia Mendez" },
  description: SITE_DESCRIPTION,
  keywords: [
    "UGC creator", "user generated content", "beauty UGC",
    "skincare UGC", "lifestyle UGC", "wellness UGC",
    "short-form video", "TikTok creator", "Instagram creator",
  ],
  authors: [{ name: "Enohelia Mendez" }],
  creator: "Enohelia Mendez",
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    locale: "en_US",
    alternateLocale: ["es_ES"],
    url: SITE_URL,
    siteName: SITE_NAME,
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    images: [{
      url: "/opengraph-image.png",
      width: 1200, height: 630,
      alt: "Enohelia Mendez - UGC Creator",
    }],
  },
  twitter: {
    card: "summary_large_image",
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    images: ["/opengraph-image.png"],
  },
  robots: {
    index: true, follow: true,
    googleBot: {
      index: true, follow: true,
      "max-image-preview": "large", "max-snippet": -1,
    },
  },
  icons: { icon: "/favicon.ico" },
};

const personJsonLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: "Enohelia Mendez",
  jobTitle: "UGC Creator",
  description: SITE_DESCRIPTION,
  url: SITE_URL,
  image: `${SITE_URL}/images/enohelia-hero.png`,
  sameAs: [
    "https://www.tiktok.com/enomendez0",
    "https://www.instagram.com/eno_mendez",
    "https://www.facebook.com/eno.mendez",
  ],
  knowsAbout: [
    "UGC", "User Generated Content", "Beauty",
    "Skincare", "Lifestyle", "Wellness", "Short-form video",
  ],
  email: "mailto:enoheliamendezmendez@gmail.com",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <head>
        <link rel="preconnect" href="https://www.tiktok.com" />
        <link rel="preconnect" href="https://www.instagram.com" />
        <link rel="preconnect" href="https://www.facebook.com" />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(personJsonLd) }}
        />
      </head>
      <body>
        <a href="#work" className="skipLink">Skip to content</a>
        {children}
      </body>
    </html>
  );
}
EOF

echo "==> [6/12] Creando app/sitemap.ts"
cat > app/sitemap.ts << 'EOF'
import type { MetadataRoute } from "next";
const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";
export default function sitemap(): MetadataRoute.Sitemap {
  return [{
    url: SITE_URL,
    lastModified: new Date(),
    changeFrequency: "monthly",
    priority: 1,
  }];
}
EOF

echo "==> [7/12] Creando app/robots.ts"
cat > app/robots.ts << 'EOF'
import type { MetadataRoute } from "next";
const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";
export default function robots(): MetadataRoute.Robots {
  return {
    rules: [{ userAgent: "*", allow: "/" }],
    sitemap: `${SITE_URL}/sitemap.xml`,
    host: SITE_URL,
  };
}
EOF

echo "==> [8/12] Reescribiendo next.config.ts"
cat > next.config.ts << 'EOF'
import type { NextConfig } from "next";

const securityHeaders = [
  { key: "X-Frame-Options", value: "SAMEORIGIN" },
  { key: "X-Content-Type-Options", value: "nosniff" },
  { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
  { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=(), interest-cohort=()" },
  { key: "Strict-Transport-Security", value: "max-age=63072000; includeSubDomains; preload" },
  { key: "X-DNS-Prefetch-Control", value: "on" },
];

const nextConfig: NextConfig = {
  poweredByHeader: false,
  async headers() {
    return [{ source: "/(.*)", headers: securityHeaders }];
  },
};

export default nextConfig;
EOF

echo "==> [9/12] Creando workflows de CI"
mkdir -p .github/workflows

cat > .github/workflows/quality.yml << 'EOF'
name: Portfolio Quality Gate
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - name: Install dependencies
        run: npm ci
      - name: Check tracked env files
        run: |
          if git ls-files | grep -Eq '(^|/)\.env($|\.)'; then
            echo "ERROR: tracked env file"; exit 1
          fi
      - name: Check tracked node_modules
        run: |
          if git ls-files | grep -q '^node_modules/'; then
            echo "ERROR: node_modules tracked"; exit 1
          fi
      - name: Lint
        run: npm run lint
      - name: Production build
        run: npm run build
      - name: Audit (production, blocking)
        run: npm audit --omit=dev --audit-level=high
      - name: Audit (dev, informational)
        continue-on-error: true
        run: npm audit --audit-level=high || true
EOF

cat > .github/workflows/security.yml << 'EOF'
name: Secret Scan
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:
jobs:
  gitleaks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: gitleaks/gitleaks-action@v3
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
EOF

echo "==> [10/12] Añadiendo estilos skip link"
if ! grep -q "skipLink" app/globals.css; then
  cat >> app/globals.css << 'EOF'

/* Accessibility: skip link */
.skipLink {
  position: absolute;
  left: -9999px;
  top: 0;
  background: var(--foreground);
  color: var(--white);
  padding: 12px 20px;
  border-radius: 0 0 8px 0;
  z-index: 9999;
  font-weight: 700;
}
.skipLink:focus { left: 0; }
EOF
fi

echo "==> [11/12] Verificando lint"
npm run lint 2>&1 | tail -20

echo "==> [12/12] Verificando build"
npm run build 2>&1 | tail -25

echo ""
echo "===================================================="
echo "✅ Cambios aplicados correctamente"
echo "===================================================="
git status --short
echo ""
echo "Siguiente paso (automático con este comando):"
echo ""
echo "  git add -A"
echo "  git commit -m \"$PR_TITLE\""
echo "  git push -u origin $BRANCH"
echo "  gh pr create --title \"$PR_TITLE\" --base $BASE --body \"SEO completo (OG, Twitter, JSON-LD), sitemap, robots, headers de seguridad, workflows CI y fix de lint.\""
