// ==========================================================================
// STATE MANAGER MODULE
// ==========================================================================
window.StateManager = {
  currentSlide: 1,
  totalSlides: 19,
  currentStep: 0, // Used for Step-by-step Reveal on Slide 16 (0 to 3)

  init() {
    this.slides = document.querySelectorAll('.slide');
    this.totalSlides = this.slides.length;
    
    this.btnPrev = document.getElementById('ctrl-prev');
    this.btnNext = document.getElementById('ctrl-next');
    this.bubbleCurrent = document.getElementById('bubble-current');
    this.bubbleTotal = document.getElementById('bubble-total');
    this.footerSlideNum = document.getElementById('current-slide-num');
    this.progressBarFill = document.getElementById('slide-progress');
    this.navItems = document.querySelectorAll('.nav-item');

    if (this.bubbleTotal) this.bubbleTotal.textContent = this.totalSlides;
    this.updateUI();
  },

  goToSlide(targetIndex) {
    if (targetIndex < 1 || targetIndex > this.totalSlides) return;
    if (targetIndex === this.currentSlide) return;

    const direction = targetIndex > this.currentSlide ? 'forward' : 'backward';
    const prevSlide = this.slides[this.currentSlide - 1];
    const nextSlide = this.slides[targetIndex - 1];

    // Reset step count if leaving Slide 16
    if (this.currentSlide === 16 && targetIndex !== 16) {
      this.currentStep = 0;
      const slide16 = document.getElementById('slide-16');
      if (slide16) {
        slide16.className = 'slide active slide-out-left'; // transition class
      }
    }

    // Remove slide transition classes
    this.slides.forEach(s => {
      s.classList.remove('slide-out-left', 'slide-out-right', 'slide-in-left', 'slide-in-left-active');
    });

    if (direction === 'forward') {
      prevSlide.classList.add('slide-out-left');
      prevSlide.classList.remove('active');
      nextSlide.classList.add('active');
    } else {
      prevSlide.classList.add('slide-out-right');
      prevSlide.classList.remove('active');
      nextSlide.classList.add('slide-in-left');
      nextSlide.offsetHeight; // force reflow
      nextSlide.classList.add('active', 'slide-in-left-active');
    }

    this.currentSlide = targetIndex;
    this.updateUI();
  },

  updateUI() {
    // 1. Update counter bubbles and footers
    if (this.bubbleCurrent) this.bubbleCurrent.textContent = this.currentSlide;
    if (this.footerSlideNum) this.footerSlideNum.textContent = this.currentSlide;

    // 2. Update Progress Bar
    if (this.progressBarFill) {
      const percentage = ((this.currentSlide - 1) / (this.totalSlides - 1)) * 100;
      this.progressBarFill.style.width = `${percentage}%`;
    }

    // 3. Navigation buttons opacity
    if (this.btnPrev) {
      if (this.currentSlide === 1) {
        this.btnPrev.style.opacity = '0.4';
        this.btnPrev.style.pointerEvents = 'none';
      } else {
        this.btnPrev.style.opacity = '1';
        this.btnPrev.style.pointerEvents = 'auto';
      }
    }

    if (this.btnNext) {
      if (this.currentSlide === this.totalSlides && (this.currentSlide !== 16 || this.currentStep === 2)) {
        this.btnNext.style.opacity = '0.4';
        this.btnNext.style.pointerEvents = 'none';
      } else {
        this.btnNext.style.opacity = '1';
        this.btnNext.style.pointerEvents = 'auto';
      }
    }

    // 4. Header nav items active states
    this.navItems.forEach(item => item.classList.remove('active'));
    if (this.currentSlide >= 1 && this.currentSlide <= 3) {
      const el = document.getElementById('nav-intro');
      if (el) el.classList.add('active');
    } else if (this.currentSlide >= 4 && this.currentSlide <= 8) {
      const el = document.getElementById('nav-entity');
      if (el) el.classList.add('active');
    } else if (this.currentSlide >= 9 && this.currentSlide <= 13) {
      const el = document.getElementById('nav-relationship');
      if (el) el.classList.add('active');
    } else if (this.currentSlide >= 14 && this.currentSlide <= 19) {
      const el = document.getElementById('nav-uml');
      if (el) el.classList.add('active');
    }

    // 5. Trigger lazy loaded graphics or special animations
    if (window.DiagramAnimations) {
      window.DiagramAnimations.triggerLazyLoading();
      window.DiagramAnimations.syncSlide16Step();
    }
  },

  next() {
    // If we are on Slide 16, handle step-by-step reveal
    if (this.currentSlide === 16 && this.currentStep < 2) {
      this.currentStep++;
      if (window.DiagramAnimations) {
        window.DiagramAnimations.syncSlide16Step();
      }
      return;
    }
    this.goToSlide(this.currentSlide + 1);
  },

  prev() {
    // If we are on Slide 16, handle step-by-step reverse
    if (this.currentSlide === 16 && this.currentStep > 0) {
      this.currentStep--;
      if (window.DiagramAnimations) {
        window.DiagramAnimations.syncSlide16Step();
      }
      return;
    }
    this.goToSlide(this.currentSlide - 1);
  }
};
