# Cleanup Recommendations for Personal Website

## 📊 Current Status
Your Jekyll site is fully functional. Here's what can be safely deleted vs. what should be kept.

---

## ✅ KEEP THESE - Essential Files

### Core Jekyll Files
- `_config.yml` - Jekyll configuration
- `Gemfile` - Ruby dependencies
- `Gemfile.lock` - Locked gem versions
- `.gitignore` - Git ignore rules
- `index.html` - Main homepage

### Layouts & Includes
- `_layouts/` folder - Template files (default.html, post.html)
- `_includes/` folder - Reusable components (blog-posts.html)

### Content
- `_posts/` folder - Blog posts (Markdown files)
- `_data/` folder - Data files (projects.yml, skills.yml, career.yml)
- `tags.html` - Tags page

### Assets
- `css/` folder - Stylesheets (style.css, blog.css)
- `js/` folder - JavaScript files (main.js)
- `assets/images/avatar.png` - Your avatar image
- `assets/images/README.md` - Avatar instructions

### Documentation (Optional but Useful)
- `README.md` - Main project documentation
- `DEPLOYMENT.md` - Deployment instructions

### Build Output (Auto-generated)
- `_site/` folder - Jekyll build output (git-ignored, regenerated on build)

---

## 🗑️ CAN DELETE - Obsolete Files

### Old Blog System (Replaced by Jekyll)
```bash
rm -rf blog/
```
**Contains:**
- `building-custom-c2-framework.html` - Old HTML version (now in `_posts/`)
- `template.html` - Old HTML template (replaced by `_layouts/post.html`)
- `template.md` - Old Markdown template (replaced by `_posts/TEMPLATE.md`)
- `MARKDOWN_GUIDE.md` - Redundant documentation
- `QUICK_REFERENCE.md` - Redundant documentation
- `README.md` - Outdated blog documentation

### Python Conversion Script (No Longer Needed)
```bash
rm convert_blog.py
```
This was only used once to convert old blog files to Jekyll format.

### One-Time Setup Scripts
```bash
rm quickstart.sh
rm setup-jekyll.sh
```
These were used for initial setup and aren't needed anymore.

### Redundant Documentation
```bash
rm JEKYLL_SETUP.md
rm LAUNCH_CHECKLIST.md
rm PROJECT_SUMMARY.md
rm START_HERE.md
rm JEKYLL_CONVERTED.md
rm AVATAR_GLITCH_UPDATES.md
rm CLEANUP_GUIDE.md
```
These were progress/setup documents. Keep only `README.md` and `DEPLOYMENT.md`.

### Empty Asset Folders
```bash
rmdir assets/avatar/
rmdir assets/icons/
rmdir assets/logo/
rmdir assets/wallpapers/
```
These are empty placeholder directories.

---

## 🧹 Complete Cleanup Commands

Run these commands from the project root:

```bash
# Navigate to project
cd /home/fr3akazo1d/personal-website

# Remove old blog folder
rm -rf blog/

# Remove obsolete scripts
rm convert_blog.py quickstart.sh setup-jekyll.sh

# Remove redundant documentation
rm JEKYLL_SETUP.md LAUNCH_CHECKLIST.md PROJECT_SUMMARY.md START_HERE.md
rm JEKYLL_CONVERTED.md AVATAR_GLITCH_UPDATES.md CLEANUP_GUIDE.md

# Remove empty asset folders
rmdir assets/avatar/ assets/icons/ assets/logo/ assets/wallpapers/

# Remove this file after cleanup
rm CLEANUP_RECOMMENDATIONS.md
```

---

## 📁 Final Structure After Cleanup

```
personal-website/
├── _config.yml           # Jekyll config
├── _data/               # Data files
│   ├── career.yml
│   ├── projects.yml
│   └── skills.yml
├── _includes/           # Reusable components
│   └── blog-posts.html
├── _layouts/            # Page templates
│   ├── default.html
│   └── post.html
├── _posts/              # Blog posts
│   ├── TEMPLATE.md
│   └── *.md
├── _site/               # Build output (auto-generated)
├── assets/              # Static assets
│   ├── images/
│   │   ├── avatar.png
│   │   └── README.md
│   └── README.md
├── css/                 # Stylesheets
│   ├── blog.css
│   └── style.css
├── js/                  # JavaScript
│   └── main.js
├── DEPLOYMENT.md        # Deployment guide
├── Gemfile              # Ruby dependencies
├── Gemfile.lock         # Locked versions
├── .gitignore           # Git ignore
├── index.html           # Homepage
├── README.md            # Project documentation
└── tags.html            # Tags page
```

---

## ⚠️ Before Deleting

1. **Backup first** (optional):
   ```bash
   cd /home/fr3akazo1d
   tar -czf personal-website-backup.tar.gz personal-website/
   ```

2. **Test your site** after cleanup:
   ```bash
   cd /home/fr3akazo1d/personal-website
   sudo bundle exec jekyll serve --livereload
   ```

3. **Verify** everything still works at http://localhost:4000

---

## 📊 Space Savings

Estimated disk space recovered:
- `blog/` folder: ~40 KB
- Scripts & docs: ~80 KB
- **Total: ~120 KB**

---

## 🚀 Next Steps

After cleanup:
1. Commit changes to git
2. Push to GitHub
3. Deploy to GitHub Pages (see DEPLOYMENT.md)
4. Delete this file: `rm CLEANUP_RECOMMENDATIONS.md`
