/* ==========================================================================
   FUNKHOUSE FILMS — Scroll Experience (premium motion layer)
   Lenis smooth scroll + GSAP ScrollTrigger reveals, parallax, pins,
   magnetic hovers, counters, horizontal galleries & image marquees.
   Runs on every page; degrades gracefully (reduced motion / no GSAP).
   ========================================================================== */
(function () {
  var $ = function (s, c) { return (c || document).querySelector(s); };
  var $$ = function (s, c) { return Array.prototype.slice.call((c || document).querySelectorAll(s)); };
  var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function onReady(fn) {
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', fn);
    else fn();
  }

  onReady(function () {
    if (typeof window.gsap === 'undefined') return;
    gsap.registerPlugin(ScrollTrigger);

    /* ------------------------------------------------------------------
       1. LENIS SMOOTH SCROLL (synced with ScrollTrigger)
       ------------------------------------------------------------------ */
    var lenis = null;
    if (window.Lenis && !reduced) {
      try {
        lenis = new Lenis({ duration: 1.12, easing: function (t) { return Math.min(1, 1.001 - Math.pow(2, -10 * t)); }, smoothWheel: true });
        lenis.on('scroll', ScrollTrigger.update);
        gsap.ticker.add(function (time) { lenis.raf(time * 1000); });
        gsap.ticker.lagSmoothing(0);
        $$('a[href^="#"]').forEach(function (a) {
          a.addEventListener('click', function (e) {
            var id = a.getAttribute('href');
            if (id && id.length > 1) {
              var el = $(id);
              if (el) { e.preventDefault(); lenis.scrollTo(el, { offset: -72 }); }
            }
          });
        });
      } catch (err) { lenis = null; }
    }

    /* ------------------------------------------------------------------
       2. REVEAL SYSTEM  ([data-reveal] = up/down/left/right/zoom/blur)
       ------------------------------------------------------------------ */
    var reveals = $$('[data-reveal]');
    if (reveals.length) {
      if (reduced) {
        reveals.forEach(function (el) { el.style.opacity = 1; el.style.transform = 'none'; });
      } else {
        reveals.forEach(function (el) {
          var dir = el.getAttribute('data-reveal') || 'up';
          var delay = parseFloat(el.getAttribute('data-delay') || '0');
          var dur = parseFloat(el.getAttribute('data-duration') || '0.9');
          var vars = { autoAlpha: 0, ease: 'power3.out', duration: dur, delay: delay };
          if (dir === 'up') vars.y = 48;
          else if (dir === 'down') vars.y = -48;
          else if (dir === 'left') vars.x = 64;
          else if (dir === 'right') vars.x = -64;
          else if (dir === 'zoom') vars.scale = 0.92;
          else if (dir === 'blur') vars.filter = 'blur(12px)';
          else if (dir === 'mask') { vars.clipPath = 'inset(0 0 100% 0)'; vars.y = 0; }
          gsap.from(el, Object.assign({}, vars, {
            scrollTrigger: { trigger: el, start: 'top 88%', once: true }
          }));
        });
      }
    }

    /* ------------------------------------------------------------------
       3. STAGGER GROUPS  ([data-stagger] > direct children)
       ------------------------------------------------------------------ */
    if (!reduced) {
      $$('[data-stagger]').forEach(function (group) {
        var children = $$('> *', group);
        if (!children.length) return;
        gsap.from(children, {
          y: 44, autoAlpha: 0, duration: 0.85, ease: 'power3.out', stagger: 0.1,
          scrollTrigger: { trigger: group, start: 'top 86%', once: true }
        });
      });
    }

    /* ------------------------------------------------------------------
       4. IMAGE PARALLAX  ([data-parallax], speed attr 0-30)
       ------------------------------------------------------------------ */
    if (!reduced) {
      $$('[data-parallax]').forEach(function (el) {
        var speed = parseFloat(el.getAttribute('data-speed') || '12');
        var trigger = el.getAttribute('data-trigger') ? $(el.getAttribute('data-trigger')) : (el.parentElement || el);
        gsap.fromTo(el,
          { yPercent: speed },
          { yPercent: -speed, ease: 'none', scrollTrigger: { trigger: trigger, start: 'top bottom', end: 'bottom top', scrub: true } }
        );
      });
    }

    /* ------------------------------------------------------------------
       5. HORIZONTAL PINNED GALLERY  ([data-h-scroll] > [data-h-track])
       ------------------------------------------------------------------ */
    if (!reduced && window.innerWidth >= 768) {
      $$('[data-h-scroll]').forEach(function (section) {
        var track = $('[data-h-track]', section);
        if (!track) return;
        var distance = function () { return Math.max(0, track.scrollWidth - window.innerWidth); };
        gsap.to(track, {
          x: function () { return -distance(); },
          ease: 'none',
          scrollTrigger: {
            trigger: section, start: 'top top', end: function () { return '+=' + distance(); },
            pin: true, scrub: 1, anticipatePin: 1, invalidateOnRefresh: true
          }
        });
      });
    } else if (window.innerWidth < 768) {
      $$('[data-h-scroll]').forEach(function (section) {
        if (section.classList.contains('h-scroll-section')) section.classList.add('h-scroll-static');
      });
    }

    /* ------------------------------------------------------------------
       6. MAGNETIC HOVER  (.magnetic targets auto-applied)
       ------------------------------------------------------------------ */
    if (!reduced && window.matchMedia('(hover: hover)').matches) {
      $$('.primary-button, .secondary-button, .card-link-cta, .footer-social').forEach(function (btn) {
        if (btn.classList.contains('skip-magnetic')) return;
        var strength = 0.32;
        var inner = btn.querySelector('.link-text, span, svg');
        btn.style.transition = 'transform 0.25s cubic-bezier(0.22, 1, 0.36, 1)';
        btn.addEventListener('mousemove', function (e) {
          var r = btn.getBoundingClientRect();
          var mx = (e.clientX - r.left - r.width / 2) * strength;
          var my = (e.clientY - r.top - r.height / 2) * strength;
          gsap.to(btn, { x: mx, y: my, duration: 0.35, ease: 'power3.out' });
          if (inner) gsap.to(inner, { x: mx * 0.35, y: my * 0.35, duration: 0.35, ease: 'power3.out' });
        });
        btn.addEventListener('mouseleave', function () {
          gsap.to(btn, { x: 0, y: 0, duration: 0.6, ease: 'elastic.out(1, 0.45)' });
          if (inner) gsap.to(inner, { x: 0, y: 0, duration: 0.6, ease: 'elastic.out(1, 0.45)' });
        });
      });
    }

    /* ------------------------------------------------------------------
       7. COUNT-UP  ([data-count])
       ------------------------------------------------------------------ */
    if (!reduced) {
      $$('[data-count]').forEach(function (el) {
        var target = parseFloat(el.getAttribute('data-count'));
        var suffix = el.getAttribute('data-suffix') || '';
        var prefix = el.getAttribute('data-prefix') || '';
        var decimals = (el.getAttribute('data-count').split('.')[1] || '').length;
        var obj = { v: 0 };
        el.innerText = prefix + '0' + suffix;
        gsap.to(obj, {
          v: target, duration: 1.8, ease: 'power2.out',
          scrollTrigger: { trigger: el, start: 'top 88%', once: true },
          onUpdate: function () {
            var val = obj.v.toFixed(decimals);
            if (decimals === 0) val = Math.round(obj.v).toString();
            el.innerText = prefix + val + suffix;
          }
        });
      });
    }

    /* ------------------------------------------------------------------
       8. IMAGE MARQUEE  ([data-marquee] — infinite seamless loop)
       ------------------------------------------------------------------ */
    if (!reduced) {
      $$('[data-marquee]').forEach(function (track) {
        var clone = track.innerHTML;
        var set = track;
        set.innerHTML = clone;
        var distance = function () { return (set.scrollWidth) / 2; };
        gsap.to(set, {
          x: function () { return -distance(); },
          duration: 42, ease: 'none', repeat: -1
        });
      });
    }

    /* ------------------------------------------------------------------
       9. HERO VIDEO PULSE — subtle slow zoom on hero iframe (adds cinema)
       ------------------------------------------------------------------ */
    if (!reduced) {
      var vf = $('.hero-video-iframe');
      if (vf) {
        gsap.to(vf, { scale: 1.08, duration: 18, ease: 'none', repeat: -1, yoyo: true });
      }
    }
  });
})();