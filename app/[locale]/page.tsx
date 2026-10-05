import { useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";

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
