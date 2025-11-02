# File Cleanup Report for Personal Website

## ✅ **REQUIRED FILES - KEEP THESE**

### Core Jekyll Files
- **_config.yml** - Jekyll configuration (REQUIRED)
- **Gemfile** - Ruby dependencies (REQUIRED)
- **Gemfile.lock** - Dependency lock file (REQUIRED, auto-generated)
- **index.html** - Homepage (REQUIRED)
- **tags.html** - Tags page (REQUIRED)

### Directories
- **_layouts/** - Jekyll layout templates (REQUIRED)
  - default.html
  - post.html
  
- **_includes/** - Reusable components (REQUIRED)
  - blog-posts.html
  
- **_posts/** - Blog posts in Markdown (REQUIRED)
  - 2025-10-28-building-custom-c2-framework.md
  - 2025-10-29-testing-new-post.md
  - TEMPLATE.md (useful reference)
  
- **_data/** - Data files (REQUIRED)
  - projects.yml
  
- **css/** - Stylesheets (REQUIRED)
  - style.css
  - blog.css
  
- **js/** - JavaScript files (REQUIRED)
  - main.js
  
- **assets/** - Images, fonts, etc. (REQUIRED if you have any)

- **_site/** - Generated site (auto-created, in .gitignore)

### Useful Documentation
- **README.md** - Main project documentation (KEEP)
- **DEPLOYMENT.md** - How to deploy to GitHub Pages (KEEP)
- **JEKYLL_CONVERTED.md** - Jekyll conversion guide (KEEP)
- **.gitignore** - Git ignore rules (KEEP)

---

## ❌ **CAN BE DELETED - Obsolete Files**

### Old Blog System (Pre-Jekyll)
These were used before Jekyll conversion and are now obsolete:

📁 **blog/** folder - ENTIRE FOLDER CAN BE DELETED
- ❌ building-custom-c2-framework.html (old HTML version, now in _posts/)
- ❌ template.html (obsolete, use _posts/TEMPLATE.md instead)
- ❌ template.md (obsolete, use _posts/TEMPLATE.md instead)
- ❌ MARKDOWN_GUIDE.md (can keep if useful, but outdated)
- ❌ QUICK_REFERENCE.md (can keep if useful, but outdated)
- ❌ README.md (outdated instructions)

### Old Conversion Script
- ❌ **convert_blog.py** - No longer needed (Jekyll handles Markdown conversion)

### Duplicate/Old Setup Scripts
- ❌ **quickstart.sh** - Superseded by setup-jekyll.sh
- ❌ **setup-jekyll.sh** - Only needed for initial setup (can delete after setup complete)

### Redundant Documentation
- ❌ **JEKYLL_SETUP.md** - Info now in JEKYLL_CONVERTED.md
- ❌ **LAUNCH_CHECKLIST.md** - One-time checklist, can archive
- ❌ **PROJECT_SUMMARY.md** - One-time summary, can archive
- ❌ **START_HERE.md** - One-time guide, can archive

---

## 📋 **COMMANDS TO CLEAN UP**

```bash
# Delete old blog folder (posts are now in _posts/)
rm -rf blog/

# Delete old Python conversion script
rm convert_blog.py

# Delete old/redundant scripts
rm quickstart.sh
rm setup-jekyll.sh  # Only if Jekyll is already installed

# Delete redundant documentation
rm JEKYLL_SETUP.md
rm LAUNCH_CHECKLIST.md
rm PROJECT_SUMMARY.md
rm START_HERE.md

# Optional: Create an archive folder for documentation
mkdir archive
mv JEKYLL_SETUP.md LAUNCH_CHECKLIST.md PROJECT_SUMMARY.md START_HERE.md archive/
```

---

## 📁 **FINAL MINIMAL STRUCTURE**

After cleanup, your site should look like:

```
personal-website/
├── _config.yml          # Jekyll config
├── _data/
│   └── projects.yml     # Projects data
├── _includes/
│   └── blog-posts.html  # Blog posts include
├── _layouts/
│   ├── default.html     # Main layout
│   └── post.html        # Blog post layout
├── _posts/              # Blog posts (Markdown)
│   ├── 2025-10-28-building-custom-c2-framework.md
│   ├── 2025-10-29-testing-new-post.md
│   └── TEMPLATE.md
├── _site/               # Generated site (auto-created)
├── assets/              # Images, etc.
├── css/
│   ├── style.css
│   └── blog.css
├── js/
│   └── main.js
├── .gitignore
├── Gemfile
├── Gemfile.lock
├── index.html           # Homepage
├── tags.html            # Tags page
├── README.md            # Main docs
├── DEPLOYMENT.md        # Deployment guide
└── JEKYLL_CONVERTED.md  # Jekyll guide
```

---

## 🎯 **RECOMMENDATION**

**Safe cleanup command (run from personal-website directory):**

```bash
# Create backup first (optional but recommended)
tar -czf ../website-backup-$(date +%Y%m%d).tar.gz .

# Delete obsolete files
rm -rf blog/
rm convert_blog.py quickstart.sh

# Move old documentation to archive
mkdir -p archive
mv JEKYLL_SETUP.md LAUNCH_CHECKLIST.md PROJECT_SUMMARY.md START_HERE.md archive/ 2>/dev/null

echo "✅ Cleanup complete!"
```

This removes ~40KB of obsolete files and makes your project cleaner and easier to maintain.
