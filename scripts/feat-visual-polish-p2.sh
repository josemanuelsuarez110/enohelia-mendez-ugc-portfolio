#!/usr/bin/env bash
# feat-visual-polish-p2.sh — Parte 2: CSS premium
set -euo pipefail
REPO_DIR="${1:-$HOME/ugc-portfolio}"
cd "$REPO_DIR"

echo "==> Reescribiendo app/[locale]/globals.css"
cat > "app/[locale]/globals.css" << 'CSS_EOF'
@import "tailwindcss";

:root {
  --background: #faf7f3;
  --background-end: #f5efe8;
  --foreground: #171412;
  --accent: #b35f4b;
  --accent-soft: #c47b6a;
  --secondary: #8b6f5e;
  --gold: #c9a961;
  --soft: #eee3dc;
  --white: #ffffff;
  --shadow-soft: 0 4px 20px rgba(23, 20, 18, 0.06);
  --shadow-medium: 0 10px 40px rgba(23, 20, 18, 0.10);
  --shadow-strong: 0 20px 60px rgba(23, 20, 18, 0.15);
  --radius-sm: 12px;
  --radius-md: 20px;
  --radius-lg: 30px;
  --radius-pill: 50px;
  --transition-smooth: cubic-bezier(0.22, 1, 0.36, 1);
}

* { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }

body {
  font-family: var(--font-body), Arial, Helvetica, sans-serif;
  background: linear-gradient(180deg, var(--background) 0%, var(--background-end) 100%);
  background-attachment: fixed;
  color: var(--foreground);
  line-height: 1.6;
  overflow-x: hidden;
}

a { color: inherit; text-decoration: none; transition: color 0.3s var(--transition-smooth); }
img, video { max-width: 100%; height: auto; display: block; }

h1, h2, h3, .logo {
  font-family: var(--font-display), Georgia, serif;
  font-weight: 500;
  letter-spacing: -0.02em;
  line-height: 1.15;
}

@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.scrollProgress {
  position: fixed;
  top: 0; left: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--accent), var(--gold));
  width: 0%;
  z-index: 9999;
  animation: scrollProgress linear;
  animation-timeline: scroll(root);
}
@keyframes scrollProgress { from { width: 0%; } to { width: 100%; } }

.skipLink {
  position: absolute; left: -9999px; top: 0;
  background: var(--foreground); color: var(--white);
  padding: 12px 20px; border-radius: 0 0 8px 0;
  z-index: 9999; font-weight: 700;
}
.skipLink:focus { left: 0; }

.whatsappFloat {
  position: fixed; bottom: 30px; right: 30px;
  width: 60px; height: 60px; border-radius: 50%;
  background: #25D366; color: white;
  display: flex; align-items: center; justify-content: center;
  box-shadow: 0 8px 30px rgba(37, 211, 102, 0.4);
  z-index: 999;
  transition: transform 0.3s var(--transition-smooth), box-shadow 0.3s var(--transition-smooth);
  animation: fadeInUp 0.6s var(--transition-smooth) 1s both;
}
.whatsappFloat:hover { transform: scale(1.1) translateY(-2px); box-shadow: 0 12px 40px rgba(37, 211, 102, 0.5); }

.nav {
  max-width: 1250px; margin: auto;
  height: 90px; padding: 0 30px;
  display: flex; align-items: center; justify-content: space-between;
  position: sticky; top: 0;
  background: rgba(250, 247, 243, 0.85);
  backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);
  z-index: 100;
}
.logo { font-size: 22px; font-weight: 600; letter-spacing: 4px; }
.navLinks { display: flex; gap: 32px; align-items: center; font-size: 14px; font-weight: 500; }
.navLinks a:not(.navButton):hover { color: var(--accent); }

.navButton, .primaryButton, .contactButton {
  background: var(--foreground); color: white;
  padding: 15px 26px; border-radius: var(--radius-pill);
  transition: transform 0.3s var(--transition-smooth), box-shadow 0.3s var(--transition-smooth), background 0.3s var(--transition-smooth);
  display: inline-block; font-weight: 600;
}
.navButton:hover, .primaryButton:hover, .contactButton:hover {
  transform: translateY(-2px); box-shadow: var(--shadow-medium); background: var(--accent);
}

.hero {
  max-width: 1250px; min-height: 700px; margin: auto;
  padding: 60px 30px 100px;
  display: grid; grid-template-columns: 1.1fr 0.9fr;
  gap: 70px; align-items: center;
  position: relative;
}
.hero::before {
  content: ""; position: absolute;
  top: -20%; right: -10%;
  width: 600px; height: 600px;
  background: radial-gradient(circle, rgba(179, 95, 75, 0.08) 0%, transparent 70%);
  z-index: -1; pointer-events: none;
}

.eyebrow {
  color: var(--accent); font-size: 12px;
  letter-spacing: 3px; font-weight: 800;
  margin-bottom: 20px;
  animation: fadeInUp 0.6s var(--transition-smooth) both;
}
.hero h1 {
  font-size: clamp(48px, 7vw, 100px);
  line-height: 0.95;
  letter-spacing: -0.04em;
  animation: fadeInUp 0.7s var(--transition-smooth) 0.1s both;
}
.hero h1 span { display: block; color: var(--accent); font-style: italic; font-weight: 400; }
.heroText {
  max-width: 580px; margin-top: 30px;
  font-size: 18px; line-height: 1.7; color: #625c58;
  animation: fadeInUp 0.7s var(--transition-smooth) 0.2s both;
}
.heroButtons {
  display: flex; gap: 15px; margin-top: 35px;
  animation: fadeInUp 0.7s var(--transition-smooth) 0.3s both;
}
.primaryButton, .secondaryButton { padding: 17px 30px; border-radius: var(--radius-pill); font-weight: 600; }
.secondaryButton {
  border: 1px solid #aaa19b;
  transition: border-color 0.3s var(--transition-smooth), color 0.3s var(--transition-smooth);
}
.secondaryButton:hover { border-color: var(--accent); color: var(--accent); }

.heroImage { position: relative; animation: fadeInUp 0.9s var(--transition-smooth) 0.3s both; }
.heroImage img { border-radius: var(--radius-lg); box-shadow: var(--shadow-strong); width: 100%; height: auto; object-fit: cover; }
.imageBadge {
  position: absolute; bottom: 20px; left: 20px;
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  padding: 14px 20px; border-radius: var(--radius-md);
  display: flex; flex-direction: column; box-shadow: var(--shadow-soft);
}
.imageBadge strong { font-size: 14px; letter-spacing: 2px; color: var(--accent); font-weight: 800; }
.imageBadge span { font-size: 12px; color: var(--foreground); letter-spacing: 1px; }

.marquee {
  background: var(--foreground); color: var(--white);
  padding: 24px 0; overflow: hidden;
  white-space: nowrap; display: flex; gap: 60px;
  animation: marquee 30s linear infinite;
}
.marquee span { font-size: 14px; letter-spacing: 4px; font-weight: 700; flex-shrink: 0; }
@keyframes marquee { from { transform: translateX(0); } to { transform: translateX(-50%); } }

.section { max-width: 1250px; margin: auto; padding: 120px 30px; }
.sectionHeading { text-align: center; margin-bottom: 60px; max-width: 700px; margin-left: auto; margin-right: auto; }
.sectionHeading h2 { font-size: clamp(36px, 5vw, 60px); margin-bottom: 15px; color: var(--foreground); }
.sectionHeading > p:last-child { color: #625c58; font-size: 17px; }

.videoGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; }
.videoCard {
  background: var(--white); border-radius: var(--radius-md);
  padding: 15px; box-shadow: var(--shadow-soft);
  transition: transform 0.4s var(--transition-smooth), box-shadow 0.4s var(--transition-smooth);
}
.videoCard:hover { transform: translateY(-6px); box-shadow: var(--shadow-medium); }
.videoCard video { width: 100%; border-radius: var(--radius-sm); background: var(--soft); }
.videoCard h3 { margin-top: 15px; font-size: 18px; text-align: center; }

.about {
  max-width: 1250px; margin: auto; padding: 120px 30px;
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 70px; align-items: center;
}
.aboutImage img { border-radius: var(--radius-lg); box-shadow: var(--shadow-medium); }
.aboutContent h2 { font-size: clamp(32px, 4vw, 48px); margin-bottom: 25px; }
.aboutContent p { font-size: 17px; line-height: 1.7; color: #625c58; margin-bottom: 15px; }
.stats { display: flex; gap: 40px; margin-top: 40px; flex-wrap: wrap; }
.stats > div { display: flex; flex-direction: column; gap: 4px; }
.stats strong { font-size: 36px; font-family: var(--font-display); color: var(--accent); }
.stats span { font-size: 13px; color: #625c58; letter-spacing: 1px; text-transform: uppercase; }

.socialReach { max-width: 1250px; margin: auto; padding: 120px 30px; }
.socialGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 30px; }
.socialCard {
  background: var(--white); padding: 35px 30px;
  border-radius: var(--radius-md); display: flex; flex-direction: column; gap: 8px;
  box-shadow: var(--shadow-soft); position: relative; overflow: hidden;
  transition: transform 0.4s var(--transition-smooth), box-shadow 0.4s var(--transition-smooth);
}
.socialCard::before {
  content: ""; position: absolute; inset: 0;
  background: linear-gradient(135deg, transparent 0%, rgba(179, 95, 75, 0.06) 100%);
  opacity: 0; transition: opacity 0.4s var(--transition-smooth);
}
.socialCard:hover { transform: translateY(-6px); box-shadow: var(--shadow-medium); }
.socialCard:hover::before { opacity: 1; }
.socialCard span { font-size: 12px; letter-spacing: 3px; font-weight: 800; color: var(--accent); }
.socialCard strong { font-size: 44px; font-family: var(--font-display); }
.socialCard p { color: #625c58; font-size: 14px; }
.socialCard small { color: var(--secondary); font-size: 13px; margin-top: 10px; font-weight: 600; }

.services { background: transparent; }
.serviceGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 25px; }
.serviceCard {
  background: var(--white); padding: 35px 30px;
  border-radius: var(--radius-md); box-shadow: var(--shadow-soft);
  transition: transform 0.4s var(--transition-smooth), box-shadow 0.4s var(--transition-smooth);
}
.serviceCard:hover { transform: translateY(-4px); box-shadow: var(--shadow-medium); }
.serviceCard > span { color: var(--gold); font-size: 14px; font-weight: 800; letter-spacing: 2px; }
.serviceCard h3 { font-size: 22px; margin: 15px 0 10px; }
.serviceCard p { color: #625c58; font-size: 15px; line-height: 1.7; }

.brandsSection { max-width: 1250px; margin: auto; padding: 120px 30px; }
.platformsContainer { display: flex; flex-direction: column; gap: 60px; }
.platformBlock { display: flex; flex-direction: column; gap: 25px; }
.platformHeader { display: flex; flex-direction: column; gap: 8px; align-items: flex-start; }
.platformBadge {
  display: inline-block;
  background: linear-gradient(135deg, var(--foreground), var(--secondary));
  color: var(--white); padding: 10px 22px;
  border-radius: var(--radius-pill);
  font-size: 12px; font-weight: 800; letter-spacing: 2px;
  text-transform: uppercase; box-shadow: var(--shadow-soft);
}
.platformDesc { color: #625c58; font-size: 14px; }
.brandsGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; }
.brandCard {
  background: var(--white); padding: 25px;
  border-radius: var(--radius-sm); display: flex; flex-direction: column; gap: 6px;
  border: 1px solid var(--soft);
  transition: transform 0.3s var(--transition-smooth), border-color 0.3s var(--transition-smooth);
}
.brandCard:hover { transform: translateY(-3px); border-color: var(--accent-soft); }
.brandCard strong { font-size: 15px; letter-spacing: 1px; }
.brandCard span { font-size: 13px; color: #625c58; }

.caseStudy { max-width: 1250px; margin: auto; padding: 120px 30px; }
.caseStudyGrid { display: flex; flex-direction: column; gap: 30px; }
.caseStudyMeta {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 25px; padding: 35px; background: var(--soft);
  border-radius: var(--radius-md);
}
.caseStudyMeta > div { display: flex; flex-direction: column; gap: 6px; }
.caseStudyMeta strong { font-size: 12px; letter-spacing: 2px; text-transform: uppercase; color: var(--accent); font-weight: 800; }
.caseStudyMeta span { font-size: 18px; font-weight: 700; font-family: var(--font-display); }
.caseStudyAbout { font-size: 18px; line-height: 1.7; color: #625c58; max-width: 800px; }
.caseStudyColumns { display: grid; grid-template-columns: 1fr 1fr; gap: 50px; }
.caseStudyColumns h3 { font-size: 22px; margin-bottom: 20px; }
.caseStudyColumns ul { list-style: none; display: flex; flex-direction: column; gap: 12px; }
.caseStudyColumns li { padding-left: 24px; position: relative; color: #625c58; font-size: 15px; }
.caseStudyColumns li::before { content: "→"; position: absolute; left: 0; color: var(--accent); font-weight: 700; }

.testimonials { max-width: 1250px; margin: auto; padding: 120px 30px; }
.testimonialGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; }
.testimonialCard {
  background: var(--white); padding: 35px 30px;
  border-radius: var(--radius-md); display: flex; flex-direction: column; gap: 20px;
  border: 1px solid var(--soft); box-shadow: var(--shadow-soft);
  transition: transform 0.4s var(--transition-smooth), box-shadow 0.4s var(--transition-smooth);
}
.testimonialCard:hover { transform: translateY(-4px); box-shadow: var(--shadow-medium); }
.testimonialCard p { font-size: 16px; line-height: 1.7; font-style: italic; color: var(--foreground); }
.testimonialCard footer { display: flex; flex-direction: column; gap: 4px; }
.testimonialCard footer strong { font-size: 15px; font-family: var(--font-display); }
.testimonialCard footer span { font-size: 13px; color: var(--accent); font-weight: 700; }

.mediaKit { max-width: 1250px; margin: auto; padding: 120px 30px; }
.mediaKitGrid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px; }
.mediaKitCard {
  background: var(--white); padding: 40px 30px;
  border-radius: var(--radius-md); border: 2px solid var(--soft);
  display: flex; flex-direction: column; gap: 15px;
  transition: transform 0.4s var(--transition-smooth), box-shadow 0.4s var(--transition-smooth);
}
.mediaKitCard:hover { transform: translateY(-4px); box-shadow: var(--shadow-medium); }
.mediaKitCard--standard {
  border-color: var(--accent); box-shadow: var(--shadow-medium);
  position: relative;
}
.mediaKitCard--standard::after {
  content: "★"; position: absolute;
  top: -14px; right: 25px;
  background: var(--accent); color: white;
  width: 30px; height: 30px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 14px; box-shadow: var(--shadow-soft);
}
.mediaKitCard h3 { font-size: 28px; }
.mediaKitCard > p { color: var(--accent); font-weight: 700; font-size: 13px; letter-spacing: 1px; text-transform: uppercase; }
.mediaKitCard ul { list-style: none; display: flex; flex-direction: column; gap: 12px; margin-top: 10px; }
.mediaKitCard li { padding-left: 24px; position: relative; color: #625c58; font-size: 15px; }
.mediaKitCard li::before { content: "✓"; position: absolute; left: 0; color: var(--accent); font-weight: 900; }
.mediaKitCta { text-align: center; margin-top: 50px; }

.faq { max-width: 900px; margin: auto; padding: 120px 30px; }
.faqList { display: flex; flex-direction: column; gap: 15px; }
.faqItem {
  background: var(--white); border: 1px solid var(--soft);
  border-radius: var(--radius-sm); padding: 22px 28px;
  transition: border-color 0.3s var(--transition-smooth);
}
.faqItem:hover { border-color: var(--accent-soft); }
.faqItem summary {
  cursor: pointer; font-weight: 600; font-size: 17px;
  list-style: none; display: flex; justify-content: space-between; align-items: center;
  font-family: var(--font-display);
}
.faqItem summary::after { content: "+"; font-size: 24px; color: var(--accent); font-weight: 400; }
.faqItem[open] summary::after { content: "−"; }
.faqItem p { margin-top: 15px; color: #625c58; line-height: 1.7; font-size: 15px; }

.contact { max-width: 900px; margin: auto; padding: 120px 30px; text-align: center; }
.contact h2 { font-size: clamp(36px, 5vw, 56px); margin-bottom: 20px; }
.contact > p:not(.eyebrow) { color: #625c58; font-size: 17px; margin-bottom: 30px; }
.contactButton { display: inline-block; padding: 18px 40px; }
.socials { display: flex; gap: 25px; justify-content: center; margin-top: 40px; }
.socials a { font-size: 14px; font-weight: 600; color: var(--secondary); }
.socials a:hover { color: var(--accent); }

.siteFooter {
  background: var(--foreground); color: var(--white);
  padding: 70px 30px 35px; margin-top: 80px;
}
.footerContent {
  max-width: 1250px; margin: auto;
  display: grid; grid-template-columns: 1fr 1fr; gap: 40px;
  padding-bottom: 40px; border-bottom: 1px solid rgba(255,255,255,0.1);
}
.footerContent strong { font-size: 24px; letter-spacing: 4px; display: block; margin-bottom: 10px; font-family: var(--font-display); }
.footerContent p { color: rgba(255,255,255,0.7); font-size: 14px; }
.footerContent a { color: var(--white); }
.footerSocials { display: flex; gap: 20px; margin-top: 15px; }
.footerSocials a { font-size: 14px; font-weight: 700; }
.footerSocials a:hover { color: var(--gold); }
.footerBottom {
  max-width: 1250px; margin: auto; padding-top: 30px;
  display: flex; justify-content: center; flex-wrap: wrap; gap: 15px;
  font-size: 13px; color: rgba(255,255,255,0.6); text-align: center;
}

@media (max-width: 1200px) {
  .hero { gap: 50px; }
  .about { gap: 50px; }
}
@media (max-width: 768px) {
  .nav { height: 70px; padding: 0 20px; }
  .navLinks { gap: 15px; font-size: 13px; }
  .hero {
    grid-template-columns: 1fr;
    padding: 40px 20px 60px;
    min-height: auto;
    gap: 40px;
  }
  .about { grid-template-columns: 1fr; padding: 80px 20px; gap: 40px; }
  .section, .socialReach, .brandsSection, .caseStudy, .testimonials, .mediaKit, .faq, .contact {
    padding: 80px 20px;
  }
  .caseStudyColumns { grid-template-columns: 1fr; gap: 30px; }
  .footerContent { grid-template-columns: 1fr; gap: 30px; }
  .footerBottom { flex-direction: column; text-align: center; }
  .whatsappFloat { width: 54px; height: 54px; bottom: 20px; right: 20px; }
}
@media (max-width: 480px) {
  .logo { font-size: 18px; letter-spacing: 2px; }
  .navLinks { display: none; }
  .marquee span { font-size: 12px; letter-spacing: 2px; }
  .stats { gap: 20px; }
  .stats strong { font-size: 28px; }
}
CSS_EOF

echo "==> Verificando lint"
npm run lint 2>&1 | tail -15

echo "==> Verificando build"
rm -rf .next node_modules/.cache
npm run build 2>&1 | tail -25

echo ""
echo "===================================================="
echo "✅ Rediseño visual aplicado"
echo "===================================================="
git status --short
