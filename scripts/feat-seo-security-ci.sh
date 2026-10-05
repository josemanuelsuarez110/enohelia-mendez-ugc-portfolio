#!/usr/bin/env bash
# feat-seo-security-ci.sh
# PR #1: SEO + Seguridad + CI para enohelia-mendez-ugc-portfolio
set -euo pipefail

REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

BRANCH="feat/seo-security-ci"
BASE="main"
PR_TITLE="feat: SEO profesional, headers de seguridad y CI"

echo "==> [1/9] Verificando estado del repo"
if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: hay cambios sin commitear. Abortando."
  git status --short
  exit 1
fi
git checkout "$BASE"
git pull origin "$BASE" --no-edit

echo "==> [2/9] Creando rama $BRANCH"
git checkout -b "$BRANCH" 2>/dev/null || { echo "La rama ya existe, cambiando a ella."; git checkout "$BRANCH"; }

echo "==> [3/9] Reescribiendo app/layout.tsx con metadata completa"
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
  title: {
    default: SITE_TITLE,
    template: "%s | Enohelia Mendez",
  },
  description: SITE_DESCRIPTION,
  keywords: [
    "UGC creator",
    "user generated content",
    "beauty UGC",
    "skincare UGC",
    "lifestyle UGC",
    "wellness UGC",
    "short-form video",
    "TikTok creator",
    "Instagram creator",
  ],
  authors: [{ name: "Enohelia Mendez" }],
  creator: "Enohelia Mendez",
  alternates: {
    canonical: "/",
  },
  openGraph: {
    type: "website",
    locale: "en_US",
    alternateLocale: ["es_ES"],
    url: SITE_URL,
    siteName: SITE_NAME,
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    images: [
      {
        url: "/opengraph-image.png",
        width: 1200,
        height: 630,
        alt: "Enohelia Mendez - UGC Creator",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    images: ["/opengraph-image.png"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  icons: {
    icon: "/favicon.ico",
  },
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
    "UGC",
    "User Generated Content",
    "Beauty",
    "Skincare",
    "Lifestyle",
    "Wellness",
    "Short-form video",
  ],
  email: "mailto:enoheliamendezmendez@gmail.com",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
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
        <a href="#work" className="skipLink">
          Skip to content
        </a>
        {children}
      </body>
    </html>
  );
}
EOF

echo "==> [4/9] Creando app/sitemap.ts"
cat > app/sitemap.ts << 'EOF'
import type { MetadataRoute } from "next";

const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";

export default function sitemap(): MetadataRoute.Sitemap {
  const now = new Date();
  return [
    {
      url: SITE_URL,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 1,
    },
  ];
}
EOF

echo "==> [5/9] Creando app/robots.ts"
cat > app/robots.ts << 'EOF'
import type { MetadataRoute } from "next";

const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
      },
    ],
    sitemap: `${SITE_URL}/sitemap.xml`,
    host: SITE_URL,
  };
}
EOF

echo "==> [6/9] Reescribiendo next.config.ts con headers de seguridad"
cat > next.config.ts << 'EOF'
import type { NextConfig } from "next";

const securityHeaders = [
  { key: "X-Frame-Options", value: "SAMEORIGIN" },
  { key: "X-Content-Type-Options", value: "nosniff" },
  { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
  {
    key: "Permissions-Policy",
    value: "camera=(), microphone=(), geolocation=(), interest-cohort=()",
  },
  {
    key: "Strict-Transport-Security",
    value: "max-age=63072000; includeSubDomains; preload",
  },
  {
    key: "X-DNS-Prefetch-Control",
    value: "on",
  },
];

const nextConfig: NextConfig = {
  poweredByHeader: false,
  async headers() {
    return [
      {
        source: "/(.*)",
        headers: securityHeaders,
      },
    ];
  },
};

export default nextConfig;
EOF

echo "==> [7/9] Creando workflows de CI"
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

      - name: Check tracked environment files
        run: |
          if git ls-files | grep -Eq '(^|/)\.env($|\.)'; then
            echo "ERROR: tracked environment file detected"
            git ls-files | grep -E '(^|/)\.env($|\.)'
            exit 1
          fi

      - name: Check tracked node_modules
        run: |
          if git ls-files | grep -q '^node_modules/'; then
            echo "ERROR: node_modules is tracked"
            exit 1
          fi

      - name: Lint
        run: npm run lint

      - name: Production build
        run: npm run build

      - name: Security audit (production, blocking)
        run: npm audit --omit=dev --audit-level=high

      - name: Security audit (dev, informational)
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
      - name: Checkout full history
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Scan repository for secrets
        uses: gitleaks/gitleaks-action@v3
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
EOF

echo "==> [8/9] Añadiendo estilos para skip link"
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

.skipLink:focus {
  left: 0;
}
EOF
fi

echo "==> [9/9] Verificando build y lint"
npm run lint
npm run build

echo ""
echo "===================================================="
echo "✅ Cambios aplicados correctamente"
echo "===================================================="
git status --short
echo ""
echo "Siguiente paso: commit, push y PR"
echo ""
echo "Ejecuta:"
echo "  git add -A"
echo "  git commit -m \"$PR_TITLE\""
echo "  git push -u origin $BRANCH"
echo "  gh pr create --title \"$PR_TITLE\" --body-file /tmp/pr-body.md --base $BASE"
