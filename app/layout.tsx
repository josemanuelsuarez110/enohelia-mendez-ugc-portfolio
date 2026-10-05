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
