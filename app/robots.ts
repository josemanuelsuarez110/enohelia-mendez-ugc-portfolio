import type { MetadataRoute } from "next";
const SITE_URL = "https://enohelia-mendez-ugc-portfolio.vercel.app";
export default function robots(): MetadataRoute.Robots {
  return {
    rules: [{ userAgent: "*", allow: "/" }],
    sitemap: `${SITE_URL}/sitemap.xml`,
    host: SITE_URL,
  };
}
