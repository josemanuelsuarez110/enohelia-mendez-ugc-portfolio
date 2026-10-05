#!/usr/bin/env bash
# feat-content-pro.sh — PR #2b: Contenido profesional (marcas, caso, testimonios, media kit, FAQ)
set -euo pipefail

REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

BRANCH="feat/content-pro"
BASE="main"
PR_TITLE="feat(content): marcas por plataforma, caso de estudio, testimonios, media kit y FAQ"

echo "==> [0/14] Verificando estado"
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

echo "==> [1/14] Creando rama $BRANCH"
git checkout -b "$BRANCH"

echo "==> [2/14] Actualizando messages/en.json"
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
    "brands": "Brands",
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
    "views": "Views",
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
    "subtitle": "Authentic UGC content created through leading creator platforms.",
    "via": "via",
    "platforms": {
      "nurilounge": {
        "name": "Nurilounge",
        "description": "Global K-beauty creator platform",
        "brands": {
          "lavoir": { "name": "LAVOIR", "category": "Home & Lifestyle" },
          "boostion": { "name": "BOOSTION", "category": "Beauty & Wellness" },
          "wishes": { "name": "9WISHES", "category": "Skincare" },
          "flouren": { "name": "FLOUREN", "category": "Beauty" }
        }
      },
      "picky": {
        "name": "Picky",
        "description": "K-beauty creator app",
        "brands": {
          "mediheal": { "name": "MEDIHEAL", "category": "Skincare" },
          "wishes": { "name": "9WISHES", "category": "Skincare" }
        }
      },
      "influenster": {
        "name": "Influenster",
        "description": "Product review platform",
        "brands": {
          "palmers": { "name": "PALMER'S", "category": "Cocoa Butter" },
          "headShoulders": { "name": "HEAD & SHOULDERS", "category": "Scalp Care" },
          "mediheal": { "name": "MEDIHEAL", "category": "Skincare" }
        }
      }
    }
  },
  "caseStudy": {
    "eyebrow": "CASE STUDY",
    "title": "MEDIHEAL × Picky + Influenster",
    "brand": "MEDIHEAL",
    "origin": "South Korea",
    "platforms": "Picky + Influenster",
    "category": "Skincare",
    "format": "Product demo + review + before/after",
    "about": "MEDIHEAL is a Korean skincare brand known for its sheet masks, toner pads and serums, with a strong global presence and active creator campaigns.",
    "resultsTitle": "Results",
    "results": [
      "[Pending metric: total views]",
      "[Pending metric: engagement rate]",
      "[Pending metric: CTR / conversions]",
      "[Pending metric: use in paid ads]"
    ],
    "deliverablesTitle": "Deliverables",
    "deliverables": [
      "[N] short-form videos",
      "[N] photos",
      "Commercial use: [yes/no]",
      "Whitelisting: [yes/no]"
    ]
  },
  "testimonials": {
    "eyebrow": "TESTIMONIALS",
    "title": "What Brands Say",
    "items": [
      {
        "quote": "[Pending testimonial from brand]",
        "author": "[Name]",
        "role": "[Role], [Brand]"
      },
      {
        "quote": "[Pending testimonial from brand]",
        "author": "[Name]",
        "role": "[Role], [Brand]"
      },
      {
        "quote": "[Pending testimonial from brand]",
        "author": "[Name]",
        "role": "[Role], [Brand]"
      }
    ]
  },
  "mediaKit": {
    "eyebrow": "MEDIA KIT",
    "title": "Work With Me",
    "subtitle": "Flexible packages for brands of all sizes.",
    "cta": "Request Media Kit",
    "tiers": {
      "basic": {
        "name": "Basic",
        "description": "Single short-form video",
        "features": [
          "1 video (15-30s)",
          "1 revision",
          "Raw footage included",
          "Delivery in 5-7 days"
        ]
      },
      "standard": {
        "name": "Standard",
        "description": "Video bundle",
        "features": [
          "3 videos (15-30s)",
          "2 revisions",
          "Raw footage included",
          "Commercial use",
          "Delivery in 10-14 days"
        ],
        "badge": "Most popular"
      },
      "premium": {
        "name": "Premium",
        "description": "Full campaign",
        "features": [
          "5+ videos",
          "Unlimited revisions",
          "Raw footage + photos",
          "Commercial use + whitelisting",
          "Priority delivery"
        ]
      }
    }
  },
  "faq": {
    "eyebrow": "FAQ",
    "title": "Frequently Asked Questions",
    "items": [
      {
        "question": "How long does delivery take?",
        "answer": "Most single videos are delivered within 5-7 days. Bundles and campaigns take 10-14 days depending on scope."
      },
      {
        "question": "Do you offer revisions?",
        "answer": "Yes. Basic includes 1 revision, Standard 2, and Premium has unlimited revisions within the agreed scope."
      },
      {
        "question": "What is your process?",
        "answer": "Brief → concept → filming → editing → delivery → revision (if needed). I keep you updated at every step."
      },
      {
        "question": "Do you work in English and Spanish?",
        "answer": "Yes. I can create content in both languages, or voiceover in either."
      },
      {
        "question": "Do you offer commercial use and whitelisting?",
        "answer": "Yes. Commercial use is included in Standard and Premium. Whitelisting is available in Premium or as an add-on."
      },
      {
        "question": "How do I contact you?",
        "answer": "Email me at enoheliamendezmendez@gmail.com or use the contact button below."
      }
    ]
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
    "contact": "Contact",
    "follow": "Follow",
    "rights": "All rights reserved.",
    "builtBy": "Site built by",
    "builtByLink": "JMTechLab"
  }
}
EOF

echo "==> [3/14] Actualizando messages/es.json"
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
    "brands": "Marcas",
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
    "views": "Visualizaciones",
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
    "subtitle": "Contenido UGC auténtico creado a través de las principales plataformas de creadores.",
    "via": "vía",
    "platforms": {
      "nurilounge": {
        "name": "Nurilounge",
        "description": "Plataforma global de creadores K-beauty",
        "brands": {
          "lavoir": { "name": "LAVOIR", "category": "Hogar y estilo de vida" },
          "boostion": { "name": "BOOSTION", "category": "Belleza y bienestar" },
          "wishes": { "name": "9WISHES", "category": "Cuidado de la piel" },
          "flouren": { "name": "FLOUREN", "category": "Belleza" }
        }
      },
      "picky": {
        "name": "Picky",
        "description": "App de creadores K-beauty",
        "brands": {
          "mediheal": { "name": "MEDIHEAL", "category": "Cuidado de la piel" },
          "wishes": { "name": "9WISHES", "category": "Cuidado de la piel" }
        }
      },
      "influenster": {
        "name": "Influenster",
        "description": "Plataforma de reviews de productos",
        "brands": {
          "palmers": { "name": "PALMER'S", "category": "Manteca de cacao" },
          "headShoulders": { "name": "HEAD & SHOULDERS", "category": "Cuidado del cuero cabelludo" },
          "mediheal": { "name": "MEDIHEAL", "category": "Cuidado de la piel" }
        }
      }
    }
  },
  "caseStudy": {
    "eyebrow": "CASO DE ESTUDIO",
    "title": "MEDIHEAL × Picky + Influenster",
    "brand": "MEDIHEAL",
    "origin": "Corea del Sur",
    "platforms": "Picky + Influenster",
    "category": "Cuidado de la piel",
    "format": "Demo de producto + review + antes/después",
    "about": "MEDIHEAL es una marca coreana de skincare conocida por sus mascarillas, pads y serums, con una fuerte presencia global y campañas activas de creadores.",
    "resultsTitle": "Resultados",
    "results": [
      "[Métrica pendiente: views totales]",
      "[Métrica pendiente: engagement rate]",
      "[Métrica pendiente: CTR / conversiones]",
      "[Métrica pendiente: uso en ads pagados]"
    ],
    "deliverablesTitle": "Entregables",
    "deliverables": [
      "[N] videos cortos",
      "[N] fotos",
      "Uso comercial: [sí/no]",
      "Whitelisting: [sí/no]"
    ]
  },
  "testimonials": {
    "eyebrow": "TESTIMONIOS",
    "title": "Lo que dicen las marcas",
    "items": [
      {
        "quote": "[Testimonio pendiente de marca]",
        "author": "[Nombre]",
        "role": "[Cargo], [Marca]"
      },
      {
        "quote": "[Testimonio pendiente de marca]",
        "author": "[Nombre]",
        "role": "[Cargo], [Marca]"
      },
      {
        "quote": "[Testimonio pendiente de marca]",
        "author": "[Nombre]",
        "role": "[Cargo], [Marca]"
      }
    ]
  },
  "mediaKit": {
    "eyebrow": "MEDIA KIT",
    "title": "Trabajemos juntos",
    "subtitle": "Paquetes flexibles para marcas de todos los tamaños.",
    "cta": "Solicitar Media Kit",
    "tiers": {
      "basic": {
        "name": "Básico",
        "description": "Un video corto",
        "features": [
          "1 video (15-30s)",
          "1 revisión",
          "Material en bruto incluido",
          "Entrega en 5-7 días"
        ]
      },
      "standard": {
        "name": "Estándar",
        "description": "Paquete de videos",
        "features": [
          "3 videos (15-30s)",
          "2 revisiones",
          "Material en bruto incluido",
          "Uso comercial",
          "Entrega en 10-14 días"
        ],
        "badge": "Más popular"
      },
      "premium": {
        "name": "Premium",
        "description": "Campaña completa",
        "features": [
          "5+ videos",
          "Revisiones ilimitadas",
          "Material en bruto + fotos",
          "Uso comercial + whitelisting",
          "Entrega prioritaria"
        ]
      }
    }
  },
  "faq": {
    "eyebrow": "PREGUNTAS FRECUENTES",
    "title": "Preguntas frecuentes",
    "items": [
      {
        "question": "¿Cuánto tardas en entregar?",
        "answer": "La mayoría de videos individuales se entregan en 5-7 días. Paquetes y campañas toman 10-14 días según el alcance."
      },
      {
        "question": "¿Haces revisiones?",
        "answer": "Sí. Básico incluye 1 revisión, Estándar 2, y Premium tiene revisiones ilimitadas dentro del alcance acordado."
      },
      {
        "question": "¿Cuál es tu proceso?",
        "answer": "Brief → concepto → grabación → edición → entrega → revisión (si hace falta). Te mantengo informada en cada paso."
      },
      {
        "question": "¿Trabajas en español e inglés?",
        "answer": "Sí. Puedo crear contenido en ambos idiomas, o voz en off en cualquiera de los dos."
      },
      {
        "question": "¿Ofreces uso comercial y whitelisting?",
        "answer": "Sí. El uso comercial está incluido en Estándar y Premium. El whitelisting está disponible en Premium o como add-on."
      },
      {
        "question": "¿Cómo te contacto?",
        "answer": "Escríbeme a enoheliamendezmendez@gmail.com o usa el botón de contacto abajo."
      }
    ]
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
    "contact": "Contacto",
    "follow": "Sígueme",
    "rights": "Todos los derechos reservados.",
    "builtBy": "Sitio creado por",
    "builtByLink": "JMTechLab"
  }
}
EOF

echo "==> [4/14] Reescribiendo app/[locale]/page.tsx con secciones nuevas"
cat > "app/[locale]/page.tsx" << 'EOF'
import Image from "next/image";
import { useTranslations } from "next-intl";

const videoKeys = [
  { src: "/videos/ugc-01-web.mp4", poster: "/videos/ugc-01-poster.jpg", brandKey: "lavoir" },
  { src: "/videos/ugc-02-web.mp4", poster: "/videos/ugc-02-poster.jpg", brandKey: "boostion" },
  { src: "/videos/ugc-03-web.mp4", poster: "/videos/ugc-03-poster.jpg", brandKey: "flouren" },
] as const;

const serviceKeys = ["productDemo", "testimonials", "unboxing", "lifestyle", "beauty", "voiceover"] as const;
const platformKeys = ["nurilounge", "picky", "influenster"] as const;

type PlatformBrand = { name: string; category: string };

export default function Home() {
  const t = useTranslations();
  const marqueeItems = t.raw("marquee.items") as string[];
  const testimonials = t.raw("testimonials.items") as { quote: string; author: string; role: string }[];
  const caseResults = t.raw("caseStudy.results") as string[];
  const caseDeliverables = t.raw("caseStudy.deliverables") as string[];
  const faqItems = t.raw("faq.items") as { question: string; answer: string }[];

  return (
    <main>
      <nav className="nav" aria-label="Main navigation">
        <a href="#" className="logo">ENOHELIA MENDEZ</a>
        <div className="navLinks">
          <a href="#work">{t("nav.work")}</a>
          <a href="#about">{t("nav.about")}</a>
          <a href="#services">{t("nav.services")}</a>
          <a href="#brands">{t("nav.brands")}</a>
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
          <Image
            src="/images/enohelia-hero.png"
            alt={t("hero.imageAlt")}
            width={600}
            height={800}
            priority
            sizes="(max-width: 768px) 100vw, 50vw"
          />
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
                  width={720}
                  height={1280}
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
          <Image
            src="/images/enohelia-about.png"
            alt={t("about.imageAlt")}
            width={600}
            height={800}
            loading="lazy"
            sizes="(max-width: 768px) 100vw, 50vw"
          />
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

      <section id="brands" className="brandsSection">
        <div className="sectionHeading">
          <p className="eyebrow">{t("brands.eyebrow")}</p>
          <h2>{t("brands.title")}</h2>
          <p>{t("brands.subtitle")}</p>
        </div>

        <div className="platformsContainer">
          {platformKeys.map((pk) => {
            const brands = t.raw(`brands.platforms.${pk}.brands`) as Record<string, PlatformBrand>;
            return (
              <div className="platformBlock" key={pk}>
                <div className="platformHeader">
                  <span className="platformBadge">{t("brands.via")} {t(`brands.platforms.${pk}.name`)}</span>
                  <p className="platformDesc">{t(`brands.platforms.${pk}.description`)}</p>
                </div>
                <div className="brandsGrid">
                  {Object.entries(brands).map(([key, brand]) => (
                    <div className="brandCard" key={`${pk}-${key}`}>
                      <strong>{brand.name}</strong>
                      <span>{brand.category}</span>
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
        </div>
      </section>

      <section className="caseStudy">
        <div className="sectionHeading">
          <p className="eyebrow">{t("caseStudy.eyebrow")}</p>
          <h2>{t("caseStudy.title")}</h2>
        </div>
        <div className="caseStudyGrid">
          <div className="caseStudyMeta">
            <div><strong>{t("caseStudy.brand")}</strong><span>{t("caseStudy.origin")}</span></div>
            <div><strong>{t("caseStudy.category")}</strong><span>{t("caseStudy.format")}</span></div>
            <div><strong>{t("caseStudy.platforms")}</strong><span>{t("caseStudy.category")}</span></div>
          </div>
          <p className="caseStudyAbout">{t("caseStudy.about")}</p>
          <div className="caseStudyColumns">
            <div>
              <h3>{t("caseStudy.resultsTitle")}</h3>
              <ul>{caseResults.map((r) => <li key={r}>{r}</li>)}</ul>
            </div>
            <div>
              <h3>{t("caseStudy.deliverablesTitle")}</h3>
              <ul>{caseDeliverables.map((d) => <li key={d}>{d}</li>)}</ul>
            </div>
          </div>
        </div>
      </section>

      <section className="testimonials">
        <div className="sectionHeading">
          <p className="eyebrow">{t("testimonials.eyebrow")}</p>
          <h2>{t("testimonials.title")}</h2>
        </div>
        <div className="testimonialGrid">
          {testimonials.map((item, i) => (
            <blockquote className="testimonialCard" key={i}>
              <p>&ldquo;{item.quote}&rdquo;</p>
              <footer>
                <strong>{item.author}</strong>
                <span>{item.role}</span>
              </footer>
            </blockquote>
          ))}
        </div>
      </section>

      <section className="mediaKit">
        <div className="sectionHeading">
          <p className="eyebrow">{t("mediaKit.eyebrow")}</p>
          <h2>{t("mediaKit.title")}</h2>
          <p>{t("mediaKit.subtitle")}</p>
        </div>
        <div className="mediaKitGrid">
          {(["basic", "standard", "premium"] as const).map((tier) => {
            const features = t.raw(`mediaKit.tiers.${tier}.features`) as string[];
            return (
              <div className={`mediaKitCard mediaKitCard--${tier}`} key={tier}>
                <h3>{t(`mediaKit.tiers.${tier}.name`)}</h3>
                <p>{t(`mediaKit.tiers.${tier}.description`)}</p>
                <ul>{features.map((f) => <li key={f}>{f}</li>)}</ul>
              </div>
            );
          })}
        </div>
        <div className="mediaKitCta">
          <a href="mailto:enoheliamendezmendez@gmail.com?subject=Media%20Kit%20Request" className="primaryButton">
            {t("mediaKit.cta")}
          </a>
        </div>
      </section>

      <section className="faq">
        <div className="sectionHeading">
          <p className="eyebrow">{t("faq.eyebrow")}</p>
          <h2>{t("faq.title")}</h2>
        </div>
        <div className="faqList">
          {faqItems.map((item, i) => (
            <details className="faqItem" key={i}>
              <summary>{item.question}</summary>
              <p>{item.answer}</p>
            </details>
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

      <footer className="siteFooter">
        <div className="footerContent">
          <div>
            <strong>{t("footer.name")}</strong>
            <p>{t("footer.tagline")}</p>
          </div>
          <div>
            <a href="mailto:enoheliamendezmendez@gmail.com">enoheliamendezmendez@gmail.com</a>
            <div className="footerSocials">
              <a href="https://www.tiktok.com/enomendez0" target="_blank" rel="noopener noreferrer" aria-label="TikTok">TikTok</a>
              <a href="https://www.instagram.com/eno_mendez" target="_blank" rel="noopener noreferrer" aria-label="Instagram">Instagram</a>
              <a href="https://www.facebook.com/eno.mendez" target="_blank" rel="noopener noreferrer" aria-label="Facebook">Facebook</a>
            </div>
          </div>
        </div>
        <div className="footerBottom">
          <p>© {new Date().getFullYear()} {t("footer.name")} · {t("footer.rights")}</p>
          <p>{t("footer.builtBy")} <a href="https://jmtechlab.do" target="_blank" rel="noopener noreferrer">{t("footer.builtByLink")}</a></p>
        </div>
      </footer>
    </main>
  );
}
EOF

echo "==> [5/14] Añadiendo CSS para las nuevas secciones"
cat >> "app/[locale]/globals.css" << 'EOF'

/* Platform blocks */
.platformsContainer { max-width: 1250px; margin: auto; padding: 0 30px; display: flex; flex-direction: column; gap: 50px; }
.platformBlock { display: flex; flex-direction: column; gap: 20px; }
.platformHeader { display: flex; flex-direction: column; gap: 8px; align-items: flex-start; }
.platformBadge { display: inline-block; background: var(--foreground); color: var(--white); padding: 8px 18px; border-radius: 50px; font-size: 12px; font-weight: 800; letter-spacing: 2px; text-transform: uppercase; }
.platformDesc { color: #625c58; font-size: 14px; }

/* Case study */
.caseStudy { max-width: 1250px; margin: auto; padding: 100px 30px; }
.caseStudyGrid { display: flex; flex-direction: column; gap: 30px; margin-top: 40px; }
.caseStudyMeta { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; padding: 30px; background: var(--soft); border-radius: 20px; }
.caseStudyMeta > div { display: flex; flex-direction: column; gap: 5px; }
.caseStudyMeta strong { font-size: 14px; letter-spacing: 1px; text-transform: uppercase; color: var(--accent); }
.caseStudyMeta span { font-size: 18px; font-weight: 700; }
.caseStudyAbout { font-size: 18px; line-height: 1.7; color: #625c58; max-width: 800px; }
.caseStudyColumns { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }
.caseStudyColumns h3 { font-size: 20px; margin-bottom: 15px; }
.caseStudyColumns ul { list-style: none; display: flex; flex-direction: column; gap: 10px; }
.caseStudyColumns li { padding-left: 20px; position: relative; color: #625c58; }
.caseStudyColumns li::before { content: "→"; position: absolute; left: 0; color: var(--accent); font-weight: 700; }

/* Testimonials */
.testimonials { max-width: 1250px; margin: auto; padding: 100px 30px; }
.testimonialGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; margin-top: 40px; }
.testimonialCard { background: var(--white); padding: 30px; border-radius: 20px; display: flex; flex-direction: column; gap: 20px; border: 1px solid var(--soft); }
.testimonialCard p { font-size: 17px; line-height: 1.7; font-style: italic; color: var(--foreground); }
.testimonialCard footer { display: flex; flex-direction: column; gap: 4px; }
.testimonialCard footer strong { font-size: 15px; }
.testimonialCard footer span { font-size: 13px; color: var(--accent); font-weight: 700; }

/* Media Kit */
.mediaKit { max-width: 1250px; margin: auto; padding: 100px 30px; }
.mediaKitGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; margin-top: 40px; }
.mediaKitCard { background: var(--white); padding: 35px 30px; border-radius: 20px; border: 2px solid var(--soft); display: flex; flex-direction: column; gap: 15px; }
.mediaKitCard--standard { border-color: var(--accent); transform: scale(1.03); }
.mediaKitCard h3 { font-size: 26px; }
.mediaKitCard > p { color: var(--accent); font-weight: 700; font-size: 14px; letter-spacing: 1px; text-transform: uppercase; }
.mediaKitCard ul { list-style: none; display: flex; flex-direction: column; gap: 12px; margin-top: 10px; }
.mediaKitCard li { padding-left: 22px; position: relative; color: #625c58; }
.mediaKitCard li::before { content: "✓"; position: absolute; left: 0; color: var(--accent); font-weight: 900; }
.mediaKitCta { text-align: center; margin-top: 50px; }

/* FAQ */
.faq { max-width: 900px; margin: auto; padding: 100px 30px; }
.faqList { display: flex; flex-direction: column; gap: 15px; margin-top: 40px; }
.faqItem { background: var(--white); border: 1px solid var(--soft); border-radius: 15px; padding: 20px 25px; }
.faqItem summary { cursor: pointer; font-weight: 700; font-size: 17px; list-style: none; display: flex; justify-content: space-between; align-items: center; }
.faqItem summary::after { content: "+"; font-size: 24px; color: var(--accent); font-weight: 400; }
.faqItem[open] summary::after { content: "−"; }
.faqItem p { margin-top: 15px; color: #625c58; line-height: 1.7; }

/* Footer */
.siteFooter { background: var(--foreground); color: var(--white); padding: 60px 30px 30px; margin-top: 80px; }
.footerContent { max-width: 1250px; margin: auto; display: grid; grid-template-columns: 1fr 1fr; gap: 40px; padding-bottom: 40px; border-bottom: 1px solid rgba(255,255,255,0.1); }
.footerContent strong { font-size: 22px; letter-spacing: 4px; display: block; margin-bottom: 10px; }
.footerContent p { color: rgba(255,255,255,0.7); }
.footerContent a { color: var(--white); text-decoration: none; }
.footerSocials { display: flex; gap: 20px; margin-top: 15px; }
.footerSocials a { font-size: 14px; font-weight: 700; }
.footerBottom { max-width: 1250px; margin: auto; padding-top: 30px; display: flex; justify-content: space-between; flex-wrap: wrap; gap: 15px; font-size: 13px; color: rgba(255,255,255,0.6); }
.footerBottom a { color: var(--accent); font-weight: 700; }

@media (max-width: 768px) {
  .caseStudyColumns { grid-template-columns: 1fr; }
  .mediaKitCard--standard { transform: none; }
  .footerContent { grid-template-columns: 1fr; }
}
EOF

echo "==> [6/14] Verificando imports"
grep -n "next/image\|next-intl\|@/i18n" "app/[locale]/page.tsx" | head -5

echo "==> [7/14] Verificando lint"
npm run lint 2>&1 | tail -15

echo "==> [8/14] Verificando build"
rm -rf .next node_modules/.cache
npm run build 2>&1 | tail -25

echo ""
echo "===================================================="
echo "✅ PR #2b lista"
echo "===================================================="
git status --short
echo ""
echo "Siguiente:"
echo "  git add -A"
echo "  git commit -m \"$PR_TITLE\""
echo "  git push -u origin $BRANCH"
echo "  gh pr create --title \"$PR_TITLE\" --base $BASE --body \"Marcas agrupadas por plataforma (Nurilounge, Picky, Influenster), caso de estudio MEDIHEAL, testimonios, media kit 3 tiers, FAQ, migración a next/image, footer completo con crédito JMTechLab.\""
