# 🎉 Your Site is Now Powered by Jekyll!

## ✅ What Changed?

Your fr3akazo1d website has been converted to Jekyll while keeping all your awesome design!

### New Files Created:

```
personal-website/
├── _config.yml                           # Jekyll configuration
├── _layouts/
│   ├── default.html                      # Main layout template
│   └── post.html                         # Blog post layout
├── _includes/
│   └── blog-posts.html                   # Auto-generates blog cards
├── _posts/
│   ├── 2025-10-28-building-custom-c2-framework.md  # Your blog post
│   └── TEMPLATE.md                       # Template for new posts
├── Gemfile                               # Ruby dependencies
└── setup-jekyll.sh                       # Setup script
```

### Updated Files:

- `index.html` - Now uses Jekyll frontmatter and includes
- Blog section - Auto-generates from `_posts/` directory

---

## 🚀 Quick Start

### 1. Install Jekyll

```bash
# Run the setup script
./setup-jekyll.sh
```

This will:
- Check Ruby installation
- Install Bundler
- Install Jekyll and dependencies

### 2. Start Development Server

```bash
# Start Jekyll
bundle exec jekyll serve

# Or with live reload (auto-refresh browser)
bundle exec jekyll serve --livereload
```

Open: http://localhost:4000

### 3. Create Your First Post

```bash
# Create a new blog post
nano _posts/2025-11-01-my-awesome-post.md
```

Add frontmatter and content:

```markdown
---
layout: post
title: My Awesome Red Team Technique
date: 2025-11-01
tags: [red-team, pentest, tools]
reading_time: 8 min read
description: Learn an awesome technique for red team operations
---

## Introduction

Your content here...
```

**Save the file** - Jekyll rebuilds automatically! 🎉

---

## 📝 New Blog Post Workflow

### Old Way (Manual):
```bash
# 1. Write Markdown
nano blog/my-post.md

# 2. Convert to HTML
python3 convert_blog.py blog/my-post.md

# 3. Add to index.html manually
nano index.html

# 4. Test and deploy
```

### New Way (Jekyll):
```bash
# 1. Create post file (filename must be YYYY-MM-DD-title.md)
nano _posts/2025-11-01-my-post.md

# 2. That's it! Jekyll does everything else automatically!
```

Jekyll will:
- ✅ Convert Markdown to HTML
- ✅ Apply your styling
- ✅ Add the post to your blog section
- ✅ Generate navigation
- ✅ Create RSS feed
- ✅ Handle all links automatically

---

## 📋 Post Filename Format

**IMPORTANT:** Posts must follow this naming convention:

```
YYYY-MM-DD-title-with-hyphens.md
```

Examples:
- ✅ `2025-11-01-building-red-team-infrastructure.md`
- ✅ `2025-10-28-custom-c2-framework.md`
- ❌ `my-post.md` (no date)
- ❌ `2025-11-01-my post.md` (spaces instead of hyphens)

---

## 🎨 Frontmatter Fields

Every post needs frontmatter at the top:

```yaml
---
layout: post                    # Always "post" for blog posts
title: Your Post Title          # Post title
date: 2025-11-01               # Publication date (YYYY-MM-DD)
tags: [tag1, tag2, tag3]       # Tags (first tag is primary)
reading_time: 10 min read      # Optional, estimated reading time
description: Brief description # Used for SEO and excerpts
author: fr3akazo1d             # Optional, defaults to site author
---
```

---

## 🛠️ Jekyll Commands

### Development

```bash
# Start server
bundle exec jekyll serve

# Start with live reload (auto-refresh)
bundle exec jekyll serve --livereload

# Include draft posts
bundle exec jekyll serve --drafts

# Custom port
bundle exec jekyll serve --port 8080

# Watch for changes (default)
bundle exec jekyll serve --watch
```

### Build

```bash
# Build site (output to _site/)
bundle exec jekyll build

# Build for production
JEKYLL_ENV=production bundle exec jekyll build
```

### Clean

```bash
# Remove built files
bundle exec jekyll clean
```

---

## 📂 Directory Structure

```
personal-website/
├── _config.yml           # Jekyll configuration
├── _layouts/             # Page templates
│   ├── default.html     # Base layout
│   └── post.html        # Blog post layout
├── _includes/            # Reusable components
│   └── blog-posts.html  # Blog card generator
├── _posts/               # Blog posts (Markdown)
│   └── YYYY-MM-DD-title.md
├── _site/                # Generated site (don't edit!)
├── _drafts/              # Unpublished posts (optional)
├── assets/               # Static files
├── css/                  # Stylesheets
├── js/                   # JavaScript
├── index.html            # Homepage
├── Gemfile               # Ruby dependencies
└── _config.yml           # Site configuration
```

---

## ✍️ Writing Posts

### Markdown Basics

```markdown
# H1 Heading
## H2 Heading
### H3 Heading

**bold text**
*italic text*
`inline code`

[link text](https://example.com)

![image alt](path/to/image.png)

> Blockquote

- List item 1
- List item 2

1. Numbered item
2. Numbered item

---  (horizontal rule)
```

### Code Blocks

````markdown
```python
def hello():
    print("Hello, world!")
```

```bash
echo "Shell commands"
ls -la
```
````

### Tables

```markdown
| Column 1 | Column 2 |
|----------|----------|
| Data 1   | Data 2   |
```

---

## 🚀 Deployment

### GitHub Pages (Automatic)

Jekyll is built into GitHub Pages! Just push:

```bash
git add .
git commit -m "Add new blog post"
git push
```

GitHub Pages will:
1. Detect Jekyll files
2. Build your site automatically
3. Deploy in 1-2 minutes

**No manual build needed!** 🎉

### Local Preview Before Deploy

```bash
# Always test locally first
bundle exec jekyll serve

# Check http://localhost:4000

# Then push
git add .
git commit -m "Update site"
git push
```

---

## 🎯 Quick Comparison

| Task | Before (Manual) | After (Jekyll) |
|------|-----------------|----------------|
| Create post | 3 files to edit | 1 file to create |
| Convert MD→HTML | Manual script | Automatic |
| Update index.html | Manual edit | Automatic |
| Test changes | Reload page | Auto-reload |
| Deploy | Push files | Push files |
| Build process | Manual | Automatic |

---

## 🔧 Configuration

### Site Settings (_config.yml)

```yaml
title: fr3akazo1d
email: philipp@fr3akazo1d.dev
description: Your description
url: https://fr3akazo1d.github.io
```

### Customize

Want to change something? Edit:
- `_config.yml` - Site settings
- `_layouts/` - Page templates
- `_includes/` - Reusable components
- `css/` - Styles (unchanged!)
- `js/` - JavaScript (unchanged!)

---

## 📝 Creating Drafts

Create posts in `_drafts/` folder without dates:

```bash
# Create draft
mkdir -p _drafts
nano _drafts/my-draft-post.md

# Preview drafts
bundle exec jekyll serve --drafts

# Publish: move to _posts with date
mv _drafts/my-draft-post.md _posts/2025-11-01-my-draft-post.md
```

---

## 🆘 Troubleshooting

### "bundle: command not found"

```bash
gem install bundler
```

### "Could not locate Gemfile"

```bash
# Make sure you're in the project directory
cd /home/fr3akazo1d/personal-website
```

### Posts not showing up

1. Check filename format: `YYYY-MM-DD-title.md`
2. Check frontmatter has `layout: post`
3. Check date is not in the future
4. Restart Jekyll: `Ctrl+C` then `bundle exec jekyll serve`

### Changes not reflecting

```bash
# Restart Jekyll
Ctrl+C
bundle exec jekyll serve --livereload
```

### Port already in use

```bash
# Use different port
bundle exec jekyll serve --port 4001
```

---

## 💡 Pro Tips

1. **Use live reload:** `bundle exec jekyll serve --livereload`
2. **Create post template:** Copy `_posts/TEMPLATE.md`
3. **Draft first:** Use `_drafts/` for work-in-progress
4. **Test locally:** Always preview before pushing
5. **Commit often:** Small, frequent commits are better
6. **SEO:** Fill out description in frontmatter
7. **Tags:** First tag becomes primary tag on cards

---

## 📚 Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages + Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll)
- [Liquid Template Language](https://shopify.github.io/liquid/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Jekyll Themes](https://jekyllthemes.io/)

---

## ✅ What You Kept

- ✅ All your custom CSS (glitch effects, neon colors)
- ✅ All your JavaScript (custom cursor, animations)
- ✅ All your HTML structure
- ✅ All your design and branding
- ✅ All your existing content

## ✅ What You Gained

- ✅ Automatic Markdown → HTML conversion
- ✅ Auto-generated blog listings
- ✅ Built-in template system
- ✅ RSS feed generation
- ✅ SEO optimization
- ✅ Simpler workflow
- ✅ No manual HTML editing
- ✅ GitHub Pages auto-build

---

## 🎉 You're Ready!

Your Jekyll site is fully configured and ready to go!

**Next steps:**

1. Run `./setup-jekyll.sh` to install dependencies
2. Run `bundle exec jekyll serve` to start development
3. Create your first post in `_posts/`
4. Watch it appear automatically on your site!

**Happy blogging with Jekyll!** 💀🚀

---

*"Root is not a privilege. It's a mindset."*
