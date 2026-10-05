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
