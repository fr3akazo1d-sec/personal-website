# Jekyll Conversion Guide for fr3akazo1d Website

## 🎯 Why Jekyll?

Jekyll is GitHub Pages' native static site generator:
- ✅ Built-in Markdown support
- ✅ Automatic blog post generation
- ✅ Template system (Liquid)
- ✅ No build step needed on GitHub Pages
- ✅ Collections and pagination
- ✅ Easy blog management

## 🚀 Quick Setup (Choose Your Path)

### Option A: Keep Current Design, Add Jekyll (Recommended)

This approach keeps your existing design and adds Jekyll's blog features.

### Option B: Full Jekyll Site

Complete rebuild using Jekyll's structure and conventions.

---

## 📦 Option A: Hybrid Approach (Easiest)

Keep your current design, add Jekyll for blog management only.

### Step 1: Create Jekyll Configuration

Create `_config.yml`:

```yaml
# Site settings
title: fr3akazo1d
email: philipp@fr3akazo1d.dev
description: >
  Root is not a privilege. It's a mindset.
  Red Team Operator & Security Researcher
baseurl: "" # empty for user page, "/repo-name" for project page
url: "https://fr3akazo1d.github.io"

# Build settings
markdown: kramdown
permalink: /blog/:title/

# Collections
collections:
  posts:
    output: true
    permalink: /blog/:title/

# Exclude from build
exclude:
  - convert_blog.py
  - quickstart.sh
  - README.md
  - DEPLOYMENT.md
  - Gemfile
  - Gemfile.lock

# Defaults
defaults:
  - scope:
      path: ""
      type: "posts"
    values:
      layout: "post"
```

### Step 2: Create Gemfile

```bash
# Create Gemfile
cat > Gemfile << 'EOF'
source "https://rubygems.org"

gem "github-pages", group: :jekyll_plugins
gem "webrick"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
end
EOF
```

### Step 3: Restructure for Jekyll

```bash
# Create Jekyll directories
mkdir -p _layouts _includes _posts assets/images

# Move blog posts to Jekyll format
# Posts must be named: YYYY-MM-DD-title.md
```

### Step 4: Create Post Layout

Create `_layouts/post.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{{ page.description | default: page.excerpt }}">
    <title>{{ page.title }} | fr3akazo1d</title>
    <link rel="stylesheet" href="{{ '/css/style.css' | relative_url }}">
    <link rel="stylesheet" href="{{ '/css/blog.css' | relative_url }}">
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="cursor"></div>
    <div class="cursor-follower"></div>

    <nav class="nav-menu">
        <ul>
            <li><a href="{{ '/' | relative_url }}" class="nav-link">← Back to Home</a></li>
            <li><a href="{{ '/#blog' | relative_url }}" class="nav-link">Blog</a></li>
            <li><a href="{{ '/#contact' | relative_url }}" class="nav-link">Contact</a></li>
        </ul>
    </nav>

    <article class="blog-post">
        <header class="post-header">
            <h1 class="post-title glitch" data-text="{{ page.title }}">{{ page.title }}</h1>
            <div class="post-meta">
                <span class="post-date">[{{ page.date | date: "%Y-%m-%d" }}]</span>
                <span class="post-tag">#{{ page.tags | first }}</span>
                <span class="post-reading-time">{{ page.reading_time | default: "5 min read" }}</span>
            </div>
            <div class="post-author">
                <span>by <strong>fr3akazo1d</strong></span>
            </div>
        </header>

        <div class="post-content">
            {{ content }}
        </div>

        <footer class="post-footer">
            <div class="post-tags">
                {% for tag in page.tags %}
                <a href="#" class="tag">#{{ tag }}</a>
                {% endfor %}
            </div>

            <div class="post-share">
                <h3>Share this post</h3>
                <div class="share-buttons">
                    <a href="https://twitter.com/intent/tweet?text={{ page.title }}&url={{ page.url | absolute_url }}" class="share-btn">Twitter</a>
                    <a href="https://www.linkedin.com/sharing/share-offsite/?url={{ page.url | absolute_url }}" class="share-btn">LinkedIn</a>
                    <a href="https://reddit.com/submit?url={{ page.url | absolute_url }}&title={{ page.title }}" class="share-btn">Reddit</a>
                </div>
            </div>

            <a href="{{ '/#blog' | relative_url }}" class="back-to-blog">← Back to all posts</a>
        </footer>
    </article>

    <script src="{{ '/js/main.js' | relative_url }}"></script>
</body>
</html>
```

### Step 5: Create Default Layout

Create `_layouts/default.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% if page.title %}{{ page.title }} | {% endif %}fr3akazo1d</title>
    <link rel="stylesheet" href="{{ '/css/style.css' | relative_url }}">
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    {{ content }}
    <script src="{{ '/js/main.js' | relative_url }}"></script>
</body>
</html>
```

### Step 6: Convert index.html

Add frontmatter to `index.html`:

```html
---
layout: default
---

<!-- Your existing index.html content without <html>, <head>, <body> tags -->
```

### Step 7: Create Blog Include

Create `_includes/blog-posts.html`:

```html
{% for post in site.posts limit: 4 %}
<article class="blog-card">
    <div class="card-header">
        <span class="card-date">[{{ post.date | date: "%Y-%m-%d" }}]</span>
        <span class="card-tag">#{{ post.tags | first }}</span>
    </div>
    <h3 class="card-title">{{ post.title }}</h3>
    <p class="card-excerpt">
        {{ post.description | default: post.excerpt | strip_html | truncate: 150 }}
    </p>
    <a href="{{ post.url | relative_url }}" class="card-link">Read more <span class="arrow">→</span></a>
</article>
{% endfor %}
```

### Step 8: Create Blog Posts

Create posts in `_posts/` directory with this naming:

```
_posts/2025-11-01-building-custom-c2-framework.md
_posts/2025-10-15-bypassing-edr-techniques.md
```

Each post should have frontmatter:

```markdown
---
layout: post
title: Building a Custom C2 Framework
date: 2025-11-01
tags: [red-team, c2, adversary-emulation]
reading_time: 15 min read
description: Deep dive into designing a modular C2 infrastructure
---

Your content here...
```

### Step 9: Local Development

```bash
# Install dependencies
bundle install

# Run locally
bundle exec jekyll serve

# Visit: http://localhost:4000
```

### Step 10: Deploy to GitHub Pages

```bash
# Just push - GitHub Pages builds automatically!
git add .
git commit -m "Convert to Jekyll"
git push
```

---

## 📦 Option B: Full Jekyll Site from Scratch

Complete Jekyll setup with proper structure.

### Step 1: Initialize Jekyll

```bash
# Install Jekyll
gem install jekyll bundler

# Create new Jekyll site (in a temp directory)
jekyll new temp-jekyll
cd temp-jekyll

# Copy structure to your project
cp -r _layouts _includes Gemfile _config.yml /home/fr3akazo1d/personal-website/
```

### Step 2: Reorganize Files

```bash
# Jekyll structure
personal-website/
├── _config.yml           # Jekyll configuration
├── _layouts/             # Page layouts
│   ├── default.html
│   ├── post.html
│   └── page.html
├── _includes/            # Reusable components
│   ├── header.html
│   ├── footer.html
│   └── blog-posts.html
├── _posts/               # Blog posts (YYYY-MM-DD-title.md)
│   └── 2025-11-01-post.md
├── _sass/                # Sass partials
│   ├── _base.scss
│   └── _layout.scss
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
├── index.html            # Homepage
├── blog.html             # Blog listing page
└── Gemfile               # Ruby dependencies
```

---

## 🎯 Recommended Approach

I recommend **Option A (Hybrid)** because:

1. ✅ Keep your existing design
2. ✅ Add Jekyll blog management
3. ✅ Automatic blog post listing
4. ✅ GitHub Pages builds automatically
5. ✅ Easy Markdown workflow
6. ✅ No major restructuring needed

---

## 🛠️ Step-by-Step: Convert Your Current Site

Want me to convert your current site to Jekyll? I can:

1. Create the Jekyll configuration files
2. Set up the layout templates
3. Convert your existing blog post to Jekyll format
4. Update index.html to use Jekyll includes
5. Create a blog listing page
6. Set up local development environment

Just say the word and I'll do it! 🚀

---

## 📚 Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages + Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll)
- [Jekyll Themes](https://jekyllthemes.io/)
- [Liquid Template Language](https://shopify.github.io/liquid/)

---

**Want me to convert your site to Jekyll now?** 

Just let me know and I'll set it all up for you! 💀
