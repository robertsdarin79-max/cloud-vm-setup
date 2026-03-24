// Fade-in on scroll
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.style.opacity = '1';
      entry.target.style.transform = 'translateY(0)';
    }
  });
}, { threshold: 0.08 });

document.querySelectorAll('.step-block, .card, .arch-node').forEach(el => {
  el.style.opacity = '0';
  el.style.transform = 'translateY(16px)';
  el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
  observer.observe(el);
});

// Stagger card animations
document.querySelectorAll('.cards-grid .card').forEach((card, i) => {
  card.style.transitionDelay = `${i * 60}ms`;
});

// Copy code blocks on click
document.querySelectorAll('.terminal pre, .file-block pre').forEach(pre => {
  pre.style.cursor = 'pointer';
  pre.title = 'Click to copy';
  pre.addEventListener('click', () => {
    const text = pre.innerText;
    navigator.clipboard.writeText(text).then(() => {
      const orig = pre.style.outline;
      pre.style.outline = '1px solid #00e5ff';
      setTimeout(() => pre.style.outline = orig, 800);
    });
  });
});
