# GitHub Pages Deployment Guide

Step-by-step guide to deploying your fr3akazo1d personal website on GitHub Pages.

## 📋 Prerequisites

- GitHub account
- Git installed on your local machine
- Your website files ready

## 🚀 Deployment Steps

### Step 1: Create GitHub Repository

1. **Via GitHub Website:**
   - Go to https://github.com
   - Click the "+" icon in the top right
   - Select "New repository"
   - Name it: `personal-website` (or `your-username.github.io` for user page)
   - Set it to **Public**
   - **DO NOT** initialize with README (we already have one)
   - Click "Create repository"

2. **Via GitHub CLI:**
   ```bash
   gh repo create personal-website --public --source=. --remote=origin
   ```

### Step 2: Initialize Git and Push

Open your terminal in the project directory:

```bash
# Initialize Git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: fr3akazo1d personal website"

# Rename branch to main (if needed)
git branch -M main

# Add remote repository (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/personal-website.git

# Push to GitHub
git push -u origin main
```

### Step 3: Enable GitHub Pages

#### Method A: Via GitHub Website

1. Go to your repository on GitHub
2. Click **Settings** (gear icon)
3. Scroll down and click **Pages** in the left sidebar
4. Under **Source**, select:
   - Branch: `main`
   - Folder: `/ (root)`
5. Click **Save**
6. Wait 1-2 minutes for deployment
7. Your site will be live at: `https://YOUR_USERNAME.github.io/personal-website/`

#### Method B: Via GitHub CLI

```bash
gh repo edit --enable-pages --pages-branch main
```

### Step 4: Configure Custom Domain (Optional)

If you own a custom domain (e.g., `fr3akazo1d.dev`):

1. **In GitHub:**
   - Go to Settings → Pages
   - Under "Custom domain", enter your domain
   - Click Save
   - Enable "Enforce HTTPS"

2. **In Your DNS Provider:**
   
   **For Apex Domain (fr3akazo1d.dev):**
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
   
   Type: A
   Name: @
   Value: 185.199.109.153
   
   Type: A
   Name: @
   Value: 185.199.110.153
   
   Type: A
   Name: @
   Value: 185.199.111.153
   ```

   **For Subdomain (www.fr3akazo1d.dev):**
   ```
   Type: CNAME
   Name: www
   Value: YOUR_USERNAME.github.io
   ```

3. **Create CNAME file:**
   ```bash
   echo "fr3akazo1d.dev" > CNAME
   git add CNAME
   git commit -m "Add custom domain"
   git push
   ```

## 🔄 Updating Your Site

After making changes to your site:

```bash
# Check what files changed
git status

# Add changed files
git add .

# Commit with descriptive message
git commit -m "Update: description of changes"

# Push to GitHub
git push

# GitHub Pages will automatically rebuild (takes 1-2 minutes)
```

## 🛠️ Quick Update Commands

Create a file `update.sh` for quick updates:

```bash
#!/bin/bash
# Quick update script

echo "What did you change?"
read commit_message

git add .
git commit -m "$commit_message"
git push

echo "✅ Changes pushed! Site will update in 1-2 minutes."
```

Make it executable:
```bash
chmod +x update.sh
```

Use it:
```bash
./update.sh
```

## 📱 Testing Before Deployment

Always test locally before pushing:

```bash
# Using Python
python -m http.server 8000

# Using Node.js
npx http-server

# Using PHP
php -S localhost:8000
```

Then open: `http://localhost:8000`

## 🔍 Troubleshooting

### Issue: 404 Page Not Found

**Solution:**
1. Verify `index.html` is in the root directory
2. Check GitHub Pages is enabled in Settings
3. Wait 5 minutes for first deployment
4. Clear browser cache

### Issue: CSS/JS Not Loading

**Solution:**
1. Check file paths are relative (not absolute)
2. Verify file names match exactly (case-sensitive)
3. Check browser console for errors (F12)

```html
<!-- ✅ Correct (relative paths) -->
<link rel="stylesheet" href="css/style.css">
<script src="js/main.js"></script>

<!-- ❌ Incorrect (absolute paths) -->
<link rel="stylesheet" href="/css/style.css">
```

### Issue: Custom Domain Not Working

**Solution:**
1. Verify DNS records are set correctly (use `dig` command)
2. Wait 24-48 hours for DNS propagation
3. Check CNAME file exists in repository root
4. Enable "Enforce HTTPS" in GitHub Pages settings

```bash
# Check DNS propagation
dig fr3akazo1d.dev
dig www.fr3akazo1d.dev

# Or use online tools
# https://dnschecker.org
```

### Issue: Changes Not Reflecting

**Solution:**
1. Check GitHub Actions tab for build status
2. Force refresh browser: `Ctrl + Shift + R` (Windows/Linux) or `Cmd + Shift + R` (Mac)
3. Clear browser cache completely
4. Try incognito/private browsing mode

## 📊 Monitoring Your Site

### GitHub Actions

View deployment status:
1. Go to your repository
2. Click **Actions** tab
3. See "pages build and deployment" workflow

### Google Analytics (Optional)

Add to your `index.html` before `</head>`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

Replace `GA_MEASUREMENT_ID` with your actual ID from Google Analytics.

## 🔒 Security Best Practices

1. **Never commit sensitive data:**
   ```bash
   # Add to .gitignore
   echo ".env" >> .gitignore
   echo "*.key" >> .gitignore
   echo "config.secret.js" >> .gitignore
   ```

2. **Use environment variables for API keys:**
   - Don't hardcode API keys in JavaScript
   - Use backend services for sensitive operations

3. **Enable branch protection:**
   - Settings → Branches → Add rule
   - Protect `main` branch
   - Require pull request reviews

## 📈 Performance Optimization

### Optimize Images

```bash
# Install tools
npm install -g imagemin-cli

# Optimize images
imagemin assets/**/*.{jpg,png} --out-dir=assets/optimized
```

### Minify CSS/JS (Optional)

```bash
# Install tools
npm install -g csso-cli terser

# Minify CSS
csso css/style.css -o css/style.min.css

# Minify JS
terser js/main.js -o js/main.min.js -c -m
```

Update HTML to use minified versions:
```html
<link rel="stylesheet" href="css/style.min.css">
<script src="js/main.min.js"></script>
```

## 🎯 SEO Optimization

Add to `index.html`:

```html
<!-- Open Graph Tags -->
<meta property="og:type" content="website">
<meta property="og:url" content="https://fr3akazo1d.dev/">
<meta property="og:title" content="fr3akazo1d | Red Team Operator">
<meta property="og:description" content="Root is not a privilege. It's a mindset.">
<meta property="og:image" content="https://fr3akazo1d.dev/assets/og-image.png">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@fr3akazo1d">
<meta name="twitter:creator" content="@fr3akazo1d">

<!-- Canonical URL -->
<link rel="canonical" href="https://fr3akazo1d.dev/">
```

Create `sitemap.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://fr3akazo1d.dev/</loc>
    <lastmod>2025-11-01</lastmod>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://fr3akazo1d.dev/blog/building-custom-c2-framework.html</loc>
    <lastmod>2025-10-28</lastmod>
    <priority>0.8</priority>
  </url>
</urlset>
```

Create `robots.txt`:

```
User-agent: *
Allow: /

Sitemap: https://fr3akazo1d.dev/sitemap.xml
```

## 📞 Support

If you encounter issues:

1. Check [GitHub Pages documentation](https://docs.github.com/en/pages)
2. Search [GitHub Community](https://github.community/)
3. Open an issue in your repository
4. Contact GitHub Support

## ✅ Deployment Checklist

- [ ] Repository created on GitHub
- [ ] All files committed and pushed
- [ ] GitHub Pages enabled in Settings
- [ ] Site accessible at GitHub Pages URL
- [ ] Custom domain configured (if applicable)
- [ ] HTTPS enabled
- [ ] All links working
- [ ] Images loading correctly
- [ ] Mobile responsive
- [ ] Browser console shows no errors
- [ ] Google Analytics added (optional)
- [ ] SEO tags added
- [ ] Sitemap created

---

**🎉 Congratulations! Your site is live!**

Share it:
- `https://YOUR_USERNAME.github.io/personal-website/`
- `https://your-custom-domain.com` (if configured)

Remember to update regularly and keep your content fresh! 🚀
