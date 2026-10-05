const videos = [
  {
    src: "/videos/ugc-01-web.mp4",
    poster: "/videos/ugc-01-poster.jpg",
    title: "LAVOIR",
  },
  {
    src: "/videos/ugc-02-web.mp4",
    poster: "/videos/ugc-02-poster.jpg",
    title: "BOOSTION",
  },
  {
    src: "/videos/ugc-03-web.mp4",
    poster: "/videos/ugc-03-poster.jpg",
    title: "FLOUREN",
  },
];

export default function Home() {
  return (
    <main>
      <nav className="nav">
        <a href="#" className="logo">ENOHELIA MENDEZ</a>

        <div className="navLinks">
          <a href="#work">Work</a>
          <a href="#about">About</a>
          <a href="#services">Services</a>
          <a href="#contact" className="navButton">Work With Me</a>
        </div>
      </nav>

      <section className="hero">
        <div className="heroContent">
          <p className="eyebrow">UGC CREATOR · BEAUTY · LIFESTYLE · WELLNESS</p>

          <h1>
            Content that feels real.
            <span>Stories that connect.</span>
          </h1>

          <p className="heroText">
            I create authentic, scroll-stopping content that helps brands
            connect with real people and turn attention into action.
          </p>

          <div className="heroButtons">
            <a href="#work" className="primaryButton">View My Work</a>
            <a href="#contact" className="secondaryButton">Let&apos;s Work Together</a>
          </div>
        </div>

        <div className="heroImage">
          <img src="/images/enohelia-hero.png" alt="Enohelia - UGC Creator" />
          <div className="imageBadge">
            <strong>UGC</strong>
            <span>Creator</span>
          </div>
        </div>
      </section>

      <section className="marquee">
        <span>BEAUTY</span>
        <span>SKINCARE</span>
        <span>LIFESTYLE</span>
        <span>WELLNESS</span>
        <span>PRODUCT DEMOS</span>
      </section>

      <section id="work" className="section">
        <div className="sectionHeading">
          <p className="eyebrow">SELECTED CONTENT</p>
          <h2>Featured Work</h2>
          <p>
            Authentic short-form content created for brands and social media.
          </p>
        </div>

        <div className="videoGrid">
          {videos.map((video) => (
            <article className="videoCard" key={video.src}>
              <video
                src={video.src}
                poster={video.poster}
                controls
                playsInline
                preload="none"
              />
              <h3>{video.title}</h3>
            </article>
          ))}
        </div>
      </section>

      <section id="about" className="about">
        <div className="aboutImage">
          <img src="/images/enohelia-about.png" alt="About Enohelia" />
        </div>

        <div className="aboutContent">
          <p className="eyebrow">MEET THE CREATOR</p>
          <h2>Hi, I&apos;m Enohelia.</h2>

          <p>
            I&apos;m a UGC creator passionate about producing relatable,
            high-quality content that doesn&apos;t feel like traditional
            advertising.
          </p>

          <p>
            My content focuses on beauty, skincare, lifestyle and wellness,
            combining authentic storytelling with visually engaging
            short-form video.
          </p>

          <div className="stats">
            <div>
              <strong>UGC</strong>
              <span>Short-form video</span>
            </div>

            <div>
              <strong>4+</strong>
              <span>Content niches</span>
            </div>

            <div>
              <strong>3</strong>
              <span>Social platforms</span>
            </div>
          </div>
        </div>
      </section>


      <section className="socialReach">
        <div className="sectionHeading">
          <p className="eyebrow">SOCIAL REACH</p>
          <h2>35K+ Community</h2>
          <p>
            An engaged audience across TikTok, Instagram and Facebook.
          </p>
        </div>

        <div className="socialGrid">
          <a
            href="https://www.tiktok.com/enomendez0"
            target="_blank"
            rel="noopener noreferrer"
            className="socialCard"
          >
            <span>TIKTOK</span>
            <strong>10.1K</strong>
            <p>Followers</p>
            <small>@enomendez0 →</small>
          </a>

          <a
            href="https://www.instagram.com/eno_mendez"
            target="_blank"
            rel="noopener noreferrer"
            className="socialCard"
          >
            <span>INSTAGRAM</span>
            <strong>6.4K</strong>
            <p>Followers</p>
            <small>@eno_mendez →</small>
          </a>

          <a
            href="https://www.facebook.com/eno.mendez"
            target="_blank"
            rel="noopener noreferrer"
            className="socialCard"
          >
            <span>FACEBOOK</span>
            <strong>18.9K</strong>
            <p>Followers</p>
            <small>Eno Mendez →</small>
          </a>
        </div>
      </section>

      <section id="services" className="section services">
        <div className="sectionHeading">
          <p className="eyebrow">WHAT I CREATE</p>
          <h2>UGC Services</h2>
        </div>

        <div className="serviceGrid">
          <div className="serviceCard">
            <span>01</span>
            <h3>Product Demo</h3>
            <p>Clear and engaging demonstrations showing your product in action.</p>
          </div>

          <div className="serviceCard">
            <span>02</span>
            <h3>Testimonials</h3>
            <p>Natural testimonial-style videos designed to build trust.</p>
          </div>

          <div className="serviceCard">
            <span>03</span>
            <h3>Unboxing</h3>
            <p>Authentic first impressions and visually engaging unboxing content.</p>
          </div>

          <div className="serviceCard">
            <span>04</span>
            <h3>Lifestyle</h3>
            <p>Products naturally integrated into relatable everyday moments.</p>
          </div>

          <div className="serviceCard">
            <span>05</span>
            <h3>Beauty & Skincare</h3>
            <p>Product-focused beauty content, routines and before-and-after concepts.</p>
          </div>

          <div className="serviceCard">
            <span>06</span>
            <h3>Voiceover</h3>
            <p>Short-form storytelling with clear voiceover and product visuals.</p>
          </div>
        </div>
      </section>


      <section className="brandsSection">
        <div className="sectionHeading">
          <p className="eyebrow">BRAND COLLABORATIONS</p>
          <h2>Brands I&apos;ve Worked With</h2>
          <p>
            Creating authentic UGC content for beauty, skincare,
            haircare and lifestyle brands.
          </p>
        </div>

        <div className="brandsGrid">
          <div className="brandCard">
            <strong>LAVOIR</strong>
            <span>Home & Lifestyle</span>
          </div>

          <div className="brandCard">
            <strong>BOOSTION</strong>
            <span>Beauty & Wellness</span>
          </div>

          <div className="brandCard">
            <strong>9WISHES</strong>
            <span>Skincare</span>
          </div>

          <div className="brandCard">
            <strong>FLOUREN</strong>
            <span>Beauty</span>
          </div>

          <div className="brandCard">
            <strong>PALMER&apos;S</strong>
            <span>Cocoa Butter</span>
          </div>

          <div className="brandCard">
            <strong>MEDIHEAL</strong>
            <span>Skincare</span>
          </div>

          <div className="brandCard">
            <strong>HEAD & SHOULDERS</strong>
            <span>Scalp Serum</span>
          </div>

          <div className="brandCard">
            <strong>KIKO MILANO</strong>
            <span>Lip Volume</span>
          </div>
        </div>
      </section>

      <section id="contact" className="contact">
        <p className="eyebrow">LET&apos;S CREATE TOGETHER</p>
        <h2>Ready to bring your brand to life?</h2>

        <p>
          Available for UGC collaborations, product demonstrations,
          testimonials and long-term partnerships.
        </p>

        <a href="mailto:enoheliamendezmendez@gmail.com" className="contactButton">
          Work With Me
        </a>

        <div className="socials">
          <a
            href="https://www.tiktok.com/enomendez0"
            target="_blank"
            rel="noopener noreferrer"
          >
            TikTok
          </a>

          <a
            href="https://www.instagram.com/eno_mendez"
            target="_blank"
            rel="noopener noreferrer"
          >
            Instagram
          </a>

          <a
            href="https://www.facebook.com/eno.mendez"
            target="_blank"
            rel="noopener noreferrer"
          >
            Facebook
          </a>
        </div>
      </section>

      <footer>
        <strong>ENOHELIA MENDEZ</strong>
        <p>UGC Creator · Beauty · Lifestyle · Wellness</p>
      </footer>
    </main>
  );
}
