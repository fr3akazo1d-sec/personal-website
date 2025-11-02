---
layout: post
title: "Building My Personal Website: A Technical Journey"
date: 2025-11-02
categories: [web-development, jekyll, portfolio]
tags: [jekyll, web-design, static-site, github-pages, javascript, css]
author: Fr3akaz01d
description: "A comprehensive documentation of building a cybersecurity-themed personal website using Jekyll, including custom features, automation scripts, and design decisions."
---

# Building My Personal Website: A Technical Journey

## Introduction

As a cybersecurity professional, having a strong online presence is essential. I decided to build a personal website that not only showcases my work and skills but also reflects my passion for hacking culture and terminal aesthetics. This post documents the entire journey of creating this website from scratch.

## Technology Stack

### Core Technologies
- **Jekyll 4.x**: Static site generator for easy content management
- **Liquid Templates**: Dynamic content generation
- **HTML5/CSS3**: Modern web standards
- **JavaScript (Vanilla)**: No frameworks, pure JS for performance
- **GitHub Pages**: Free hosting with CI/CD

### Design Philosophy
- **Terminal/Hacker Aesthetic**: Monospace fonts, green/cyan color scheme
- **Minimalist**: Focus on content over decoration
- **Responsive**: Mobile-first design approach
- **Performance**: Static generation for fast load times

## Project Structure

```
personal-website/
├── _config.yml              # Jekyll configuration
├── _data/
│   ├── conferences.yml      # Conference attendance data
│   └── gallery.yml          # Photo gallery configuration
├── _includes/               # Reusable HTML components
├── _layouts/
│   ├── default.html         # Base layout
│   └── post.html           # Blog post layout
├── _posts/                  # Blog posts (Markdown)
├── assets/
│   ├── images/
│   │   └── gallery/        # Event photos
│   └── pdf/                # Downloadable files
├── css/
│   ├── style.css           # Main stylesheet (~2856 lines)
│   └── blog.css            # Blog-specific styles
├── js/
│   └── main.js             # Interactive features (~674 lines)
├── add_gallery.sh          # Gallery automation script
├── gallery.html            # Gallery page
├── conferences.html        # Conferences page
└── index.html              # Homepage
```

## Key Features Implementation

### 1. Custom Cursor Effect

One of the signature features is a custom cursor with a following dot effect:

**CSS Implementation:**
```css
.cursor {
    width: 20px;
    height: 20px;
    border: 2px solid var(--accent-cyan);
    border-radius: 50%;
    position: fixed;
    pointer-events: none;
    z-index: 99999;
    transition: 0.1s;
}

.cursor-follower {
    width: 8px;
    height: 8px;
    background: var(--accent-cyan);
    border-radius: 50%;
    position: fixed;
    pointer-events: none;
    z-index: 99998;
    transition: 0.15s;
}
```

**JavaScript Tracking:**
```javascript
const cursor = document.querySelector('.cursor');
const cursorFollower = document.querySelector('.cursor-follower');

document.addEventListener('mousemove', (e) => {
    cursor.style.left = e.clientX + 'px';
    cursor.style.top = e.clientY + 'px';
    
    setTimeout(() => {
        cursorFollower.style.left = e.clientX + 'px';
        cursorFollower.style.top = e.clientY + 'px';
    }, 100);
});
```

### 2. Interactive Gallery System

The gallery system was one of the most complex features to implement.

#### Gallery Structure
- Photo galleries organized by events (conferences, workshops)
- YAML-based configuration for easy management
- Automated script for adding new galleries

#### Features:
- **Grid View**: Responsive photo grid with hover effects
- **Modal Viewer**: Click to open full gallery in modal
- **Lightbox**: Fullscreen photo viewing with navigation
- **Keyboard Controls**: Arrow keys and Escape for navigation
- **Photo Counter**: Shows current position (e.g., "1 / 44")

#### Gallery Automation Script

Created `add_gallery.sh` to automate gallery creation:

```bash
#!/bin/bash
# Features:
# - Looks for dedicated cover.jpg/jpeg/png
# - If found: Uses as cover, includes ALL photos
# - If not found: Uses first photo as cover
# - Sequential photo naming (photo-001, photo-002, etc.)
# - Automatic YAML generation with proper formatting
```

**Usage:**
```bash
./add_gallery.sh
# Interactive prompts for:
# - Gallery name
# - Date
# - Location
# - Description
# - Source folder path
```

### 3. Navigation System

Implemented a fixed navigation menu with:
- Smooth scrolling to sections
- Active state highlighting
- Mobile hamburger menu
- Hash-based anchor links

**Challenge:** External page navigation to homepage anchors didn't work initially.

**Solution:** JavaScript hash detection on page load:
```javascript
window.addEventListener('DOMContentLoaded', () => {
    if (window.location.hash) {
        setTimeout(() => {
            const target = document.querySelector(window.location.hash);
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
            }
        }, 100);
    }
});
```

### 4. Blog System

Implemented using Jekyll's built-in blog functionality:
- Markdown-based posts
- Category and tag support
- Syntax highlighting for code
- Responsive reading layout (1100px max-width)
- Custom blog.css for optimal readability

### 5. Conferences Timeline

Created a dedicated conferences page:
- Chronological event listing
- Year grouping
- Event details (name, location, date, type)
- Links to conference websites

## Design Decisions

### Color Scheme
```css
:root {
    --bg-main: #10141a;
    --bg-secondary: #1a1f2e;
    --accent-cyan: #00fff7;
    --accent-green: #39ff14;
    --accent-red: #ff073a;
    --text-bright: #e0e0e0;
    --text-dim: #8a8a8a;
}
```

Inspired by terminal colors and cyberpunk aesthetics.

### Typography
- **Primary Font**: JetBrains Mono (monospace)
- **Fallback**: Courier New, monospace
- Enhances the terminal/hacker theme

### Spacing System
```css
:root {
    --spacing-xs: 0.5rem;
    --spacing-sm: 1rem;
    --spacing-md: 2rem;
    --spacing-lg: 3rem;
    --spacing-xl: 4rem;
}
```

Consistent spacing throughout the site.

## Challenges & Solutions

### Challenge 1: YAML Formatting in Bash Script
**Problem:** Script generated literal `\n` characters instead of newlines in YAML.

**Solution:** Use `$'\n'` syntax for proper newline handling:
```bash
PHOTO_ENTRIES+=$'      - image: /'"$PATH"$'\n'
```

### Challenge 2: Gallery Modal Cutting Off Top Photos
**Problem:** Modal with `align-items: center` cut off first 8 photos when content was taller than viewport.

**Solution:** Changed to `align-items: flex-start` to align content to top.

### Challenge 3: Cursor Z-Index Issues
**Problem:** Custom cursor appeared behind modals.

**Solution:** Increased cursor z-index to 99999, higher than modal (10001).

### Challenge 4: Back-to-Top Button Null Reference
**Problem:** Button element didn't exist on all pages, causing JavaScript errors.

**Solution:** Added null check:
```javascript
if (backToTopBtn) {
    // Add event listeners
}
```

## Performance Optimizations

1. **Lazy Loading**: Images load only when needed
2. **Static Generation**: Jekyll pre-builds all pages
3. **Minimal JavaScript**: ~674 lines, no external libraries
4. **CSS Bundling**: Single stylesheet minimizes HTTP requests
5. **Image Optimization**: JPEG compression for gallery photos

## Deployment

### Local Development
```bash
bundle exec jekyll serve --livereload --host 0.0.0.0
```

### Production
- Hosted on GitHub Pages
- Automatic deployment on git push
- Custom domain support available

## Maintenance

### Adding New Content

**Blog Posts:**
```bash
cd _posts
touch YYYY-MM-DD-post-title.md
```

**Gallery:**
```bash
./add_gallery.sh
```

**Conferences:**
Edit `_data/conferences.yml` directly.

## Statistics

- **Total CSS**: ~2856 lines
- **Total JavaScript**: ~674 lines
- **Build Time**: ~1.6 seconds
- **Pages**: 5+ (Home, Gallery, Conferences, Blog, Tags)
- **Blog Posts**: Growing collection
- **Gallery Photos**: 47+ photos across multiple events

## Future Enhancements

- [ ] Search functionality for blog posts
- [ ] Dark/light theme toggle (currently dark only)
- [ ] Comments system integration
- [ ] RSS feed optimization
- [ ] Photo EXIF data display
- [ ] Thumbnail generation in gallery script
- [ ] Progressive Web App (PWA) support
- [ ] Analytics integration

## Lessons Learned

1. **Start Simple**: Begin with core features, add complexity gradually
2. **Automation Saves Time**: Scripts like `add_gallery.sh` pay off quickly
3. **Test Cross-Browser**: Different browsers handle CSS differently
4. **Mobile First**: Easier to scale up than scale down
5. **Document As You Go**: This post would be harder to write months later
6. **Version Control**: Git saved me multiple times during development
7. **User Feedback**: Real usage reveals issues you didn't anticipate

## Conclusion

Building this personal website was a rewarding project that combined technical skills with creative design. The terminal aesthetic reflects my passion for cybersecurity, while the clean structure ensures maintainability.

The site serves as both a portfolio and a learning platform, showcasing not just what I've done, but how I approach problems and implement solutions.

**Live Site:** [Your URL Here]  
**Source Code:** [GitHub Repository]

---

## Technical Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages](https://pages.github.com/)
- [Liquid Template Language](https://shopify.github.io/liquid/)
- [CSS Variables Guide](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)

## Acknowledgments

Thanks to the open-source community for the tools and inspiration that made this project possible.

---

*Last Updated: November 2, 2025*
