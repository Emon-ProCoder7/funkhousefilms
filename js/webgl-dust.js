/* ==========================================================================
   FUNKHOUSE FILMS — WebGL gold-dust hero particles (Three.js)
   Subtle floating particle field behind hero text; additive, brand-tinted.
   Degrades to nothing if THREE fails or reduced-motion is set.
   ========================================================================== */
(function () {
  var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (reduced) return;

  function onReady(fn) {
    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', fn);
    else fn();
  }

  function loadThree() {
    return new Promise(function (resolve, reject) {
      if (window.THREE) return resolve(window.THREE);
      var s = document.createElement('script');
      s.src = 'https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js';
      s.onload = function () { resolve(window.THREE); };
      s.onerror = function () { reject(new Error('three failed')); };
      document.head.appendChild(s);
    });
  }

  onReady(function () {
    if (!document.querySelector('[data-dust]')) return;
    loadThree().then(function () {
      boot();
    }).catch(function (err) {
      if (window.console && console.warn) console.warn('Dust disabled:', err && err.message || err);
    });
  });

  function boot() {
    var canvases = document.querySelectorAll('[data-dust]');
    if (!canvases.length) return;

    var color = new THREE.Color('#d6c3a3');
    var rat = window.devicePixelRatio || 1;
    var dpr = Math.min(rat, 1.6);

    Array.prototype.slice.call(canvases).forEach(function (canvas) {
      var holder = canvas.parentElement;
      if (!holder) return;

      var renderer;
      try {
        renderer = new THREE.WebGLRenderer({ canvas: canvas, alpha: true, antialias: false, powerPreference: 'low-power' });
      } catch (err) { return; }
      renderer.setPixelRatio(dpr);

      var scene = new THREE.Scene();
      var camera = new THREE.PerspectiveCamera(60, 1, 0.1, 100);
      camera.position.z = 10;

      var COUNT = 150;
      var geo = new THREE.BufferGeometry();
      var pos = new Float32Array(COUNT * 3);
      var seed = new Float32Array(COUNT);
      for (var i = 0; i < COUNT; i++) {
        pos[i * 3] = (Math.random() - 0.5) * 18;
        pos[i * 3 + 1] = (Math.random() - 0.5) * 10;
        pos[i * 3 + 2] = (Math.random() - 0.5) * 6;
        seed[i] = Math.random() * Math.PI * 2;
      }
      geo.setAttribute('position', new THREE.BufferAttribute(pos, 3));

      var mat = new THREE.PointsMaterial({
        color: color, size: 0.12, transparent: true, opacity: 0.55,
        blending: THREE.AdditiveBlending, depthWrite: false, sizeAttenuation: true
      });
      var points = new THREE.Points(geo, mat);
      scene.add(points);

      function resize() {
        var w = holder.clientWidth || 1;
        var h = holder.clientHeight || 1;
        renderer.setSize(w, h, false);
        camera.aspect = w / h;
        camera.updateProjectionMatrix();
      }
      resize();
      window.addEventListener('resize', resize);

      var raf = 0;
      var t0 = performance.now();
      function loop(now) {
        var t = (now - t0) * 0.001;
        var arr = geo.attributes.position.array;
        for (var i = 0; i < COUNT; i++) {
          var s = seed[i];
          arr[i * 3] += Math.sin(t * 0.35 + s) * 0.0022;
          arr[i * 3 + 1] += Math.cos(t * 0.28 + s * 1.7) * 0.0018;
        }
        geo.attributes.position.needsUpdate = true;
        points.rotation.y = Math.sin(t * 0.06) * 0.06;
        points.rotation.z += 0.0004;
        // fade with window scroll
        var y = window.scrollY || 0;
        mat.opacity = Math.max(0, 0.55 - y / (window.innerHeight * 0.8));
        renderer.render(scene, camera);
        raf = requestAnimationFrame(loop);
      }
      raf = requestAnimationFrame(loop);

      var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (en) {
          if (en.isIntersecting) { if (!raf) raf = requestAnimationFrame(loop); }
          else { if (raf) { cancelAnimationFrame(raf); raf = 0; } }
        });
      }, { threshold: 0.01 });
      observer.observe(holder);

      // Free resources on page hide
      window.addEventListener('pagehide', function () {
        if (raf) cancelAnimationFrame(raf);
        observer.disconnect();
        geo.dispose(); mat.dispose(); renderer.dispose();
      });
    });
  }
})();