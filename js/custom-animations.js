/* ==========================================================================
   FUNKHOUSE FILMS — Custom Animations
   Replicates the ArenaX template interactions using GSAP + ScrollTrigger
   --------------------------------------------------------------------------
   Interactions:
   1.  Hero intro (triptych panels slide in, title lines rise, CTAs fade)
   2.  Character-level text reveal (`.text-animate`) — scrub
   3.  Section-title wipe reveal (`.title-animation-overlay`) — scrub
   4.  Streaming section scroll-pin (`.home-one-stream-scroll-wrap`) — scrub
   5.  GSAP carousels (`.slides-container`) — Draggable, infinite, progress
   6.  Drag sliders (`.drag-container`) — momentum + progress track
   7.  Countdown timer (`.countdown[data-time]`)
   8.  Reveal blocks ([data-reveal], .reveal-blur) — viewport entrance
   9.  Hover micro-interactions & marquee loop
   10. Lightbox (YouTube trailer playback)
   ========================================================================== */

/* --------------------------------------------------------------------------
   Utilities
   -------------------------------------------------------------------------- */
const $ = (sel, ctx) => (ctx || document).querySelector(sel);
const $$ = (sel, ctx) => Array.prototype.slice.call((ctx || document).querySelectorAll(sel));

function onReady(fn) {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', fn);
  } else {
    fn();
  }
}

function prefersReducedMotion() {
  return window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
}

/* --------------------------------------------------------------------------
   Main
   -------------------------------------------------------------------------- */
onReady(() => {
  if (typeof window.gsap === 'undefined') return;

  gsap.registerPlugin(ScrollTrigger, Draggable);

  const reduced = prefersReducedMotion();

  /* ======================================================================
     1. HERO INTRO
     ===================================================================== */
  const hero = $('.brand-hero');
  if (hero && !reduced) {
    const tl = gsap.timeline({ defaults: { ease: 'power3.out' } });

    tl.fromTo('.brand-hero .hero-title .line-inner',
      { yPercent: 115 },
      { yPercent: 0, duration: 1.1, stagger: 0.14 }, 0.15)
      .fromTo('.brand-hero .hero-kicker', { opacity: 0, y: 16 }, { opacity: 1, y: 0, duration: 0.7 }, 0.35)
      .fromTo('.brand-hero .hero-sub', { opacity: 0, y: 22 }, { opacity: 1, y: 0, duration: 0.8 }, 0.5)
      .fromTo('.brand-hero .hero-cta-row > *', { opacity: 0, y: 24 }, { opacity: 1, y: 0, duration: 0.7, stagger: 0.1 }, 0.65)
      .fromTo('.brand-hero .hero-tags > *', { opacity: 0, y: 14 }, { opacity: 1, y: 0, duration: 0.6, stagger: 0.07 }, 0.8)
      .fromTo('.brand-hero .hero-scroll-indicator', { opacity: 0 }, { opacity: 1, duration: 0.8 }, 1);
  }

  /* ======================================================================
     1b. FILM SLIDER SECTION — appears from nowhere, zooms to fit on scroll
     ===================================================================== */
  const sliderSection = $('#heroSlider');
  if (sliderSection && !reduced) {
    gsap.set(sliderSection, { opacity: 0, scale: 0.72, transformOrigin: '50% 50%', willChange: 'transform, opacity' });
    gsap.set('#heroSlider .hero-kicker, #heroSlider .hero-title .line-inner, #heroSlider .hero-sub, #heroSlider .hero-cta-row > *, #heroSlider .hero-tags > *', { opacity: 0 });

    gsap.timeline({
      scrollTrigger: {
        trigger: sliderSection,
        start: 'top 92%',
        end: 'top 20%',
        scrub: 0.6
      }
    })
      .to(sliderSection, { opacity: 1, scale: 1, ease: 'none' }, 0)
      .to('#heroSlider .hero-kicker, #heroSlider .hero-title .line-inner, #heroSlider .hero-sub, #heroSlider .hero-cta-row > *, #heroSlider .hero-tags > *',
        { opacity: 1, ease: 'none', stagger: 0.03 }, 0.15);
  } else if (sliderSection && reduced) {
    gsap.set(sliderSection, { opacity: 1, scale: 1 });
  }

  /* Header scroll state */
  const header = $('.header');
  if (header) {
    const onScroll = () => header.classList.toggle('is-scrolled', window.scrollY > 40);
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  /* ======================================================================
     2. MOBILE MENU
     ===================================================================== */
  const menuBtn = $('.menu-button');
  const mobileMenu = $('.mobile-menu');
  const hamburger = $('.hamburger');

  const closeMenu = () => {
    if (!mobileMenu) return;
    mobileMenu.classList.remove('is-open');
    hamburger && hamburger.classList.remove('is-open');
    document.body.classList.remove('menu-open');
    mobileMenu.querySelectorAll('.mobile-menu-link').forEach((link, i) => {
      gsap.to(link, { opacity: 0, y: 24, duration: 0.25, delay: i * 0.02, overwrite: true });
    });
  };

  const openMenu = () => {
    if (!mobileMenu) return;
    mobileMenu.classList.add('is-open');
    hamburger && hamburger.classList.add('is-open');
    document.body.classList.add('menu-open');
    mobileMenu.querySelectorAll('.mobile-menu-link').forEach((link, i) => {
      gsap.to(link, { opacity: 1, y: 0, duration: 0.6, delay: 0.1 + i * 0.06, ease: 'power3.out', overwrite: true });
    });
    gsap.to('.mobile-menu-cta', { opacity: 1, y: 0, duration: 0.6, delay: 0.1 + mobileMenu.querySelectorAll('.mobile-menu-link').length * 0.06, ease: 'power3.out', overwrite: true });
  };

  if (menuBtn && mobileMenu) {
    menuBtn.addEventListener('click', () => {
      mobileMenu.classList.contains('is-open') ? closeMenu() : openMenu();
    });
    mobileMenu.querySelectorAll('.mobile-menu-link, .mobile-menu-cta').forEach((el) => {
      el.addEventListener('click', closeMenu);
    });

    // "More" nav dropdown
    const navMore = $('.nav-more');
    const navMoreToggle = navMore ? navMore.querySelector('.nav-more-toggle') : null;
    if (navMore && navMoreToggle) {
      navMoreToggle.addEventListener('click', (e) => {
        e.stopPropagation();
        const open = navMore.classList.toggle('is-open');
        navMoreToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
      });
      document.addEventListener('click', (e) => {
        if (!navMore.contains(e.target)) {
          navMore.classList.remove('is-open');
          navMoreToggle.setAttribute('aria-expanded', 'false');
        }
      });
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          navMore.classList.remove('is-open');
          navMoreToggle.setAttribute('aria-expanded', 'false');
        }
      });
    }
  }

  /* ======================================================================
     3. TEXT ANIMATION (char-level scrub reveal) — template interaction
     ===================================================================== */
  function splitTextPreserveLines(el) {
    const text = el.textContent.trim();
    el.textContent = '';
    const words = text.split(/\s+/);
    const charsArray = [];
    const imageWords = (el.getAttribute('data-image-word') || 'image').toLowerCase().split(',');

    words.forEach((word, wordIndex) => {
      if (imageWords.indexOf(word.toLowerCase()) > -1) {
        const special = document.createElement('span');
        special.classList.add('bg-image-word');
        special.textContent = word;
        special.style.display = 'inline-block';
        el.appendChild(special);
        if (wordIndex < words.length - 1) el.appendChild(document.createTextNode(' '));
        return;
      }

      const wordSpan = document.createElement('span');
      wordSpan.style.display = 'inline-block';
      wordSpan.style.whiteSpace = 'nowrap';

      word.split('').forEach((char) => {
        const charSpan = document.createElement('span');
        charSpan.classList.add('text-animate-char');
        charSpan.textContent = char;
        charSpan.style.display = 'inline-block';
        wordSpan.appendChild(charSpan);
        charsArray.push(charSpan);
      });

      el.appendChild(wordSpan);
      if (wordIndex < words.length - 1) el.appendChild(document.createTextNode(' '));
    });

    return charsArray;
  }

  $$('.text-animate').forEach((el) => {
    if (reduced) return;
    const chars = splitTextPreserveLines(el);
    if (!chars.length) return;
    gsap.set(chars, { opacity: 0, x: -7 });
    gsap.to(chars, {
      scrollTrigger: {
        trigger: el,
        start: 'top 92%',
        end: 'top 58%',
        scrub: 1
      },
      x: 0,
      y: 0,
      opacity: 1,
      duration: 1,
      stagger: 0.05
    });
  });

  /* ======================================================================
     4. SECTION TITLE WIPE (title-animation-overlay) — scrub
     ===================================================================== */
  $$('.section-title-block').forEach((block) => {
    if (reduced) return;
    const overlay = block.querySelector('.title-animation-overlay');
    if (!overlay) return;

    gsap.timeline({
      scrollTrigger: {
        trigger: block,
        start: 'top 85%',
        end: 'top 45%',
        scrub: 0.6
      }
    })
      .fromTo(overlay, { scaleX: 0 }, { scaleX: 1, ease: 'none', duration: 1 }, 0)
      .to(overlay, { scaleX: 0, transformOrigin: '100% 50%', ease: 'none', duration: 1 }, 1);
  });

  /* ======================================================================
     5. STREAMING SECTION SCROLL — template interaction (scroll-pin)
     ===================================================================== */
  const initStreamScroll = () => {
    if (window.innerWidth < 992) return;
    if (!window.gsap || !window.ScrollTrigger) return;
    if (reduced) return;

    const wrapper = $('.home-one-stream-scroll-wrap');
    const grid = $('.home-one-streaming-grid');
    const innerWrapper = $('.home-one-stream-wrapper');
    if (!wrapper || !grid || !innerWrapper) return;

    innerWrapper.style.overflow = 'auto';
    innerWrapper.scrollTop = 0;
    innerWrapper.style.position = 'relative';

    let accumulatedDelta = 0;
    let wheelRafScheduled = false;

    innerWrapper.addEventListener('wheel', (e) => {
      e.preventDefault();
      accumulatedDelta += e.deltaY * 1.1;
      if (!wheelRafScheduled) {
        wheelRafScheduled = true;
        requestAnimationFrame(() => {
          innerWrapper.scrollTop += accumulatedDelta;
          accumulatedDelta = 0;
          wheelRafScheduled = false;
        });
      }
    }, { passive: false });

    innerWrapper.addEventListener('touchmove', (e) => {
      if (e.touches.length === 1 && innerWrapper.scrollHeight > innerWrapper.clientHeight) e.preventDefault();
    }, { passive: false });

    const getMaxScroll = () => Math.max(0, innerWrapper.scrollHeight - innerWrapper.clientHeight);
    const endOffset = 30;

    const st = ScrollTrigger.create({
      trigger: wrapper,
      start: 'top top+=100',
      end: () => `+=${Math.max(getMaxScroll(), endOffset)}`,
      scrub: true,
      invalidateOnRefresh: true,
      onUpdate: (self) => {
        requestAnimationFrame(() => { innerWrapper.scrollTop = self.progress * getMaxScroll(); });
      }
    });

    requestAnimationFrame(() => st && ScrollTrigger.refresh());
    setTimeout(() => ScrollTrigger.refresh(), 100);
    setTimeout(() => ScrollTrigger.refresh(), 300);
    setTimeout(() => ScrollTrigger.refresh(), 600);

    new ResizeObserver(() => { if (st) ScrollTrigger.refresh(); }).observe(innerWrapper);

    let resizeTimeout;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(() => {
        if (window.innerWidth < 992 && st) st.kill();
      }, 250);
    });
  };

  if (document.readyState === 'complete') {
    initStreamScroll();
  } else {
    window.addEventListener('load', initStreamScroll);
  }

  /* ======================================================================
     6. GSAP CAROUSEL (`.slides-container`) — template interaction
     ===================================================================== */
  const carouselInstances = $$('.slides-container');

  carouselInstances.forEach((slidesContainer, index) => {
    initCarousel(slidesContainer, index);
  });

  function initCarousel(slidesContainer, instanceIndex) {
    const slidesInner = slidesContainer.querySelector('.slides-inner');
    const originalSlides = slidesContainer.querySelectorAll('.slide');
    const progressBar = slidesContainer.querySelector('.progress-bar');
    const progressBarTrack = slidesContainer.querySelector('.progress-bar-track');
    const progressBlock = slidesContainer.querySelector('.progress-block');
    const prevButton = slidesContainer.querySelector('.carousel-prev');
    const nextButton = slidesContainer.querySelector('.carousel-next');
    const sliderIndex = slidesContainer.querySelector('.slider-index');
    const railFill = slidesContainer.querySelector('.progress-rail-fill');

    const isCenterMode = slidesContainer.getAttribute('data-center-mode') === 'true';

    if (!slidesInner || originalSlides.length === 0) return;

    const computedStyle = window.getComputedStyle(slidesInner);
    let gapValue = parseFloat(computedStyle.columnGap) || parseFloat(computedStyle.gap) || 0;

    const numOriginalSlides = originalSlides.length;
    let containerWidth = slidesContainer.offsetWidth;

    // Prevent measure issues while undefined
    if (containerWidth === 0) containerWidth = slidesContainer.parentElement ? slidesContainer.parentElement.offsetWidth : 600;

    // Clone first slides, append to end
    const firstForClone = (slidesInner.querySelector('.slide:not(.clone)')) || originalSlides[0];
    const slidesForClone = firstForClone ? firstForClone.parentElement.querySelectorAll('.slide:not(.clone)') : originalSlides;

    const arrForClone = Array.prototype.slice.call(slidesForClone.length ? slidesForClone : originalSlides);

    let slideWidth = arrForClone[0].offsetWidth || 470;
    let slidesPerView = Math.max(1, Math.ceil(containerWidth / (slideWidth + gapValue)));

    const clonesToCreate = Math.max(slidesPerView + 1, 3);

    // Clone first slides to the end
    for (let i = 0; i < clonesToCreate; i++) {
      const clone = arrForClone[i % numOriginalSlides].cloneNode(true);
      clone.classList.add('clone', 'clone-end');
      slidesInner.appendChild(clone);
    }

    // Clone last slides to the start
    for (let j = 0; j < clonesToCreate; j++) {
      const cloneIndex = numOriginalSlides - 1 - j;
      const clone = arrForClone[cloneIndex].cloneNode(true);
      clone.classList.add('clone', 'clone-start');
      slidesInner.insertBefore(clone, slidesInner.firstChild);
    }

    const allSlides = slidesInner.querySelectorAll('.slide');
    const totalSlides = allSlides.length;

    const config = {
      slideDuration: 0.45,
      gap: gapValue,
      numSlides: numOriginalSlides,
      totalWithClones: totalSlides,
      clonesToCreate: clonesToCreate,
      slidesPerView: slidesPerView,
      progressBlockWidth: 50,
      centerMode: isCenterMode
    };

    const state = {
      slideWidth: 0,
      totalWidth: 0,
      currentIndex: clonesToCreate,
      progressPerItem: numOriginalSlides > 1 ? 1 / (numOriginalSlides - 1) : 1,
      slideAnimation: null,
      isWrapping: false,
      centerOffset: 0
    };

    state.threshold = state.progressPerItem / 5;

    function calculateCenterOffset() {
      if (config.centerMode) return (containerWidth - state.slideWidth) / 2;
      return 0;
    }

    function updateSliderIndex(realIndex) {
      if (sliderIndex) {
        const displayIndex = String(realIndex + 1).padStart(2, '0');
        sliderIndex.textContent = displayIndex;
      }
    }

    function updateProgressBar(isDragging) {
      let realIndex = (state.currentIndex - config.clonesToCreate) % config.numSlides;
      if (realIndex < 0) realIndex += config.numSlides;

      updateSliderIndex(realIndex);

      if (progressBar) {
        const actualProgress = (realIndex / (config.numSlides - 1)) * 100;
        if (isDragging) progressBar.style.transition = 'none';
        else progressBar.style.transition = 'width 0.4s ease-out';
        progressBar.style.width = actualProgress + '%';
      }

      if (railFill) {
        const actualProgress = (realIndex / (config.numSlides - 1)) * 100;
        if (isDragging) railFill.style.transition = 'none';
        else railFill.style.transition = 'width 0.4s ease-out';
        railFill.style.width = actualProgress + '%';
      }

      if (progressBarTrack && progressBlock) {
        const progress = realIndex / (config.numSlides - 1);
        const trackWidth = progressBarTrack.offsetWidth;
        const blockWidth = config.progressBlockWidth;
        const maxBlockX = trackWidth - blockWidth;
        const blockX = progress * maxBlockX;
        if (isDragging) progressBlock.style.transition = 'none';
        else progressBlock.style.transition = 'transform 0.4s ease-out';
        gsap.set(progressBlock, { x: blockX });
      }
    }

    function calculatePosition(slideIndex) {
      const basePosition = -(state.slideWidth + config.gap) * slideIndex;
      return basePosition + state.centerOffset;
    }

    function wrapSlide() {
      if (state.isWrapping) return;

      if (state.currentIndex >= config.clonesToCreate + config.numSlides) {
        state.isWrapping = true;
        const offset = state.currentIndex - (config.clonesToCreate + config.numSlides);
        state.currentIndex = config.clonesToCreate + offset;
        gsap.set(slidesInner, { x: calculatePosition(state.currentIndex) });
        setTimeout(() => { state.isWrapping = false; }, 50);
      } else if (state.currentIndex < config.clonesToCreate) {
        state.isWrapping = true;
        const offset = config.clonesToCreate - state.currentIndex;
        state.currentIndex = config.clonesToCreate + config.numSlides - offset;
        gsap.set(slidesInner, { x: calculatePosition(state.currentIndex) });
        setTimeout(() => { state.isWrapping = false; }, 50);
      }

      updateProgressBar(false);
    }

    function measure() {
      state.slideWidth = allSlides[0].offsetWidth;
      state.centerOffset = calculateCenterOffset();
      gsap.set(slidesInner, { x: calculatePosition(state.currentIndex) });
    }

    state.slideWidth = allSlides[0].offsetWidth || slideWidth || 470;
    state.centerOffset = calculateCenterOffset();
    gsap.set(slidesInner, { x: calculatePosition(state.currentIndex) });

    if (progressBar) progressBar.style.transition = 'width 0.4s ease-out';
    if (progressBlock) progressBlock.style.transition = 'transform 0.4s ease-out';

    /* Auto-advance — smooth, continuous right-to-left motion, pauses on hover/drag */
    const AUTO_ADVANCE_MS = 4200;
    let autoTimer = null;
    function stopAuto() { if (autoTimer) { clearInterval(autoTimer); autoTimer = null; } }
    function startAuto() {
      if (numOriginalSlides <= 1 || prefersReducedMotion()) return;
      stopAuto();
      autoTimer = setInterval(() => animateSlides(1), AUTO_ADVANCE_MS);
    }
    slidesContainer.addEventListener('mouseenter', stopAuto);
    slidesContainer.addEventListener('mouseleave', startAuto);
    startAuto();

    const draggableInstance = Draggable.create(document.createElement('div'), {
      type: 'x',
      trigger: slidesContainer,
      onPress: function () {
        stopAuto();
        gsap.killTweensOf(slidesInner);
        this.startIndex = state.currentIndex;
        this.startX = this.x;
      },
      onDrag: function () {
        const dragDistance = this.x - this.startX;
        const newPosition = calculatePosition(this.startIndex) + dragDistance;
        gsap.set(slidesInner, { x: newPosition });
        const slidesMoved = -dragDistance / (state.slideWidth + config.gap);
        state.currentIndex = this.startIndex + slidesMoved;
        updateProgressBar(true);
      },
      onRelease: function () {
        const dragDistance = this.x - this.startX;
        const slidesMoved = -dragDistance / (state.slideWidth + config.gap);
        const newIndex = Math.round(this.startIndex + slidesMoved);
        state.currentIndex = newIndex;
        gsap.to(slidesInner, {
          x: calculatePosition(newIndex),
          duration: config.slideDuration,
          ease: 'power2.out',
          overwrite: true,
          onComplete: function () { wrapSlide(); }
        });
        updateProgressBar(false);
        startAuto();
      }
    })[0];

    function animateSlides(direction) {
      if (state.isWrapping || numOriginalSlides <= 1) return;
      const newIndex = state.currentIndex + direction;
      state.currentIndex = newIndex;
      if (state.slideAnimation) state.slideAnimation.kill();
      state.slideAnimation = gsap.to(slidesInner, {
        x: calculatePosition(newIndex),
        duration: config.slideDuration,
        ease: 'power2.out',
        overwrite: true,
        onComplete: function () { wrapSlide(); }
      });
      updateProgressBar(false);
    }

    if (prevButton) prevButton.addEventListener('click', () => { animateSlides(-1); startAuto(); });
    if (nextButton) nextButton.addEventListener('click', () => { animateSlides(1); startAuto(); });

    function handleResize() {
      const cs = window.getComputedStyle(slidesInner);
      config.gap = parseFloat(cs.columnGap) || parseFloat(cs.gap) || 0;
      containerWidth = slidesContainer.offsetWidth || containerWidth;
      state.slideWidth = allSlides[0].offsetWidth;
      state.centerOffset = calculateCenterOffset();
      gsap.set(slidesInner, { x: calculatePosition(state.currentIndex) });
      updateProgressBar(false);
    }

    window.addEventListener('resize', handleResize);
    setTimeout(handleResize, 200);
    setTimeout(handleResize, 600);

    if (typeof ScrollTrigger !== 'undefined') ScrollTrigger.refresh();
  }

  /* ======================================================================
     7. DRAG SLIDER (`.drag-container`) — template interaction (momentum)
     ===================================================================== */
  const dragSliderConfig = {
    dampingFactor: 0.85,
    velocityBoost: 1.2,
    edgeResistance: 0.65,
    mobileBreakpoint: 768
  };

  $$('.drag-container').forEach((wrapper, index) => {
    initDragSlider(wrapper, index);
  });

  function initDragSlider(wrapper, instanceIndex) {
    const inner = wrapper.querySelector('.drag-inner');
    const progressBar = wrapper.querySelector('.drag-track');
    const progressBlock = wrapper.querySelector('.drag-block');
    const dragCount = wrapper.querySelector('.track-count');

    if (!inner) return;

    const isMobileOnly = wrapper.getAttribute('data-mobile-only') === 'true';

    const state = {
      draggableInstance: null,
      blockDraggable: null,
      currentX: 0,
      velocity: 0,
      isEnabled: true
    };

    function shouldEnableDrag() {
      if (!isMobileOnly) return true;
      return window.innerWidth < dragSliderConfig.mobileBreakpoint;
    }

    function updateProgressBlock() {
      if (!progressBar || !progressBlock) return;
      const wrapperWidth = wrapper.offsetWidth;
      const innerWidth = inner.scrollWidth;
      const maxScroll = innerWidth - wrapperWidth;

      if (maxScroll <= 0) {
        gsap.set(progressBlock, { x: 0 });
        if (dragCount) dragCount.textContent = '00 / ' + String(inner.querySelectorAll('.upcoming-games-card').length).padStart(2, '0');
        return;
      }

      let progress = Math.abs(state.currentX) / maxScroll;
      progress = Math.max(0, Math.min(1, progress));

      const trackWidth = progressBar.offsetWidth;
      const blockWidth = progressBlock.offsetWidth;
      const maxBlockX = trackWidth - blockWidth;
      gsap.set(progressBlock, { x: progress * maxBlockX });

      if (dragCount) {
        const total = inner.querySelectorAll('.upcoming-games-card').length || 1;
        const shown = Math.max(1, Math.round(progress * (total - 1)) + 1);
        dragCount.textContent = String(Math.min(shown, total)).padStart(2, '0') + ' / ' + String(total).padStart(2, '0');
      }
    }

    function tickerUpdate() {
      if (!state.isEnabled) return;
      state.velocity *= dragSliderConfig.dampingFactor;
      state.currentX += state.velocity;

      const wrapperWidth = wrapper.offsetWidth;
      const innerWidth = inner.scrollWidth;
      const minX = Math.min(0, wrapperWidth - innerWidth);
      const maxX = 0;

      if (state.currentX > maxX) {
        state.currentX += (maxX - state.currentX) * 0.2;
        state.velocity = 0;
      }

      if (state.currentX < minX) {
        state.currentX += (minX - state.currentX) * 0.2;
        state.velocity = 0;
      }

      gsap.set(inner, { x: state.currentX });
      updateProgressBlock();
    }

    gsap.ticker.add(tickerUpdate);

    function createContentDraggable() {
      if (state.draggableInstance) { state.draggableInstance.kill(); state.draggableInstance = null; }

      if (!shouldEnableDrag()) {
        state.isEnabled = false;
        gsap.set(inner, { x: 0 });
        state.currentX = 0;
        state.velocity = 0;
        updateProgressBlock();
        return;
      }

      state.isEnabled = true;
      const wrapperWidth = wrapper.offsetWidth;
      const innerWidth = inner.scrollWidth;

      state.draggableInstance = Draggable.create(inner, {
        type: 'x',
        bounds: { minX: wrapperWidth - innerWidth, maxX: 0 },
        edgeResistance: dragSliderConfig.edgeResistance,
        inertia: false,
        onPress: function () { state.velocity = 0; },
        onDrag: function () {
          const newX = gsap.getProperty(inner, 'x');
          state.velocity = newX - state.currentX;
          state.currentX = newX;
          updateProgressBlock();
        },
        onDragEnd: function () { state.velocity *= dragSliderConfig.velocityBoost; }
      })[0];
    }

    function createBlockDraggable() {
      if (!progressBar || !progressBlock) return;
      if (state.blockDraggable) { state.blockDraggable.kill(); state.blockDraggable = null; }
      if (!shouldEnableDrag()) {
        gsap.set(progressBlock, { x: 0 });
        return;
      }

      state.blockDraggable = Draggable.create(progressBlock, {
        type: 'x',
        bounds: progressBar,
        inertia: false,
        onPress: function () { state.velocity = 0; },
        onDrag: function () {
          const trackWidth = progressBar.offsetWidth;
          const blockWidth = progressBlock.offsetWidth;
          const maxBlockX = trackWidth - blockWidth;
          if (maxBlockX <= 0) return;
          const progress = Math.max(0, Math.min(1, this.x / maxBlockX));
          const wrapperWidth = wrapper.offsetWidth;
          const innerWidth = inner.scrollWidth;
          const maxScroll = innerWidth - wrapperWidth;
          state.currentX = -progress * maxScroll;
          gsap.set(inner, { x: state.currentX });
        },
        onDragEnd: function () { state.velocity = 0; }
      })[0];
    }

    createContentDraggable();
    createBlockDraggable();
    updateProgressBlock();

    function handleResize() {
      createContentDraggable();
      createBlockDraggable();
      updateProgressBlock();
    }

    window.addEventListener('resize', handleResize);
    setTimeout(handleResize, 300);
    setTimeout(updateProgressBlock, 700);
  }

  /* ======================================================================
     8. COUNTDOWN — template interaction (adapted to date countdown)
     ===================================================================== */
  $$('.countdown').forEach((countdownEl) => {
    const targetAttr = countdownEl.getAttribute('data-time');
    let target;

    if (targetAttr && /^\d{4}-\d{2}-\d{2}/.test(targetAttr)) {
      target = new Date(targetAttr).getTime();
    } else if (targetAttr) {
      const [h, m, s] = targetAttr.split(':').map(Number);
      const initialSeconds = (h || 0) * 3600 + (m || 0) * 60 + (s || 0);
      target = Date.now() + initialSeconds * 1000;
    } else {
      target = Date.now() + (30 * 24 * 3600 + 12 * 3600) * 1000;
    }

    const fmt = (n) => String(Math.max(0, n)).padStart(2, '0');

    function updateCountdown() {
      const diff = Math.max(0, target - Date.now());
      const days = Math.floor(diff / 86400000);
      const hours = Math.floor((diff % 86400000) / 3600000);
      const minutes = Math.floor((diff % 3600000) / 60000);
      const seconds = Math.floor((diff % 60000) / 1000);

      let newValue;
      if (days > 0) newValue = `${fmt(days)}:${fmt(hours)}:${fmt(minutes)}:${fmt(seconds)}`;
      else newValue = `${fmt(hours)}:${fmt(minutes)}:${fmt(seconds)}`;

      gsap.fromTo(countdownEl,
        { opacity: 0.45 },
        {
          opacity: 1,
          duration: 0.3,
          ease: 'power2.out',
          onStart: () => { countdownEl.textContent = newValue; }
        }
      );
    }

    updateCountdown();
    setInterval(updateCountdown, 1000);
  });

  /* ======================================================================
     9. REVEAL BLOCKS (viewport entrances)
     [data-reveal] itself is owned by scroll-experience.js (section 2) —
     handling it here too created a duplicate gsap.from() on the same
     elements, which caused stuck/invisible ("black panel") sections.
     Only .reveal-blur is handled here.
     ===================================================================== */
  if (!reduced) {
    $$('.reveal-blur').forEach((el) => {
      gsap.fromTo(el,
        { opacity: 0, filter: 'blur(14px)' },
        {
          opacity: 1, filter: 'blur(0px)',
          duration: 0.9, ease: 'power2.out',
          scrollTrigger: { trigger: el, start: 'top 90%', once: true }
        });
    });
  } else {
    $$('[data-reveal], .reveal-blur').forEach((el) => el.classList.add('is-revealed'));
  }

  /* Staggered card entrances in carousel/sliders via parent section */
  if (!reduced) {
    $$('.featured-games-section, .editor-choice-section, .best-selling-games-section').forEach((section) => {
      if (section.querySelector('.slides-container')) return;
    });
  }

  /* ======================================================================
     10. MARQUEE (infinite strip)
     ===================================================================== */
  $$('.cta-marquee-wrapper').forEach((wrapper) => {
    const track = wrapper.querySelector('.cta-marquee-track');
    if (!track) return;

    const items = track.querySelectorAll('.cta-marquee-inner');
    if (!items.length) return;

    const cloneGroup = items[0].cloneNode(true);
    track.appendChild(cloneGroup);

    const totalWidth = track.scrollWidth / 2;

    gsap.to(track, {
      xPercent: -50,
      ease: 'none',
      duration: 34,
      repeat: -1,
      modifiers: {
        x: (x) => {
          const w = totalWidth;
          const mod = ((parseFloat(x) % w) + w) % w - w;
          return mod + 'px';
        }
      }
    });
  });

  /* ======================================================================
     11. LIGHTBOX (YouTube playback)
     ===================================================================== */
  const lightbox = $('.lightbox');
  const lightboxFrame = lightbox ? $('.lightbox-frame', lightbox) : null;
  const lightboxClose = lightbox ? $('.lightbox-close', lightbox) : null;

  function openLightbox(videoId) {
    if (!lightbox || !lightboxFrame) return;
    lightboxFrame.innerHTML = `<iframe src="https://www.youtube-nocookie.com/embed/${videoId}?autoplay=1&rel=0" title="Funkhouse Films" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`;
    lightbox.classList.add('is-open');
    document.body.classList.add('no-scroll');
  }

  function closeLightbox() {
    if (!lightbox) return;
    lightbox.classList.remove('is-open');
    if (lightboxFrame) lightboxFrame.innerHTML = '';
    document.body.classList.remove('no-scroll');
  }

  if (lightbox && lightboxClose) {
    lightboxClose.addEventListener('click', closeLightbox);
    lightbox.addEventListener('click', (e) => { if (e.target === lightbox) closeLightbox(); });
    document.addEventListener('keydown', (e) => { if (e.key === 'Escape') closeLightbox(); });
  }

  $$('[data-youtube]').forEach((el) => {
    el.addEventListener('click', (e) => {
      e.preventDefault();
      const id = el.getAttribute('data-youtube');
      if (id) openLightbox(id);
    });
  });

  /* ======================================================================
     12. FAQ ACCORDION
     ===================================================================== */
  $$('.faq-question').forEach((q) => {
    q.addEventListener('click', () => {
      const item = q.closest('.faq-item');
      const answer = item.querySelector('.faq-answer');
      const open = item.classList.contains('is-open');

      $$('.faq-item.is-open').forEach((other) => {
        if (other !== item) {
          other.classList.remove('is-open');
          const a = other.querySelector('.faq-answer');
          if (a) a.style.maxHeight = '0px';
        }
      });

      item.classList.toggle('is-open', !open);
      if (answer) answer.style.maxHeight = open ? '0px' : answer.scrollHeight + 'px';
    });
  });

  /* ======================================================================
     13. FORM FEEDBACK
     ===================================================================== */
  $$('form[data-js-form]').forEach((form) => {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const success = form.querySelector('.form-success');
      if (success) success.style.display = 'block';
      form.reset();
    });
  });

  /* ======================================================================
     Final refresh
     ===================================================================== */
  if (typeof ScrollTrigger !== 'undefined') {
    setTimeout(() => ScrollTrigger.refresh(), 400);
    setTimeout(() => ScrollTrigger.refresh(), 900);
  }
});