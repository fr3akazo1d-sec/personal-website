# Avatar and Glitch Effect Updates

## ✅ Changes Made

### 1. **Avatar Image Support**
   - Replaced the CSS-based avatar circle with an image element
   - Avatar now supports your personal image file
   - Located at: `assets/images/avatar.png`

### 2. **Glitch Effect Improvements**
   - **More Subtle**: Glitch only appears on hover (was constant before)
   - **Smoother**: Reduced frequency and intensity
   - **Added skew animation**: Subtle warping effect
   - **Better performance**: Lighter animations

## 🎨 Visual Features

### Avatar:
- ✨ Cyan glowing border with shadow
- 🔴 Hover effect changes border to red and scales image
- 🌊 Floating animation (gentle up/down motion)
- 🌈 Animated gradient ring around the avatar
- 🖼️ Supports PNG, JPG, WEBP, or GIF files

### Glitch Effect (F! logo and terminal line):
- 👻 **Hidden by default** - only shows on hover
- ⚡ Slower, more controlled animations
- 🎭 Subtle skew/warp effect
- 💫 Red and cyan color split effects

## 📝 How to Use

### Adding Your Avatar:

1. **Place your image** in `assets/images/` folder
2. **Name it** `avatar.png` (or update the filename in `index.html`)
3. **Recommended specs:**
   - Square format (500x500px or larger)
   - PNG format (transparent background looks best)
   - Good quality, clear face/logo

### Using a Different Filename:

Edit `index.html` line ~20:
```html
<img src="{{ site.baseurl }}/assets/images/YOUR-FILE.png" alt="fr3akazo1d avatar" class="avatar-image">
```

### Adjusting Glitch Intensity:

Edit `css/style.css` glitch section if you want:
- More/less opacity: Change `opacity: 0.8`
- Faster/slower: Change animation duration `4s` and `3.5s`
- Always visible: Remove the `opacity: 0` and hover rules

## 🎯 Current Behavior

### Before Hover:
- Avatar: Gentle floating animation
- Logo/Terminal: Clean, no glitch visible

### On Hover:
- Avatar: Scales up 5%, border turns red, stronger glow
- Logo/Terminal: Glitch effect activates (color split, skew)

This creates a cleaner, more professional look while keeping the hacker aesthetic available on interaction!
