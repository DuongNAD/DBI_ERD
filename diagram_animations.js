// ==========================================================================
// DIAGRAM ANIMATIONS MODULE
// ==========================================================================
window.DiagramAnimations = {
  loadedDiagrams: {},

  init() {
    this.setupDormCalculator();
    this.setupSlide12EdunextControls();
    this.setupSlide17Interactivity();
    this.setupSlide3CompanyInteractivity();
    this.setupSlide4Interactivity();
    this.setupSlide5Interactivity();
    this.setupSlide6Interactivity();
    this.setupSlide8Interactivity();
    this.setupSlide7Interactivity();
    this.setupSlide9Interactivity();
    this.setupSlide10Interactivity();
    this.setupSlide11Interactivity();
    this.setupSlide13Interactivity();
    this.setupSlide14Interactivity();
    this.setupSlide15Interactivity();
    this.setupSlide18Interactivity();
    this.setupSlide19Interactivity();
  },

  // 1. Lazy Load & SVG Scaling Manager
  triggerLazyLoading() {
    const currentSlide = window.StateManager.currentSlide;

    // Slide 16 Lazy Loading: Scaled & Grouped COMPANY ERD
    if (currentSlide === 16 && !this.loadedDiagrams['company']) {
      const placeholder = document.getElementById('company-lazy-placeholder');
      if (placeholder) {
        placeholder.outerHTML = `
          <svg width="100%" height="100%" viewBox="35 60 860 495" style="color: var(--color-navy); width: 100%; height: auto; max-height: 100%; overflow: visible;">
            <defs>
              <!-- Modern premium drop shadow -->
              <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
                <feDropShadow dx="0" dy="4" stdDeviation="6" flood-color="rgba(0, 34, 68, 0.1)"/>
              </filter>
              <!-- Gradient for entities -->
              <linearGradient id="entityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f8fafc" />
              </linearGradient>
              <!-- Gradient for weak entities -->
              <linearGradient id="weakEntityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0fdfa" />
              </linearGradient>
              <!-- Gradient for relationships -->
              <linearGradient id="relGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0f9ff" />
              </linearGradient>
            </defs>

            <!-- Group 1: Entities -->
            <g class="entity-group" style="transition: opacity 0.5s ease-in-out; opacity: 1;">
              <!-- NHÂN_VIÊN -->
              <g id="slide16-entity-emp" class="diagram-entity-node">
                <rect x="80" y="255" width="140" height="50" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow)"></rect>
                <text x="150" y="285" font-family="var(--font-title)" font-weight="800" font-size="13.5" fill="var(--color-navy)" text-anchor="middle">NHÂN_VIÊN</text>
              </g>
              
              <!-- PHÒNG_BAN -->
              <g id="slide16-entity-dept" class="diagram-entity-node">
                <rect x="410" y="255" width="140" height="50" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow)"></rect>
                <text x="480" y="285" font-family="var(--font-title)" font-weight="800" font-size="13.5" fill="var(--color-navy)" text-anchor="middle">PHÒNG_BAN</text>
              </g>
              
              <!-- DỰ_ÁN -->
              <g id="slide16-entity-proj" class="diagram-entity-node">
                <rect x="740" y="255" width="140" height="50" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow)"></rect>
                <text x="810" y="285" font-family="var(--font-title)" font-weight="800" font-size="13.5" fill="var(--color-navy)" text-anchor="middle">DỰ_ÁN</text>
              </g>
              
              <!-- PHỤ_THUỘC (Weak entity double rect) -->
              <g id="slide16-entity-dep" class="diagram-entity-node">
                <rect x="410" y="445" width="140" height="50" fill="#ffffff" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow)"></rect>
                <rect x="414" y="449" width="132" height="42" fill="url(#weakEntityGrad)" stroke="var(--color-navy)" stroke-width="1.2" rx="4"></rect>
                <text x="480" y="475" font-family="var(--font-title)" font-weight="800" font-size="13.5" fill="var(--color-navy)" text-anchor="middle">PHỤ_THUỘC</text>
              </g>
            </g>

            <!-- Group 2: Relationships -->
            <g class="rel-group" style="transition: opacity 0.5s ease-in-out; opacity: 0;">
              <!-- LÀM_CHO diamond -->
              <g id="slide16-rel-works-for" class="diagram-rel-group connection-group">
                <polygon points="315,258 360,280 315,302 270,280" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="2" filter="url(#shadow)"></polygon>
                <text x="315" y="284" font-family="var(--font-title)" font-weight="800" font-size="11" fill="var(--color-navy)" text-anchor="middle">LÀM_CHO</text>
                <line class="conn-line-bg" x1="220" y1="280" x2="270" y2="280" stroke="var(--color-navy)" stroke-width="2"></line>
                <line class="conn-line-flow" x1="220" y1="280" x2="270" y2="280"></line>
                <line class="conn-line-bg" x1="360" y1="280" x2="410" y2="280" stroke="var(--color-navy)" stroke-width="2"></line>
                <line class="conn-line-flow" x1="360" y1="280" x2="410" y2="280"></line>
              </g>

              <!-- QUẢN_LÝ diamond -->
              <g id="slide16-rel-manages" class="diagram-rel-group connection-group">
                <polygon points="315,118 360,140 315,162 270,140" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="2" filter="url(#shadow)"></polygon>
                <text x="315" y="144" font-family="var(--font-title)" font-weight="800" font-size="11" fill="var(--color-navy)" text-anchor="middle">QUẢN_LÝ</text>
                <path class="conn-line-bg" d="M 150,255 V 140 H 270" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 150,255 V 140 H 270" fill="none"></path>
                <path class="conn-line-bg" d="M 480,255 V 140 H 360" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 480,255 V 140 H 360" fill="none"></path>
              </g>

              <!-- GIÁM_SÁT self-loop -->
              <g id="slide16-rel-supervision" class="diagram-rel-group connection-group">
                <polygon points="100,368 140,390 100,412 60,390" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="2" filter="url(#shadow)"></polygon>
                <text x="100" y="394" font-family="var(--font-title)" font-weight="800" font-size="11" fill="var(--color-navy)" text-anchor="middle">GIÁM_SÁT</text>
                <path class="conn-line-bg" d="M 100,305 C 50,305 40,360 60,390" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 100,305 C 50,305 40,360 60,390" fill="none"></path>
                <path class="conn-line-bg" d="M 140,390 C 160,390 150,335 120,305" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 140,390 C 160,390 150,335 120,305" fill="none"></path>
              </g>

              <!-- KIỂM_SOÁT diamond -->
              <g id="slide16-rel-controls" class="diagram-rel-group connection-group">
                <polygon points="645,258 690,280 645,302 600,280" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="2" filter="url(#shadow)"></polygon>
                <text x="645" y="284" font-family="var(--font-title)" font-weight="800" font-size="11" fill="var(--color-navy)" text-anchor="middle">KIỂM_SOÁT</text>
                <line class="conn-line-bg" x1="550" y1="280" x2="600" y2="280" stroke="var(--color-navy)" stroke-width="2"></line>
                <line class="conn-line-flow" x1="550" y1="280" x2="600" y2="280"></line>
                <line class="conn-line-bg" x1="690" y1="280" x2="740" y2="280" stroke="var(--color-navy)" stroke-width="2"></line>
                <line class="conn-line-flow" x1="690" y1="280" x2="740" y2="280"></line>
              </g>

              <!-- LÀM_VIỆC N:M diamond -->
              <g id="slide16-rel-works-on" class="diagram-rel-group connection-group">
                <polygon points="480,68 525,90 480,112 435,90" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="2" filter="url(#shadow)"></polygon>
                <text x="480" y="94" font-family="var(--font-title)" font-weight="800" font-size="11" fill="var(--color-navy)" text-anchor="middle">LÀM_VIỆC</text>
                <path class="conn-line-bg" d="M 120,255 C 120,130 350,90 435,90" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 120,255 C 120,130 350,90 435,90" fill="none"></path>
                <path class="conn-line-bg" d="M 840,255 C 840,130 610,90 525,90" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 840,255 C 840,130 610,90 525,90" fill="none"></path>
              </g>

              <!-- CỦA_NV double diamond -->
              <g id="slide16-rel-dependents-of" class="diagram-rel-group connection-group">
                <polygon points="480,353 525,375 480,397 435,375" fill="none" stroke="var(--color-navy)" stroke-width="2" filter="url(#shadow)"></polygon>
                <polygon points="480,356 521,375 480,394 439,375" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="1"></polygon>
                <text x="480" y="379" font-family="var(--font-title)" font-weight="800" font-size="11" fill="var(--color-navy)" text-anchor="middle">CỦA_NV</text>
                <path class="conn-line-bg" d="M 180,305 V 375 H 435" fill="none" stroke="var(--color-navy)" stroke-width="2"></path>
                <path class="conn-line-flow" d="M 180,305 V 375 H 435" fill="none"></path>
                <path class="conn-line-bg" d="M 478,397 V 445 M 482,397 V 445" fill="none" stroke="var(--color-navy)" stroke-width="1.8"></path>
              </g>
            </g>

            <!-- Group 3: Cardinalities -->
            <g class="card-group" style="transition: opacity 0.5s ease-in-out; opacity: 0;">
              <!-- LÀM_CHO cardinalities -->
              <g id="slide16-card-works-for">
                <text x="232" y="272" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">N</text>
                <text x="398" y="272" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">1</text>
              </g>
              <!-- QUẢN_LÝ cardinalities -->
              <g id="slide16-card-manages">
                <text x="162" y="245" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">1</text>
                <text x="492" y="245" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">1</text>
              </g>
              <!-- GIÁM_SÁT cardinalities -->
              <g id="slide16-card-supervision">
                <text x="62" y="272" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">1</text>
                <text x="132" y="325" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">N</text>
              </g>
              <!-- KIỂM_SOÁT cardinalities -->
              <g id="slide16-card-controls">
                <text x="562" y="272" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">1</text>
                <text x="728" y="272" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">N</text>
              </g>
              <!-- LÀM_VIỆC cardinalities -->
              <g id="slide16-card-works-on">
                <text x="135" y="240" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">N</text>
                <text x="825" y="240" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">M</text>
              </g>
              <!-- CỦA_NV cardinalities -->
              <g id="slide16-card-dependents-of">
                <text x="195" y="325" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">1</text>
                <text x="492" y="432" font-family="var(--font-title)" font-weight="800" font-size="15" fill="var(--color-blue)">N</text>
              </g>
            </g>

            <!-- Always-visible notation legend -->
            <g class="legend-group" transform="translate(50, 430)">
              <rect x="0" y="0" width="230" height="115" fill="rgba(255, 255, 255, 0.9)" stroke="rgba(0, 34, 68, 0.12)" stroke-width="1.5" rx="6" style="backdrop-filter: blur(4px); filter: drop-shadow(0 4px 12px rgba(0,0,0,0.05));"></rect>
              <text x="15" y="20" font-family="var(--font-title)" font-weight="700" font-size="10.5" fill="var(--color-navy-light)">KÝ HIỆU ERD (CHEN NOTATION):</text>
              
              <rect x="15" y="32" width="25" height="12" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="1.5" rx="2"></rect>
              <text x="50" y="42" font-family="var(--font-body)" font-size="10" font-weight="600" fill="var(--color-gray)">Thực thể chính (Entity)</text>
              
              <rect x="15" y="52" width="25" height="12" fill="none" stroke="var(--color-navy)" stroke-width="1.5" rx="2"></rect>
              <rect x="17.5" y="54.5" width="20" height="7" fill="url(#weakEntityGrad)" stroke="var(--color-navy)" stroke-width="0.8" rx="1"></rect>
              <text x="50" y="62" font-family="var(--font-body)" font-size="10" font-weight="600" fill="var(--color-gray)">Thực thể yếu (Weak Entity)</text>
              
              <polygon points="27.5,77 37.5,83 27.5,89 17.5,83" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="1.2"></polygon>
              <text x="50" y="85" font-family="var(--font-body)" font-size="10" font-weight="600" fill="var(--color-gray)">Mối quan hệ (Relationship)</text>
              
              <polygon points="27.5,97 37.5,103 27.5,109 17.5,103" fill="none" stroke="var(--color-navy)" stroke-width="1.2"></polygon>
              <polygon points="27.5,99 34.5,103 27.5,107 20.5,103" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="0.6"></polygon>
              <text x="50" y="105" font-family="var(--font-body)" font-size="10" font-weight="600" fill="var(--color-gray)">Quan hệ xác định (Identifying)</text>
            </g>
          </svg>`;
        this.loadedDiagrams['company'] = true;
      }
    }

    // Slide 18 Lazy Loading: Scaled Ternary Relationship
    if (currentSlide === 18 && !this.loadedDiagrams['ternary']) {
      const placeholder = document.getElementById('ternary-lazy-placeholder');
      if (placeholder) {
        placeholder.outerHTML = `
          <svg width="100%" height="100%" viewBox="-10 0 500 340" style="color: var(--color-navy); max-width: 500px; overflow: visible;">
            <defs>
              <filter id="shadow-slide18" x="-10%" y="-10%" width="120%" height="120%">
                <feDropShadow dx="0" dy="4" stdDeviation="5" flood-color="rgba(0, 34, 68, 0.08)"/>
              </filter>
              <linearGradient id="entityGrad18" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#eff6ff" />
              </linearGradient>
              <linearGradient id="relGrad18" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f5f3ff" />
              </linearGradient>
            </defs>

            <!-- Hypothetical Binary Split Lines (Dashed Red, initially hidden) -->
            <line class="binary-split-line" x1="85" y1="175" x2="240" y2="260" style="opacity: 0; transition: opacity 0.4s ease;"></line>
            <line class="binary-split-line" x1="240" y1="260" x2="395" y2="175" style="opacity: 0; transition: opacity 0.4s ease;"></line>
            <line class="binary-split-line" x1="150" y1="150" x2="330" y2="150" style="opacity: 0; transition: opacity 0.4s ease;"></line>

            <!-- Ternary Diamond -->
            <g id="slide18-rel-supply" class="diagram-rel-node" style="cursor: pointer;">
              <polygon points="240,110 290,150 240,190 190,150" fill="url(#relGrad18)" stroke="var(--color-navy)" stroke-width="2.5" filter="url(#shadow-slide18)"></polygon>
              <text x="240" y="154" font-family="var(--font-title)" font-weight="800" font-size="12" fill="var(--color-navy)" text-anchor="middle">CUNG_CẤP</text>
            </g>
            
            <!-- Nodes -->
            <!-- NHÀ_CUNG_CẤP -->
            <g id="slide18-entity-supplier" class="diagram-entity-node" style="cursor: pointer;">
              <rect x="20" y="125" width="130" height="50" fill="url(#entityGrad18)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow-slide18)"></rect>
              <text x="85" y="155" font-family="var(--font-title)" font-weight="800" font-size="12" fill="var(--color-navy)" text-anchor="middle">NHÀ_CUNG_CẤP</text>
            </g>
            
            <!-- DỰ_ÁN -->
            <g id="slide18-entity-project" class="diagram-entity-node" style="cursor: pointer;">
              <rect x="330" y="125" width="130" height="50" fill="url(#entityGrad18)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow-slide18)"></rect>
              <text x="395" y="155" font-family="var(--font-title)" font-weight="800" font-size="12" fill="var(--color-navy)" text-anchor="middle">DỰ_ÁN</text>
            </g>
            
            <!-- LINH_KIỆN -->
            <g id="slide18-entity-part" class="diagram-entity-node" style="cursor: pointer;">
              <rect x="175" y="260" width="130" height="50" fill="url(#entityGrad18)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" filter="url(#shadow-slide18)"></rect>
              <text x="240" y="290" font-family="var(--font-title)" font-weight="800" font-size="12" fill="var(--color-navy)" text-anchor="middle">LINH_KIỆN</text>
            </g>
            
            <!-- Connections -->
            <g id="slide18-conn-supplier" class="connection-group">
              <line class="conn-line-bg" x1="150" y1="150" x2="190" y2="150" stroke="var(--color-navy)" stroke-width="2.5"></line>
              <line class="conn-line-flow" x1="150" y1="150" x2="190" y2="150"></line>
            </g>
            <text x="168" y="140" font-family="var(--font-title)" font-weight="800" font-size="13" fill="var(--color-blue)">N</text>
            
            <g id="slide18-conn-project" class="connection-group">
              <line class="conn-line-bg" x1="290" y1="150" x2="330" y2="150" stroke="var(--color-navy)" stroke-width="2.5"></line>
              <line class="conn-line-flow" x1="290" y1="150" x2="330" y2="150"></line>
            </g>
            <text x="308" y="140" font-family="var(--font-title)" font-weight="800" font-size="13" fill="var(--color-blue)">M</text>
            
            <g id="slide18-conn-part" class="connection-group">
              <line class="conn-line-bg" x1="240" y1="190" x2="240" y2="260" stroke="var(--color-navy)" stroke-width="2.5"></line>
              <line class="conn-line-flow" x1="240" y1="190" x2="240" y2="260"></line>
            </g>
            <text x="250" y="225" font-family="var(--font-title)" font-weight="800" font-size="13" fill="var(--color-blue)">P</text>
            
            <!-- Quantity Attribute -->
            <g id="slide18-attr-qty" class="diagram-attr-node" style="cursor: pointer;">
              <ellipse cx="340" cy="50" rx="46" ry="20" fill="#ffffff" stroke="var(--color-navy)" stroke-width="1.8" filter="url(#shadow-slide18)"></ellipse>
              <text x="340" y="54" font-family="var(--font-title)" font-weight="600" font-size="11" fill="var(--color-navy)" text-anchor="middle">SốLượng</text>
            </g>
            
            <g id="slide18-conn-qty" class="connection-group">
              <line class="conn-line-bg" x1="315" y1="69" x2="265" y2="130" stroke="var(--color-navy)" stroke-width="1.5" stroke-dasharray="3 3"></line>
              <line class="conn-line-flow" x1="315" y1="69" x2="265" y2="130" stroke-dasharray="3 3"></line>
            </g>
 
            <!-- Red Cross Warning Overlay -->
            <g id="slide18-invalid-marker" style="opacity: 0; transition: opacity 0.4s ease; pointer-events: none;">
              <circle cx="240" cy="150" r="28" fill="rgba(239, 68, 68, 0.15)" stroke="var(--color-red)" stroke-width="2" style="animation: pulseRed 1s infinite alternate;"></circle>
              <text x="240" y="159" font-family="var(--font-title)" font-size="24" fill="var(--color-red)" font-weight="900" text-anchor="middle">❌</text>
            </g>
          </svg>
        `;
        this.loadedDiagrams['ternary'] = true;
        this.bindSlide18Events();
      }
    }
  },

  // 2. Step-by-Step Reveal sync for Slide 16
  syncSlide16Step() {
    if (window.StateManager.currentSlide !== 16) return;

    const step = window.StateManager.currentStep;
    const slide16 = document.getElementById('slide-16');
    if (!slide16) return;

    // Toggle reveal step classes
    slide16.classList.remove('reveal-step-0', 'reveal-step-1', 'reveal-step-2');
    slide16.classList.add(`reveal-step-${step}`);

    const svgEntities = slide16.querySelector('.entity-group');
    const svgRels = slide16.querySelector('.rel-group');
    const svgCards = slide16.querySelector('.card-group');

    if (svgEntities) svgEntities.style.opacity = step >= 0 ? '1' : '0';
    if (svgRels) svgRels.style.opacity = step >= 1 ? '1' : '0';
    if (svgCards) svgCards.style.opacity = step >= 2 ? '1' : '0';

    // Update dynamic helper text for steps
    const helperText = document.getElementById('reveal-helper-text');
    if (helperText) {
      if (step === 0) {
        helperText.innerHTML = "🧱 <strong>Bước 1:</strong> Xác định các Thực thể chính và Thực thể yếu. Bấm <strong>Next/Mũi tên phải</strong> để tiếp tục.";
      } else if (step === 1) {
        helperText.innerHTML = "🔗 <strong>Bước 2:</strong> Thiết lập các Mối quan hệ và Đường liên kết. Bấm <strong>Next/Mũi tên phải</strong> để tiếp tục.";
      } else if (step === 2) {
        helperText.innerHTML = "🔢 <strong>Bước 3:</strong> Gán các Bản số và Lực lượng Cardinality (1:N, N:N). Hoàn thành!";
      }
    }
  },

  // 3. Occupancy Derived calculator for KTX Dom D (Slide 6)
  setupDormCalculator() {
    const inputCheckin = document.getElementById('input-checkin-date');
    const txtDays = document.getElementById('txt-derived-days');

    if (inputCheckin && txtDays) {
      const calcDays = () => {
        const checkinDate = new Date(inputCheckin.value);
        if (isNaN(checkinDate)) return;

        const today = new Date();
        const diffTime = Math.abs(today - checkinDate);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

        txtDays.style.transform = 'scale(0.8)';
        txtDays.style.opacity = '0';

        // Trigger SVG connection path pulse for calculation
        const connSongay = document.getElementById('slide6-conn-songay');
        const attrSongay = document.getElementById('slide6-attr-songay');
        if (connSongay) {
          connSongay.classList.add('active', 'energy-pulse');
          if (attrSongay) attrSongay.classList.add('active');
          setTimeout(() => {
            connSongay.classList.remove('energy-pulse');
            // Remove active state unless cursor is hovering
            if (connSongay && !connSongay.dataset.hovered) {
              connSongay.classList.remove('active');
            }
            if (attrSongay && !attrSongay.dataset.hovered) {
              attrSongay.classList.remove('active');
            }
          }, 1000);
        }

        setTimeout(() => {
          txtDays.textContent = `${diffDays} ngày`;
          txtDays.style.transform = 'scale(1)';
          txtDays.style.opacity = '1';
        }, 150);
      };

      inputCheckin.addEventListener('input', calcDays);
      // Run once on load
      calcDays();
    }
  },

  // 4. Edunext LMS Cardinality tabs switcher (Slide 12)
  setupSlide12EdunextControls() {
    const btnRatio = document.getElementById('btn-card-ratio');
    const btnMinmax = document.getElementById('btn-card-minmax');
    
    const cardTitle = document.getElementById('card-viz-title');
    const arrowLabel = document.getElementById('card-arrow-label');
    const labelLeft = document.getElementById('card-label-left');
    const labelRight = document.getElementById('card-label-right');
    const cardDescText = document.getElementById('card-desc-text');

    if (btnRatio && btnMinmax) {
      btnRatio.addEventListener('click', () => {
        btnRatio.classList.add('active');
        btnMinmax.classList.remove('active');

        cardTitle.textContent = 'Biểu diễn: Tỷ lệ bản số Edunext';
        arrowLabel.textContent = 'N:N';
        labelLeft.textContent = 'Tham gia: Sinh viên';
        labelRight.textContent = 'Tham gia: Bài tập nhóm';
        cardDescText.innerHTML = '👉 Lực lượng: <strong>N:N</strong> (Một Sinh viên làm nhiều Bài tập nhóm, một Bài tập nhóm được làm bởi nhiều Sinh viên).';
      });

      btnMinmax.addEventListener('click', () => {
        btnMinmax.classList.add('active');
        btnRatio.classList.remove('active');

        cardTitle.textContent = 'Biểu diễn: Ký hiệu khoảng (min, max)';
        arrowLabel.textContent = '(0, N)   ⬅️   (1, N)';
        labelLeft.textContent = 'Khoảng tham gia: (0, N)';
        labelRight.textContent = 'Khoảng tham gia: (1, N)';
        cardDescText.innerHTML = '👉 Ký hiệu: <strong>(min, max)</strong>. Sinh viên <code>(0, N)</code> nghĩa là có thể làm 0 hoặc nhiều bài tập. Bài tập nhóm <code>(1, N)</code> nghĩa là bắt buộc có ít nhất 1 sinh viên tham gia, tối đa N sinh viên.';
      });
    }
  },

  // 5. 3D card flip & bidirectional hover sync for Slide 17 (ER vs UML comparison)
  setupSlide17Interactivity() {
    const btnFlip = document.getElementById('btn-highlight-uml');
    
    // Toggle 3D flip cards on button click
    if (btnFlip) {
      btnFlip.addEventListener('click', () => {
        const cards = document.querySelectorAll('#slide-17 .flip-card');
        const isFlipped = cards[0]?.classList.contains('flipped');
        
        cards.forEach(card => {
          if (isFlipped) {
            card.classList.remove('flipped');
          } else {
            card.classList.add('flipped');
          }
        });

        // Highlight table rows as well
        const rows = document.querySelectorAll('#uml-compare-table tr.table-row-highlightable');
        rows.forEach(row => {
          if (isFlipped) {
            row.classList.remove('highlighted');
          } else {
            row.classList.add('highlighted');
          }
        });

        if (isFlipped) {
          btnFlip.textContent = 'Kích hoạt so sánh Thuật ngữ (3D Flip)';
          btnFlip.style.borderColor = '';
          btnFlip.style.color = '';
        } else {
          btnFlip.textContent = 'Hủy so sánh Thuật ngữ';
          btnFlip.style.borderColor = 'var(--color-blue)';
          btnFlip.style.color = 'var(--color-blue)';
        }
      });
    }

    // SVG Nodes
    const erdEmp = document.getElementById('slide17-node-erd-emp');
    const erdDept = document.getElementById('slide17-node-erd-dept');
    const erdRel = document.getElementById('slide17-node-erd-rel');
    const erdWeak = document.getElementById('slide17-node-erd-weak');
    const erdWeakOwner = document.getElementById('slide17-node-erd-weak-owner');
    const erdWeakRel = document.getElementById('slide17-node-erd-weak-rel');
    
    const umlEmp = document.getElementById('slide17-node-uml-emp');
    const umlDept = document.getElementById('slide17-node-uml-dept');
    const umlWeakOwner = document.getElementById('slide17-node-uml-weak-owner');
    const umlWeak = document.getElementById('slide17-node-uml-weak');
    const umlWeakQualifier = document.getElementById('slide17-node-uml-weak-qualifier');

    const allNodes = [
      erdEmp, erdDept, erdRel, erdWeak, erdWeakOwner, erdWeakRel,
      umlEmp, umlDept, umlWeakOwner, umlWeak, umlWeakQualifier
    ];

    // Connections
    const connErd1 = document.getElementById('slide17-conn-erd-1');
    const connErd2 = document.getElementById('slide17-conn-erd-2');
    const connUml = document.getElementById('slide17-conn-uml');
    const connErdWeakLeft = document.getElementById('slide17-conn-erd-weak-left');
    const connErdWeakRight = document.getElementById('slide17-conn-erd-weak-right');
    const connUmlWeak = document.getElementById('slide17-conn-uml-weak');

    const allConns = [
      connErd1, connErd2, connUml,
      connErdWeakLeft, connErdWeakRight, connUmlWeak
    ];

    // Card texts
    const textErdCardN = document.getElementById('slide17-text-erd-card-N');
    const textErdCard1 = document.getElementById('slide17-text-erd-card-1');
    const textUmlMultStar = document.getElementById('slide17-text-uml-mult-star');
    const textUmlMult1 = document.getElementById('slide17-text-uml-mult-1');
    const textErdCardWeak1 = document.getElementById('slide17-text-erd-card-weak-1');
    const textErdCardWeakN = document.getElementById('slide17-text-erd-card-weak-N');
    const textUmlMultWeak = document.getElementById('slide17-text-uml-mult-weak');

    const allTexts = [
      textErdCardN, textErdCard1, textUmlMultStar, textUmlMult1,
      textErdCardWeak1, textErdCardWeakN, textUmlMultWeak
    ];

    // Table rows
    const rowEntity = document.getElementById('slide17-row-entity');
    const rowRel = document.getElementById('slide17-row-rel');
    const rowCard = document.getElementById('slide17-row-card');
    const rowWeak = document.getElementById('slide17-row-weak');
    const allRows = [rowEntity, rowRel, rowCard, rowWeak];

    const clearAll = () => {
      allNodes.forEach(n => { if (n) n.classList.remove('active', 'dimmed'); });
      allConns.forEach(c => { if (c) c.classList.remove('active', 'dimmed'); });
      allTexts.forEach(t => { if (t) t.classList.remove('active', 'dimmed'); });
      allRows.forEach(r => { if (r) r.classList.remove('highlighted'); });
    };

    const highlightConcept = (activeNodes, activeConns, activeTexts, activeRow) => {
      allNodes.forEach(n => {
        if (n) {
          if (activeNodes.includes(n)) n.classList.add('active');
          else n.classList.add('dimmed');
        }
      });
      allConns.forEach(c => {
        if (c) {
          if (activeConns.includes(c)) c.classList.add('active');
          else c.classList.add('dimmed');
        }
      });
      allTexts.forEach(t => {
        if (t) {
          if (activeTexts.includes(t)) t.classList.add('active');
          else t.classList.add('dimmed');
        }
      });
      if (activeRow) activeRow.classList.add('highlighted');
    };

    // Row 1 hover (Concept: Entity vs Class)
    if (rowEntity) {
      rowEntity.addEventListener('mouseenter', () => {
        highlightConcept(
          [erdEmp, erdDept, umlEmp, umlDept, erdWeakOwner, erdWeak, umlWeakOwner, umlWeak],
          [],
          [],
          rowEntity
        );
      });
      rowEntity.addEventListener('mouseleave', clearAll);
    }

    // Row 2 hover (Concept: Relationship vs Association)
    if (rowRel) {
      rowRel.addEventListener('mouseenter', () => {
        highlightConcept(
          [erdRel, erdWeakRel, umlWeakQualifier],
          [connErd1, connErd2, connUml, connErdWeakLeft, connErdWeakRight, connUmlWeak],
          [],
          rowRel
        );
      });
      rowRel.addEventListener('mouseleave', clearAll);
    }

    // Row 3 hover (Concept: Cardinality vs Multiplicity)
    if (rowCard) {
      rowCard.addEventListener('mouseenter', () => {
        highlightConcept(
          [],
          [],
          [textErdCardN, textErdCard1, textUmlMultStar, textUmlMult1, textErdCardWeak1, textErdCardWeakN, textUmlMultWeak],
          rowCard
        );
      });
      rowCard.addEventListener('mouseleave', clearAll);
    }

    // Row 4 hover (Concept: Weak Entity vs Qualified Association)
    if (rowWeak) {
      rowWeak.addEventListener('mouseenter', () => {
        highlightConcept(
          [erdWeak, erdWeakRel, erdWeakOwner, umlWeakOwner, umlWeak, umlWeakQualifier],
          [connErdWeakLeft, connErdWeakRight, connUmlWeak],
          [textErdCardWeak1, textErdCardWeakN, textUmlMultWeak],
          rowWeak
        );
      });
      rowWeak.addEventListener('mouseleave', clearAll);
    }

    // Bind reverse hover from SVG nodes to highlight table rows
    const bindNodeHover = (nodes, activeRow, activeNodes, activeConns, activeTexts) => {
      nodes.forEach(node => {
        if (node) {
          node.addEventListener('mouseenter', () => {
            highlightConcept(activeNodes, activeConns, activeTexts, activeRow);
          });
          node.addEventListener('mouseleave', clearAll);
        }
      });
    };

    // Entity nodes reverse hover (Row 1)
    bindNodeHover(
      [erdEmp, erdDept, umlEmp, umlDept],
      rowEntity,
      [erdEmp, erdDept, umlEmp, umlDept, erdWeakOwner, erdWeak, umlWeakOwner, umlWeak],
      [],
      []
    );

    // Relationship nodes reverse hover (Row 2)
    bindNodeHover(
      [erdRel],
      rowRel,
      [erdRel, erdWeakRel, umlWeakQualifier],
      [connErd1, connErd2, connUml, connErdWeakLeft, connErdWeakRight, connUmlWeak],
      []
    );

    // Text nodes reverse hover (Row 3)
    allTexts.forEach(txt => {
      if (txt) {
        txt.addEventListener('mouseenter', () => {
          highlightConcept(
            [],
            [],
            [textErdCardN, textErdCard1, textUmlMultStar, textUmlMult1, textErdCardWeak1, textErdCardWeakN, textUmlMultWeak],
            rowCard
          );
        });
        txt.addEventListener('mouseleave', clearAll);
      }
    });

    // Weak / Qualified Association nodes reverse hover (Row 4)
    bindNodeHover(
      [erdWeak, erdWeakRel, erdWeakOwner, umlWeakOwner, umlWeak, umlWeakQualifier],
      rowWeak,
      [erdWeak, erdWeakRel, erdWeakOwner, umlWeakOwner, umlWeak, umlWeakQualifier],
      [connErdWeakLeft, connErdWeakRight, connUmlWeak],
      [textErdCardWeak1, textErdCardWeakN, textUmlMultWeak]
    );
  },

  // 6. Interactive Network Highlighting for COMPANY ERD (Slide 3)
  setupSlide3CompanyInteractivity() {
    const cardDept = document.getElementById('card-dept');
    const cardEmp = document.getElementById('card-emp');
    const cardProj = document.getElementById('card-proj');
    const cardDep = document.getElementById('card-dep');
    const allCards = [cardDept, cardEmp, cardProj, cardDep];

    const connDeptEmp = document.getElementById('conn-dept-emp');
    const connEmpProj = document.getElementById('conn-emp-proj');
    const connEmpDep = document.getElementById('conn-emp-dep');
    const connDeptProj = document.getElementById('conn-dept-proj');
    const allConns = [connDeptEmp, connEmpProj, connEmpDep, connDeptProj];

    const badgeWork = document.getElementById('badge-work');
    const badgeWorkOn = document.getElementById('badge-work-on');
    const badgeDepend = document.getElementById('badge-depend');
    const badgeControl = document.getElementById('badge-control');
    const allBadges = [badgeWork, badgeWorkOn, badgeDepend, badgeControl];

    const clearAll = () => {
      allCards.forEach(c => {
        if (c) {
          c.classList.remove('highlight-glow');
          c.classList.remove('dimmed');
        }
      });
      allConns.forEach(conn => {
        if (conn) conn.classList.remove('active');
      });
      allBadges.forEach(b => {
        if (b) b.classList.remove('active-badge');
      });
    };

    const highlightRelation = (activeCard, relatedCards, activeConns, activeBadges) => {
      allCards.forEach(c => {
        if (c) {
          if (c === activeCard) {
            c.classList.add('highlight-glow');
          } else if (relatedCards.includes(c)) {
            c.classList.add('highlight-glow');
          } else {
            c.classList.add('dimmed');
          }
        }
      });
      activeConns.forEach(conn => {
        if (conn) conn.classList.add('active');
      });
      activeBadges.forEach(b => {
        if (b) b.classList.add('active-badge');
      });
    };

    if (cardDept) {
      cardDept.addEventListener('mouseenter', () => {
        highlightRelation(cardDept, [cardEmp, cardProj], [connDeptEmp, connDeptProj], [badgeWork, badgeControl]);
      });
      cardDept.addEventListener('mouseleave', clearAll);
    }

    if (cardEmp) {
      cardEmp.addEventListener('mouseenter', () => {
        highlightRelation(cardEmp, [cardDept, cardProj, cardDep], [connDeptEmp, connEmpProj, connEmpDep], [badgeWork, badgeWorkOn, badgeDepend]);
      });
      cardEmp.addEventListener('mouseleave', clearAll);
    }

    if (cardProj) {
      cardProj.addEventListener('mouseenter', () => {
        highlightRelation(cardProj, [cardDept, cardEmp], [connEmpProj, connDeptProj], [badgeWorkOn, badgeControl]);
      });
      cardProj.addEventListener('mouseleave', clearAll);
    }

    if (cardDep) {
      cardDep.addEventListener('mouseenter', () => {
        highlightRelation(cardDep, [cardEmp], [connEmpDep], [badgeDepend]);
      });
      cardDep.addEventListener('mouseleave', clearAll);
    }
  },

  // 7. Interactive Network Highlighting for Entity & Attributes (Slide 4)
  setupSlide4Interactivity() {
    const entityNode = document.getElementById('slide4-entity');
    const attrManv = document.getElementById('slide4-attr-manv');
    const attrHoten = document.getElementById('slide4-attr-hoten');
    const attrLuong = document.getElementById('slide4-attr-luong');
    const allNodes = [entityNode, attrManv, attrHoten, attrLuong];

    const connManv = document.getElementById('slide4-conn-manv');
    const connHoten = document.getElementById('slide4-conn-hoten');
    const connLuong = document.getElementById('slide4-conn-luong');
    const allConns = [connManv, connHoten, connLuong];

    const clearAll = () => {
      allNodes.forEach(n => {
        if (n) {
          n.classList.remove('active');
          n.classList.remove('dimmed');
        }
      });
      allConns.forEach(c => {
        if (c) c.classList.remove('active');
      });
    };

    const highlightRelation = (activeNode, activeConns) => {
      allNodes.forEach(n => {
        if (n) {
          if (n === activeNode || (activeNode === entityNode && n !== entityNode)) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      activeConns.forEach(c => {
        if (c) c.classList.add('active');
      });
    };

    if (entityNode) {
      entityNode.addEventListener('mouseenter', () => {
        highlightRelation(entityNode, allConns);
      });
      entityNode.addEventListener('mouseleave', clearAll);
    }

    if (attrManv) {
      attrManv.addEventListener('mouseenter', () => {
        highlightRelation(attrManv, [connManv]);
      });
      attrManv.addEventListener('mouseleave', clearAll);
    }

    if (attrHoten) {
      attrHoten.addEventListener('mouseenter', () => {
        highlightRelation(attrHoten, [connHoten]);
      });
      attrHoten.addEventListener('mouseleave', clearAll);
    }

    if (attrLuong) {
      attrLuong.addEventListener('mouseenter', () => {
        highlightRelation(attrLuong, [connLuong]);
      });
      attrLuong.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.5. Interactive tree node highlights for Composite Attributes (Slide 5)
  setupSlide5Interactivity() {
    const rootNode = document.getElementById('slide5-root');
    const leafDom = document.getElementById('slide5-leaf-dom');
    const leafTang = document.getElementById('slide5-leaf-tang');
    const leafPhong = document.getElementById('slide5-leaf-phong');
    const leafGiuong = document.getElementById('slide5-leaf-giuong');
    const allNodes = [rootNode, leafDom, leafTang, leafPhong, leafGiuong];

    const connDom = document.getElementById('slide5-conn-dom');
    const connTang = document.getElementById('slide5-conn-tang');
    const connPhong = document.getElementById('slide5-conn-phong');
    const connGiuong = document.getElementById('slide5-conn-giuong');
    const allConns = [connDom, connTang, connPhong, connGiuong];

    const bulletSimple = document.getElementById('slide5-bullet-simple');
    const bulletComposite = document.getElementById('slide5-bullet-composite');

    const clearAll = () => {
      allNodes.forEach(n => {
        if (n) {
          n.classList.remove('active');
          n.classList.remove('dimmed');
        }
      });
      allConns.forEach(c => {
        if (c) c.classList.remove('active');
      });
      if (bulletSimple) bulletSimple.classList.remove('highlighted-bullet');
      if (bulletComposite) bulletComposite.classList.remove('highlighted-bullet');
    };

    const highlightRelation = (activeNode, activeConns, activeBullet) => {
      allNodes.forEach(n => {
        if (n) {
          if (n === activeNode || (activeNode === rootNode && n !== rootNode) || (activeNode === 'all-leaves' && n !== rootNode)) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      activeConns.forEach(c => {
        if (c) c.classList.add('active');
      });
      if (activeBullet) activeBullet.classList.add('highlighted-bullet');
    };

    // 1. Mouse events on SVG Nodes
    if (rootNode) {
      rootNode.addEventListener('mouseenter', () => {
        highlightRelation(rootNode, allConns, bulletComposite);
      });
      rootNode.addEventListener('mouseleave', clearAll);
    }

    const leaves = [
      { node: leafDom, conn: connDom },
      { node: leafTang, conn: connTang },
      { node: leafPhong, conn: connPhong },
      { node: leafGiuong, conn: connGiuong }
    ];

    leaves.forEach(leaf => {
      if (leaf.node) {
        leaf.node.addEventListener('mouseenter', () => {
          highlightRelation(leaf.node, [leaf.conn], bulletSimple);
        });
        leaf.node.addEventListener('mouseleave', clearAll);
      }
    });

    // 2. Mouse events on Bullet Points
    if (bulletSimple) {
      bulletSimple.addEventListener('mouseenter', () => {
        highlightRelation('all-leaves', allConns, bulletSimple);
      });
      bulletSimple.addEventListener('mouseleave', clearAll);
    }

    if (bulletComposite) {
      bulletComposite.addEventListener('mouseenter', () => {
        highlightRelation(rootNode, allConns, bulletComposite);
      });
      bulletComposite.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.8. Interactive keys and table column highlights (Slide 8)
  setupSlide8Interactivity() {
    const entityNode = document.getElementById('slide8-entity');
    const attrCccd = document.getElementById('slide8-attr-cccd');
    const attrHoten = document.getElementById('slide8-attr-hoten');
    const attrLuong = document.getElementById('slide8-attr-luong');
    const allNodes = [entityNode, attrCccd, attrHoten, attrLuong];

    const connCccd = document.getElementById('slide8-conn-cccd');
    const connHoten = document.getElementById('slide8-conn-hoten');
    const connLuong = document.getElementById('slide8-conn-luong');
    const allConns = [connCccd, connHoten, connLuong];

    const table = document.getElementById('slide8-table');

    const clearAll = () => {
      allNodes.forEach(n => {
        if (n) {
          n.classList.remove('active');
          n.classList.remove('dimmed');
        }
      });
      allConns.forEach(c => {
        if (c) c.classList.remove('active');
      });
      if (table) {
        table.classList.remove('highlight-table');
        const highlightedCells = table.querySelectorAll('.highlighted');
        highlightedCells.forEach(cell => cell.classList.remove('highlighted'));
      }
    };

    const highlightRelation = (activeNode, activeConns, colClass) => {
      allNodes.forEach(n => {
        if (n) {
          if (n === activeNode) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      activeConns.forEach(c => {
        if (c) c.classList.add('active');
      });
      if (table && colClass) {
        const cells = table.querySelectorAll(`.${colClass}`);
        cells.forEach(cell => cell.classList.add('highlighted'));
      }
    };

    if (entityNode) {
      entityNode.addEventListener('mouseenter', () => {
        allNodes.forEach(n => {
          if (n && n !== entityNode) n.classList.add('dimmed');
        });
        entityNode.classList.add('active');
        if (table) table.classList.add('highlight-table');
      });
      entityNode.addEventListener('mouseleave', clearAll);
    }

    if (attrCccd) {
      attrCccd.addEventListener('mouseenter', () => {
        highlightRelation(attrCccd, [connCccd], 'col-cccd');
      });
      attrCccd.addEventListener('mouseleave', clearAll);
    }

    if (attrHoten) {
      attrHoten.addEventListener('mouseenter', () => {
        highlightRelation(attrHoten, [connHoten], 'col-hoten');
      });
      attrHoten.addEventListener('mouseleave', clearAll);
    }

    if (attrLuong) {
      attrLuong.addEventListener('mouseenter', () => {
        highlightRelation(attrLuong, [connLuong], 'col-luong');
      });
      attrLuong.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.7. Interactive sync between SVG Tree and JSON Block (Slide 7)
  setupSlide7Interactivity() {
    const rootNode = document.getElementById('slide7-root');
    const nodePhone = document.getElementById('slide7-node-phone');
    const nodeDiachi = document.getElementById('slide7-node-diachi');
    const allNodes = [rootNode, nodePhone, nodeDiachi];

    const connPhone = document.getElementById('slide7-conn-phone');
    const connDiachi = document.getElementById('slide7-conn-diachi');
    const allConns = [connPhone, connDiachi];

    const jsonBlock = document.getElementById('slide7-json-block');
    const jsonLienhe = document.getElementById('slide7-json-lienhe');
    const jsonLienheClose = document.getElementById('slide7-json-lienhe-close');
    const jsonPhone = document.getElementById('slide7-json-phone');
    const jsonDiachi = document.getElementById('slide7-json-diachi');

    const clearAll = () => {
      allNodes.forEach(n => {
        if (n) {
          n.classList.remove('active');
          n.classList.remove('dimmed');
        }
      });
      allConns.forEach(c => {
        if (c) c.classList.remove('active');
      });
      if (jsonBlock) jsonBlock.classList.remove('highlight-block');
      [jsonLienhe, jsonLienheClose, jsonPhone, jsonDiachi].forEach(el => {
        if (el) el.classList.remove('highlighted');
      });
    };

    const highlightRelation = (activeNode, activeConns, activeJsonElements, activeBlockGlow = false) => {
      allNodes.forEach(n => {
        if (n) {
          if (n === activeNode) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      activeConns.forEach(c => {
        if (c) c.classList.add('active');
      });
      if (jsonBlock && activeBlockGlow) {
        jsonBlock.classList.add('highlight-block');
      }
      activeJsonElements.forEach(el => {
        if (el) el.classList.add('highlighted');
      });
    };

    // 1. Mouse events on SVG Nodes
    if (rootNode) {
      rootNode.addEventListener('mouseenter', () => {
        highlightRelation(rootNode, allConns, [jsonLienhe, jsonLienheClose], true);
      });
      rootNode.addEventListener('mouseleave', clearAll);
    }

    if (nodePhone) {
      nodePhone.addEventListener('mouseenter', () => {
        highlightRelation(nodePhone, [connPhone], [jsonPhone]);
      });
      nodePhone.addEventListener('mouseleave', clearAll);
    }

    if (nodeDiachi) {
      nodeDiachi.addEventListener('mouseenter', () => {
        highlightRelation(nodeDiachi, [connDiachi], [jsonDiachi]);
      });
      nodeDiachi.addEventListener('mouseleave', clearAll);
    }

    // 2. Mouse events on JSON Code Spans
    if (jsonLienhe) {
      jsonLienhe.addEventListener('mouseenter', () => {
        highlightRelation(rootNode, allConns, [jsonLienhe, jsonLienheClose], true);
      });
      jsonLienhe.addEventListener('mouseleave', clearAll);
    }
    if (jsonLienheClose) {
      jsonLienheClose.addEventListener('mouseenter', () => {
        highlightRelation(rootNode, allConns, [jsonLienhe, jsonLienheClose], true);
      });
      jsonLienheClose.addEventListener('mouseleave', clearAll);
    }

    if (jsonPhone) {
      jsonPhone.addEventListener('mouseenter', () => {
        highlightRelation(nodePhone, [connPhone], [jsonPhone]);
      });
      jsonPhone.addEventListener('mouseleave', clearAll);
    }

    if (jsonDiachi) {
      jsonDiachi.addEventListener('mouseenter', () => {
        highlightRelation(nodeDiachi, [connDiachi], [jsonDiachi]);
      });
      jsonDiachi.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.6. Interactive sync between SVG, Bullet Points, and Calculator (Slide 6)
  setupSlide6Interactivity() {
    const entityNode = document.getElementById('slide6-entity');
    const attrTiennghi = document.getElementById('slide6-attr-tiennghi');
    const attrSongay = document.getElementById('slide6-attr-songay');
    const allNodes = [entityNode, attrTiennghi, attrSongay];

    const connTiennghi = document.getElementById('slide6-conn-tiennghi');
    const connSongay = document.getElementById('slide6-conn-songay');
    const allConns = [connTiennghi, connSongay];

    const bulletMultivalued = document.getElementById('slide6-bullet-multivalued');
    const bulletDerived = document.getElementById('slide6-bullet-derived');
    const calculatorBox = document.getElementById('slide6-calculator-box');

    const clearAll = () => {
      allNodes.forEach(n => {
        if (n) {
          n.classList.remove('active');
          n.classList.remove('dimmed');
          delete n.dataset.hovered;
        }
      });
      allConns.forEach(c => {
        if (c) {
          c.classList.remove('active');
          delete c.dataset.hovered;
        }
      });
      if (bulletMultivalued) bulletMultivalued.classList.remove('highlighted-bullet');
      if (bulletDerived) bulletDerived.classList.remove('highlighted-bullet');
      if (calculatorBox) calculatorBox.classList.remove('highlight-table');
    };

    const highlightRelation = (activeNode, activeConns, activeBullet, activeCalc = false) => {
      allNodes.forEach(n => {
        if (n) {
          if (n === activeNode) {
            n.classList.add('active');
            n.dataset.hovered = 'true';
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      activeConns.forEach(c => {
        if (c) {
          c.classList.add('active');
          c.dataset.hovered = 'true';
        }
      });
      if (activeBullet) activeBullet.classList.add('highlighted-bullet');
      if (activeCalc && calculatorBox) calculatorBox.classList.add('highlight-table');
    };

    // 1. Mouse events on SVG Nodes
    if (entityNode) {
      entityNode.addEventListener('mouseenter', () => {
        allNodes.forEach(n => {
          if (n && n !== entityNode) n.classList.add('dimmed');
        });
        entityNode.classList.add('active');
      });
      entityNode.addEventListener('mouseleave', clearAll);
    }

    if (attrTiennghi) {
      attrTiennghi.addEventListener('mouseenter', () => {
        highlightRelation(attrTiennghi, [connTiennghi], bulletMultivalued);
      });
      attrTiennghi.addEventListener('mouseleave', clearAll);
    }

    if (attrSongay) {
      attrSongay.addEventListener('mouseenter', () => {
        highlightRelation(attrSongay, [connSongay], bulletDerived, true);
      });
      attrSongay.addEventListener('mouseleave', clearAll);
    }

    // 2. Mouse events on Bullet Points
    if (bulletMultivalued) {
      bulletMultivalued.addEventListener('mouseenter', () => {
        highlightRelation(attrTiennghi, [connTiennghi], bulletMultivalued);
      });
      bulletMultivalued.addEventListener('mouseleave', clearAll);
    }

    if (bulletDerived) {
      bulletDerived.addEventListener('mouseenter', () => {
        highlightRelation(attrSongay, [connSongay], bulletDerived, true);
      });
      bulletDerived.addEventListener('mouseleave', clearAll);
    }

    // 3. Mouse events on Calculator Box
    if (calculatorBox) {
      calculatorBox.addEventListener('mouseenter', () => {
        highlightRelation(attrSongay, [connSongay], bulletDerived, true);
      });
      calculatorBox.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.9. Interactive sync for Slide 9 (Lược đồ Thuộc tính Ban đầu)
  setupSlide9Interactivity() {
    const empNode = document.getElementById('slide9-entity-emp');
    const deptNode = document.getElementById('slide9-entity-dept');
    const projNode = document.getElementById('slide9-entity-proj');
    const depNode = document.getElementById('slide9-entity-dep');
    const allNodes = [empNode, deptNode, projNode, depNode];

    const refEmpDept = document.getElementById('slide9-ref-emp-dept');
    const refEmpSuper = document.getElementById('slide9-ref-emp-super');
    const refDeptMgr = document.getElementById('slide9-ref-dept-mgr');
    const refProjDept = document.getElementById('slide9-ref-proj-dept');
    const refDepEmp = document.getElementById('slide9-ref-dep-emp');
    const allRefs = [refEmpDept, refEmpSuper, refDeptMgr, refProjDept, refDepEmp];

    const bulletQuanly = document.getElementById('slide9-bullet-quanly');
    const bulletGiamsat = document.getElementById('slide9-bullet-giamsat');
    const bulletThuocphong = document.getElementById('slide9-bullet-thuocphong');
    const bulletCuanv = document.getElementById('slide9-bullet-cuanv');

    const clearAll = () => {
      allNodes.forEach(n => {
        if (n) {
          n.classList.remove('active');
          n.classList.remove('dimmed');
        }
      });
      allRefs.forEach(r => {
        if (r) r.classList.remove('active', 'dimmed');
      });
      [bulletQuanly, bulletGiamsat, bulletThuocphong, bulletCuanv].forEach(b => {
        if (b) b.classList.remove('highlighted-bullet');
      });
    };

    const highlightRelation = (activeNodes, activeRefs, activeBullet) => {
      allNodes.forEach(n => {
        if (n) {
          if (activeNodes.includes(n)) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      allRefs.forEach(r => {
        if (r) {
          if (activeRefs.includes(r)) {
            r.classList.add('active');
          } else {
            r.classList.add('dimmed');
          }
        }
      });
      if (activeBullet) activeBullet.classList.add('highlighted-bullet');
    };

    // 1. Mouse events on SVG Nodes (Entities)
    if (empNode) {
      empNode.addEventListener('mouseenter', () => {
        highlightRelation([empNode, deptNode], [refEmpDept, refEmpSuper], null);
      });
      empNode.addEventListener('mouseleave', clearAll);
    }

    if (deptNode) {
      deptNode.addEventListener('mouseenter', () => {
        highlightRelation([deptNode, empNode, projNode], [refDeptMgr], null);
      });
      deptNode.addEventListener('mouseleave', clearAll);
    }

    if (projNode) {
      projNode.addEventListener('mouseenter', () => {
        highlightRelation([projNode, deptNode], [refProjDept], null);
      });
      projNode.addEventListener('mouseleave', clearAll);
    }

    if (depNode) {
      depNode.addEventListener('mouseenter', () => {
        highlightRelation([depNode, empNode], [refDepEmp], null);
      });
      depNode.addEventListener('mouseleave', clearAll);
    }

    // 2. Mouse events on Bullet Points
    if (bulletQuanly) {
      bulletQuanly.addEventListener('mouseenter', () => {
        highlightRelation([deptNode, empNode], [refDeptMgr], bulletQuanly);
      });
      bulletQuanly.addEventListener('mouseleave', clearAll);
    }

    if (bulletGiamsat) {
      bulletGiamsat.addEventListener('mouseenter', () => {
        highlightRelation([empNode], [refEmpSuper], bulletGiamsat);
      });
      bulletGiamsat.addEventListener('mouseleave', clearAll);
    }

    if (bulletThuocphong) {
      bulletThuocphong.addEventListener('mouseenter', () => {
        highlightRelation([projNode, deptNode], [refProjDept], bulletThuocphong);
      });
      bulletThuocphong.addEventListener('mouseleave', clearAll);
    }

    if (bulletCuanv) {
      bulletCuanv.addEventListener('mouseenter', () => {
        highlightRelation([depNode, empNode], [refDepEmp], bulletCuanv);
      });
      bulletCuanv.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.10. Interactive sync for Slide 10 (Mối Quan Hệ & Tập Quan Hệ)
  setupSlide10Interactivity() {
    const e1 = document.getElementById('slide10-e1');
    const e2 = document.getElementById('slide10-e2');
    const e3 = document.getElementById('slide10-e3');
    const d1 = document.getElementById('slide10-d1');
    const d2 = document.getElementById('slide10-d2');
    const r1 = document.getElementById('slide10-r1');
    const r2 = document.getElementById('slide10-r2');
    const r3 = document.getElementById('slide10-r3');

    const connR1 = document.getElementById('slide10-conn-r1');
    const connR2 = document.getElementById('slide10-conn-r2');
    const connR3 = document.getElementById('slide10-conn-r3');

    const setEmp = document.getElementById('slide10-set-emp');
    const setDept = document.getElementById('slide10-set-dept');

    const bulletType = document.getElementById('slide10-bullet-type');
    const bulletSet = document.getElementById('slide10-bullet-set');
    const bulletDegree = document.getElementById('slide10-bullet-degree');

    const allEntities = [e1, e2, e3, d1, d2];
    const allRels = [r1, r2, r3];
    const allConns = [connR1, connR2, connR3];
    const allBullets = [bulletType, bulletSet, bulletDegree];

    const clearAll = () => {
      allEntities.forEach(n => { if (n) { n.classList.remove('active', 'dimmed'); } });
      allRels.forEach(n => { if (n) { n.classList.remove('active', 'dimmed'); } });
      allConns.forEach(c => { if (c) { c.classList.remove('active'); } });
      allBullets.forEach(b => { if (b) { b.classList.remove('highlighted-bullet'); } });
      if (setEmp) { setEmp.style.stroke = ''; setEmp.style.opacity = ''; }
      if (setDept) { setDept.style.stroke = ''; setDept.style.opacity = ''; }
    };

    const highlightRelation = (activeEntities, activeRels, activeConns, activeBullet) => {
      allEntities.forEach(n => {
        if (n) {
          if (activeEntities.includes(n)) { n.classList.add('active'); }
          else { n.classList.add('dimmed'); }
        }
      });
      allRels.forEach(n => {
        if (n) {
          if (activeRels.includes(n)) { n.classList.add('active'); }
          else { n.classList.add('dimmed'); }
        }
      });
      activeConns.forEach(c => { if (c) c.classList.add('active'); });
      if (activeBullet) activeBullet.classList.add('highlighted-bullet');
    };

    // Hover elements triggers
    if (e1) { e1.addEventListener('mouseenter', () => highlightRelation([e1, d1], [r1], [connR1], null)); e1.addEventListener('mouseleave', clearAll); }
    if (e2) { e2.addEventListener('mouseenter', () => highlightRelation([e2, d1], [r2], [connR2], null)); e2.addEventListener('mouseleave', clearAll); }
    if (e3) { e3.addEventListener('mouseenter', () => highlightRelation([e3, d2], [r3], [connR3], null)); e3.addEventListener('mouseleave', clearAll); }
    if (d1) { d1.addEventListener('mouseenter', () => highlightRelation([d1, e1, e2], [r1, r2], [connR1, connR2], null)); d1.addEventListener('mouseleave', clearAll); }
    if (d2) { d2.addEventListener('mouseenter', () => highlightRelation([d2, e3], [r3], [connR3], null)); d2.addEventListener('mouseleave', clearAll); }

    if (r1) { r1.addEventListener('mouseenter', () => highlightRelation([e1, d1], [r1], [connR1], null)); r1.addEventListener('mouseleave', clearAll); }
    if (r2) { r2.addEventListener('mouseenter', () => highlightRelation([e2, d1], [r2], [connR2], null)); r2.addEventListener('mouseleave', clearAll); }
    if (r3) { r3.addEventListener('mouseenter', () => highlightRelation([e3, d2], [r3], [connR3], null)); r3.addEventListener('mouseleave', clearAll); }

    // Left Bullet Hover
    if (bulletType) {
      bulletType.addEventListener('mouseenter', () => {
        highlightRelation([], allRels, [], bulletType);
      });
      bulletType.addEventListener('mouseleave', clearAll);
    }
    if (bulletSet) {
      bulletSet.addEventListener('mouseenter', () => {
        highlightRelation(allEntities, allRels, allConns, bulletSet);
        if (setEmp) { setEmp.style.stroke = 'var(--color-blue)'; setEmp.style.opacity = '1'; }
        if (setDept) { setDept.style.stroke = 'var(--color-blue)'; setDept.style.opacity = '1'; }
      });
      bulletSet.addEventListener('mouseleave', clearAll);
    }
    if (bulletDegree) {
      bulletDegree.addEventListener('mouseenter', () => {
        highlightRelation(allEntities, allRels, allConns, bulletDegree);
      });
      bulletDegree.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.11. Interactive sync for Slide 11 (Mối quan hệ tự tham chiếu/đệ quy)
  setupSlide11Interactivity() {
    const userNode = document.getElementById('slide11-entity-user');
    const relNode = document.getElementById('slide11-rel-friend');
    const connSender = document.getElementById('slide11-conn-sender');
    const connRecipient = document.getElementById('slide11-conn-recipient');
    const roleSender = document.getElementById('slide11-role-sender');
    const roleRecipient = document.getElementById('slide11-role-recipient');

    const bulletRole = document.getElementById('slide11-bullet-role');
    const bulletFriend = document.getElementById('slide11-bullet-friend');

    const clearAll = () => {
      [userNode, relNode].forEach(n => { if (n) n.classList.remove('active', 'dimmed'); });
      [connSender, connRecipient].forEach(c => { if (c) c.classList.remove('active', 'energy-pulse'); });
      [roleSender, roleRecipient].forEach(r => { if (r) { r.style.fill = ''; r.style.transform = ''; } });
      [bulletRole, bulletFriend].forEach(b => { if (b) b.classList.remove('highlighted-bullet'); });
    };

    if (relNode) {
      relNode.addEventListener('mouseenter', () => {
        if (userNode) userNode.classList.add('active');
        relNode.classList.add('active');
        if (connSender) connSender.classList.add('energy-pulse');
        if (connRecipient) connRecipient.classList.add('energy-pulse');
      });
      relNode.addEventListener('mouseleave', clearAll);
    }

    if (userNode) {
      userNode.addEventListener('mouseenter', () => {
        userNode.classList.add('active');
        if (relNode) relNode.classList.add('active');
        if (connSender) connSender.classList.add('active');
        if (connRecipient) connRecipient.classList.add('active');
      });
      userNode.addEventListener('mouseleave', clearAll);
    }

    if (bulletRole) {
      bulletRole.addEventListener('mouseenter', () => {
        bulletRole.classList.add('highlighted-bullet');
        if (connSender) connSender.classList.add('active');
        if (connRecipient) connRecipient.classList.add('active');
        [roleSender, roleRecipient].forEach(r => {
          if (r) {
            r.style.fill = 'var(--color-blue)';
            r.style.transform = 'scale(1.1)';
          }
        });
      });
      bulletRole.addEventListener('mouseleave', clearAll);
    }

    if (bulletFriend) {
      bulletFriend.addEventListener('mouseenter', () => {
        bulletFriend.classList.add('highlighted-bullet');
        if (userNode) userNode.classList.add('active');
        if (relNode) relNode.classList.add('active');
        if (connSender) connSender.classList.add('active');
        if (connRecipient) connRecipient.classList.add('active');
      });
      bulletFriend.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.13. Interactive sync for Slide 13 (Thuộc tính mối quan hệ)
  setupSlide13Interactivity() {
    const emp = document.getElementById('slide13-entity-emp');
    const proj = document.getElementById('slide13-entity-proj');
    const rel = document.getElementById('slide13-rel-workson');
    const hours = document.getElementById('slide13-attr-hours');
    const connEmp = document.getElementById('slide13-conn-emp');
    const connProj = document.getElementById('slide13-conn-proj');
    const connHours = document.getElementById('slide13-conn-hours');
    const migrationArrow = document.getElementById('slide13-migration-arrow');

    const bullet1 = document.getElementById('slide13-bullet-1');
    const bullet2 = document.getElementById('slide13-bullet-2');

    const clearAll = () => {
      [emp, proj, rel, hours].forEach(n => { if (n) n.classList.remove('active', 'dimmed'); });
      [connEmp, connProj, connHours].forEach(c => { if (c) c.classList.remove('active'); });
      [bullet1, bullet2].forEach(b => { if (b) b.classList.remove('highlighted-bullet'); });
      if (migrationArrow) migrationArrow.style.opacity = '0';
    };

    if (emp) {
      emp.addEventListener('mouseenter', () => {
        emp.classList.add('active');
        if (proj) proj.classList.add('dimmed');
        if (hours) hours.classList.add('dimmed');
        if (rel) rel.classList.add('active');
        if (connEmp) connEmp.classList.add('active');
      });
      emp.addEventListener('mouseleave', clearAll);
    }

    if (proj) {
      proj.addEventListener('mouseenter', () => {
        proj.classList.add('active');
        if (emp) emp.classList.add('dimmed');
        if (hours) hours.classList.add('dimmed');
        if (rel) rel.classList.add('active');
        if (connProj) connProj.classList.add('active');
      });
      proj.addEventListener('mouseleave', clearAll);
    }

    if (rel) {
      rel.addEventListener('mouseenter', () => {
        rel.classList.add('active');
        if (emp) emp.classList.add('active');
        if (proj) proj.classList.add('active');
        if (hours) hours.classList.add('active');
        if (connEmp) connEmp.classList.add('active');
        if (connProj) connProj.classList.add('active');
        if (connHours) connHours.classList.add('active');
      });
      rel.addEventListener('mouseleave', clearAll);
    }

    if (hours) {
      hours.addEventListener('mouseenter', () => {
        hours.classList.add('active');
        if (rel) rel.classList.add('active');
        if (connHours) connHours.classList.add('active');
        if (emp) emp.classList.add('dimmed');
        if (proj) proj.classList.add('dimmed');
      });
      hours.addEventListener('mouseleave', clearAll);
    }

    if (bullet1) {
      bullet1.addEventListener('mouseenter', () => {
        bullet1.classList.add('highlighted-bullet');
        if (emp) emp.classList.add('active');
        if (hours) hours.classList.add('dimmed');
        if (rel) rel.classList.add('dimmed');
        if (proj) proj.classList.add('dimmed');
        if (migrationArrow) migrationArrow.style.opacity = '1';
      });
      bullet1.addEventListener('mouseleave', clearAll);
    }

    if (bullet2) {
      bullet2.addEventListener('mouseenter', () => {
        bullet2.classList.add('highlighted-bullet');
        if (rel) rel.classList.add('active');
        if (hours) hours.classList.add('active');
        if (connHours) connHours.classList.add('active');
        if (emp) emp.classList.add('active');
        if (proj) proj.classList.add('active');
      });
      bullet2.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.14. Interactive sync for Slide 14 (Thực thể yếu)
  setupSlide14Interactivity() {
    const acc = document.getElementById('slide14-entity-acc');
    const tx = document.getElementById('slide14-entity-tx');
    const rel = document.getElementById('slide14-rel-perform');
    const txid = document.getElementById('slide14-attr-txid');
    const connAcc = document.getElementById('slide14-conn-acc');
    const connTx = document.getElementById('slide14-conn-tx');
    const connTxid = document.getElementById('slide14-conn-txid');

    const bullet1 = document.getElementById('slide14-bullet-1');
    const bullet2 = document.getElementById('slide14-bullet-2');
    const bullet3 = document.getElementById('slide14-bullet-3');

    const allNodes = [acc, tx, rel, txid];
    const allConns = [connAcc, connTx, connTxid];
    const allBullets = [bullet1, bullet2, bullet3];

    const clearAll = () => {
      allNodes.forEach(n => { if (n) n.classList.remove('active', 'dimmed'); });
      allConns.forEach(c => { if (c) c.classList.remove('active'); });
      allBullets.forEach(b => { if (b) b.classList.remove('highlighted-bullet'); });
    };

    const highlightRelation = (activeNodes, activeConns, activeBullet) => {
      allNodes.forEach(n => {
        if (n) {
          if (activeNodes.includes(n)) { n.classList.add('active'); }
          else { n.classList.add('dimmed'); }
        }
      });
      activeConns.forEach(c => { if (c) c.classList.add('active'); });
      if (activeBullet) activeBullet.classList.add('highlighted-bullet');
    };

    if (acc) {
      acc.addEventListener('mouseenter', () => highlightRelation([acc, rel], [connAcc], null));
      acc.addEventListener('mouseleave', clearAll);
    }

    if (tx) {
      tx.addEventListener('mouseenter', () => highlightRelation([tx, txid, rel], [connTx, connTxid], null));
      tx.addEventListener('mouseleave', clearAll);
    }

    if (rel) {
      rel.addEventListener('mouseenter', () => highlightRelation([rel, acc, tx], [connAcc, connTx], null));
      rel.addEventListener('mouseleave', clearAll);
    }

    if (txid) {
      txid.addEventListener('mouseenter', () => highlightRelation([txid, tx], [connTxid], null));
      txid.addEventListener('mouseleave', clearAll);
    }

    if (bullet1) {
      bullet1.addEventListener('mouseenter', () => highlightRelation([acc], [], bullet1));
      bullet1.addEventListener('mouseleave', clearAll);
    }

    if (bullet2) {
      bullet2.addEventListener('mouseenter', () => highlightRelation([tx, txid], [connTxid], bullet2));
      bullet2.addEventListener('mouseleave', clearAll);
    }

    if (bullet3) {
      bullet3.addEventListener('mouseenter', () => highlightRelation([rel, tx], [connTx], bullet3));
      bullet3.addEventListener('mouseleave', clearAll);
    }
  },

  // 7.15. Interactive sync for Slide 15 (Quy ước & Ký hiệu ERD)
  setupSlide15Interactivity() {
    const cards = document.querySelectorAll('.symbol-card');
    const namingPanel = document.getElementById('slide15-naming-panel');
    const detailsPanel = document.getElementById('slide15-details-panel');
    const backBtn = document.getElementById('slide15-back-btn');

    const detailType = document.getElementById('slide15-detail-type');
    const detailTitle = document.getElementById('slide15-detail-title');
    const detailDesc = document.getElementById('slide15-detail-desc');
    const previewContainer = document.getElementById('slide15-preview-container');
    const detailExample = document.getElementById('slide15-detail-example');

    let currentActiveCard = null;

    // Notation detailed data mapping
    const symbolsData = {
      'slide15-symbol-entity': {
        type: 'Thực thể',
        title: 'Thực Thể Thường (Strong Entity)',
        desc: 'Biểu diễn một lớp đối tượng cụ thể tồn tại độc lập trong thế giới thực và bắt buộc phải có thuộc tính khóa chính để phân biệt các thực thể với nhau.',
        example: 'Ví dụ: Thực thể NHÂN_VIÊN (khóa chính MãNV), thực thể PHÒNG_BAN (khóa chính MãPhòng).',
        svg: `
          <svg width="240" height="90" viewBox="0 0 240 90">
            <defs>
              <linearGradient id="entityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f8fafc" />
              </linearGradient>
            </defs>
            <rect x="50" y="20" width="140" height="50" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="2.5" rx="6" style="filter: drop-shadow(0 4px 10px rgba(0,0,0,0.05));"></rect>
            <text x="120" y="49" font-family="var(--font-title)" font-weight="800" font-size="12" fill="var(--color-navy)" text-anchor="middle">NHÂN_VIÊN</text>
          </svg>
        `
      },
      'slide15-symbol-weak-entity': {
        type: 'Thực thể',
        title: 'Thực Thể Yếu (Weak Entity)',
        desc: 'Là kiểu thực thể không có thuộc tính khóa riêng để tự định danh. Nó phải phụ thuộc vào một thực thể khác (thực thể chủ) thông qua một mối quan hệ xác định.',
        example: 'Ví dụ: Thực thể PHỤ_THUỘC (thông tin người thân) phụ thuộc vào thực thể chủ NHÂN_VIÊN.',
        svg: `
          <svg width="240" height="90" viewBox="0 0 240 90">
            <defs>
              <linearGradient id="weakEntityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0fdfa" />
              </linearGradient>
            </defs>
            <rect x="50" y="20" width="140" height="50" fill="#ffffff" stroke="var(--color-navy)" stroke-width="2.5" rx="6" style="filter: drop-shadow(0 4px 10px rgba(0,0,0,0.05));"></rect>
            <rect x="54" y="24" width="132" height="42" fill="url(#weakEntityGrad)" stroke="var(--color-navy)" stroke-width="1.2" rx="4"></rect>
            <text x="120" y="49" font-family="var(--font-title)" font-weight="800" font-size="12" fill="var(--color-navy)" text-anchor="middle">PHỤ_THUỘC</text>
          </svg>
        `
      },
      'slide15-symbol-rel': {
        type: 'Mối quan hệ',
        title: 'Mối Quan Hệ Thường (Relationship)',
        desc: 'Biểu diễn sự liên kết, tương tác hoặc phụ thuộc ràng buộc có ý nghĩa học thuật giữa hai hay nhiều kiểu thực thể khác nhau.',
        example: 'Ví dụ: Nhân viên LÀM_CHO phòng ban, phòng ban KIỂM_SOÁT dự án.',
        svg: `
          <svg width="280" height="90" viewBox="0 0 280 90">
            <defs>
              <linearGradient id="relGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0f9ff" />
              </linearGradient>
            </defs>
            <line x1="20" y1="45" x2="260" y2="45" stroke="var(--color-navy)" stroke-width="2" stroke-linecap="round"></line>
            <polygon points="140,23 185,45 140,67 95,45" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="2" style="filter: drop-shadow(0 4px 8px rgba(0,0,0,0.05));"></polygon>
            <text x="140" y="48.5" font-family="var(--font-title)" font-weight="700" font-size="10.5" fill="var(--color-navy)" text-anchor="middle">LÀM_CHO</text>
          </svg>
        `
      },
      'slide15-symbol-identifying-rel': {
        type: 'Mối quan hệ',
        title: 'Mối Quan Hệ Xác Định (Identifying)',
        desc: 'Là mối quan hệ đặc biệt liên kết thực thể yếu với thực thể chủ của nó. Đường kết nối về phía thực thể yếu bắt buộc phải vẽ nét đôi (toàn phần).',
        example: 'Ví dụ: Mối quan hệ CỦA_NV liên kết người PHỤ_THUỘC vào NHÂN_VIÊN bảo lãnh.',
        svg: `
          <svg width="280" height="90" viewBox="0 0 280 90">
            <defs>
              <linearGradient id="relGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0f9ff" />
              </linearGradient>
            </defs>
            <line x1="20" y1="45" x2="95" y2="45" stroke="var(--color-navy)" stroke-width="2" stroke-linecap="round"></line>
            <line x1="185" y1="42" x2="260" y2="42" stroke="var(--color-navy)" stroke-width="1.5"></line>
            <line x1="185" y1="48" x2="260" y2="48" stroke="var(--color-navy)" stroke-width="1.5"></line>
            <polygon points="140,23 185,45 140,67 95,45" fill="none" stroke="var(--color-navy)" stroke-width="2" style="filter: drop-shadow(0 4px 8px rgba(0,0,0,0.05));"></polygon>
            <polygon points="140,26 181,45 140,64 99,45" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="1"></polygon>
            <text x="140" y="48.5" font-family="var(--font-title)" font-weight="700" font-size="10.5" fill="var(--color-navy)" text-anchor="middle">CỦA_NV</text>
          </svg>
        `
      },
      'slide15-symbol-attr': {
        type: 'Thuộc tính',
        title: 'Thuộc Tính Thường (Attribute)',
        desc: 'Mô tả một khía cạnh thông tin, đặc tính của thực thể hoặc mối quan hệ. Giá trị của nó là nguyên tố (đơn trị không thể phân chia tiếp).',
        example: 'Ví dụ: Thuộc tính HọTên, NgàySinh, Lương của thực thể NHÂN_VIÊN.',
        svg: `
          <svg width="240" height="90" viewBox="0 0 240 90">
            <defs>
              <linearGradient id="relGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0f9ff" />
              </linearGradient>
            </defs>
            <line x1="120" y1="45" x2="120" y2="70" stroke="var(--color-navy)" stroke-width="1.5" stroke-dasharray="3 3"></line>
            <ellipse cx="120" cy="35" rx="55" ry="20" fill="url(#relGrad)" stroke="var(--color-navy)" stroke-width="1.8" style="filter: drop-shadow(0 2px 5px rgba(0,0,0,0.03));"></ellipse>
            <text x="120" y="39" font-family="var(--font-body)" font-size="11" fill="var(--color-navy)" text-anchor="middle">HọTên</text>
          </svg>
        `
      },
      'slide15-symbol-key-attr': {
        type: 'Thuộc tính',
        title: 'Thuộc Tính Khóa (Key Attribute)',
        desc: 'Là thuộc tính có tính chất định danh duy nhất cho mỗi thực thể trong tập thực thể. Tên của thuộc tính khóa bắt buộc phải gạch chân.',
        example: 'Ví dụ: Thuộc tính MãNV của thực thể NHÂN_VIÊN, hoặc MãPhòng của PHÒNG_BAN.',
        svg: `
          <svg width="240" height="90" viewBox="0 0 240 90">
            <defs>
              <linearGradient id="entityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f8fafc" />
              </linearGradient>
            </defs>
            <line x1="120" y1="45" x2="120" y2="70" stroke="var(--color-navy)" stroke-width="1.8"></line>
            <ellipse cx="120" cy="35" rx="55" ry="20" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="2" style="filter: drop-shadow(0 2px 5px rgba(0,0,0,0.03));"></ellipse>
            <text x="120" y="39" font-family="var(--font-body)" font-weight="700" font-size="11" fill="var(--color-navy)" text-anchor="middle" text-decoration="underline">MãNV</text>
          </svg>
        `
      },
      'slide15-symbol-multivalued-attr': {
        type: 'Thuộc tính',
        title: 'Thuộc Tính Đa Trị (Multivalued)',
        desc: 'Là thuộc tính có thể nhận nhiều giá trị đồng thời cho cùng một đối tượng thực thể cụ thể. Được ký hiệu bằng hai vòng oval lồng nhau.',
        example: 'Ví dụ: Thuộc tính {ĐịaĐiểm} (phòng ban có thể ở Hà Nội, Đà Nẵng, TP.HCM).',
        svg: `
          <svg width="240" height="90" viewBox="0 0 240 90">
            <defs>
              <linearGradient id="weakEntityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f0fdfa" />
              </linearGradient>
            </defs>
            <line x1="120" y1="45" x2="120" y2="70" stroke="var(--color-navy)" stroke-width="1.8"></line>
            <ellipse cx="120" cy="35" rx="55" ry="20" fill="none" stroke="var(--color-navy)" stroke-width="1.8" style="filter: drop-shadow(0 2px 5px rgba(0,0,0,0.03));"></ellipse>
            <ellipse cx="120" cy="35" rx="51" ry="16" fill="url(#weakEntityGrad)" stroke="var(--color-navy)" stroke-width="1"></ellipse>
            <text x="120" y="39" font-family="var(--font-body)" font-size="11" fill="var(--color-navy)" text-anchor="middle">{ĐịaĐiểm}</text>
          </svg>
        `
      },
      'slide15-symbol-derived-attr': {
        type: 'Thuộc tính',
        title: 'Thuộc Tính Dẫn Xuất (Derived Attribute)',
        desc: 'Là thuộc tính có giá trị được tính toán tự động từ các thuộc tính khác có sẵn trong hệ thống. Được ký hiệu bằng hình oval nét đứt.',
        example: 'Ví dụ: Thuộc tính SốLượngNV (đếm số nhân viên), Tuổi (tính từ NgàySinh).',
        svg: `
          <svg width="240" height="90" viewBox="0 0 240 90">
            <defs>
              <linearGradient id="entityGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#ffffff" />
                <stop offset="100%" stop-color="#f8fafc" />
              </linearGradient>
            </defs>
            <line x1="120" y1="45" x2="120" y2="70" stroke="var(--color-navy)" stroke-width="1.5" stroke-dasharray="3 3"></line>
            <ellipse cx="120" cy="35" rx="55" ry="20" fill="url(#entityGrad)" stroke="var(--color-navy)" stroke-width="1.8" stroke-dasharray="4 3" style="filter: drop-shadow(0 2px 5px rgba(0,0,0,0.03));"></ellipse>
            <text x="120" y="39" font-family="var(--font-body)" font-size="10.5" fill="var(--color-navy)" text-anchor="middle">SốLượngNV</text>
          </svg>
        `
      }
    };

    // Update highlights helper function
    const updateCardHighlights = (hoveredCard) => {
      cards.forEach(c => {
        c.classList.remove('dimmed', 'active');
        if (currentActiveCard) {
          if (c === currentActiveCard) {
            c.classList.add('active');
          } else {
            c.classList.add('dimmed');
          }
        } else if (hoveredCard) {
          if (c !== hoveredCard) {
            c.classList.add('dimmed');
          } else {
            c.classList.add('active');
          }
        }
      });
    };

    // Bind card hover events
    cards.forEach(card => {
      card.addEventListener('mouseenter', () => {
        if (!currentActiveCard) {
          updateCardHighlights(card);
        }
      });
      card.addEventListener('mouseleave', () => {
        if (!currentActiveCard) {
          cards.forEach(c => c.classList.remove('dimmed', 'active'));
        }
      });

      // Bind card click event
      card.addEventListener('click', () => {
        currentActiveCard = card;
        updateCardHighlights();

        const data = symbolsData[card.id];
        if (data) {
          // Update dynamic text
          if (detailType) detailType.textContent = `Ký hiệu: ${data.type}`;
          if (detailTitle) detailTitle.textContent = data.title;
          if (detailDesc) detailDesc.textContent = data.desc;
          if (previewContainer) previewContainer.innerHTML = data.svg;
          if (detailExample) detailExample.innerHTML = `💡 <strong>Thực tế:</strong> ${data.example}`;

          // Transition left panels
          if (namingPanel && detailsPanel) {
            namingPanel.classList.remove('show');
            setTimeout(() => {
              namingPanel.style.display = 'none';
              detailsPanel.style.display = 'flex';
              detailsPanel.offsetHeight; // force reflow
              detailsPanel.classList.add('show');
            }, 250);
          }
        }
      });
    });

    // Bind back button click event
    if (backBtn) {
      backBtn.addEventListener('click', () => {
        currentActiveCard = null;
        cards.forEach(c => c.classList.remove('dimmed', 'active'));

        // Transition back to naming panel
        if (namingPanel && detailsPanel) {
          detailsPanel.classList.remove('show');
          setTimeout(() => {
            detailsPanel.style.display = 'none';
            namingPanel.style.display = 'flex';
            namingPanel.offsetHeight; // force reflow
            namingPanel.classList.add('show');
          }, 250);
        }
      });
    }
  },

  // 7.18. Interactive sync for Slide 18 (Quan hệ bậc cao/Tam phân)
  setupSlide18Interactivity() {
    this.slide18EventsBound = false;
  },

  bindSlide18Events() {
    const supplier = document.getElementById('slide18-entity-supplier');
    const project = document.getElementById('slide18-entity-project');
    const part = document.getElementById('slide18-entity-part');
    const rel = document.getElementById('slide18-rel-supply');
    const qty = document.getElementById('slide18-attr-qty');
    const connSupplier = document.getElementById('slide18-conn-supplier');
    const connProject = document.getElementById('slide18-conn-project');
    const connPart = document.getElementById('slide18-conn-part');
    const connQty = document.getElementById('slide18-conn-qty');

    const splitLines = document.querySelectorAll('.binary-split-line');
    const invalidMarker = document.getElementById('slide18-invalid-marker');

    const bullet1 = document.getElementById('slide18-bullet-1');
    const bullet2 = document.getElementById('slide18-bullet-2');

    const allNodes = [supplier, project, part, rel, qty];
    const allConns = [connSupplier, connProject, connPart, connQty];

    if (!supplier) return; // Not loaded yet

    const clearAll = () => {
      allNodes.forEach(n => { if (n) n.classList.remove('active', 'dimmed'); });
      allConns.forEach(c => { if (c) c.classList.remove('active'); });
      if (bullet1) bullet1.classList.remove('highlighted-bullet');
      if (bullet2) bullet2.classList.remove('highlighted-bullet');
      splitLines.forEach(line => { line.style.opacity = '0'; });
      if (invalidMarker) invalidMarker.style.opacity = '0';
    };

    const highlightRelation = (activeNodes, activeConns, activeBullet) => {
      allNodes.forEach(n => {
        if (n) {
          if (activeNodes.includes(n)) { n.classList.add('active'); }
          else { n.classList.add('dimmed'); }
        }
      });
      activeConns.forEach(c => { if (c) c.classList.add('active'); });
      if (activeBullet) activeBullet.classList.add('highlighted-bullet');
    };

    supplier.addEventListener('mouseenter', () => highlightRelation([supplier, rel], [connSupplier], null));
    supplier.addEventListener('mouseleave', clearAll);

    project.addEventListener('mouseenter', () => highlightRelation([project, rel], [connProject], null));
    project.addEventListener('mouseleave', clearAll);

    part.addEventListener('mouseenter', () => highlightRelation([part, rel], [connPart], null));
    part.addEventListener('mouseleave', clearAll);

    rel.addEventListener('mouseenter', () => highlightRelation([rel, supplier, project, part, qty], [connSupplier, connProject, connPart, connQty], null));
    rel.addEventListener('mouseleave', clearAll);

    qty.addEventListener('mouseenter', () => highlightRelation([qty, rel], [connQty], null));
    qty.addEventListener('mouseleave', clearAll);

    if (bullet1) {
      bullet1.addEventListener('mouseenter', () => {
        highlightRelation([rel, supplier, project, part], [connSupplier, connProject, connPart], bullet1);
      });
      bullet1.addEventListener('mouseleave', clearAll);
    }

    if (bullet2) {
      bullet2.addEventListener('mouseenter', () => {
        bullet2.classList.add('highlighted-bullet');
        allNodes.forEach(n => { if (n && n !== rel) n.classList.add('dimmed'); });
        splitLines.forEach(line => { line.style.opacity = '1'; });
        if (invalidMarker) invalidMarker.style.opacity = '1';
      });
      bullet2.addEventListener('mouseleave', clearAll);
    }

    this.slide18EventsBound = true;
  },

  setupSlide16Interactivity() {
    // Entities
    const empNode = document.getElementById('slide16-entity-emp');
    const deptNode = document.getElementById('slide16-entity-dept');
    const projNode = document.getElementById('slide16-entity-proj');
    const depNode = document.getElementById('slide16-entity-dep');
    const allEntities = [empNode, deptNode, projNode, depNode];

    // Relationships
    const relWorksFor = document.getElementById('slide16-rel-works-for');
    const relManages = document.getElementById('slide16-rel-manages');
    const relControls = document.getElementById('slide16-rel-controls');
    const relWorksOn = document.getElementById('slide16-rel-works-on');
    const relSupervision = document.getElementById('slide16-rel-supervision');
    const relDependentsOf = document.getElementById('slide16-rel-dependents-of');
    const allRels = [relWorksFor, relManages, relControls, relWorksOn, relSupervision, relDependentsOf];

    // Cardinalities
    const cardWorksFor = document.getElementById('slide16-card-works-for');
    const cardManages = document.getElementById('slide16-card-manages');
    const cardControls = document.getElementById('slide16-card-controls');
    const cardWorksOn = document.getElementById('slide16-card-works-on');
    const cardSupervision = document.getElementById('slide16-card-supervision');
    const cardDependentsOf = document.getElementById('slide16-card-dependents-of');
    const allCards = [cardWorksFor, cardManages, cardControls, cardWorksOn, cardSupervision, cardDependentsOf];

    // Theory Bullets
    const bulletWorksFor = document.getElementById('slide16-bullet-works-for');
    const bulletManages = document.getElementById('slide16-bullet-manages');
    const bulletControls = document.getElementById('slide16-bullet-controls');
    const bulletWorksOn = document.getElementById('slide16-bullet-works-on');
    const bulletSupervision = document.getElementById('slide16-bullet-supervision');
    const bulletDependentsOf = document.getElementById('slide16-bullet-dependents-of');
    const allBullets = [bulletWorksFor, bulletManages, bulletControls, bulletWorksOn, bulletSupervision, bulletDependentsOf];

    const clearAll = () => {
      allEntities.forEach(n => {
        if (n) n.classList.remove('active', 'dimmed');
      });
      allRels.forEach(n => {
        if (n) n.classList.remove('active', 'dimmed');
      });
      allCards.forEach(n => {
        if (n) n.classList.remove('active', 'dimmed');
      });
      allBullets.forEach(n => {
        if (n) n.classList.remove('highlighted-bullet');
      });
    };

    const highlightRelation = (activeEntities, activeRels, activeCards, activeBullets) => {
      allEntities.forEach(n => {
        if (n) {
          if (activeEntities.includes(n)) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      allRels.forEach(n => {
        if (n) {
          if (activeRels.includes(n)) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      allCards.forEach(n => {
        if (n) {
          if (activeCards.includes(n)) {
            n.classList.add('active');
          } else {
            n.classList.add('dimmed');
          }
        }
      });
      allBullets.forEach(n => {
        if (n) {
          if (activeBullets.includes(n)) {
            n.classList.add('highlighted-bullet');
          }
        }
      });
    };

    // 1. Mouse events on Theory Bullets
    if (bulletWorksFor) {
      bulletWorksFor.addEventListener('mouseenter', () => {
        highlightRelation([empNode, deptNode], [relWorksFor], [cardWorksFor], [bulletWorksFor]);
      });
      bulletWorksFor.addEventListener('mouseleave', clearAll);
    }
    if (bulletManages) {
      bulletManages.addEventListener('mouseenter', () => {
        highlightRelation([empNode, deptNode], [relManages], [cardManages], [bulletManages]);
      });
      bulletManages.addEventListener('mouseleave', clearAll);
    }
    if (bulletControls) {
      bulletControls.addEventListener('mouseenter', () => {
        highlightRelation([deptNode, projNode], [relControls], [cardControls], [bulletControls]);
      });
      bulletControls.addEventListener('mouseleave', clearAll);
    }
    if (bulletWorksOn) {
      bulletWorksOn.addEventListener('mouseenter', () => {
        highlightRelation([empNode, projNode], [relWorksOn], [cardWorksOn], [bulletWorksOn]);
      });
      bulletWorksOn.addEventListener('mouseleave', clearAll);
    }
    if (bulletSupervision) {
      bulletSupervision.addEventListener('mouseenter', () => {
        highlightRelation([empNode], [relSupervision], [cardSupervision], [bulletSupervision]);
      });
      bulletSupervision.addEventListener('mouseleave', clearAll);
    }
    if (bulletDependentsOf) {
      bulletDependentsOf.addEventListener('mouseenter', () => {
        highlightRelation([empNode, depNode], [relDependentsOf], [cardDependentsOf], [bulletDependentsOf]);
      });
      bulletDependentsOf.addEventListener('mouseleave', clearAll);
    }

    // 2. Mouse events on Relationship SVGs
    if (relWorksFor) {
      relWorksFor.addEventListener('mouseenter', () => {
        highlightRelation([empNode, deptNode], [relWorksFor], [cardWorksFor], [bulletWorksFor]);
      });
      relWorksFor.addEventListener('mouseleave', clearAll);
    }
    if (relManages) {
      relManages.addEventListener('mouseenter', () => {
        highlightRelation([empNode, deptNode], [relManages], [cardManages], [bulletManages]);
      });
      relManages.addEventListener('mouseleave', clearAll);
    }
    if (relControls) {
      relControls.addEventListener('mouseenter', () => {
        highlightRelation([deptNode, projNode], [relControls], [cardControls], [bulletControls]);
      });
      relControls.addEventListener('mouseleave', clearAll);
    }
    if (relWorksOn) {
      relWorksOn.addEventListener('mouseenter', () => {
        highlightRelation([empNode, projNode], [relWorksOn], [cardWorksOn], [bulletWorksOn]);
      });
      relWorksOn.addEventListener('mouseleave', clearAll);
    }
    if (relSupervision) {
      relSupervision.addEventListener('mouseenter', () => {
        highlightRelation([empNode], [relSupervision], [cardSupervision], [bulletSupervision]);
      });
      relSupervision.addEventListener('mouseleave', clearAll);
    }
    if (relDependentsOf) {
      relDependentsOf.addEventListener('mouseenter', () => {
        highlightRelation([empNode, depNode], [relDependentsOf], [cardDependentsOf], [bulletDependentsOf]);
      });
      relDependentsOf.addEventListener('mouseleave', clearAll);
    }

    // 3. Mouse events on Entity SVGs
    if (empNode) {
      empNode.addEventListener('mouseenter', () => {
        highlightRelation(
          [empNode, deptNode, projNode, depNode],
          [relWorksFor, relManages, relWorksOn, relSupervision, relDependentsOf],
          [cardWorksFor, cardManages, cardWorksOn, cardSupervision, cardDependentsOf],
          [bulletWorksFor, bulletManages, bulletWorksOn, bulletSupervision, bulletDependentsOf]
        );
      });
      empNode.addEventListener('mouseleave', clearAll);
    }
    if (deptNode) {
      deptNode.addEventListener('mouseenter', () => {
        highlightRelation(
          [deptNode, empNode, projNode],
          [relWorksFor, relManages, relControls],
          [cardWorksFor, cardManages, cardControls],
          [bulletWorksFor, bulletManages, bulletControls]
        );
      });
      deptNode.addEventListener('mouseleave', clearAll);
    }
    if (projNode) {
      projNode.addEventListener('mouseenter', () => {
        highlightRelation(
          [projNode, empNode, deptNode],
          [relWorksOn, relControls],
          [cardWorksOn, cardControls],
          [bulletWorksOn, bulletControls]
        );
      });
      projNode.addEventListener('mouseleave', clearAll);
    }
    if (depNode) {
      depNode.addEventListener('mouseenter', () => {
        highlightRelation(
          [depNode, empNode],
          [relDependentsOf],
          [cardDependentsOf],
          [bulletDependentsOf]
        );
      });
    }
  },

  // 7.19. Interactive sync for Slide 19 (3D Hologram Sphere & Q&A)
  setupSlide19Interactivity() {
    const qaBtn = document.getElementById('btn-slide19-qa');
    const sphere3d = document.querySelector('.sphere-3d');
    const sphereCore = document.querySelector('.sphere-core');
    const rings = document.querySelectorAll('.sphere-ring');

    if (qaBtn) {
      qaBtn.addEventListener('click', () => {
        // High-energy acceleration and coloring on Q&A trigger
        if (sphere3d) {
          sphere3d.style.animationDuration = '2s';
        }
        if (sphereCore) {
          sphereCore.style.background = 'radial-gradient(circle, rgba(242, 113, 35, 0.95) 0%, rgba(242, 113, 35, 0) 70%)';
          sphereCore.style.transform = 'translate(-50%, -50%) scale(1.4)';
          sphereCore.style.filter = 'blur(12px)';
        }
        rings.forEach(ring => {
          ring.style.borderColor = 'rgba(242, 113, 35, 0.8)';
          ring.style.boxShadow = '0 0 20px rgba(242, 113, 35, 0.5)';
        });

        const text = document.querySelector('.slide19-subtitle');
        if (text) {
          const originalText = text.textContent;
          text.textContent = "Nhóm 3 xin mời thầy cô và các bạn đặt câu hỏi thảo luận! 💬";
          text.style.color = "#a855f7";
          text.style.fontWeight = "bold";
          setTimeout(() => {
            text.textContent = originalText;
            text.style.color = "";
            text.style.fontWeight = "";
            
            // Revert sphere to original state
            if (sphere3d) sphere3d.style.animationDuration = '';
            if (sphereCore) {
              sphereCore.style.background = '';
              sphereCore.style.transform = '';
              sphereCore.style.filter = '';
            }
            rings.forEach(ring => {
              ring.style.borderColor = '';
              ring.style.boxShadow = '';
            });
          }, 4000);
        }
      });
    }
  }
}

