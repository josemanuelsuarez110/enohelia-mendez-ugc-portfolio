"use client";

import Image from "next/image";
import { useLocale, useTranslations } from "next-intl";
import { useEffect, useRef, useState } from "react";
import { Link } from "@/i18n/navigation";

export function PortfolioNav() {
  const t = useTranslations("nav");
  const locale = useLocale();
  const [open, setOpen] = useState(false);
  const toggle = useRef<HTMLButtonElement>(null);
  return (
    <nav className="nav" aria-label={t("label")} onKeyDown={(event) => {
      if (event.key === "Escape") { setOpen(false); toggle.current?.focus(); }
    }}>
      <a href="#" className="logo">ENOHELIA MÉNDEZ</a>
      <button ref={toggle} type="button" className="menuToggle" aria-expanded={open} aria-controls="portfolio-navigation" onClick={() => setOpen(!open)}>{open ? t("close") : t("menu")}</button>
      <div id="portfolio-navigation" className={`navLinks${open ? " navLinksOpen" : ""}`}>
        {(["work", "about", "services", "brands", "contact"] as const).map((key) => (
          <a key={key} href={`#${key}`} className={key === "contact" ? "navButton" : undefined} onClick={() => setOpen(false)}>{t(key)}</a>
        ))}
        <div className="languageSwitch" aria-label={t("langLabel")}>
          <Link href="/" locale="es" lang="es" aria-current={locale === "es" ? "page" : undefined}>ES</Link>
          <Link href="/" locale="en" lang="en" aria-current={locale === "en" ? "page" : undefined}>EN</Link>
        </div>
      </div>
    </nav>
  );
}

type Video = { src: string; poster: string; brand: string };
export function VideoGallery({ videos }: { videos: Video[] }) {
  const t = useTranslations("interactive");
  const [active, setActive] = useState(0);
  const [failed, setFailed] = useState(false);
  const dialog = useRef<HTMLDialogElement>(null);
  const player = useRef<HTMLVideoElement>(null);
  const trigger = useRef<HTMLButtonElement | null>(null);
  const video = videos[active];
  useEffect(() => {
    const element = dialog.current;
    const unlock = () => { document.body.style.overflow = ""; };
    element?.addEventListener("close", unlock);
    return () => { element?.removeEventListener("close", unlock); unlock(); };
  }, []);
  function close() {
    player.current?.pause();
    dialog.current?.close();
    trigger.current?.focus();
  }
  function change(direction: number) {
    player.current?.pause();
    setFailed(false);
    setActive((active + direction + videos.length) % videos.length);
  }
  return <>
    <div className="videoGrid">
      {videos.map((item, index) => <article className="videoCard" key={item.src}>
        <button type="button" className="videoPreview" aria-label={t("play", { brand: item.brand })} onClick={(event) => {
          trigger.current = event.currentTarget;
          setActive(index); setFailed(false);
          dialog.current?.showModal();
          document.body.style.overflow = "hidden";
        }}>
          <Image src={item.poster} alt={t("poster", { brand: item.brand })} width={720} height={1280} sizes="(max-width: 768px) 90vw, 30vw" />
          <span className="playBadge" aria-hidden="true">▶</span>
          <span className="previewCaption">{t("watch")}</span>
        </button>
        <h3>{item.brand}</h3>
        <a className="videoDownload" href={item.src}>{t("directVideo")}</a>
      </article>)}
    </div>
    <dialog ref={dialog} className="videoDialog" aria-labelledby="video-title" onCancel={(event) => { event.preventDefault(); close(); }} onClick={(event) => { if (event.target === event.currentTarget) close(); }}>
      <div className="videoDialogBody">
        <div className="videoDialogHeader"><h3 id="video-title">{video.brand}</h3><button type="button" onClick={close} aria-label={t("close")}>{t("close")} ×</button></div>
        <video key={video.src} ref={player} src={video.src} poster={video.poster} controls playsInline preload="none" aria-label={t("play", { brand: video.brand })} onError={() => setFailed(true)} />
        {failed && <p role="alert">{t("videoError")} <a href={video.src}>{t("directVideo")}</a></p>}
        <div className="videoDialogControls"><button type="button" onClick={() => change(-1)}>← {t("previous")}</button><span aria-live="polite">{active + 1} / {videos.length}</span><button type="button" onClick={() => change(1)}>{t("next")} →</button></div>
        <a className="primaryButton" href="#contact" onClick={close}>{t("similar")}</a>
      </div>
    </dialog>
  </>;
}

export function CollaborationBrief() {
  const t = useTranslations("brief");
  const [brand, setBrand] = useState("");
  const [format, setFormat] = useState("demo");
  const [details, setDetails] = useState("");
  const [message, setMessage] = useState("");
  const [copied, setCopied] = useState(false);
  const [copyFailed, setCopyFailed] = useState(false);
  const result = useRef<HTMLDivElement>(null);
  function reset() { setMessage(""); setCopied(false); setCopyFailed(false); }
  return <form className="briefForm" onSubmit={(event) => {
    event.preventDefault();
    setMessage(t("template", { brand: brand.trim(), format: t(`formats.${format}`), details: details.trim() || t("toDiscuss") }));
    setCopied(false); setCopyFailed(false);
    requestAnimationFrame(() => result.current?.focus());
  }}>
    <h3>{t("title")}</h3>
    <p>{t("intro")}</p>
    <div className="briefFields">
      <label>{t("brand")}<input name="brand" autoComplete="organization" required maxLength={100} pattern=".*\S.*" value={brand} onChange={(event) => { setBrand(event.target.value); reset(); }} /></label>
      <label>{t("format")}<select name="format" value={format} onChange={(event) => { setFormat(event.target.value); reset(); }}>
        {["demo", "unboxing", "testimonial", "campaign"].map((key) => <option key={key} value={key}>{t(`formats.${key}`)}</option>)}
      </select></label>
    </div>
    <label>{t("details")}<textarea name="details" rows={3} maxLength={700} placeholder={t("placeholder")} value={details} onChange={(event) => { setDetails(event.target.value); reset(); }} /></label>
    <p className="briefPrivacy">{t("privacy")}</p>
    <button type="submit" className="primaryButton">{t("prepare")} →</button>
    {message && <div className="briefResult" ref={result} tabIndex={-1} aria-label={t("preview")}>
      <h4>{t("preview")}</h4><p className="briefMessage">{message}</p>
      <div className="briefActions">
        <a className="primaryButton" href={`mailto:enoheliamendezmendez@gmail.com?subject=${encodeURIComponent(t("subject", { brand: brand.trim() }))}&body=${encodeURIComponent(message)}`}>{t("email")}</a>
        <a className="secondaryButton" target="_blank" rel="noopener noreferrer" href={`https://wa.me/18293684901?text=${encodeURIComponent(message)}`}>WhatsApp ↗</a>
        <button type="button" className="copyButton" onClick={async () => {
          try { await navigator.clipboard.writeText(message); setCopied(true); setCopyFailed(false); }
          catch { setCopyFailed(true); }
        }}>{copied ? t("copied") : t("copy")}</button>
      </div>
      <p role="status">{copyFailed ? t("copyFailed") : copied ? t("copied") : t("sendNote")}</p>
    </div>}
  </form>;
}
