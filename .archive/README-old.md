# fr3akazo1d Personal Website

> **Root is not a privilege. It's a mindset.**

A dark, glitchy hacker-themed personal website showcasing Red Team expertise, blog content, and projects.

## 🎨 Features

- **Dark Hacker Aesthetic**: Custom color scheme with neon cyan (#00fff7) and red (#ff003c) accents
- **Glitch Effects**: Aggressive glitch animations on logo and terminal elements
- **Custom Cursor**: Terminal-style cursor with smooth tracking
- **Responsive Design**: Fully responsive across desktop, tablet, and mobile devices
- **Smooth Animations**: Intersection Observer API for scroll-triggered animations
- **Interactive Elements**: Hover effects, card tilt animations, and neon glows
- **Terminal UI**: Terminal-styled sections for authentic hacker feel

## 🖼️ Branding

### Logo
- **F!** - Cursive hacker-style font
  - `F` - Neon cyan outline (#00fff7)
  - `!` - Solid neon red (#ff003c)
- **Terminal Line**: `fr3akazo1d@root:~#` in neon red

### Color Palette
| Element | Hex Code | Usage |
|---------|----------|-------|
| Background (main) | #10141a | Body background |
| Secondary Background | #141d2b | Panels, cards |
| Accent Cyan | #00fff7 | Logo outline, hover effects |
| Accent Red | #ff003c | Logo fill, terminal line, buttons |
| Text (main) | #c0c0c0 | Body text |
| Link Hover | #00fff7 | Neon glow |

## 🚀 Quick Start

### Prerequisites
- A modern web browser (Chrome, Firefox, Safari, Edge)
- Git (for cloning and deployment)
- Optional: Live Server extension for VS Code

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/fr3akazo1d/personal-website.git
   cd personal-website
   ```

2. **Open the project**
   - Simply open `index.html` in your browser, or
   - Use a local server (recommended for best experience)

3. **Using VS Code Live Server**
   - Install the "Live Server" extension
   - Right-click `index.html` and select "Open with Live Server"
   - The site will open at `http://localhost:5500`

4. **Using Python**
   ```bash
   # Python 3
   python -m http.server 8000
   
   # Python 2
   python -m SimpleHTTPServer 8000
   ```
   Then open `http://localhost:8000`

5. **Using Node.js**
   ```bash
   npx http-server
   ```

## 📁 Project Structure

```
personal-website/
├── index.html          # Main HTML file
├── css/
│   └── style.css       # All styles, animations, and responsive design
├── js/
│   └── main.js         # Interactive features and animations
├── assets/             # Images, logo, and media files
│   ├── logo/
│   ├── avatar/
│   └── wallpapers/
├── README.md           # This file
└── .gitignore          # Git ignore file
```

## 🌐 GitHub Pages Deployment

### Method 1: Via GitHub Website

1. **Push your code to GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: fr3akazo1d personal website"
   git branch -M main
   git remote add origin https://github.com/fr3akazo1d/personal-website.git
   git push -u origin main
   ```

2. **Enable GitHub Pages**
   - Go to your repository on GitHub
   - Click on `Settings` → `Pages`
   - Under "Source", select `main` branch
   - Click `Save`
   - Your site will be live at: `https://fr3akazo1d.github.io/personal-website/`

### Method 2: Using GitHub CLI

```bash
# Install GitHub CLI if you haven't
# https://cli.github.com/

# Create repository and push
gh repo create personal-website --public --source=. --remote=origin --push

# Enable GitHub Pages
gh repo edit --enable-pages --pages-branch main
```

## 🎯 Customization

### Update Personal Information

1. **Contact Links** (`index.html`)
   - Update email, GitHub, LinkedIn, and Twitter links in the contact section
   - Replace placeholder URLs with your actual profiles

2. **Blog Posts** (`index.html`)
   - Edit the blog cards with your actual blog content
   - Add links to full blog posts

3. **Projects** (`index.html`)
   - Update project cards with your GitHub repositories
   - Add real project descriptions and links

4. **Avatar/Logo** (Future enhancement)
   - Add your custom avatar image to `assets/avatar/`
   - Update the CSS to use the image instead of placeholder

### Modify Colors

Edit the CSS variables in `css/style.css`:

```css
:root {
    --bg-main: #10141a;           /* Main background */
    --bg-secondary: #141d2b;      /* Card backgrounds */
    --accent-cyan: #00fff7;       /* Primary accent */
    --accent-red: #ff003c;        /* Secondary accent */
    --text-main: #c0c0c0;         /* Body text */
}
```

### Add/Remove Sections

1. Add a new section in `index.html`:
   ```html
   <section id="your-section" class="section">
       <div class="container">
           <h2 class="section-title glitch" data-text="$ your-title"># your-title</h2>
           <!-- Your content -->
       </div>
   </section>
   ```

2. Add navigation link:
   ```html
   <li><a href="#your-section" class="nav-link">Your Section</a></li>
   ```

## 🔤 Fonts

The site uses:
- **Primary**: JetBrains Mono (via Google Fonts)
- **Secondary**: Inter (via Google Fonts)
- **Fallback**: monospace, sans-serif

To change fonts, update the Google Fonts link in `index.html` and CSS variables in `style.css`.

## 💡 Features to Enable

### Matrix Rain Effect
Uncomment the last line in `js/main.js`:
```javascript
// Uncomment to enable matrix rain effect
createMatrixRain();
```

### Custom Avatar
1. Add your avatar image to `assets/avatar/`
2. Update `.avatar-hoodie` in CSS to use your image:
   ```css
   .avatar-hoodie {
       background-image: url('../assets/avatar/your-avatar.png');
       background-size: cover;
   }
   ```

## 📱 Responsive Breakpoints

- **Desktop**: > 1200px
- **Tablet**: 768px - 1199px
- **Mobile**: < 767px

## 🛠️ Technologies Used

- **HTML5**: Semantic markup
- **CSS3**: Modern features (Grid, Flexbox, Custom Properties, Animations)
- **JavaScript (ES6+)**: Interactive features, Intersection Observer, custom cursor
- **Google Fonts**: JetBrains Mono, Inter

## 🎨 Assets Needed

To complete the website, you'll need to add:

1. **Logo** (`.svg` or `.png`)
   - F! logo with transparent background
   - Recommended size: 512x512px

2. **Avatar** (`.jpg`, `.png`, or `.svg`)
   - Back-view hoodie avatar
   - Recommended size: 800x800px

3. **Favicon** (`.ico` or `.png`)
   - 32x32px or 64x64px

4. **Open Graph Images** (for social sharing)
   - 1200x630px

Add these to the `assets/` folder and update the HTML accordingly.

## 📝 SEO Optimization

Update the meta tags in `index.html`:

```html
<meta name="description" content="Your custom description">
<meta name="keywords" content="your, keywords, here">
<meta property="og:title" content="fr3akazo1d | Your Tagline">
<meta property="og:description" content="Your description">
<meta property="og:image" content="URL to your OG image">
```

## 🔒 Security Considerations

- Keep dependencies updated
- Use HTTPS for all external resources
- Sanitize any user input if you add forms
- Consider adding Content Security Policy (CSP) headers

## 📊 Performance

Current optimizations:
- Minimal external dependencies (only Google Fonts)
- CSS animations use `transform` and `opacity` for GPU acceleration
- Lazy loading for scroll-triggered animations
- Optimized particle and cursor effects

## 🐛 Troubleshooting

### Custom cursor not showing
- Ensure JavaScript is enabled
- Check browser console for errors
- Custom cursor is disabled on mobile devices (intentional)

### Glitch effects not working
- Verify `data-text` attributes match the element text
- Check CSS animations are supported in your browser

### Fonts not loading
- Check internet connection (fonts loaded from Google Fonts CDN)
- Verify font links in HTML are correct

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📧 Contact

- **Email**: philipp@fr3akazo1d.dev
- **GitHub**: [@fr3akazo1d](https://github.com/fr3akazo1d)
- **LinkedIn**: [fr3akazo1d](https://linkedin.com/in/fr3akazo1d)
- **Twitter**: [@fr3akazo1d](https://twitter.com/fr3akazo1d)

---

<p align="center">
  <strong>"Sometimes I feel like giving up, then I remember I have a lot of people to prove wrong."</strong>
</p>

<p align="center">
  Built with 💀 by fr3akazo1d | © 2025
</p>
