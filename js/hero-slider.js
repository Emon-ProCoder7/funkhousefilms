/* ==========================================================================
   FUNKHOUSE FILMS — Hero Slider
   Auto-advancing full-bleed background carousel with thumbnail controls,
   progress bar and arrow navigation. GSAP cross-fade + scale transition.
   Pauses on hover, resumes on mouse leave. Respects prefers-reduced-motion.
   ========================================================================== */
(function () {
  function onReady(fn) {
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', fn);
    else fn();
  }

  onReady(function () {
    var root = document.getElementById('heroSlider');
    if (!root) return;

    var slides = Array.prototype.slice.call(root.querySelectorAll('.hero-slide'));
    var thumbs = Array.prototype.slice.call(root.querySelectorAll('.hero-thumb'));
    var prevBtn = root.querySelector('.hero-arrow.prev');
    var nextBtn = root.querySelector('.hero-arrow.next');
    var fill = root.querySelector('.hero-slider-line-fill');
    var currentEl = root.querySelector('.hero-slider-index .current');
    var total = slides.length;
    if (!total) return;

    var DURATION = 5; // seconds
    var index = 0;
    var fillTween = null;
    var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    function pad(n) { return String(n + 1).padStart(2, '0'); }

    function setActive(newIndex) {
      thumbs[index] && thumbs[index].classList.remove('is-active');
      thumbs[newIndex] && thumbs[newIndex].classList.add('is-active');
      if (currentEl) currentEl.textContent = pad(newIndex);
    }

    function goTo(newIndex) {
      newIndex = ((newIndex % total) + total) % total;
      if (newIndex === index) { restart(); return; }

      var outgoing = slides[index];
      var incoming = slides[newIndex];
      setActive(newIndex);
      index = newIndex;

      if (window.gsap) {
        gsap.set(incoming, { zIndex: 2 });
        gsap.set(outgoing, { zIndex: 1 });
        gsap.fromTo(incoming, { opacity: 0 }, { opacity: 1, duration: 1.1, ease: 'power2.out' });
        gsap.to(outgoing, { opacity: 0, duration: 0.9, ease: 'power2.out' });
      } else {
        outgoing.classList.remove('is-active');
        incoming.classList.add('is-active');
      }
      restart();
    }

    function next() { goTo(index + 1); }
    function prev() { goTo(index - 1); }

    function startFill() {
      if (reduced || !window.gsap || !fill) return;
      if (fillTween) fillTween.kill();
      gsap.set(fill, { scaleX: 0 });
      fillTween = gsap.to(fill, { scaleX: 1, duration: DURATION, ease: 'none', onComplete: next });
    }

    function restart() { startFill(); }

    thumbs.forEach(function (t, i) {
      t.addEventListener('click', function () { goTo(i); });
    });
    if (nextBtn) nextBtn.addEventListener('click', next);
    if (prevBtn) prevBtn.addEventListener('click', prev);

    root.addEventListener('mouseenter', function () { if (fillTween) fillTween.pause(); });
    root.addEventListener('mouseleave', function () { if (fillTween) fillTween.resume(); });

    // Init state
    if (window.gsap) {
      gsap.set(slides[0], { opacity: 1, zIndex: 2 });
      for (var i = 1; i < slides.length; i++) gsap.set(slides[i], { opacity: 0, zIndex: 0 });
    }
    startFill();
  });
})();
