document.addEventListener('DOMContentLoaded', () => {
  
  // 1. Initialize State Manager
  window.StateManager.init();

  // 2. Initialize Diagram Animations
  window.DiagramAnimations.init();

  // 3. Initialize Navigation Control Events
  window.Navigation.init();

  // ==========================================================================
  // SLIDE 1: OBJECTIVES INTERACTION
  // ==========================================================================
  const objectiveItems = document.querySelectorAll('.objective-item');
  objectiveItems.forEach((item, index) => {
    // Staggered checkmarks reveal
    setTimeout(() => {
      item.classList.add('checked');
    }, 600 + (index * 200));
    
    item.addEventListener('click', () => {
      item.classList.toggle('checked');
    });
    
    item.addEventListener('keydown', (e) => {
      if (e.key === ' ' || e.key === 'Enter') {
        e.preventDefault();
        item.classList.toggle('checked');
      }
    });
  });

  // ==========================================================================
  // SLIDE 2: FLOWCHART CONTROLS (DBMS Independent vs Dependent)
  // ==========================================================================
  const btnIndep = document.getElementById('btn-phase-independent');
  const btnDep = document.getElementById('btn-phase-dependent');
  const flowReq = document.getElementById('flow-req');
  const flowConceptual = document.getElementById('flow-conceptual');
  const flowLogical = document.getElementById('flow-logical');
  const flowPhysical = document.getElementById('flow-physical');
  const flowArr1 = document.getElementById('flow-arr-1');
  const flowArr2 = document.getElementById('flow-arr-2');
  const phaseTitle = document.getElementById('phase-viz-title');

  if (btnIndep && btnDep) {
    btnIndep.addEventListener('click', () => {
      btnIndep.classList.add('active');
      btnDep.classList.remove('active');
      phaseTitle.textContent = 'Sơ đồ Luồng Thiết kế: Độc lập với DBMS';
      
      flowReq.classList.add('highlight');
      flowConceptual.classList.add('highlight');
      flowLogical.classList.remove('highlight');
      flowPhysical.classList.remove('highlight');
      flowArr1.classList.remove('highlight');
      flowArr2.classList.remove('highlight');
    });
    
    btnDep.addEventListener('click', () => {
      btnDep.classList.add('active');
      btnIndep.classList.remove('active');
      phaseTitle.textContent = 'Sơ đồ Luồng Thiết kế: Phụ thuộc vào DBMS';
      
      flowReq.classList.remove('highlight');
      flowConceptual.classList.remove('highlight');
      flowLogical.classList.add('highlight');
      flowPhysical.classList.add('highlight');
      flowArr1.classList.add('highlight');
      flowArr2.classList.add('highlight');
    });
  }

});
