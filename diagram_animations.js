// ==========================================================================
// DIAGRAM ANIMATIONS MODULE
// ==========================================================================
window.DiagramAnimations = {
  loadedDiagrams: {},

  init() {
    this.setupDormCalculator();
    this.setupSlide12EdunextControls();
    this.setupSlide17FlipControls();
  },

  // 1. Lazy Load & SVG Scaling Manager
  triggerLazyLoading() {
    const currentSlide = window.StateManager.currentSlide;

    // Slide 16 Lazy Loading: Scaled & Grouped COMPANY ERD
    if (currentSlide === 16 && !this.loadedDiagrams['company']) {
      const placeholder = document.getElementById('company-lazy-placeholder');
      if (placeholder) {
        placeholder.outerHTML = `
          <svg width="100%" height="100%" viewBox="0 0 600 450" style="color: var(--color-navy); max-width: 600px; overflow: visible;">
            <!-- Group 1: Entities -->
            <g class="entity-group" style="transition: opacity 0.5s ease-in-out; opacity: 0;">
              <!-- NHÂN_VIÊN -->
              <rect x="30" y="110" width="120" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
              <text x="90" y="140" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">NHÂN_VIÊN</text>
              
              <!-- PHÒNG_BAN -->
              <rect x="240" y="110" width="130" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
              <text x="305" y="140" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">PHÒNG_BAN</text>
              
              <!-- DỰ_ÁN -->
              <rect x="450" y="110" width="120" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
              <text x="510" y="140" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">DỰ_ÁN</text>
              
              <!-- PHỤ_THUỘC (Weak entity double rect) -->
              <rect x="240" y="330" width="130" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
              <rect x="244" y="334" width="122" height="42" fill="none" stroke="currentColor" stroke-width="1" rx="2"></rect>
              <text x="305" y="360" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">PHỤ_THUỘC</text>
            </g>

            <!-- Group 2: Relationships -->
            <g class="rel-group" style="transition: opacity 0.5s ease-in-out; opacity: 0;">
              <!-- LÀM_CHO diamond -->
              <polygon points="185,110 205,135 185,160 165,135" fill="none" stroke="currentColor" stroke-width="1.8"></polygon>
              <text x="185" y="139" font-family="var(--font-title)" font-size="9" fill="currentColor" text-anchor="middle">LÀM_CHO</text>
              <!-- LÀM_CHO lines -->
              <line x1="150" y1="135" x2="165" y2="135" stroke="currentColor" stroke-width="1.5"></line>
              <line x1="205" y1="135" x2="240" y2="135" stroke="currentColor" stroke-width="1.5"></line>

              <!-- QUẢN_LÝ diamond -->
              <polygon points="185,15 205,35 185,55 165,35" fill="none" stroke="currentColor" stroke-width="1.8"></polygon>
              <text x="185" y="39" font-family="var(--font-title)" font-size="9" fill="currentColor" text-anchor="middle">QUẢN_LÝ</text>
              <!-- QUẢN_LÝ lines -->
              <line x1="90" y1="110" x2="90" y2="35" stroke="currentColor" stroke-width="1.5"></line>
              <line x1="90" y1="35" x2="165" y2="35" stroke="currentColor" stroke-width="1.5"></line>
              <line x1="205" y1="35" x2="305" y2="35" stroke="currentColor" stroke-width="1.5"></line>
              <line x1="305" y1="35" x2="305" y2="110" stroke="currentColor" stroke-width="1.5"></line>

              <!-- CỦA_NV double diamond identifying relationship -->
              <polygon points="305,220 330,245 305,270 280,245" fill="none" stroke="currentColor" stroke-width="1.8"></polygon>
              <polygon points="305,224 325,245 305,266 285,245" fill="none" stroke="currentColor" stroke-width="0.8"></polygon>
              <text x="305" y="248" font-family="var(--font-title)" font-size="8" fill="currentColor" text-anchor="middle">CỦA_NV</text>
              <!-- CỦA_NV lines -->
              <line x1="305" y1="160" x2="305" y2="220" stroke="currentColor" stroke-width="1.5"></line>
              <line x1="305" y1="270" x2="305" y2="330" stroke="currentColor" stroke-width="2.5"></line>
              <line x1="301" y1="270" x2="301" y2="330" stroke="currentColor" stroke-width="0.8"></line>
            </g>

            <!-- Group 3: Cardinalities -->
            <g class="card-group" style="transition: opacity 0.5s ease-in-out; opacity: 0;">
              <!-- LÀM_CHO cardinalities -->
              <text x="156" y="128" font-family="var(--font-title)" font-weight="700" font-size="11" fill="var(--color-blue)">N</text>
              <text x="232" y="128" font-family="var(--font-title)" font-weight="700" font-size="11" fill="var(--color-blue)">1</text>
              <!-- QUẢN_LÝ cardinalities -->
              <text x="96" y="102" font-family="var(--font-title)" font-weight="700" font-size="11" fill="var(--color-blue)">1</text>
              <text x="312" y="102" font-family="var(--font-title)" font-weight="700" font-size="11" fill="var(--color-blue)">1</text>
              <!-- CỦA_NV cardinalities -->
              <text x="312" y="180" font-family="var(--font-title)" font-weight="700" font-size="11" fill="var(--color-blue)">1</text>
              <text x="312" y="322" font-family="var(--font-title)" font-weight="700" font-size="11" fill="var(--color-blue)">N</text>
            </g>
          </svg>
        `;
        this.loadedDiagrams['company'] = true;
      }
    }

    // Slide 18 Lazy Loading: Scaled Ternary Relationship
    if (currentSlide === 18 && !this.loadedDiagrams['ternary']) {
      const placeholder = document.getElementById('ternary-lazy-placeholder');
      if (placeholder) {
        placeholder.outerHTML = `
          <svg width="100%" height="100%" viewBox="0 0 480 340" style="color: var(--color-navy); max-width: 480px; overflow: visible;">
            <!-- Ternary Diamond -->
            <polygon points="240,110 290,150 240,190 190,150" fill="none" stroke="currentColor" stroke-width="2.5" class="glowing-line"></polygon>
            <text x="240" y="154" font-family="var(--font-title)" font-weight="700" font-size="14" fill="currentColor" text-anchor="middle">CUNG_CẤP</text>
            
            <!-- Nodes -->
            <!-- NHÀ_CUNG_CẤP -->
            <rect x="20" y="125" width="130" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
            <text x="85" y="155" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">NHÀ_CUNG_CẤP</text>
            
            <!-- DỰ_ÁN -->
            <rect x="330" y="125" width="130" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
            <text x="395" y="155" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">DỰ_ÁN</text>
            
            <!-- LINH_KIỆN -->
            <rect x="175" y="260" width="130" height="50" fill="none" stroke="currentColor" stroke-width="2" rx="4"></rect>
            <text x="240" y="290" font-family="var(--font-title)" font-weight="700" font-size="12" fill="currentColor" text-anchor="middle">LINH_KIỆN</text>
            
            <!-- Connections -->
            <line x1="150" y1="150" x2="190" y2="150" stroke="currentColor" stroke-width="2"></line>
            <text x="165" y="140" font-family="var(--font-title)" font-weight="700" font-size="13" fill="var(--color-blue)">N</text>
            
            <line x1="290" y1="150" x2="330" y2="150" stroke="currentColor" stroke-width="2"></line>
            <text x="305" y="140" font-family="var(--font-title)" font-weight="700" font-size="13" fill="var(--color-blue)">M</text>
            
            <line x1="240" y1="190" x2="240" y2="260" stroke="currentColor" stroke-width="2"></line>
            <text x="250" y="225" font-family="var(--font-title)" font-weight="700" font-size="13" fill="var(--color-blue)">P</text>
            
            <!-- Quantity Attribute -->
            <ellipse cx="340" cy="50" rx="50" ry="22" fill="none" stroke="currentColor" stroke-width="1.8"></ellipse>
            <text x="340" y="54" font-family="var(--font-body)" font-size="12" fill="currentColor" text-anchor="middle">SốLượng</text>
            <line x1="315" y1="69" x2="265" y2="130" stroke="currentColor" stroke-dasharray="4 4" stroke-width="2"></line>
          </svg>
        `;
        this.loadedDiagrams['ternary'] = true;
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
    slide16.classList.remove('reveal-step-0', 'reveal-step-1', 'reveal-step-2', 'reveal-step-3');
    slide16.classList.add(`reveal-step-${step}`);

    const svgEntities = slide16.querySelector('.entity-group');
    const svgRels = slide16.querySelector('.rel-group');
    const svgCards = slide16.querySelector('.card-group');

    if (svgEntities) svgEntities.style.opacity = step >= 1 ? '1' : '0';
    if (svgRels) svgRels.style.opacity = step >= 2 ? '1' : '0';
    if (svgCards) svgCards.style.opacity = step >= 3 ? '1' : '0';

    // Update dynamic helper text for steps
    const helperText = document.getElementById('reveal-helper-text');
    if (helperText) {
      if (step === 0) {
        helperText.innerHTML = "🎯 Bấm <strong>Mũi tên phải</strong> hoặc <strong>Click Next</strong> để bắt đầu vẽ sơ đồ từng bước.";
      } else if (step === 1) {
        helperText.innerHTML = "🧱 <strong>Bước 1:</strong> Xác định các Thực thể chính và Thực thể yếu.";
      } else if (step === 2) {
        helperText.innerHTML = "🔗 <strong>Bước 2:</strong> Thiết lập các Mối quan hệ và Đường liên kết.";
      } else if (step === 3) {
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

  // 5. 3D card flip trigger for Slide 17 Terminology Comparison
  setupSlide17FlipControls() {
    const btnFlip = document.getElementById('btn-highlight-uml');
    
    if (btnFlip) {
      btnFlip.addEventListener('click', () => {
        const cards = document.querySelectorAll('.flip-card');
        const isFlipped = cards[0]?.classList.contains('flipped');
        
        cards.forEach(card => {
          if (isFlipped) {
            card.classList.remove('flipped');
          } else {
            card.classList.add('flipped');
          }
        });

        // Trigger color row highlights as well
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
  }
};
