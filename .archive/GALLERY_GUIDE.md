# Gallery System

## How to Add Photos

### 1. Organize Your Photos
Create a folder for each event in `assets/images/gallery/`:
```
assets/images/gallery/
├── defcon-32/
│   ├── cover.jpg      (Main cover image)
│   ├── photo1.jpg
│   ├── photo2.jpg
│   └── photo3.jpg
├── blackhat-2024/
│   ├── cover.jpg
│   └── ...
└── your-event-name/
    ├── cover.jpg
    └── ...
```

### 2. Add Gallery Configuration
Edit `_data/gallery.yml` and add your gallery:

```yaml
- name: Your Event Name
  slug: your-event-name  # Must match folder name
  date: 2024-11
  location: City, Country
  description: Brief description of the event
  cover_image: /assets/images/gallery/your-event-name/cover.jpg
  visible: true
  photos:
    - image: /assets/images/gallery/your-event-name/photo1.jpg
      caption: Photo description
      date: 2024-11-01
    - image: /assets/images/gallery/your-event-name/photo2.jpg
      caption: Another photo
      date: 2024-11-02
```

### 3. Hide a Gallery
Set `visible: false` to hide a gallery without deleting it:
```yaml
visible: false  # Gallery won't show on the page
```

### 4. Image Recommendations
- **Cover image**: 1200x600px or 2:1 ratio
- **Photos**: 1000x1000px or square ratio for best display
- **Format**: JPG or PNG
- **Size**: Keep under 500KB per image for fast loading

### 5. Example Structure
```
assets/images/gallery/
├── defcon-32/
│   ├── cover.jpg          # 1200x600px
│   ├── photo1.jpg         # 1000x1000px
│   ├── photo2.jpg
│   └── photo3.jpg
```

## Features
- ✅ Multiple event galleries
- ✅ Cover image with overlay
- ✅ Photo count display
- ✅ Location and date metadata
- ✅ Responsive grid layout
- ✅ Hover effects
- ✅ Show/hide galleries with `visible` flag

## Tips
1. Use descriptive filenames: `defcon-workshop.jpg` instead of `IMG_1234.jpg`
2. Add captions to make photos more meaningful
3. Keep consistent aspect ratios within each gallery
4. Compress images before uploading to improve load times
