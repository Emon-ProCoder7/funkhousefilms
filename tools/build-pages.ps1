# ============================================================================
# Funkhouse Films — page generator
# Composes static pages from a shared header/footer + page body.
# Run:  powershell -ExecutionPolicy Bypass -File tools/build-pages.ps1
# Output: static .html files in the project root (already committed).
# ============================================================================
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

function Get-HeaderBody {
  param([string]$Active)
  $links = @(
    @{ href = 'index.html'; label = 'Home'; key = 'home' },
    @{ href = 'films.html'; label = 'Films'; key = 'films' },
    @{ href = 'about.html'; label = 'About'; key = 'about' },
    @{ href = 'director.html'; label = 'The Director'; key = 'director' },
    @{ href = 'services.html'; label = 'Services'; key = 'services' },
    @{ href = 'behind-the-films.html'; label = 'Behind The Films'; key = 'behind' },
    @{ href = 'awards.html'; label = 'Awards &amp; Press'; key = 'awards' },
    @{ href = 'internship.html'; label = 'Internship'; key = 'internship' },
    @{ href = 'contact.html'; label = 'Contact'; key = 'contact' }
  )
  $nav = ($links | ForEach-Object {
    $cls = if ($_.key -eq $Active) { ' class="nav-menu-link active"' } else { ' class="nav-menu-link"' }
    "<li class=`"nav-menu-list`"><a href=`"$($_.href)`"$cls>$($_.label)</a></li>"
  }) -join "`n                  "
  $mobile = ($links | ForEach-Object {
    "<a href=`"$($_.href)`" class=`"mobile-menu-link`">$($_.label)</a>"
  }) -join "`n      "

@"
<!-- ======= HEADER ======= -->
  <header class="header">
    <div class="header-main">
      <div class="container-default">
        <div class="navbar-container">
          <div class="navbar-inner-wrapper">
            <div class="header-logo-wrapper">
              <a href="index.html" class="brand-logo">
                <img src="assets/img/funkhouse-logo.png" alt="Funkhouse Films" class="funkhouse-logo">
              </a>
            </div>
            <div class="navbar-wrapper">
              <nav role="navigation" class="nav-menu-wrapper">
                <ul role="list" class="nav-menu">
                  $nav
                </ul>
              </nav>
              <div class="nav-button-block">
                <a href="film-coral.html" class="primary-button nav-cta"><span class="link-text">Watch Coral</span></a>
                <div class="menu-button">
                  <button class="hamburger" aria-label="Open menu" aria-expanded="false"><span></span><span></span><span></span></button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>

  <div class="mobile-menu" aria-hidden="true">
    <div class="mobile-menu-inner">
      $mobile
      <a href="film-coral.html" class="primary-button mobile-menu-cta"><span class="link-text">Watch Coral</span></a>
    </div>
  </div>

"@
}

function Get-Footer {
@"
  <!-- ======= FOOTER ======= -->
  <footer class="footer-main">
    <div class="container-default">
      <div class="footer-wrapper">
        <div class="footer-block footer-block-right">
          <a href="index.html" class="brand-logo"><img src="assets/img/funkhouse-logo.png" alt="Funkhouse Films" class="funkhouse-logo"></a>
          <p class="paragraph" style="max-width:420px;">Funkhouse Films is an independent film and media company creating original stories, films and intellectual property — worlds audiences want to return to.</p>
          <div class="footer-address-block">
            <h4 class="footer-heading">Connect</h4>
            <div class="footer-social-row">
              <a href="https://www.youtube.com/@Funkhousefilms" target="_blank" rel="noopener" class="footer-social" aria-label="YouTube"><svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M23 7.5s-.2-1.6-.9-2.3c-.8-.9-1.8-.9-2.3-1C16.6 4 12 4 12 4s-4.6 0-7.8.2c-.5.1-1.5.1-2.3 1-.7.7-.9 2.3-.9 2.3S.8 9.4.8 11.3v1.4c0 1.9.2 3.8.2 3.8s.2 1.6.9 2.3c.8.9 1.9.8 2.4 1 1.7.2 7 .2 7 .2s4.6 0 7.8-.2c.5-.1 1.5-.1 2.3-1 .7-.7.9-2.3.9-2.3s.2-1.9.2-3.8v-1.4c0-1.9-.2-3.8-.2-3.8ZM9.8 15.3V8.7l6.2 3.3-6.2 3.3Z"/></svg></a>
              <a href="#" class="footer-social" aria-label="Instagram"><svg width="18" height="18" viewBox="0 0 24 24" fill="none"><rect x="2.5" y="2.5" width="19" height="19" rx="5.5" stroke="currentColor" stroke-width="1.8"/><circle cx="12" cy="12" r="4.2" stroke="currentColor" stroke-width="1.8"/><circle cx="17.6" cy="6.4" r="1.3" fill="currentColor"/></svg></a>
              <a href="#" class="footer-social" aria-label="X"><svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M18.9 1.2h3.7l-8.1 9.3L24 22.8h-7.5l-5.9-7.7-6.7 7.7H.2l8.7-9.9L0 1.2h7.7l5.3 7 6-7Zm-1.3 19.4h2L6.6 3.3H4.4l13.2 17.3Z"/></svg></a>
            </div>
          </div>
        </div>
        <div class="footer-block footer-block-left">
          <div style="display:grid; grid-template-columns:1fr 1fr; gap:40px;">
            <div>
              <h4 class="footer-heading">Explore</h4>
              <a href="films.html" class="footer-link">Films</a>
              <a href="about.html" class="footer-link">About</a>
              <a href="director.html" class="footer-link">The Director</a>
              <a href="behind-the-films.html" class="footer-link">Behind the Films</a>
              <a href="awards.html" class="footer-link">Awards &amp; Press</a>
            </div>
            <div>
              <h4 class="footer-heading">Work With Us</h4>
              <a href="services.html" class="footer-link">Services</a>
              <a href="internship.html" class="footer-link">Internship</a>
              <a href="contact.html" class="footer-link">Contact</a>
            </div>
          </div>
          <div class="footer-newsletter-block">
            <h4 class="footer-heading">The Newsletter</h4>
            <p class="paragraph" style="max-width:420px;">First access to trailers, behind-the-scenes stories and festival news.</p>
            <form data-js-form class="footer-newsletter-form" style="margin-top:16px;">
              <input type="email" class="cta-input" placeholder="Your email address" aria-label="Email address" required>
              <button type="submit" class="primary-button"><span class="link-text">Subscribe</span></button>
            </form>
            <div class="form-success">Thank you — you're in.</div>
          </div>
        </div>
      </div>
      <div class="footer-lower">
        <div class="footer-lower-inner-block">
          <div class="footer-legal">© 2026 Funkhouse Films. All rights reserved.</div>
          <div class="footer-statement">Funkhouse Films <span class="gold">— Stories Worth Remembering.</span></div>
        </div>
      </div>
    </div>
  </footer>

  <div class="lightbox" aria-hidden="true">
    <button class="lightbox-close" aria-label="Close">×</button>
    <div class="lightbox-frame"></div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/gsap.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/ScrollTrigger.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/Draggable.min.js"></script>
  <script src="js/custom-animations.js"></script>
"@
}

function Get-PageHead {
  param([string]$Title, [string]$Desc)
@"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$Title</title>
  <meta name="description" content="$Desc">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Poppins:wght@400;700&family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
"@
}

function New-Page {
  param(
    [string]$File,
    [string]$Title,
    [string]$Desc,
    [string]$Active,
    [string]$Body
  )
  $html = Get-PageHead -Title $Title -Desc $Desc
  $html += Get-HeaderBody -Active $Active
  $html += '<main>'
  $html += $Body
  $html += '</main>'
  $html += Get-Footer
  $html += @"

</body>
</html>
"@
  $out = Join-Path $root $File
  [System.IO.File]::WriteAllText($out, $html, [System.Text.UTF8Encoding]::new($false))
  Write-Host "Built $File"
}

Write-Host "Funkhouse Films page generator ready."

# ============================================================================
# PAGE: film-coral.html — individual film page template
# ============================================================================
$coralBody = @'
    <!-- FILM HERO -->
    <section class="page-hero" style="padding-bottom:40px;">
      <div class="container-default">
        <div class="page-hero-kicker">Now Streaming · Feature Film</div>
        <h1 class="page-hero-title">Coral: The Haunted Assignment</h1>
        <p class="page-hero-sub" style="font-family:var(--font-display); font-style:italic; font-size:22px;">Secrets have consequences. Some refuse to stay buried.</p>
      </div>
    </section>

    <!-- TRAILER / THE STORY -->
    <section class="section-gap">
      <div class="container-default">
        <div class="editor-choce-wrapper">
          <a href="#" class="editor-choice-slider-image" data-youtube="mrG6mndMxSE" data-reveal>
            <img src="assets/img/coral-poster.jpg" loading="lazy" alt="Watch the Coral trailer">
            <div class="editor-choice-image-overlay" style="align-items:center; justify-content:center; background:rgba(0,0,0,0.35);">
              <div style="text-align:center;">
                <div class="stream-play" style="position:static; transform:none; margin:0 auto 16px;">
                  <svg width="18" height="20" viewBox="0 0 18 20" fill="none"><path d="M17.28 9.2 1.3.35A.76.76 0 0 0 .2.5a.76.76 0 0 0-.2.55v17.9a.8.8 0 0 0 .4.7.76.76 0 0 0 .9-.15l15.98-8.85a.8.8 0 0 0 0-1.45Z" fill="currentColor"/></svg>
                </div>
                <div class="editor-choice-image-sub">Watch the Official Trailer</div>
              </div>
            </div>
          </a>

          <div>
            <div class="section-title-caption">The Story</div>
            <h3 class="title-serif" style="margin-top:16px; margin-bottom:18px;">A family secret. A haunting force. A race against time.</h3>
            <p class="paragraph" style="margin-bottom:16px;">When Coral uncovers a dark secret within her seemingly perfect family, she finds herself caught in a terrifying battle against manipulation, revenge, and a haunting force determined to expose the truth.</p>
            <p class="paragraph" style="margin-bottom:28px;">What begins as a haunting becomes a confrontation — where every lie threatens to tear the family apart, and the truth refuses to stay buried.</p>
            <div class="film-row-meta" style="margin-bottom:24px;">
              <span class="genre-chip">Horror</span>
              <span class="genre-chip">Thriller</span>
              <span class="genre-chip">Best Horror Trailer · Film Fest LA</span>
              <span class="genre-chip">Best Editing · Marina Del Rey</span>
            </div>
            <div class="film-row-cta">
              <a href="#" class="primary-button" data-youtube="mrG6mndMxSE"><span class="link-text">Watch Now</span></a>
              <a href="behind-the-films.html" class="secondary-button"><span class="link-text">Behind the Scenes</span></a>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- MEET THE CHARACTERS -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-inner">
            <div class="section-title-block">
              <div class="gradient-text-wrapper"><h2 class="section-title">Meet the Characters</h2></div>
              <div class="title-animation-overlay"></div>
            </div>
          </div>
        </div>
        <div class="explore-grid">
          <div class="game-card-block" data-reveal>
            <div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/coral-ayla-1.jpg" loading="lazy" alt="Coral" class="game-thumbnail"></div></div>
            <div class="game-card-content-block">
              <h3 class="game-title">Coral</h3>
              <div class="game-card-meta-wrapper"><div class="game-card-meta">Protagonist</div></div>
              <p class="paragraph" style="font-size:15px;">A young woman who uncovers the truth her family buried — and must survive what it awakens.</p>
            </div>
          </div>
          <div class="game-card-block" data-reveal data-delay="0.06">
            <div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/coral-ayla-2.jpg" loading="lazy" alt="The Family" class="game-thumbnail"></div></div>
            <div class="game-card-content-block">
              <h3 class="game-title">The Family</h3>
              <div class="game-card-meta-wrapper"><div class="game-card-meta">Secrets &amp; Lies</div></div>
              <p class="paragraph" style="font-size:15px;">A seemingly perfect family whose past refuses to stay in the ground.</p>
            </div>
          </div>
          <div class="game-card-block" data-reveal data-delay="0.12">
            <div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/coral-ayla-4.jpg" loading="lazy" alt="The Haunting Force" class="game-thumbnail"></div></div>
            <div class="game-card-content-block">
              <h3 class="game-title">The Haunting Force</h3>
              <div class="game-card-meta-wrapper"><div class="game-card-meta">Antagonist</div></div>
              <p class="paragraph" style="font-size:15px;">A presence determined to expose the truth — no matter the cost.</p>
            </div>
          </div>
          <div class="game-card-block" data-reveal data-delay="0.18">
            <div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/coral-sm-13.jpg" loading="lazy" alt="The Assignment" class="game-thumbnail"></div></div>
            <div class="game-card-content-block">
              <h3 class="game-title">The Assignment</h3>
              <div class="game-card-meta-wrapper"><div class="game-card-meta">The Hook</div></div>
              <p class="paragraph" style="font-size:15px;">An ordinary task becomes an invitation into the dark heart of the story.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- BEHIND THE FILM -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-inner">
            <div class="section-title-block">
              <div class="gradient-text-wrapper"><h2 class="section-title">Behind the Film</h2></div>
              <div class="title-animation-overlay"></div>
            </div>
            <div class="section-title-button-block">
              <a href="behind-the-films.html" class="link-button-with-icon"><div>All Stories</div><div class="link-button-icon"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="10" viewBox="0 0 18 10" fill="none"><path d="M.31 4.24h16.1l-3.81-3.7A.55.55 0 0 1 13.04-.2l3.34 3.3a.75.75 0 0 1 0 1.06l-3.34 3.3a.55.55 0 0 1-.77-.8l3.81-3.7H.31a.55.55 0 0 1 0-1.1Z" fill="currentColor"/></svg></div></a>
            </div>
          </div>
        </div>

        <div class="featured-post-wrapper">
          <a href="#" class="featured-post-block" data-youtube="MMe2VQwyVUU" data-reveal>
            <div class="featured-post-bg" style="background-image:url('assets/img/coral-sm-10.jpg')"></div>
            <div class="featured-post-shade"></div>
            <div class="featured-post-content">
              <div class="post-meta">Video · Feature</div>
              <h3 class="post-title">The Cast Interviews — inside the world of Coral</h3>
              <p class="post-excerpt">The cast and crew on building the scares, the family drama and the story's beating heart.</p>
              <span class="arrow-link">Watch the Interviews</span>
            </div>
          </a>
          <div class="feature-highlight-card-block">
            <a href="behind-the-films.html" class="highlight-card" data-reveal><div class="highlight-card-thumb"><img src="assets/img/onset-6.jpg" loading="lazy" alt="On set"></div><div class="highlight-card-body"><h4 class="highlight-card-title">On set with the cast and crew</h4><div class="highlight-card-meta">Production</div></div></a>
            <a href="behind-the-films.html" class="highlight-card" data-reveal data-delay="0.05"><div class="highlight-card-thumb"><img src="assets/img/djn-directors-chair.png" loading="lazy" alt="Directing"></div><div class="highlight-card-body"><h4 class="highlight-card-title">The Director's Chair</h4><div class="highlight-card-meta">Direction</div></div></a>
            <a href="awards.html" class="highlight-card" data-reveal data-delay="0.1"><div class="highlight-card-thumb"><img src="assets/img/coral-sm-16.jpg" loading="lazy" alt="Awards"></div><div class="highlight-card-body"><h4 class="highlight-card-title">Festival journey &amp; recognition</h4><div class="highlight-card-meta">Awards</div></div></a>
          </div>
        </div>
      </div>
    </section>

    <!-- WATCH / STREAM -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/coral-sm-15.jpg')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Watch Coral</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <p class="cta-sub">Stream the trailer, explore the cast interviews and step inside the world of the film.</p>
                <div class="banner-button-wrapper">
                  <a href="#" class="primary-button" data-youtube="mrG6mndMxSE"><span class="link-text">Watch the Trailer</span></a>
                  <a href="#" class="secondary-button" data-youtube="MMe2VQwyVUU"><span class="link-text">Cast Interviews</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'film-coral.html' -Title 'Coral: The Haunted Assignment — Funkhouse Films' -Desc 'Coral: The Haunted Assignment — an original Funkhouse Films horror thriller. Watch the trailer, meet the characters and go behind the film.' -Active 'films' -Body $coralBody

# ============================================================================
# PAGE: about.html
# ============================================================================
$aboutBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">About Funkhouse Films</div>
        <h1 class="page-hero-title">Built on Stories. Driven by Vision.</h1>
        <p class="page-hero-sub">We believe the best films do more than fill a screen — they create conversations, challenge perspectives, evoke emotion and build worlds audiences want to return to.</p>
      </div>
    </section>

    <!-- STATEMENT -->
    <section class="section-gap">
      <div class="container-narrow" style="text-align:center;">
        <h2 class="home-about-title text-animate" data-image-word="stories">STORIES ARE MORE THAN ENTERTAINMENT. THEY START CONVERSATIONS. THEY STAY WITH US.</h2>
        <p class="paragraph" style="margin-top:40px; font-size:17px;">Funkhouse Films is an independent film and media company dedicated to developing original stories with impact. From concept development to production and post-production, we bring stories to life with creativity, collaboration and a commitment to quality.</p>
      </div>
    </section>

    <!-- STATS -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="stats-band">
          <div class="stat-item" data-reveal><div class="stat-num">20+</div><div class="stat-label">Years of Creative &amp; Filmmaking Experience</div></div>
          <div class="stat-item" data-reveal data-delay="0.06"><div class="stat-num">Distinct</div><div class="stat-label">Original Storytelling &amp; Worlds</div></div>
          <div class="stat-item" data-reveal data-delay="0.12"><div class="stat-num">Award</div><div class="stat-label">Festival Recognition</div></div>
          <div class="stat-item" data-reveal data-delay="0.18"><div class="stat-num">One</div><div class="stat-label">Mission — Create Stories That Last</div></div>
        </div>
      </div>
    </section>

    <!-- WHO WE ARE -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="director-intro">
          <div class="director-portrait" data-reveal><img src="assets/img/djn-directors-chair.png" loading="lazy" alt="Dr. John Neal Jr."></div>
          <div data-reveal data-delay="0.06">
            <div class="section-title-caption">The Company</div>
            <h3 class="title-serif" style="margin-top:16px; margin-bottom:18px;">A boutique production house with the vision of an entertainment brand.</h3>
            <p class="paragraph" style="margin-bottom:16px;">Funkhouse Films develops original stories, films and intellectual property — from the first page to the screen and beyond.</p>
            <p class="paragraph" style="margin-bottom:28px;">Founded on the belief that the best stories are the ones that stay with you, the company unites creative development, production and post-production under one vision.</p>
            <div class="banner-button-wrapper">
              <a href="director.html" class="primary-button"><span class="link-text">Meet the Director</span></a>
              <a href="films.html" class="secondary-button"><span class="link-text">Explore the Films</span></a>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="section-gap">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/onset-8.jpg')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Have a Story to Tell?</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <p class="cta-sub">From a first idea to a finished film — let's build a world together.</p>
                <div class="banner-button-wrapper">
                  <a href="contact.html" class="primary-button"><span class="link-text">Start a Conversation</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'about.html' -Title 'About — Funkhouse Films' -Desc 'Funkhouse Films is an independent film and media company building original stories, films and intellectual property.' -Active 'about' -Body $aboutBody

# ============================================================================
# PAGE: director.html
# ============================================================================
$directorBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">Writer · Director · Producer · Storyteller</div>
        <h1 class="page-hero-title">Dr. John Neal Jr.</h1>
        <p class="page-hero-sub">More than two decades of experience across documentaries and feature films — building the worlds behind Funkhouse Films.</p>
      </div>
    </section>

    <!-- INTRO -->
    <section class="section-gap">
      <div class="container-default">
        <div class="director-intro">
          <div class="director-portrait" data-reveal><img src="assets/img/djn-empty-stage.png" loading="lazy" alt="Dr. John Neal Jr. on stage"></div>
          <div data-reveal data-delay="0.06">
            <div class="section-title-caption">The Vision Behind the Stories</div>
            <h3 class="title-serif" style="margin-top:16px; margin-bottom:18px;">Every story is a world. Every world deserves to be built with intention.</h3>
            <p class="paragraph" style="margin-bottom:16px;">Dr. John Neal Jr. is a filmmaker whose work spans original features, documentaries and the development of new intellectual property — leading every project from concept through production to the final cut.</p>
            <div class="director-quote-block">
              <p class="director-quote">"Stories are how we make sense of the world. I build worlds so audiences can live in them — even for a moment."</p>
              <div class="director-name">Dr. John Neal Jr.</div>
            </div>
            <div class="banner-button-wrapper" style="margin-top:30px;">
              <a href="contact.html" class="primary-button"><span class="link-text">Book a Conversation</span></a>
              <a href="behind-the-films.html" class="secondary-button"><span class="link-text">In the Director's Chair</span></a>
            </div>
          </div>
        </div>

        <div class="director-stats-row" style="margin-top:64px;">
          <div class="director-stat" data-reveal><div class="director-stat-num">20+</div><div class="director-stat-label">Years of Creative &amp; Filmmaking Experience</div></div>
          <div class="director-stat" data-reveal data-delay="0.05"><div class="director-stat-num">Docs</div><div class="director-stat-label">Documentaries Written &amp; Directed</div></div>
          <div class="director-stat" data-reveal data-delay="0.1"><div class="director-stat-num">Film</div><div class="director-stat-label">Original Features &amp; Shorts</div></div>
          <div class="director-stat" data-reveal data-delay="0.15"><div class="director-stat-num">One</div><div class="director-stat-label">Mission — Create Stories That Last</div></div>
        </div>
      </div>
    </section>

    <!-- PERSONA TABS -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-inner">
            <div class="section-title-block">
              <div class="gradient-text-wrapper"><h2 class="section-title">The Filmmaker · The Storyteller · The Educator</h2></div>
              <div class="title-animation-overlay"></div>
            </div>
          </div>
        </div>

        <div class="esports-tab-menu">
          <button class="esports-tab-link active" data-tab="filmmaker">The Filmmaker</button>
          <button class="esports-tab-link" data-tab="storyteller">The Storyteller</button>
          <button class="esports-tab-link" data-tab="educator">The Educator</button>
          <button class="esports-tab-link" data-tab="speaker">The Speaker</button>
        </div>

        <div class="esports-tab-pane active" id="tab-filmmaker">
          <div class="persona-grid">
            <div class="persona-card"><div class="persona-card-num">01</div><h4 class="persona-card-title">Direction &amp; Vision</h4><p class="persona-card-text">A philosophy rooted in emotional truth — every frame, performance and cut in service of the story.</p></div>
            <div class="persona-card"><div class="persona-card-num">02</div><h4 class="persona-card-title">From Page to Screen</h4><p class="persona-card-text">Writing and developing original material through production — protecting the idea through the final cut.</p></div>
            <div class="persona-card"><div class="persona-card-num">03</div><h4 class="persona-card-title">Building Worlds</h4><p class="persona-card-text">Creating stories designed to live beyond a single film — franchises, universes and original I.P.</p></div>
          </div>
        </div>

        <div class="esports-tab-pane" id="tab-storyteller">
          <div class="persona-grid">
            <div class="persona-card"><div class="persona-card-num">01</div><h4 class="persona-card-title">Why Stories Matter</h4><p class="persona-card-text">Stories create conversation, challenge perspective and stay with audiences — that's the mission.</p></div>
            <div class="persona-card"><div class="persona-card-num">02</div><h4 class="persona-card-title">Character First</h4><p class="persona-card-text">Audiences return for people, not plot. Every world is built around characters worth caring about.</p></div>
            <div class="persona-card"><div class="persona-card-num">03</div><h4 class="persona-card-title">Emotional Impact</h4><p class="persona-card-text">The best films make you feel something — long after the credits have rolled.</p></div>
          </div>
        </div>

        <div class="esports-tab-pane" id="tab-educator">
          <div class="persona-grid">
            <div class="persona-card"><div class="persona-card-num">01</div><h4 class="persona-card-title">Teaching the Craft</h4><p class="persona-card-text">Guiding the next generation of filmmakers through the realities of writing, directing and producing.</p></div>
            <div class="persona-card"><div class="persona-card-num">02</div><h4 class="persona-card-title">Mentorship</h4><p class="persona-card-text">On-set and in the edit bay — learning by doing, alongside experienced filmmakers.</p></div>
            <div class="persona-card"><div class="persona-card-num">03</div><h4 class="persona-card-title">Hands-on Experience</h4><p class="persona-card-text">The internship program puts emerging talent in real production environments.</p></div>
          </div>
        </div>

        <div class="esports-tab-pane" id="tab-speaker">
          <div class="persona-grid">
            <div class="persona-card"><div class="persona-card-num">01</div><h4 class="persona-card-title">Filmmaking Talks</h4><p class="persona-card-text">Keynotes and conversations on the craft, business and future of independent storytelling.</p></div>
            <div class="persona-card"><div class="persona-card-num">02</div><h4 class="persona-card-title">Leadership</h4><p class="persona-card-text">Leading creative teams, building worlds and keeping a vision alive through production.</p></div>
            <div class="persona-card"><div class="persona-card-num">03</div><h4 class="persona-card-title">Creativity &amp; Storytelling</h4><p class="persona-card-text">Speaking on how ideas become stories — and how stories become worlds.</p></div>
          </div>
        </div>

      </div>
    </section>

    <!-- CTA -->
    <section class="section-gap">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/djn-empty-theater.png')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Meet Dr. John Neal Jr.</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <p class="cta-sub">For speaking engagements, collaborations or to bring your story to the screen — start a conversation.</p>
                <div class="banner-button-wrapper">
                  <a href="contact.html" class="primary-button"><span class="link-text">Start a Conversation</span></a>
                  <a href="internship.html" class="secondary-button"><span class="link-text">Internship Program</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'director.html' -Title 'The Director — Dr. John Neal Jr. — Funkhouse Films' -Desc 'Meet Dr. John Neal Jr., writer, director, producer and storyteller — the vision behind Funkhouse Films.' -Active 'director' -Body $directorBody

# ============================================================================
# PAGE: services.html
# ============================================================================
$servicesBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">Services</div>
        <h1 class="page-hero-title">From Idea to Screen</h1>
        <p class="page-hero-sub">A full creative pipeline — from the first spark of an idea to the final frame on screen.</p>
      </div>
    </section>

    <!-- SERVICES -->
    <section class="section-gap">
      <div class="container-default">
        <div class="services-grid">
          <div class="service-card" data-reveal>
            <div class="service-card-num">01</div>
            <div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M4 3h16a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1Zm2 3v12h12V6H6Zm2 2h8v8H8V8Z" fill="currentColor"/></svg></div>
            <h3 class="service-card-title">Film Production</h3>
            <p class="service-card-text">From concept to final delivery — a complete, cinematic production pipeline built around your story.</p>
          </div>
          <div class="service-card" data-reveal data-delay="0.05">
            <div class="service-card-num">02</div>
            <div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M5 4h14a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1Zm-1 13h16v2H4v-2Z" fill="currentColor"/></svg></div>
            <h3 class="service-card-title">Story &amp; Script Development</h3>
            <p class="service-card-text">Developing compelling stories from the first idea — structure, character and world-building.</p>
          </div>
          <div class="service-card" data-reveal data-delay="0.1">
            <div class="service-card-num">03</div>
            <div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M17 10.5V7a1 1 0 0 0-1-1H4a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-3.5l4 4v-11l-4 4Z" fill="currentColor"/></svg></div>
            <h3 class="service-card-title">Video Production</h3>
            <p class="service-card-text">Creative visual content with cinematic quality — commercials, brand films and digital stories.</p>
          </div>
          <div class="service-card" data-reveal data-delay="0.15">
            <div class="service-card-num">04</div>
            <div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M16 11c1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3 1.34 3 3 3Zm-8 0c1.66 0 3-1.34 3-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3Zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5Zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5Z" fill="currentColor"/></svg></div>
            <h3 class="service-card-title">Casting &amp; Crewing</h3>
            <p class="service-card-text">Building the right creative team for every production — from cast to key crew.</p>
          </div>
          <div class="service-card" data-reveal data-delay="0.2">
            <div class="service-card-num">05</div>
            <div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M6.5 2h11l.5.5-2 1.5v11l2 1.5-.5.5h-11l-.5-.5 2-1.5V4L6 2.5l.5-.5Zm2 3v10h7V5h-7Z" fill="currentColor"/></svg></div>
            <h3 class="service-card-title">Post-Production</h3>
            <p class="service-card-text">Editing, story shaping and final creative execution — where the film finds its rhythm.</p>
          </div>
          <div class="service-card" data-reveal data-delay="0.25">
            <div class="service-card-num">06</div>
            <div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M9 4c2 0 3.5 1.5 3 4 1.5-1 3-1 4.5 0l-1.5 1.5c.8.6 1 1.3 1 2.5h-1.8c-.2-3-2-4-3.5-4-1 0-2 .7-2 1.8 0 .7.4 1.2 1 1.6.7.6 1 1.1 1 2H9.3c0-1-.3-1.5-1-2.1-.6-.5-1-1-1-1.8A2.6 2.6 0 0 1 9 4Zm9 7 1.5 1.5 1.5-1.5-1.5-1.5L18 11Zm-3 4 2 2-2 2-2-2 2-2Zm-4 3 1.5 1.5L20.5 13 19 11.5 11 19Z" fill="currentColor"/></svg></div>
            <h3 class="service-card-title">Creative Development</h3>
            <p class="service-card-text">Helping ideas become original, screen-ready properties with real commercial and creative legs.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- PROCESS -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-block">
            <div class="gradient-text-wrapper"><h2 class="section-title">How We Work</h2></div>
            <div class="title-animation-overlay"></div>
          </div>
        </div>
        <div class="timeline">
          <div class="timeline-step" data-reveal><div class="timeline-num">01</div><div><h4 class="timeline-title">Discover</h4><p class="timeline-text">We talk about your story, your audience and your vision — and define the world we're building.</p></div></div>
          <div class="timeline-step" data-reveal><div class="timeline-num">02</div><div><h4 class="timeline-title">Develop</h4><p class="timeline-text">Script, structure and creative direction take shape through iteration and collaboration.</p></div></div>
          <div class="timeline-step" data-reveal><div class="timeline-num">03</div><div><h4 class="timeline-title">Produce</h4><p class="timeline-text">On set and in the field — capturing the story with cinematic craft and care.</p></div></div>
          <div class="timeline-step" data-reveal><div class="timeline-num">04</div><div><h4 class="timeline-title">Deliver</h4><p class="timeline-text">Editing, sound and finishing — then a film ready for audiences, festivals and beyond.</p></div></div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="section-gap">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/onset-1.jpg')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Have a Story to Tell?</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <p class="cta-sub">Tell us about your project — we'll help you take it from idea to screen.</p>
                <div class="banner-button-wrapper">
                  <a href="contact.html" class="primary-button"><span class="link-text">Start a Conversation</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'services.html' -Title 'Services — From Idea to Screen — Funkhouse Films' -Desc 'Funkhouse Films services — film production, story and script development, video production, casting, post-production and creative development.' -Active 'services' -Body $servicesBody

# ============================================================================
# PAGE: behind-the-films.html
# ============================================================================
$behindBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">Behind the Films</div>
        <h1 class="page-hero-title">Every Film Has a Story Before the Story</h1>
        <p class="page-hero-sub">On set, in the edit, in the director's chair — a continuous look inside how Funkhouse worlds are made.</p>
      </div>
    </section>

    <!-- STREAM GRID -->
    <section class="section-gap">
      <div class="container-default">
        <div class="home-one-streaming-grid" style="position:static;">
          <a href="#" class="home-one-stream-large-card stream-card" data-youtube="MMe2VQwyVUU">
            <img src="assets/img/coral-sm-10.jpg" loading="lazy" alt="Cast interviews" class="stream-card-media">
            <div class="stream-card-shade"></div>
            <div class="stream-play"><svg width="18" height="20" viewBox="0 0 18 20" fill="none"><path d="M17.28 9.2 1.3.35A.76.76 0 0 0 .2.5a.76.76 0 0 0-.2.55v17.9a.8.8 0 0 0 .4.7.76.76 0 0 0 .9-.15l15.98-8.85a.8.8 0 0 0 0-1.45Z" fill="currentColor"/></svg></div>
            <div class="stream-card-content"><div class="stream-card-kicker">On Set · Feature</div><h3 class="stream-card-title">Coral — Cast Interviews</h3><div class="stream-card-stats"><span class="live-dot"></span> Inside the world of Coral</div></div>
          </a>
          <div class="stream-cards-column">
            <a href="#" class="stream-card" data-youtube="mrG6mndMxSE">
              <img src="assets/img/djn-directors-chair.png" loading="lazy" alt="Official trailer" class="stream-card-media">
              <div class="stream-card-shade"></div>
              <div class="stream-play"><svg width="12" height="14" viewBox="0 0 18 20" fill="none"><path d="M17.28 9.2 1.3.35A.76.76 0 0 0 .2.5a.76.76 0 0 0-.2.55v17.9a.8.8 0 0 0 .4.7.76.76 0 0 0 .9-.15l15.98-8.85a.8.8 0 0 0 0-1.45Z" fill="currentColor"/></svg></div>
              <div class="stream-card-content"><div class="stream-card-kicker">Official Trailer</div><h3 class="stream-card-title">Coral — The Haunted Assignment</h3><div class="stream-card-stats"><span class="live-dot"></span> Best Horror Trailer · Film Fest LA</div></div>
            </a>
            <a href="#" class="stream-card" data-youtube="k1rqimMpY8o">
              <img src="assets/img/coral-sm-13.jpg" loading="lazy" alt="Teaser" class="stream-card-media">
              <div class="stream-card-shade"></div>
              <div class="stream-play"><svg width="12" height="14" viewBox="0 0 18 20" fill="none"><path d="M17.28 9.2 1.3.35A.76.76 0 0 0 .2.5a.76.76 0 0 0-.2.55v17.9a.8.8 0 0 0 .4.7.76.76 0 0 0 .9-.15l15.98-8.85a.8.8 0 0 0 0-1.45Z" fill="currentColor"/></svg></div>
              <div class="stream-card-content"><div class="stream-card-kicker">Teaser</div><h3 class="stream-card-title">Coral — First Look</h3><div class="stream-card-stats"><span class="live-dot"></span> Making the scares</div></div>
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- HUB CATEGORIES -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-block">
            <div class="gradient-text-wrapper"><h2 class="section-title">Inside the Machine</h2></div>
            <div class="title-animation-overlay"></div>
          </div>
        </div>
        <div class="services-grid">
          <div class="service-card" data-reveal><div class="service-card-num">01</div><div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M4 3h16a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1Zm2 3v12h12V6H6Zm2 2h8v8H8V8Z" fill="currentColor"/></svg></div><h3 class="service-card-title">On Set</h3><p class="service-card-text">Production photographs, videos and stories from the shoot.</p></div>
          <div class="service-card" data-reveal data-delay="0.05"><div class="service-card-num">02</div><div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M6.5 2h11l.5.5-2 1.5v11l2 1.5-.5.5h-11l-.5-.5 2-1.5V4L6 2.5l.5-.5Zm2 3v10h7V5h-7Z" fill="currentColor"/></svg></div><h3 class="service-card-title">In the Edit</h3><p class="service-card-text">How scenes evolve — story shaping and the final creative execution.</p></div>
          <div class="service-card" data-reveal data-delay="0.1"><div class="service-card-num">03</div><div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M5 4h14a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V5a1 1 0 0 1 1-1Zm-1 13h16v2H4v-2Z" fill="currentColor"/></svg></div><h3 class="service-card-title">From Page to Screen</h3><p class="service-card-text">Script-to-film storytelling — how written words become images.</p></div>
          <div class="service-card" data-reveal data-delay="0.15"><div class="service-card-num">04</div><div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M16 11c1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3 1.34 3 3 3Zm-8 0c1.66 0 3-1.34 3-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3Zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5Zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5Z" fill="currentColor"/></svg></div><h3 class="service-card-title">Meet the Cast &amp; Crew</h3><p class="service-card-text">The people behind the productions — the human side of the machine.</p></div>
          <div class="service-card" data-reveal data-delay="0.2"><div class="service-card-num">05</div><div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M12 2l2.5 5.1 5.5.8-4 3.9.9 5.5L12 14.8 7.1 17.3 8 11.8 4 7.9l5.5-.8L12 2z" fill="currentColor"/></svg></div><h3 class="service-card-title">Making the Scares</h3><p class="service-card-text">How the horror lands — practical effects, tension and atmosphere.</p></div>
          <div class="service-card" data-reveal data-delay="0.25"><div class="service-card-num">06</div><div class="service-card-icon"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M18.5 4.5 6 10.5l4.5 3 3 4.5 6-12.5ZM13.8 13.3l-1.5-1.5 4-4 1.5 1.5-4 4Z" fill="currentColor"/></svg></div><h3 class="service-card-title">The Director's Chair</h3><p class="service-card-text">Insights from Dr. John Neal Jr. on direction, craft and creativity.</p></div>
        </div>
      </div>
    </section>

    <!-- PHOTO STRIP -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-block">
            <div class="gradient-text-wrapper"><h2 class="section-title">From the Production</h2></div>
            <div class="title-animation-overlay"></div>
          </div>
        </div>
        <div class="explore-grid">
          <div class="game-card-block" data-reveal><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/onset-1.jpg" loading="lazy" alt="On set" class="game-thumbnail"></div></div></div>
          <div class="game-card-block" data-reveal data-delay="0.06"><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/onset-6.jpg" loading="lazy" alt="On set" class="game-thumbnail"></div></div></div>
          <div class="game-card-block" data-reveal data-delay="0.12"><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/onset-8.jpg" loading="lazy" alt="On set" class="game-thumbnail"></div></div></div>
          <div class="game-card-block" data-reveal data-delay="0.18"><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/directing.jpg" loading="lazy" alt="Directing" class="game-thumbnail"></div></div></div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/coral-sm-11.jpg')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Want More Behind the Films?</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <p class="cta-sub">Join the Funkhouse for behind-the-scenes stories, first looks and festival news.</p>
                <div class="banner-button-wrapper">
                  <a href="#join" class="primary-button"><span class="link-text">Join the Story</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'behind-the-films.html' -Title 'Behind the Films — Funkhouse Films' -Desc 'A continuous look inside how Funkhouse worlds are made — on set, in the edit, from page to screen.' -Active 'behind' -Body $behindBody

# ============================================================================
# PAGE: awards.html
# ============================================================================
$awardsBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">Awards &amp; Recognition</div>
        <h1 class="page-hero-title">Recognized for the Stories We Tell</h1>
        <p class="page-hero-sub">Festival laurels, awards, official selections and press — the recognition behind every Funkhouse world.</p>
      </div>
    </section>

    <!-- AWARD CARDS -->
    <section class="section-gap">
      <div class="container-default">
        <div class="services-grid">
          <div class="award-card" data-reveal>
            <div class="award-laurel"><svg width="30" height="30" viewBox="0 0 24 24" fill="none"><path d="M12 2l2.5 5.1 5.5.8-4 3.9.9 5.5L12 14.8 7.1 17.3 8 11.8 4 7.9l5.5-.8L12 2z" fill="currentColor"/></svg></div>
            <div class="award-meta">Film Fest LA · 2025</div>
            <h3 class="award-title">Best Horror Trailer</h3>
            <p class="award-desc">Coral: The Haunted Assignment — the official trailer's craft and tension celebrated on the festival stage.</p>
          </div>
          <div class="award-card" data-reveal data-delay="0.06">
            <div class="award-laurel"><svg width="30" height="30" viewBox="0 0 24 24" fill="none"><path d="M12 2l2.5 5.1 5.5.8-4 3.9.9 5.5L12 14.8 7.1 17.3 8 11.8 4 7.9l5.5-.8L12 2z" fill="currentColor"/></svg></div>
            <div class="award-meta">Marina Del Rey Film Festival</div>
            <h3 class="award-title">Best Editing</h3>
            <p class="award-desc">Recognition for the rhythm and craft of Coral's cutting — every frame earning its place.</p>
          </div>
          <div class="award-card" data-reveal data-delay="0.12">
            <div class="award-laurel"><svg width="30" height="30" viewBox="0 0 24 24" fill="none"><path d="M12 2l2.5 5.1 5.5.8-4 3.9.9 5.5L12 14.8 7.1 17.3 8 11.8 4 7.9l5.5-.8L12 2z" fill="currentColor"/></svg></div>
            <div class="award-meta">Festival Circuit</div>
            <h3 class="award-title">Official Selections</h3>
            <p class="award-desc">Coral continues its journey with official selections and audience screenings around the world.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- QUOTE / PRESS -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="sponsor-title-wrapper">
          <h2 class="home-about-title text-animate" data-image-word="stories" style="font-size:clamp(28px,3.4vw,46px);">RECOGNIZED FOR THE STORIES WE TELL</h2>
          <p class="paragraph" style="margin-top:32px; text-align:center; max-width:680px; margin-left:auto; margin-right:auto;">From trailer awards to editing honors, the recognition behind Coral reflects the craft and commitment that goes into every Funkhouse world.</p>
        </div>
        <div class="sponsor-grid">
          <div class="sponsor-card-block" data-reveal><div class="sponsor-logo-wrapper"><div class="sponsor-logo-text">Film Fest<br>LA</div><div class="sponsor-logo-overlay"><div><div class="sponsor-overlay-title">Best Horror Trailer</div><div class="sponsor-overlay-sub">Coral · 2025</div></div></div></div></div>
          <div class="sponsor-card-block" data-reveal data-delay="0.05"><div class="sponsor-logo-wrapper"><div class="sponsor-logo-text">Marina Del Rey<br>Film Festival</div><div class="sponsor-logo-overlay"><div><div class="sponsor-overlay-title">Best Editing</div><div class="sponsor-overlay-sub">Coral · Craft</div></div></div></div></div>
          <div class="sponsor-card-block" data-reveal data-delay="0.1"><div class="sponsor-logo-wrapper"><div class="sponsor-logo-text">Coral<br>The Haunted Assignment</div><div class="sponsor-logo-overlay"><div><div class="sponsor-overlay-title">Now Streaming</div><div class="sponsor-overlay-sub">Trailer &amp; interviews</div></div></div></div></div>
          <div class="sponsor-card-block" data-reveal data-delay="0.15"><div class="sponsor-logo-wrapper"><div class="sponsor-logo-text">Funkhouse<br>Originals</div><div class="sponsor-logo-overlay"><div><div class="sponsor-overlay-title">Original IP</div><div class="sponsor-overlay-sub">Stories built to last</div></div></div></div></div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="section-gap">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/coral-sm-1.jpg')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Experience the Award-Winning Trailer</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <div class="banner-button-wrapper">
                  <a href="#" class="primary-button" data-youtube="mrG6mndMxSE"><span class="link-text">Watch the Trailer</span></a>
                  <a href="film-coral.html" class="secondary-button"><span class="link-text">About the Film</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'awards.html' -Title 'Awards &amp; Press — Funkhouse Films' -Desc 'Funkhouse Films awards and recognition — Best Horror Trailer at Film Fest LA 2025, Best Editing at Marina Del Rey Film Festival.' -Active 'awards' -Body $awardsBody

# ============================================================================
# PAGE: internship.html
# ============================================================================
$internshipBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">Internship Program</div>
        <h1 class="page-hero-title">Learn Where Films Are Made</h1>
        <p class="page-hero-sub">A hands-on internship experience in real production settings — on set and in the edit bay alongside experienced filmmakers.</p>
      </div>
    </section>

    <!-- THREE-STEP JOURNEY -->
    <section class="section-gap">
      <div class="container-default">
        <div class="timeline">
          <div class="timeline-step" data-reveal><div class="timeline-num">01</div><div><h4 class="timeline-title">On Set</h4><p class="timeline-text">Experience real production environments — observing how a film set runs, from camera to craft.</p></div></div>
          <div class="timeline-step" data-reveal><div class="timeline-num">02</div><div><h4 class="timeline-title">In the Edit</h4><p class="timeline-text">Understand how stories are shaped after filming — editing, pacing and the final creative execution.</p></div></div>
          <div class="timeline-step" data-reveal><div class="timeline-num">03</div><div><h4 class="timeline-title">Build Your Craft</h4><p class="timeline-text">Learn through collaboration and hands-on experience — mentored by working filmmakers.</p></div></div>
        </div>
      </div>
    </section>

    <!-- EXPERIENCE -->
    <section class="section-gap-top section-gap-bottom bg-surface">
      <div class="container-default">
        <div class="section-title-wrapper">
          <div class="section-title-block">
            <div class="gradient-text-wrapper"><h2 class="section-title">The Experience</h2></div>
            <div class="title-animation-overlay"></div>
          </div>
        </div>
        <div class="explore-grid">
          <div class="game-card-block" data-reveal><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/onset-1.jpg" loading="lazy" alt="On set" class="game-thumbnail"></div></div><div class="game-card-content-block"><h4 class="highlight-card-title">Real Sets</h4><div class="game-card-meta-wrapper"><div class="game-card-meta">Production</div></div></div></div>
          <div class="game-card-block" data-reveal data-delay="0.06"><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/onset-6.jpg" loading="lazy" alt="On set" class="game-thumbnail"></div></div><div class="game-card-content-block"><h4 class="highlight-card-title">Real Roles</h4><div class="game-card-meta-wrapper"><div class="game-card-meta">Collaboration</div></div></div></div>
          <div class="game-card-block" data-reveal data-delay="0.12"><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/onset-8.jpg" loading="lazy" alt="On set" class="game-thumbnail"></div></div><div class="game-card-content-block"><h4 class="highlight-card-title">Real Projects</h4><div class="game-card-meta-wrapper"><div class="game-card-meta">Hands-on</div></div></div></div>
          <div class="game-card-block" data-reveal data-delay="0.18"><div class="game-thumbnail-wrapper"><div class="game-thumbnail-inner"><img src="assets/img/directing.jpg" loading="lazy" alt="Directing" class="game-thumbnail"></div></div><div class="game-card-content-block"><h4 class="highlight-card-title">Real Mentors</h4><div class="game-card-meta-wrapper"><div class="game-card-meta">Guidance</div></div></div></div>
        </div>
      </div>
    </section>

    <!-- HOW TO APPLY + FAQ -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="two-col">
          <div data-reveal>
            <div class="section-title-caption" style="margin-bottom:20px;">How to Apply</div>
            <h3 class="title-serif" style="margin-bottom:16px;">Tell us why you want to make films.</h3>
            <p class="paragraph" style="margin-bottom:28px;">Send a note about your background, why you love storytelling, and what you'd like to learn. No experience required — just passion and curiosity.</p>
            <div class="banner-button-wrapper">
              <a href="contact.html" class="primary-button"><span class="link-text">Apply Now</span></a>
              <a href="director.html" class="secondary-button"><span class="link-text">Meet Your Mentor</span></a>
            </div>
          </div>

          <div data-reveal data-delay="0.06">
            <h3 class="title-serif" style="margin-bottom:20px;">Frequently Asked Questions</h3>
            <div class="faq-item">
              <button class="faq-question">Do I need film experience?<span class="faq-icon">+</span></button>
              <div class="faq-answer"><div class="faq-answer-inner">No. We look for curiosity, passion and a willingness to learn. Experience helps but isn't required.</div></div>
            </div>
            <div class="faq-item">
              <button class="faq-question">Is the internship paid?<span class="faq-icon">+</span></button>
              <div class="faq-answer"><div class="faq-answer-inner">Arrangements are discussed individually. The focus is on hands-on experience in real production environments.</div></div>
            </div>
            <div class="faq-item">
              <button class="faq-question">What will I work on?<span class="faq-icon">+</span></button>
              <div class="faq-answer"><div class="faq-answer-inner">You'll work across current productions — on set and in the edit bay — wherever the story needs you most.</div></div>
            </div>
            <div class="faq-item">
              <button class="faq-question">How long is the program?<span class="faq-icon">+</span></button>
              <div class="faq-answer"><div class="faq-answer-inner">Programs are shaped around productions — typically a few months, with opportunities to extend.</div></div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA -->
    <section class="section-gap-top section-gap-bottom">
      <div class="container-default">
        <div class="cta-sticky-wrapper">
          <div class="cta-bg" style="background-image:url('assets/img/onset-6.jpg')"></div>
          <div class="cta-wrapper">
            <div class="cta-inner-block">
              <div class="cta-content-block">
                <div class="cta-title-block">
                  <div class="section-title-block">
                    <div class="gradient-text-wrapper"><h2 class="section-title">Ready to Learn Where Films Are Made?</h2></div>
                    <div class="title-animation-overlay"></div>
                  </div>
                </div>
                <div class="banner-button-wrapper">
                  <a href="contact.html" class="primary-button"><span class="link-text">Apply Now</span></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'internship.html' -Title 'Internship — Learn Where Films Are Made — Funkhouse Films' -Desc 'The Funkhouse Films internship program — hands-on experience in real production settings, on set and in the edit bay.' -Active 'internship' -Body $internshipBody

# ============================================================================
# PAGE: contact.html
# ============================================================================
$contactBody = @'
    <!-- PAGE HERO -->
    <section class="page-hero">
      <div class="container-default">
        <div class="page-hero-kicker">Contact</div>
        <h1 class="page-hero-title">Start a Conversation</h1>
        <p class="page-hero-sub">Have a story to tell, a project to build, an internship question or a speaking inquiry — we'd love to hear from you.</p>
      </div>
    </section>

    <!-- CONTACT -->
    <section class="section-gap">
      <div class="container-default">
        <div class="contact-grid">
          <div data-reveal>
            <div class="section-title-caption" style="margin-bottom:20px;">Get in Touch</div>
            <h3 class="title-serif" style="margin-bottom:16px;">Tell us about your project.</h3>
            <p class="paragraph" style="margin-bottom:32px;">Whether it's a film, a brand story, an internship or a speaking request — we read everything and respond to the stories that move us.</p>

            <div class="footer-address-block">
              <div>
                <h4 class="footer-heading">Films &amp; Press</h4>
                <p class="paragraph">Best Horror Trailer · Film Fest LA 2025<br>Best Editing · Marina Del Rey Film Festival</p>
              </div>
              <div>
                <h4 class="footer-heading">Watch</h4>
                <div class="footer-social-row" style="margin-top:4px;">
                  <a href="https://www.youtube.com/@Funkhousefilms" target="_blank" rel="noopener" class="footer-social" aria-label="YouTube"><svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M23 7.5s-.2-1.6-.9-2.3c-.8-.9-1.8-.9-2.3-1C16.6 4 12 4 12 4s-4.6 0-7.8.2c-.5.1-1.5.1-2.3 1-.7.7-.9 2.3-.9 2.3S.8 9.4.8 11.3v1.4c0 1.9.2 3.8.2 3.8s.2 1.6.9 2.3c.8.9 1.9.8 2.4 1 1.7.2 7 .2 7 .2s4.6 0 7.8-.2c.5-.1 1.5-.1 2.3-1 .7-.7.9-2.3.9-2.3s.2-1.9.2-3.8v-1.4c0-1.9-.2-3.8-.2-3.8ZM9.8 15.3V8.7l6.2 3.3-6.2 3.3Z"/></svg></a>
                  <a href="#" class="footer-social" aria-label="Instagram"><svg width="18" height="18" viewBox="0 0 24 24" fill="none"><rect x="2.5" y="2.5" width="19" height="19" rx="5.5" stroke="currentColor" stroke-width="1.8"/><circle cx="12" cy="12" r="4.2" stroke="currentColor" stroke-width="1.8"/><circle cx="17.6" cy="6.4" r="1.3" fill="currentColor"/></svg></a>
                  <a href="#" class="footer-social" aria-label="X"><svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M18.9 1.2h3.7l-8.1 9.3L24 22.8h-7.5l-5.9-7.7-6.7 7.7H.2l8.7-9.9L0 1.2h7.7l5.3 7 6-7Zm-1.3 19.4h2L6.6 3.3H4.4l13.2 17.3Z"/></svg></a>
                </div>
              </div>
            </div>
          </div>

          <div data-reveal data-delay="0.06">
            <form data-js-form>
              <div class="form-field">
                <label class="form-label" for="cf-name">Name</label>
                <input class="form-input" id="cf-name" type="text" placeholder="Your name" required>
              </div>
              <div class="form-field">
                <label class="form-label" for="cf-email">Email</label>
                <input class="form-input" id="cf-email" type="email" placeholder="you@example.com" required>
              </div>
              <div class="form-field">
                <label class="form-label" for="cf-topic">Topic</label>
                <select class="form-input" id="cf-topic">
                  <option>Film / Project Inquiry</option>
                  <option>Production Services</option>
                  <option>Internship</option>
                  <option>Speaking / Press</option>
                  <option>Something Else</option>
                </select>
              </div>
              <div class="form-field">
                <label class="form-label" for="cf-msg">Message</label>
                <textarea class="form-textarea" id="cf-msg" placeholder="Tell us about your story..." required></textarea>
              </div>
              <button type="submit" class="primary-button"><span class="link-text">Send Message</span></button>
              <div class="form-success" style="margin-top:16px;">Thank you — your message is on its way.</div>
            </form>
          </div>
        </div>
      </div>
    </section>
'@
New-Page -File 'contact.html' -Title 'Contact — Funkhouse Films' -Desc 'Start a conversation with Funkhouse Films — films, production services, internships, speaking and press.' -Active 'contact' -Body $contactBody

Write-Host "All pages generated."