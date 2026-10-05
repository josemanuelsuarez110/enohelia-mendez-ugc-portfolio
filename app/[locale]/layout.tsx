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
