// ========================================
// fr3akazo1d Personal Website - JavaScript
// Custom Cursor, Smooth Scrolling, and Animations
// ========================================

// === INITIALIZE CURSOR IMMEDIATELY ===
(function initCursor() {
    let mouseX = window.innerWidth / 2;
    let mouseY = window.innerHeight / 2;
    let cursorX = mouseX;
    let cursorY = mouseY;
    let followerX = mouseX;
    let followerY = mouseY;
    
    function updateCursor() {
        const cursor = document.querySelector('.cursor');
        const cursorFollower = document.querySelector('.cursor-follower');
        
        if (cursor && cursorFollower) {
            // Track mouse movement
            document.addEventListener('mousemove', (e) => {
                mouseX = e.clientX;
                mouseY = e.clientY;
            });
            
            // Animate cursor
            function animateCursor() {
                cursorX += (mouseX - cursorX) * 0.5;
                cursorY += (mouseY - cursorY) * 0.5;
                followerX += (mouseX - followerX) * 0.15;
                followerY += (mouseY - followerY) * 0.15;
                
                cursor.style.left = cursorX + 'px';
                cursor.style.top = cursorY + 'px';
                cursorFollower.style.left = followerX + 'px';
                cursorFollower.style.top = followerY + 'px';
                
                requestAnimationFrame(animateCursor);
            }
            
            animateCursor();
        } else {
            // Retry after a short delay if elements not found
            setTimeout(updateCursor, 100);
        }
    }
    
    // Try immediately
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', updateCursor);
    } else {
        updateCursor();
    }
})();

document.addEventListener('DOMContentLoaded', () => {
    console.log('DOMContentLoaded fired!');
    
    // === HANDLE HASH NAVIGATION ON PAGE LOAD ===
    // Fix for anchor links from external pages (e.g., /gallery/ -> /index.html#blog)
    if (window.location.hash) {
        // Wait a bit for page to fully render, then scroll
        setTimeout(() => {
            const hash = window.location.hash;
            const targetSection = document.querySelector(hash);
            console.log('Hash detected:', hash, 'Target:', targetSection);
            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        }, 100);
    }
    
    // === CURSOR ELEMENTS (for hover effects) ===
    const cursor = document.querySelector('.cursor');
    const cursorFollower = document.querySelector('.cursor-follower');
    console.log('Cursor elements:', cursor, cursorFollower);
    
    // === LOADING SCREEN ===
    const loadingScreen = document.querySelector('.loading-screen');
    const loadingStatus = document.querySelector('.loading-status');
    
    // Only show loading screen on first visit to home page
    const isHomePage = window.location.pathname === '/' || window.location.pathname === '/index.html';
    const hasVisited = sessionStorage.getItem('hasVisitedHome');
    
    if (!isHomePage || hasVisited) {
        // Skip loading screen - already hidden by default CSS
        // Do nothing, loading screen stays hidden
    } else {
        // First visit to home - show loading screen
        sessionStorage.setItem('hasVisitedHome', 'true');
        loadingScreen.classList.add('show');
        
        const loadingMessages = [
            'Bypassing firewall...',
            'Cracking password hash...',
            'Decrypting SSL certificates...',
            'Injecting malicious code... just kidding!',
            'Loading coffee.exe...',
            'Hacking the mainframe...',
            'Downloading more RAM...',
            'Deleting system32... NOT!',
            'Establishing secure connection...',
            'Compiling exploits...',
            'Access granted! Welcome, hacker.'
        ];
        
        let messageIndex = 0;
        const messageInterval = setInterval(() => {
            if (messageIndex < loadingMessages.length - 1) {
                messageIndex++;
                loadingStatus.textContent = loadingMessages[messageIndex];
            }
        }, 450);
        
        // Show loading screen for at least 4 seconds
        const minLoadTime = 4000;
        const startTime = Date.now();
        
        window.addEventListener('load', () => {
            const elapsed = Date.now() - startTime;
            const remainingTime = Math.max(0, minLoadTime - elapsed);
            
            setTimeout(() => {
                clearInterval(messageInterval);
                loadingStatus.textContent = loadingMessages[loadingMessages.length - 1];
                setTimeout(() => {
                    loadingScreen.classList.add('hidden');
                    loadingScreen.classList.remove('show');
                    // Add fade-in animation to sections
                    document.querySelectorAll('.section').forEach((section, index) => {
                        setTimeout(() => {
                            section.classList.add('fade-in');
                        }, index * 100);
                    });
                }, 800);
            }, remainingTime);
        });
    }
    
    // === MOBILE MENU TOGGLE ===
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const navMenu = document.querySelector('.nav-menu');
    const navLinks = document.querySelectorAll('.nav-link');
    
    if (mobileMenuToggle) {
        mobileMenuToggle.addEventListener('click', () => {
            mobileMenuToggle.classList.toggle('active');
            navMenu.classList.toggle('active');
        });
        
        // Close menu when clicking on a link
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                mobileMenuToggle.classList.remove('active');
                navMenu.classList.remove('active');
            });
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!navMenu.contains(e.target) && !mobileMenuToggle.contains(e.target)) {
                mobileMenuToggle.classList.remove('active');
                navMenu.classList.remove('active');
            }
        });
    }
    
    // Back to top button
    const backToTopBtn = document.querySelector('.back-to-top');
    
    if (backToTopBtn) {
        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                backToTopBtn.classList.add('visible');
            } else {
                backToTopBtn.classList.remove('visible');
            }
        });
        
        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
    
    // Cursor hover effects
    if (cursor && cursorFollower) {
        const hoverElements = document.querySelectorAll('a, button, .blog-card, .project-card, .contact-card, .platform-card, .skill-category, .timeline-item, .cert-item');
        
        hoverElements.forEach(element => {
            element.addEventListener('mouseenter', () => {
                cursor.style.transform = 'translate(-50%, -50%) scale(1.5)';
                cursor.style.borderColor = '#ff003c';
                cursorFollower.style.transform = 'translate(-50%, -50%) scale(2)';
            });
            
            element.addEventListener('mouseleave', () => {
                cursor.style.transform = 'translate(-50%, -50%) scale(1)';
                cursor.style.borderColor = '#00fff7';
                cursorFollower.style.transform = 'translate(-50%, -50%) scale(1)';
            });
        });
    }
    
    // === SMOOTH SCROLL (already handled in mobile menu) ===
    // Additional smooth scroll functionality
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            const targetId = link.getAttribute('href');
            
            // Only apply smooth scroll to anchor links (starting with #)
            if (targetId && targetId.startsWith('#')) {
                e.preventDefault();
                
                const targetSection = document.querySelector(targetId);
                
                if (targetSection) {
                    targetSection.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }
            // For regular links (like /tags/), let the browser handle navigation normally
        });
    });    // === ACTIVE NAV LINK ===
    const sections = document.querySelectorAll('.section, header');
    
    function updateActiveNav() {
        const scrollPosition = window.scrollY + 100;
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${sectionId}`) {
                        link.classList.add('active');
                    }
                });
            }
        });
    }
    
    window.addEventListener('scroll', updateActiveNav);
    updateActiveNav();
    
    // === GLITCH EFFECT TRIGGER ===
    const glitchElements = document.querySelectorAll('.glitch');
    
    function triggerGlitch(element) {
        element.style.animation = 'none';
        setTimeout(() => {
            element.style.animation = '';
        }, 10);
    }
    
    // Random glitch effect every 5-10 seconds
    setInterval(() => {
        const randomElement = glitchElements[Math.floor(Math.random() * glitchElements.length)];
        triggerGlitch(randomElement);
    }, Math.random() * 5000 + 5000);
    
    // === INTERSECTION OBSERVER FOR ANIMATIONS ===
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // Observe all sections
    document.querySelectorAll('.section').forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(50px)';
        section.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
        observer.observe(section);
    });
    
    // === TYPING EFFECT FOR TERMINAL ===
    function typeEffect(element, text, speed = 50) {
        let i = 0;
        element.textContent = '';
        
        function type() {
            if (i < text.length) {
                element.textContent += text.charAt(i);
                i++;
                setTimeout(type, speed);
            }
        }
        
        type();
    }
    
    // Apply typing effect to terminal prompts on scroll
    const terminalOutputs = document.querySelectorAll('.terminal-body .output');
    
    const terminalObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && !entry.target.dataset.typed) {
                entry.target.dataset.typed = 'true';
                const text = entry.target.textContent;
                typeEffect(entry.target, text, 20);
            }
        });
    }, { threshold: 0.5 });
    
    // Only apply to first paragraph in each terminal
    document.querySelectorAll('.terminal-body').forEach(terminal => {
        const firstOutput = terminal.querySelector('.output:not(ul)');
        if (firstOutput) {
            terminalObserver.observe(firstOutput);
        }
    });
    
    // === PARTICLE BACKGROUND (Optional) ===
    function createParticle() {
        const particle = document.createElement('div');
        particle.style.position = 'fixed';
        particle.style.width = '2px';
        particle.style.height = '2px';
        particle.style.background = Math.random() > 0.5 ? '#00fff7' : '#ff003c';
        particle.style.opacity = Math.random() * 0.5 + 0.2;
        particle.style.left = Math.random() * 100 + '%';
        particle.style.top = '-10px';
        particle.style.pointerEvents = 'none';
        particle.style.zIndex = '0';
        particle.style.borderRadius = '50%';
        
        document.body.appendChild(particle);
        
        let posY = -10;
        const speed = Math.random() * 2 + 1;
        
        function animateParticle() {
            posY += speed;
            particle.style.top = posY + 'px';
            
            if (posY < window.innerHeight) {
                requestAnimationFrame(animateParticle);
            } else {
                particle.remove();
            }
        }
        
        animateParticle();
    }
    
    // Create particles periodically (reduce frequency to avoid performance issues)
    setInterval(createParticle, 2000);
    
    // === LOGO HOVER EFFECT ===
    const logo = document.querySelector('.logo');
    
    if (logo) {
        logo.addEventListener('mouseenter', () => {
            logo.style.animation = 'none';
            logo.style.transform = 'scale(1.1) rotate(5deg)';
        });
        
        logo.addEventListener('mouseleave', () => {
            logo.style.transform = 'scale(1) rotate(0deg)';
            setTimeout(() => {
                logo.style.animation = 'float 6s ease-in-out infinite';
            }, 300);
        });
    }
    

    
    // === MAKE BLOG CARDS CLICKABLE ===
    const blogCards = document.querySelectorAll('.blog-card');
    
    blogCards.forEach(card => {
        card.addEventListener('click', (e) => {
            // Find the link inside the card
            const link = card.querySelector('.card-link');
            if (link && !e.target.closest('a')) {
                // Navigate to the blog post
                window.location.href = link.getAttribute('href');
            }
        });
        
        // Add pointer cursor
        card.style.cursor = 'pointer';
    });
    

    
    // === MATRIX RAIN EFFECT (Background) ===
    function createMatrixRain() {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        
        canvas.style.position = 'fixed';
        canvas.style.top = '0';
        canvas.style.left = '0';
        canvas.style.width = '100%';
        canvas.style.height = '100%';
        canvas.style.zIndex = '-1';
        canvas.style.opacity = '0.03';
        canvas.style.pointerEvents = 'none';
        
        document.body.appendChild(canvas);
        
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        
        const columns = Math.floor(canvas.width / 20);
        const drops = Array(columns).fill(1);
        
        const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()';
        
        function draw() {
            ctx.fillStyle = 'rgba(16, 20, 26, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            ctx.fillStyle = '#00fff7';
            ctx.font = '15px monospace';
            
            for (let i = 0; i < drops.length; i++) {
                const text = chars[Math.floor(Math.random() * chars.length)];
                ctx.fillText(text, i * 20, drops[i] * 20);
                
                if (drops[i] * 20 > canvas.height && Math.random() > 0.975) {
                    drops[i] = 0;
                }
                
                drops[i]++;
            }
        }
        
        setInterval(draw, 50);
        
        window.addEventListener('resize', () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        });
    }
    
    // Uncomment to enable matrix rain effect
    // createMatrixRain();
    
    // === GALLERY FUNCTIONALITY ===
    const galleryButtons = document.querySelectorAll('.gallery-view-btn');
    console.log('=== GALLERY DEBUG ===');
    console.log('Gallery buttons found:', galleryButtons.length);
    console.log('Buttons:', galleryButtons);
    
    if (galleryButtons.length > 0) {
        console.log('Creating gallery modal...');
        // Create gallery modal dynamically
        const modal = document.createElement('div');
        modal.className = 'gallery-modal';
        modal.innerHTML = `
            <div class="gallery-modal-content">
                <div class="gallery-modal-header">
                    <h2 class="gallery-modal-title"></h2>
                    <button class="gallery-close-btn">&times;</button>
                </div>
                <div class="gallery-photos-grid"></div>
            </div>
        `;
        document.body.appendChild(modal);
        console.log('Modal created and added to body');
        
        // Close modal on X button
        modal.querySelector('.gallery-close-btn').addEventListener('click', () => {
            modal.classList.remove('active');
        });
        
        // Close modal on background click
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.classList.remove('active');
            }
        });
        
        // Close modal on ESC key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && modal.classList.contains('active')) {
                modal.classList.remove('active');
            }
        });
        
        // Add click handlers to all gallery buttons
        galleryButtons.forEach((button, index) => {
            console.log(`Setting up button ${index}:`, button);
            button.addEventListener('click', (e) => {
                console.log('===== GALLERY BUTTON CLICKED! =====');
                e.preventDefault();
                e.stopPropagation();
                
                const gallerySlug = button.getAttribute('data-gallery');
                console.log('Gallery slug:', gallerySlug);
                const galleryCard = button.closest('.gallery-card');
                const galleryTitle = galleryCard.querySelector('.gallery-title').textContent;
                
                // Set modal title
                modal.querySelector('.gallery-modal-title').textContent = galleryTitle;
                
                // Get photo elements from the gallery card (they're rendered by Jekyll)
                const photosGrid = modal.querySelector('.gallery-photos-grid');
                const photoElements = galleryCard.querySelectorAll('.gallery-photo-data');
                
                console.log('Gallery card:', galleryCard);
                console.log('Photo elements found:', photoElements.length);
                
                if (photoElements.length > 0) {
                    // Clear grid and add photos
                    photosGrid.innerHTML = '';
                    photoElements.forEach((photoData, index) => {
                        console.log('Photo data:', photoData.dataset.image, photoData.dataset.caption);
                        const photoDiv = document.createElement('div');
                        photoDiv.className = 'gallery-photo-item';
                        photoDiv.innerHTML = `
                            <img src="${photoData.dataset.image}" alt="${photoData.dataset.caption}" loading="lazy">
                            <div class="gallery-photo-caption">${photoData.dataset.caption}</div>
                        `;
                        
                        // Add click to view fullscreen
                        photoDiv.addEventListener('click', () => {
                            console.log('Photo clicked! Opening lightbox...');
                            let currentIndex = index;
                            
                            const lightbox = document.createElement('div');
                            lightbox.className = 'gallery-lightbox';
                            lightbox.innerHTML = `
                                <button class="lightbox-close">&times;</button>
                                <button class="lightbox-nav lightbox-prev" aria-label="Previous photo">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="15 18 9 12 15 6"></polyline>
                                    </svg>
                                </button>
                                <button class="lightbox-nav lightbox-next" aria-label="Next photo">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="9 18 15 12 9 6"></polyline>
                                    </svg>
                                </button>
                                <img src="${photoData.dataset.image}" alt="${photoData.dataset.caption}">
                                <div class="lightbox-caption">${photoData.dataset.caption}</div>
                                <div class="lightbox-counter">${currentIndex + 1} / ${photoElements.length}</div>
                            `;
                            document.body.appendChild(lightbox);
                            console.log('Lightbox created and added to body');
                            
                            const lightboxImg = lightbox.querySelector('img');
                            const lightboxCaption = lightbox.querySelector('.lightbox-caption');
                            const lightboxCounter = lightbox.querySelector('.lightbox-counter');
                            const prevBtn = lightbox.querySelector('.lightbox-prev');
                            const nextBtn = lightbox.querySelector('.lightbox-next');
                            
                            console.log('Navigation buttons:', prevBtn, nextBtn);
                            console.log('Total photos:', photoElements.length);
                            console.log('Current index:', currentIndex);
                            
                            // Function to update lightbox content
                            function updateLightbox() {
                                const currentPhoto = photoElements[currentIndex];
                                lightboxImg.src = currentPhoto.dataset.image;
                                lightboxImg.alt = currentPhoto.dataset.caption;
                                lightboxCaption.textContent = currentPhoto.dataset.caption;
                                lightboxCounter.textContent = `${currentIndex + 1} / ${photoElements.length}`;
                                
                                // Hide/show navigation buttons at edges
                                prevBtn.style.display = currentIndex === 0 ? 'none' : 'flex';
                                nextBtn.style.display = currentIndex === photoElements.length - 1 ? 'none' : 'flex';
                                console.log('Updated navigation visibility - prev:', prevBtn.style.display, 'next:', nextBtn.style.display);
                            }
                            
                            // Navigation button handlers
                            prevBtn.addEventListener('click', (e) => {
                                e.stopPropagation();
                                if (currentIndex > 0) {
                                    currentIndex--;
                                    updateLightbox();
                                }
                            });
                            
                            nextBtn.addEventListener('click', (e) => {
                                e.stopPropagation();
                                if (currentIndex < photoElements.length - 1) {
                                    currentIndex++;
                                    updateLightbox();
                                }
                            });
                            
                            // Show lightbox
                            setTimeout(() => {
                                lightbox.classList.add('active');
                                updateLightbox(); // Update button visibility
                                console.log('Lightbox active class added');
                            }, 10);
                            
                            // Close handlers
                            const closeBtn = lightbox.querySelector('.lightbox-close');
                            closeBtn.addEventListener('click', () => {
                                lightbox.classList.remove('active');
                                setTimeout(() => lightbox.remove(), 300);
                            });
                            
                            lightbox.addEventListener('click', (e) => {
                                if (e.target === lightbox) {
                                    lightbox.classList.remove('active');
                                    setTimeout(() => lightbox.remove(), 300);
                                }
                            });
                            
                            // Keyboard navigation
                            document.addEventListener('keydown', function keyHandler(e) {
                                if (e.key === 'Escape') {
                                    lightbox.classList.remove('active');
                                    setTimeout(() => lightbox.remove(), 300);
                                    document.removeEventListener('keydown', keyHandler);
                                } else if (e.key === 'ArrowLeft' && currentIndex > 0) {
                                    currentIndex--;
                                    updateLightbox();
                                } else if (e.key === 'ArrowRight' && currentIndex < photoElements.length - 1) {
                                    currentIndex++;
                                    updateLightbox();
                                }
                            });
                        });
                        
                        photosGrid.appendChild(photoDiv);
                        console.log('Photo added to grid');
                    });
                } else {
                    // Show placeholder if no photos found
                    console.log('No photos found, showing placeholder');
                    photosGrid.innerHTML = `
                        <div style="grid-column: 1/-1; text-align: center; padding: 3rem; color: var(--text-main);">
                            <p>No photos found for this gallery.</p>
                        </div>
                    `;
                }
                
                // Show modal
                modal.classList.add('active');
                console.log('Modal active class added. Modal classList:', modal.classList);
                console.log('Photos grid HTML:', photosGrid.innerHTML.substring(0, 200));
            });
        });
    }
    
    // === CONSOLE EASTER EGG ===
    console.log('%c fr3akazo1d ', 'background: #ff003c; color: #00fff7; font-size: 20px; font-weight: bold; padding: 10px;');
    console.log('%c Root is not a privilege. It\'s a mindset. ', 'background: #00fff7; color: #10141a; font-size: 14px; padding: 5px;');
    console.log('%c Looking for something? Check out my GitHub: https://github.com/fr3akazo1d ', 'color: #c0c0c0; font-size: 12px;');
});

// === PERFORMANCE MONITORING ===
window.addEventListener('load', () => {
    const loadTime = window.performance.timing.domContentLoadedEventEnd - window.performance.timing.navigationStart;
    console.log(`Page loaded in ${loadTime}ms`);
});

// === EASTER EGGS ===
console.log('%c🎮 Easter eggs loaded! Try: Konami Code, typing "root", or triple-clicking the logo', 'color: #39ff14; font-size: 12px;');

// 1. Konami Code Easter Egg
let konamiCode = [];
const konamiSequence = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'];

document.addEventListener('keydown', (e) => {
    konamiCode.push(e.key);
    konamiCode = konamiCode.slice(-10);
    
    console.log('Key pressed:', e.key, '| Sequence:', konamiCode.join(''));
    
    if (konamiCode.join('') === konamiSequence.join('')) {
        activateKonamiMode();
    }
});

function activateKonamiMode() {
    console.log('%c🎮 KONAMI CODE ACTIVATED! 🎮', 'background: #39ff14; color: #10141a; font-size: 20px; font-weight: bold; padding: 10px;');
    
    // Create matrix rain effect
    const canvas = document.createElement('canvas');
    canvas.style.position = 'fixed';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.width = '100%';
    canvas.style.height = '100%';
    canvas.style.zIndex = '99999';
    canvas.style.pointerEvents = 'none';
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    document.body.appendChild(canvas);
    
    const ctx = canvas.getContext('2d');
    const chars = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
    const fontSize = 16;
    const columns = canvas.width / fontSize;
    const drops = Array(Math.floor(columns)).fill(1);
    
    let frameCount = 0;
    const maxFrames = 300; // 6 seconds at 50fps
    
    const interval = setInterval(() => {
        ctx.fillStyle = 'rgba(16, 20, 26, 0.05)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = '#00fff7';
        ctx.font = fontSize + 'px monospace';
        
        for (let i = 0; i < drops.length; i++) {
            const text = chars[Math.floor(Math.random() * chars.length)];
            ctx.fillText(text, i * fontSize, drops[i] * fontSize);
            
            if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
                drops[i] = 0;
            }
            drops[i]++;
        }
        
        frameCount++;
        if (frameCount >= maxFrames) {
            clearInterval(interval);
            canvas.style.opacity = '0';
            canvas.style.transition = 'opacity 1s';
            setTimeout(() => canvas.remove(), 1000);
        }
    }, 50);
    
    // Show message
    const message = document.createElement('div');
    message.innerHTML = `
        <div style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); 
                    z-index: 100000; background: var(--bg-secondary); border: 2px solid var(--accent-cyan);
                    padding: 2rem; border-radius: 12px; text-align: center; font-family: 'JetBrains Mono', monospace;">
            <h2 style="color: var(--accent-green); font-size: 2rem; margin-bottom: 1rem;">🎮 Achievement Unlocked! 🎮</h2>
            <p style="color: var(--text-bright); font-size: 1.2rem;">You found the Konami Code!</p>
            <p style="color: var(--accent-cyan); margin-top: 1rem;">Matrix mode activated...</p>
        </div>
    `;
    document.body.appendChild(message);
    setTimeout(() => {
        message.style.opacity = '0';
        message.style.transition = 'opacity 1s';
        setTimeout(() => message.remove(), 1000);
    }, 3000);
    
    konamiCode = [];
}

// 2. Type "root" Easter Egg
let typedKeys = [];
const rootSequence = ['r', 'o', 'o', 't'];

document.addEventListener('keypress', (e) => {
    typedKeys.push(e.key.toLowerCase());
    typedKeys = typedKeys.slice(-4);
    
    if (typedKeys.join('') === rootSequence.join('')) {
        activateRootMode();
    }
});

function activateRootMode() {
    console.log('%c# ROOT ACCESS GRANTED #', 'background: #ff073a; color: #fff; font-size: 18px; font-weight: bold; padding: 10px;');
    
    const notification = document.createElement('div');
    notification.innerHTML = `
        <div style="position: fixed; top: 20px; right: 20px; z-index: 100000;
                    background: var(--bg-secondary); border: 2px solid var(--accent-red);
                    padding: 1.5rem; border-radius: 8px; font-family: 'JetBrains Mono', monospace;
                    box-shadow: 0 0 30px rgba(255, 7, 58, 0.5); animation: slideInRight 0.5s;">
            <div style="color: var(--accent-red); font-size: 1rem; margin-bottom: 0.5rem;">⚠️ ROOT ACCESS GRANTED ⚠️</div>
            <div style="color: var(--text-bright); font-size: 0.875rem;">fr3akazo1d@root:~# whoami</div>
            <div style="color: var(--accent-cyan); font-size: 0.875rem;">root</div>
        </div>
    `;
    
    const style = document.createElement('style');
    style.innerHTML = `
        @keyframes slideInRight {
            from { transform: translateX(400px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
    `;
    document.head.appendChild(style);
    
    document.body.appendChild(notification);
    
    // Flash screen red
    const overlay = document.createElement('div');
    overlay.style.position = 'fixed';
    overlay.style.top = '0';
    overlay.style.left = '0';
    overlay.style.width = '100%';
    overlay.style.height = '100%';
    overlay.style.background = 'rgba(255, 7, 58, 0.2)';
    overlay.style.zIndex = '99998';
    overlay.style.pointerEvents = 'none';
    document.body.appendChild(overlay);
    
    setTimeout(() => {
        overlay.style.opacity = '0';
        overlay.style.transition = 'opacity 0.5s';
        setTimeout(() => overlay.remove(), 500);
    }, 200);
    
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transition = 'opacity 0.5s';
        setTimeout(() => notification.remove(), 500);
    }, 5000);
    
    typedKeys = [];
}

// 3. Triple Click Logo Easter Egg
let logoClickCount = 0;
let logoClickTimer = null;

document.addEventListener('DOMContentLoaded', () => {
    const logo = document.querySelector('.logo');
    if (logo) {
        logo.addEventListener('click', () => {
            logoClickCount++;
            clearTimeout(logoClickTimer);
            
            if (logoClickCount === 3) {
                activateLogoEasterEgg();
                logoClickCount = 0;
            }
            
            logoClickTimer = setTimeout(() => {
                logoClickCount = 0;
            }, 500);
        });
    }
});

function activateLogoEasterEgg() {
    console.log('%c👾 LOGO EASTER EGG ACTIVATED! 👾', 'background: #39ff14; color: #10141a; font-size: 16px; padding: 8px;');
    
    // Spin and glow effect
    const logo = document.querySelector('.logo');
    const originalTransform = logo.style.transform;
    const originalFilter = logo.style.filter;
    
    logo.style.transition = 'all 1s ease';
    logo.style.transform = 'rotate(720deg) scale(1.5)';
    logo.style.filter = 'drop-shadow(0 0 30px var(--accent-cyan)) drop-shadow(0 0 60px var(--accent-green))';
    
    setTimeout(() => {
        logo.style.transform = originalTransform;
        logo.style.filter = originalFilter;
    }, 1000);
    
    // Show secret message
    const secret = document.createElement('div');
    secret.innerHTML = `
        <div style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
                    z-index: 100000; background: var(--bg-secondary); border: 2px solid var(--accent-green);
                    padding: 2rem; border-radius: 12px; text-align: center; font-family: 'JetBrains Mono', monospace;
                    box-shadow: 0 0 50px rgba(57, 255, 20, 0.4);">
            <h3 style="color: var(--accent-green); margin-bottom: 1rem;">🎯 Secret Found! 🎯</h3>
            <p style="color: var(--text-bright);">You're curious... I like that.</p>
            <p style="color: var(--accent-cyan); margin-top: 0.5rem; font-size: 0.875rem;">Try typing "root" or the Konami Code!</p>
        </div>
    `;
    document.body.appendChild(secret);
    
    setTimeout(() => {
        secret.style.opacity = '0';
        secret.style.transition = 'opacity 0.5s';
        setTimeout(() => secret.remove(), 500);
    }, 4000);
}

// 4. Console Message Easter Egg
console.log('%c🔍 HINT: Try triple-clicking the logo!', 'color: #39ff14; font-size: 12px; font-style: italic;');
