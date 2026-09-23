import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Enohelia Mendez | UGC Creator",
  description:
    "UGC creator specializing in beauty, skincare, lifestyle and wellness content.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
