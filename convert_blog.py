#!/usr/bin/env python3
"""
Blog Post Converter - Markdown to HTML
Converts Markdown blog posts to HTML using the fr3akazo1d blog template
"""

import sys
import re
from pathlib import Path
from datetime import datetime

# Check if markdown module is available
try:
    import markdown
    from markdown.extensions.codehilite import CodeHiliteExtension
    from markdown.extensions.fenced_code import FencedCodeExtension
    from markdown.extensions.tables import TableExtension
except ImportError:
    print("⚠️  markdown library not found. Installing...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "markdown"])
    import markdown
    from markdown.extensions.codehilite import CodeHiliteExtension
    from markdown.extensions.fenced_code import FencedCodeExtension
    from markdown.extensions.tables import TableExtension

def extract_metadata(content):
    """Extract metadata from markdown frontmatter"""
    metadata = {
        'title': 'Untitled Post',
        'date': datetime.now().strftime('%Y-%m-%d'),
        'tags': ['general'],
        'reading_time': '5 min read',
        'description': ''
    }
    
    # Check for YAML frontmatter
    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            frontmatter = parts[1].strip()
            content = parts[2].strip()
            
            # Parse frontmatter
            for line in frontmatter.split('\n'):
                if ':' in line:
                    key, value = line.split(':', 1)
                    key = key.strip().lower()
                    value = value.strip()
                    
                    if key == 'title':
                        metadata['title'] = value.strip('"\'')
                    elif key == 'date':
                        metadata['date'] = value.strip('"\'')
                    elif key == 'tags':
                        # Handle list format
                        if value.startswith('['):
                            metadata['tags'] = [t.strip().strip('"\'') for t in value.strip('[]').split(',')]
                        else:
                            metadata['tags'] = [value.strip('"\'')]
                    elif key == 'reading_time':
                        metadata['reading_time'] = value.strip('"\'')
                    elif key == 'description':
                        metadata['description'] = value.strip('"\'')
    
    return metadata, content

def convert_code_blocks(html_content):
    """Convert code blocks to terminal-style blocks"""
    # Pattern to match <pre><code> blocks
    pattern = r'<pre><code(?:\s+class="language-(\w+)")?>(.*?)</code></pre>'
    
    def replace_code(match):
        lang = match.group(1) or ''
        code = match.group(2)
        
        return f'''<div class="terminal-code">
    <div class="terminal-code-header">
        <span class="dot red"></span>
        <span class="dot yellow"></span>
        <span class="dot green"></span>
        <span style="margin-left: auto; color: #c0c0c0; font-size: 0.9rem;">{lang}</span>
    </div>
    <div class="terminal-code-body">
        <pre><code class="language-{lang}">{code}</code></pre>
    </div>
</div>'''
    
    return re.sub(pattern, replace_code, html_content, flags=re.DOTALL)

def generate_html(metadata, html_content):
    """Generate complete HTML page with template"""
    
    # Format tags for display
    tags_html = '\n                '.join([f'<a href="#" class="tag">#{tag}</a>' for tag in metadata['tags']])
    primary_tag = f"#{metadata['tags'][0]}" if metadata['tags'] else "#general"
    
    template = f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{metadata['description'] or metadata['title']}">
    <meta name="author" content="Philipp (fr3akazo1d)">
    <title>{metadata['title']} | fr3akazo1d</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/blog.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Custom Cursor -->
    <div class="cursor"></div>
    <div class="cursor-follower"></div>

    <!-- Navigation -->
    <nav class="nav-menu">
        <ul>
            <li><a href="../index.html" class="nav-link">← Back to Home</a></li>
            <li><a href="../index.html#blog" class="nav-link">Blog</a></li>
            <li><a href="../index.html#contact" class="nav-link">Contact</a></li>
        </ul>
    </nav>

    <!-- Blog Post -->
    <article class="blog-post">
        <!-- Post Header -->
        <header class="post-header">
            <h1 class="post-title glitch" data-text="{metadata['title']}">{metadata['title']}</h1>
            <div class="post-meta">
                <span class="post-date">[{metadata['date']}]</span>
                <span class="post-tag">{primary_tag}</span>
                <span class="post-reading-time">{metadata['reading_time']}</span>
            </div>
            <div class="post-author">
                <span>by <strong>fr3akazo1d</strong></span>
            </div>
        </header>

        <!-- Post Content -->
        <div class="post-content">
{html_content}
        </div>

        <!-- Post Footer -->
        <footer class="post-footer">
            <div class="post-tags">
                {tags_html}
            </div>

            <div class="post-share">
                <h3>Share this post</h3>
                <div class="share-buttons">
                    <a href="#" class="share-btn">Twitter</a>
                    <a href="#" class="share-btn">LinkedIn</a>
                    <a href="#" class="share-btn">Reddit</a>
                </div>
            </div>

            <a href="../index.html#blog" class="back-to-blog">← Back to all posts</a>
        </footer>
    </article>

    <script src="../js/main.js"></script>
</body>
</html>
'''
    return template

def main():
    if len(sys.argv) < 2:
        print("Usage: python convert_blog.py <markdown_file.md>")
        print("\nExample:")
        print("  python convert_blog.py blog/my-post.md")
        print("\nThis will create: blog/my-post.html")
        sys.exit(1)
    
    # Get input file
    md_file = Path(sys.argv[1])
    
    if not md_file.exists():
        print(f"❌ Error: File '{md_file}' not found")
        sys.exit(1)
    
    # Read markdown content
    print(f"📖 Reading {md_file}...")
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract metadata
    metadata, md_content = extract_metadata(content)
    print(f"✓ Title: {metadata['title']}")
    print(f"✓ Date: {metadata['date']}")
    print(f"✓ Tags: {', '.join(metadata['tags'])}")
    
    # Convert markdown to HTML
    print("🔄 Converting Markdown to HTML...")
    md = markdown.Markdown(extensions=[
        'extra',
        'codehilite',
        'fenced_code',
        'tables',
        'nl2br'
    ])
    html_content = md.convert(md_content)
    
    # Convert code blocks to terminal style
    html_content = convert_code_blocks(html_content)
    
    # Generate complete HTML
    final_html = generate_html(metadata, html_content)
    
    # Write output file
    html_file = md_file.with_suffix('.html')
    print(f"💾 Writing {html_file}...")
    with open(html_file, 'w', encoding='utf-8') as f:
        f.write(final_html)
    
    print(f"\n✅ Success! Blog post created: {html_file}")
    print(f"\n📝 Next steps:")
    print(f"   1. Review the generated HTML file")
    print(f"   2. Add a link to this post in index.html")
    print(f"   3. Test locally: python -m http.server 8000")
    print(f"   4. Commit and push to GitHub")
    print(f"\n🔗 Add this to index.html blog section:")
    
    slug = md_file.stem
    print(f'''
    <article class="blog-card">
        <div class="card-header">
            <span class="card-date">[{metadata['date']}]</span>
            <span class="card-tag">{f"#{metadata['tags'][0]}" if metadata['tags'] else "#general"}</span>
        </div>
        <h3 class="card-title">{metadata['title']}</h3>
        <p class="card-excerpt">
            {metadata['description'] or "Description of your blog post..."}
        </p>
        <a href="blog/{slug}.html" class="card-link">Read more <span class="arrow">→</span></a>
    </article>
    ''')

if __name__ == '__main__':
    main()
