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
