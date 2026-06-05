// ==========================================================================
// NAVIGATION ENGINE MODULE
// ==========================================================================
window.Navigation = {
  init() {
    this.setupClickControls();
    this.setupKeyboardControls();
    this.setupTouchGestures();
  },

  // Mouse / click navigation
  setupClickControls() {
    const btnPrev = document.getElementById('ctrl-prev');
    const btnNext = document.getElementById('ctrl-next');
    
    if (btnPrev) {
      btnPrev.addEventListener('click', () => {
        window.StateManager.prev();
      });
    }

    if (btnNext) {
      btnNext.addEventListener('click', () => {
        window.StateManager.next();
      });
    }

    // Header nav links to specific slides
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
      item.addEventListener('click', () => {
        const targetSlide = parseInt(item.getAttribute('data-slide'));
        window.StateManager.goToSlide(targetSlide);
      });
    });
  },

  // Keyboard navigation
  setupKeyboardControls() {
    document.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'Enter') {
        e.preventDefault(); // prevent scrolling
        window.StateManager.next();
      } else if (e.key === 'ArrowLeft' || e.key === 'Backspace') {
        e.preventDefault();
        window.StateManager.prev();
      }
    });
  },

  // Touch swipe gestures
  setupTouchGestures() {
    let touchStartX = 0;
    
    document.addEventListener('touchstart', (e) => {
      touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });

    document.addEventListener('touchend', (e) => {
      const touchEndX = e.changedTouches[0].screenX;
      const threshold = 60;
      
      if (touchStartX - touchEndX > threshold) {
        window.StateManager.next();
      } else if (touchEndX - touchStartX > threshold) {
        window.StateManager.prev();
      }
    }, { passive: true });
  }
};
