#!/usr/bin/env bash
# feat-i18n.sh — PR #2a: Bilingüe con next-intl
set -euo pipefail

REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

BRANCH="feat/i18n-next-intl"
BASE="main"
PR_TITLE="feat(i18n): sitio bilingüe en/es con next-intl"

echo "==> [0/12] Verificando estado"
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

echo "==> [1/12] Creando rama $BRANCH"
git checkout -b "$BRANCH"

echo "==> [2/12] Instalando next-intl"
npm install next-intl

echo "==> [3/12] Creando i18n/routing.ts"
mkdir -p i18n
cat > i18n/routing.ts << 'EOF'
import { defineRouting } from "next-intl/routing";

export const routing = defineRouting({
  locales: ["en", "es"],
  defaultLocale: "en",
  localePrefix: "always",
});

export type Locale = (typeof routing.locales)[number];
EOF

echo "==> [4/12] Creando i18n/request.ts"
cat > i18n/request.ts << 'EOF'
import { getRequestConfig } from "next-intl/server";
import { hasLocale } from "next-intl";
import { routing } from "./routing";

export default getRequestConfig(async ({ requestLocale }) => {
  const requested = await requestLocale;
  const locale = hasLocale(routing.locales, requested)
    ? requested
    : routing.defaultLocale;

  return {
    locale,
    messages: (await import(`../messages/${locale}.json`)).default,
  };
});
EOF

echo "==> [5/12] Creando middleware.ts"
cat > middleware.ts << 'EOF'
import createMiddleware from "next-intl/middleware";
import { routing } from "./i18n/routing";

export default createMiddleware(routing);

export const config = {
  matcher: ["/", "/(en|es)/:path*"],
};
EOF

echo "==> [6/12] Creando next.config.ts con plugin de next-intl"
cat > next.config.ts << 'EOF'
import type { NextConfig } from "next";
import createNextIntlPlugin from "next-intl/plugin";

const withNextIntl = createNextIntlPlugin("./i18n/request.ts");

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

export default withNextIntl(nextConfig);
EOF

echo "==> [7/12] Creando messages/en.json"
mkdir -p messages
cat > messages/en.json << 'EOF'
{
  "meta": {
    "title": "Enohelia Mendez | UGC Creator",
    "description": "UGC creator specializing in beauty, skincare, lifestyle and wellness content. Authentic short-form video for brands that want real results."
  },
  "nav": {
    "work": "Work",
    "about": "About",
    "services": "Services",
    "contact": "Work With Me",
    "langLabel": "Language"
  },
  "hero": {
    "eyebrow": "UGC CREATOR · BEAUTY · LIFESTYLE · WELLNESS",
    "titleLine1": "Content that feels real.",
    "titleLine2": "Stories that connect.",
    "text": "I create authentic, scroll-stopping content that helps brands connect with real people and turn attention into action.",
    "ctaPrimary": "View My Work",
    "ctaSecondary": "Let's Work Together",
    "imageAlt": "Enohelia - UGC Creator",
    "badgeTitle": "UGC",
    "badgeSubtitle": "Creator"
  },
  "marquee": {
    "items": ["BEAUTY", "SKINCARE", "LIFESTYLE", "WELLNESS", "PRODUCT DEMOS"]
  },
  "work": {
    "eyebrow": "SELECTED CONTENT",
    "title": "Featured Work",
    "subtitle": "Authentic short-form content created for brands and social media.",
    "videoAlt": "UGC video for {brand}",
    "brands": {
      "lavoir": "LAVOIR",
      "boostion": "BOOSTION",
      "flouren": "FLOUREN"
    }
  },
  "about": {
    "eyebrow": "MEET THE CREATOR",
    "title": "Hi, I'm Enohelia.",
    "p1": "I'm a UGC creator passionate about producing relatable, high-quality content that doesn't feel like traditional advertising.",
    "p2": "My content focuses on beauty, skincare, lifestyle and wellness, combining authentic storytelling with visually engaging short-form video.",
    "imageAlt": "About Enohelia",
    "stat1Title": "UGC",
    "stat1Label": "Short-form video",
    "stat2Title": "4+",
    "stat2Label": "Content niches",
    "stat3Title": "3",
    "stat3Label": "Social platforms"
  },
  "social": {
    "eyebrow": "SOCIAL REACH",
    "title": "38K+ Community",
    "subtitle": "An engaged audience across TikTok, Instagram and Facebook.",
    "followers": "Followers",
    "tiktok": "TIKTOK",
    "instagram": "INSTAGRAM",
    "facebook": "FACEBOOK"
  },
  "services": {
    "eyebrow": "WHAT I CREATE",
    "title": "UGC Services",
    "items": {
      "productDemo": { "title": "Product Demo", "desc": "Clear and engaging demonstrations showing your product in action." },
      "testimonials": { "title": "Testimonials", "desc": "Natural testimonial-style videos designed to build trust." },
      "unboxing": { "title": "Unboxing", "desc": "Authentic first impressions and visually engaging unboxing content." },
      "lifestyle": { "title": "Lifestyle", "desc": "Products naturally integrated into relatable everyday moments." },
      "beauty": { "title": "Beauty & Skincare", "desc": "Product-focused beauty content, routines and before-and-after concepts." },
      "voiceover": { "title": "Voiceover", "desc": "Short-form storytelling with clear voiceover and product visuals." }
    }
  },
  "brands": {
    "eyebrow": "BRAND COLLABORATIONS",
    "title": "Brands I've Worked With",
    "subtitle": "Creating authentic UGC content for beauty, skincare, haircare and lifestyle brands.",
    "items": {
      "lavoir": "Home & Lifestyle",
      "boostion": "Beauty & Wellness",
      "wishes": "Skincare",
      "flouren": "Beauty",
      "palmers": "Cocoa Butter",
      "mediheal": "Skincare",
      "headShoulders": "Scalp Serum",
      "kiko": "Lip Volume"
    }
  },
  "contact": {
    "eyebrow": "LET'S CREATE TOGETHER",
    "title": "Ready to bring your brand to life?",
    "text": "Available for UGC collaborations, product demonstrations, testimonials and long-term partnerships.",
    "cta": "Work With Me"
  },
  "footer": {
    "name": "ENOHELIA MENDEZ",
    "tagline": "UGC Creator · Beauty · Lifestyle · Wellness",
    "builtBy": "Site built by JMTechLab"
  }
}
EOF

echo "==> [8/12] Creando messages/es.json"
cat > messages/es.json << 'EOF'
{
  "meta": {
    "title": "Enohelia Mendez | Creadora UGC",
    "description": "Creadora UGC especializada en contenido de belleza, cuidado de la piel, estilo de vida y bienestar. Video corto auténtico para marcas que buscan resultados reales."
  },
  "nav": {
    "work": "Trabajo",
    "about": "Sobre mí",
    "services": "Servicios",
    "contact": "Trabajemos",
    "langLabel": "Idioma"
  },
  "hero": {
    "eyebrow": "CREADORA UGC · BELLEZA · ESTILO DE VIDA · BIENESTAR",
    "titleLine1": "Contenido que se siente real.",
    "titleLine2": "Historias que conectan.",
    "text": "Creo contenido auténtico que detiene el scroll y ayuda a las marcas a conectar con personas reales y convertir la atención en acción.",
    "ctaPrimary": "Ver mi trabajo",
    "ctaSecondary": "Trabajemos juntos",
    "imageAlt": "Enohelia - Creadora UGC",
    "badgeTitle": "UGC",
    "badgeSubtitle": "Creadora"
  },
  "marquee": {
    "items": ["BELLEZA", "CUIDADO DE LA PIEL", "ESTILO DE VIDA", "BIENESTAR", "DEMOS DE PRODUCTO"]
  },
  "work": {
    "eyebrow": "CONTENIDO SELECCIONADO",
    "title": "Trabajo destacado",
    "subtitle": "Contenido corto auténtico creado para marcas y redes sociales.",
    "videoAlt": "Video UGC para {brand}",
    "brands": {
      "lavoir": "LAVOIR",
      "boostion": "BOOSTION",
      "flouren": "FLOUREN"
    }
  },
  "about": {
    "eyebrow": "CONOCE A LA CREADORA",
    "title": "Hola, soy Enohelia.",
    "p1": "Soy creadora UGC y me apasiona producir contenido cercano y de alta calidad que no se sienta como publicidad tradicional.",
    "p2": "Mi contenido se centra en belleza, cuidado de la piel, estilo de vida y bienestar, combinando storytelling auténtico con video corto visualmente atractivo.",
    "imageAlt": "Sobre Enohelia",
    "stat1Title": "UGC",
    "stat1Label": "Video corto",
    "stat2Title": "4+",
    "stat2Label": "Nichos de contenido",
    "stat3Title": "3",
    "stat3Label": "Plataformas sociales"
  },
  "social": {
    "eyebrow": "ALCANCE SOCIAL",
    "title": "Comunidad de 38K+",
    "subtitle": "Una audiencia comprometida en TikTok, Instagram y Facebook.",
    "followers": "Seguidores",
    "tiktok": "TIKTOK",
    "instagram": "INSTAGRAM",
    "facebook": "FACEBOOK"
  },
  "services": {
    "eyebrow": "LO QUE CREO",
    "title": "Servicios UGC",
    "items": {
      "productDemo": { "title": "Demo de producto", "desc": "Demostraciones claras y atractivas que muestran tu producto en acción." },
      "testimonials": { "title": "Testimonios", "desc": "Videos estilo testimonio natural, diseñados para generar confianza." },
      "unboxing": { "title": "Unboxing", "desc": "Primeras impresiones auténticas y contenido de unboxing visualmente atractivo." },
      "lifestyle": { "title": "Estilo de vida", "desc": "Productos integrados de forma natural en momentos cotidianos cercanos." },
      "beauty": { "title": "Belleza y cuidado de la piel", "desc": "Contenido de belleza centrado en el producto, rutinas y conceptos antes/después." },
      "voiceover": { "title": "Voz en off", "desc": "Storytelling corto con voz en off clara y visuales del producto." }
    }
  },
  "brands": {
    "eyebrow": "COLABORACIONES DE MARCA",
    "title": "Marcas con las que he trabajado",
    "subtitle": "Creando contenido UGC auténtico para marcas de belleza, cuidado de la piel, cabello y estilo de vida.",
    "items": {
      "lavoir": "Hogar y estilo de vida",
      "boostion": "Belleza y bienestar",
      "wishes": "Cuidado de la piel",
      "flouren": "Belleza",
      "palmers": "Manteca de cacao",
      "mediheal": "Cuidado de la piel",
      "headShoulders": "Sérum para cuero cabelludo",
      "kiko": "Volumen de labios"
    }
  },
  "contact": {
    "eyebrow": "CREEMOS JUNTOS",
    "title": "¿Lista para dar vida a tu marca?",
    "text": "Disponible para colaboraciones UGC, demostraciones de producto, testimonios y alianzas a largo plazo.",
    "cta": "Trabajemos"
  },
  "footer": {
    "name": "ENOHELIA MENDEZ",
    "tagline": "Creadora UGC · Belleza · Estilo de vida · Bienestar",
    "builtBy": "Sitio creado por JMTechLab"
  }
}
EOF

echo "==> [9/12] Moviendo app a app/[locale]"
mkdir -p "app/[locale]"
git mv app/page.tsx "app/[locale]/page.tsx"
git mv app/layout.tsx "app/[locale]/layout.tsx"
git mv app/globals.css "app/[locale]/globals.css" 2>/dev/null || true

# Si globals.css se movió, actualizar el import en layout
if [ -f "app/[locale]/globals.css" ]; then
  sed -i 's|import "./globals.css"|import "./globals.css"|' "app/[locale]/layout.tsx"
fi

# favicon se queda en app/ (no en [locale])
if [ -f "app/favicon.ico" ]; then
  git mv app/favicon.ico "app/[locale]/favicon.ico" 2>/dev/null || true
fi

echo "==> [10/12] Reescribiendo app/[locale]/layout.tsx"
cat > "app/[locale]/layout.tsx" << 'EOF'
import type { Metadata } from "next";
import { NextIntlClientProvider, hasLocale } from "next-intl";
import { notFound } from "next/navigation";
import { routing } from "@/i18n/routing";
import { getTranslations } from "next-intl/server";
import "./globals.css";

const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "meta" });

  return {
    metadataBase: new URL(SITE_URL),
    title: { default: t("title"), template: "%s | Enohelia Mendez" },
    description: t("description"),
    alternates: {
      canonical: `/${locale}`,
      languages: {
        en: "/en",
        es: "/es",
      },
    },
    openGraph: {
      type: "website",
      locale: locale === "es" ? "es_ES" : "en_US",
      url: `${SITE_URL}/${locale}`,
      siteName: "Enohelia Mendez",
      title: t("title"),
      description: t("description"),
      images: [{ url: "/opengraph-image.png", width: 1200, height: 630, alt: "Enohelia Mendez - UGC Creator" }],
    },
    twitter: {
      card: "summary_large_image",
      title: t("title"),
      description: t("description"),
      images: ["/opengraph-image.png"],
    },
    robots: { index: true, follow: true },
    icons: { icon: "/favicon.ico" },
  };
}

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

const personJsonLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: "Enohelia Mendez",
  jobTitle: "UGC Creator",
  url: SITE_URL,
  image: `${SITE_URL}/images/enohelia-hero.png`,
  sameAs: [
    "https://www.tiktok.com/enomendez0",
    "https://www.instagram.com/eno_mendez",
    "https://www.facebook.com/eno.mendez",
  ],
  knowsAbout: ["UGC", "Beauty", "Skincare", "Lifestyle", "Wellness"],
  email: "mailto:enoheliamendezmendez@gmail.com",
};

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  if (!hasLocale(routing.locales, locale)) {
    notFound();
  }

  return (
    <html lang={locale}>
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
        <NextIntlClientProvider>
          <a href="#work" className="skipLink">Skip to content</a>
          {children}
        </NextIntlClientProvider>
      </body>
    </html>
  );
}
EOF

echo "==> [11/12] Creando app/[locale]/page.tsx traducido"
cat > "app/[locale]/page.tsx" << 'EOF'
import { useTranslations } from "next-intl";
import { Link } from "@/i18n/routing";

const videoKeys = [
  { src: "/videos/ugc-01-web.mp4", poster: "/videos/ugc-01-poster.jpg", brandKey: "lavoir" },
  { src: "/videos/ugc-02-web.mp4", poster: "/videos/ugc-02-poster.jpg", brandKey: "boostion" },
  { src: "/videos/ugc-03-web.mp4", poster: "/videos/ugc-03-poster.jpg", brandKey: "flouren" },
] as const;

const serviceKeys = ["productDemo", "testimonials", "unboxing", "lifestyle", "beauty", "voiceover"] as const;
const brandKeys = ["lavoir", "boostion", "wishes", "flouren", "palmers", "mediheal", "headShoulders", "kiko"] as const;

export default function Home() {
  const t = useTranslations();
  const marqueeItems = t.raw("marquee.items") as string[];

  return (
    <main>
      <nav className="nav" aria-label="Main navigation">
        <a href="#" className="logo">ENOHELIA MENDEZ</a>
        <div className="navLinks">
          <a href="#work">{t("nav.work")}</a>
          <a href="#about">{t("nav.about")}</a>
          <a href="#services">{t("nav.services")}</a>
          <a href="#contact" className="navButton">{t("nav.contact")}</a>
        </div>
      </nav>

      <section className="hero">
        <div className="heroContent">
          <p className="eyebrow">{t("hero.eyebrow")}</p>
          <h1>
            {t("hero.titleLine1")}
            <span>{t("hero.titleLine2")}</span>
          </h1>
          <p className="heroText">{t("hero.text")}</p>
          <div className="heroButtons">
            <a href="#work" className="primaryButton">{t("hero.ctaPrimary")}</a>
            <a href="#contact" className="secondaryButton">{t("hero.ctaSecondary")}</a>
          </div>
        </div>
        <div className="heroImage">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/images/enohelia-hero.png" alt={t("hero.imageAlt")} />
          <div className="imageBadge">
            <strong>{t("hero.badgeTitle")}</strong>
            <span>{t("hero.badgeSubtitle")}</span>
          </div>
        </div>
      </section>

      <section className="marquee" aria-hidden="true">
        {marqueeItems.map((item) => <span key={item}>{item}</span>)}
      </section>

      <section id="work" className="section">
        <div className="sectionHeading">
          <p className="eyebrow">{t("work.eyebrow")}</p>
          <h2>{t("work.title")}</h2>
          <p>{t("work.subtitle")}</p>
        </div>
        <div className="videoGrid">
          {videoKeys.map((v) => {
            const brand = t(`work.brands.${v.brandKey}`);
            return (
              <article className="videoCard" key={v.src}>
                <video
                  src={v.src}
                  poster={v.poster}
                  controls
                  playsInline
                  preload="none"
                  aria-label={t("work.videoAlt", { brand })}
                />
                <h3>{brand}</h3>
              </article>
            );
          })}
        </div>
      </section>

      <section id="about" className="about">
        <div className="aboutImage">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src="/images/enohelia-about.png" alt={t("about.imageAlt")} />
        </div>
        <div className="aboutContent">
          <p className="eyebrow">{t("about.eyebrow")}</p>
          <h2>{t("about.title")}</h2>
          <p>{t("about.p1")}</p>
          <p>{t("about.p2")}</p>
          <div className="stats">
            <div><strong>{t("about.stat1Title")}</strong><span>{t("about.stat1Label")}</span></div>
            <div><strong>{t("about.stat2Title")}</strong><span>{t("about.stat2Label")}</span></div>
            <div><strong>{t("about.stat3Title")}</strong><span>{t("about.stat3Label")}</span></div>
          </div>
        </div>
      </section>

      <section className="socialReach">
        <div className="sectionHeading">
          <p className="eyebrow">{t("social.eyebrow")}</p>
          <h2>{t("social.title")}</h2>
          <p>{t("social.subtitle")}</p>
        </div>
        <div className="socialGrid">
          <a href="https://www.tiktok.com/enomendez0" target="_blank" rel="noopener noreferrer" className="socialCard" aria-label="TikTok profile">
            <span>{t("social.tiktok")}</span><strong>10.1K</strong><p>{t("social.followers")}</p><small>@enomendez0 →</small>
          </a>
          <a href="https://www.instagram.com/eno_mendez" target="_blank" rel="noopener noreferrer" className="socialCard" aria-label="Instagram profile">
            <span>{t("social.instagram")}</span><strong>9K</strong><p>{t("social.followers")}</p><small>@eno_mendez →</small>
          </a>
          <a href="https://www.facebook.com/eno.mendez" target="_blank" rel="noopener noreferrer" className="socialCard" aria-label="Facebook profile">
            <span>{t("social.facebook")}</span><strong>18.9K</strong><p>{t("social.followers")}</p><small>Eno Mendez →</small>
          </a>
        </div>
      </section>

      <section id="services" className="section services">
        <div className="sectionHeading">
          <p className="eyebrow">{t("services.eyebrow")}</p>
          <h2>{t("services.title")}</h2>
        </div>
        <div className="serviceGrid">
          {serviceKeys.map((key, i) => (
            <div className="serviceCard" key={key}>
              <span>{String(i + 1).padStart(2, "0")}</span>
              <h3>{t(`services.items.${key}.title`)}</h3>
              <p>{t(`services.items.${key}.desc`)}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="brandsSection">
        <div className="sectionHeading">
          <p className="eyebrow">{t("brands.eyebrow")}</p>
          <h2>{t("brands.title")}</h2>
          <p>{t("brands.subtitle")}</p>
        </div>
        <div className="brandsGrid">
          {brandKeys.map((key) => (
            <div className="brandCard" key={key}>
              <strong>{key.toUpperCase()}</strong>
              <span>{t(`brands.items.${key}`)}</span>
            </div>
          ))}
        </div>
      </section>

      <section id="contact" className="contact">
        <p className="eyebrow">{t("contact.eyebrow")}</p>
        <h2>{t("contact.title")}</h2>
        <p>{t("contact.text")}</p>
        <a href="mailto:enoheliamendezmendez@gmail.com" className="contactButton">{t("contact.cta")}</a>
        <div className="socials">
          <a href="https://www.tiktok.com/enomendez0" target="_blank" rel="noopener noreferrer">TikTok</a>
          <a href="https://www.instagram.com/eno_mendez" target="_blank" rel="noopener noreferrer">Instagram</a>
          <a href="https://www.facebook.com/eno.mendez" target="_blank" rel="noopener noreferrer">Facebook</a>
        </div>
      </section>

      <footer>
        <strong>{t("footer.name")}</strong>
        <p>{t("footer.tagline")}</p>
      </footer>
    </main>
  );
}
EOF

echo "==> [12/12] Actualizando sitemap.ts para bilingüe"
cat > app/sitemap.ts << 'EOF'
import type { MetadataRoute } from "next";

const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";

export default function sitemap(): MetadataRoute.Sitemap {
  const now = new Date();
  return [
    {
      url: `${SITE_URL}/en`,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 1,
      alternates: {
        languages: { en: `${SITE_URL}/en`, es: `${SITE_URL}/es` },
      },
    },
    {
      url: `${SITE_URL}/es`,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 1,
      alternates: {
        languages: { en: `${SITE_URL}/en`, es: `${SITE_URL}/es` },
      },
    },
  ];
}
EOF

# Verificar tsconfig paths
if ! grep -q '"@/\*"' tsconfig.json; then
  python3 - << 'PYEOF'
import json
with open("tsconfig.json") as f:
    cfg = json.load(f)
cfg.setdefault("compilerOptions", {}).setdefault("paths", {})["@/*"] = ["./*"]
with open("tsconfig.json", "w") as f:
    json.dump(cfg, f, indent=2)
print("OK: paths @/* añadido a tsconfig.json")
PYEOF
fi

echo ""
echo "==> Verificando lint"
npm run lint 2>&1 | tail -15

echo ""
echo "==> Verificando build"
npm run build 2>&1 | tail -25

echo ""
echo "===================================================="
echo "✅ PR #2a lista"
echo "===================================================="
git status --short
echo ""
echo "Siguiente:"
echo "  git add -A"
echo "  git commit -m \"$PR_TITLE\""
echo "  git push -u origin $BRANCH"
echo "  gh pr create --title \"$PR_TITLE\" --base $BASE --body \"Sitio bilingüe en/es con next-intl. Rutas /en y /es, detección automática, selector en nav, sitemap con hreflang.\""
