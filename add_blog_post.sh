#!/bin/bash
# Script to create a new blog post
# Usage: ./add_blog_post.sh

echo "=== Create New Blog Post ==="
echo ""

# Get post details
read -p "Post title: " title
read -p "Post slug (URL-friendly, e.g., my-awesome-post): " slug
read -p "Category (e.g., offensive-security, red-team, tools): " category
read -p "Tags (comma-separated, e.g., c2,malware,evasion): " tags_input
read -p "Description (short summary): " description

# Convert tags to array
IFS=',' read -ra tags_array <<< "$tags_input"

# Get current date
date=$(date +%Y-%m-%d)
time=$(date +%H:%M:%S)

# Create blog post directory and file
post_dir="_posts"
mkdir -p "$post_dir"

post_file="${post_dir}/${date}-${slug}.md"

# Create frontmatter
cat > "$post_file" << EOF
---
layout: post
title: "${title}"
date: ${date} ${time}
categories: [${category}]
tags: [$(IFS=','; echo "${tags_array[*]}" | sed 's/,/, /g')]
description: "${description}"
author: fr3akazo1d
---

## Introduction

Write your introduction here...

## Section 1

Content goes here...

## Section 2

More content...

## Conclusion

Wrap up your post here...

---

**Tags:** $(for tag in "${tags_array[@]}"; do echo -n "#${tag// /} "; done)
EOF

echo ""
echo "✅ Blog post created: $post_file"
echo ""
echo "Next steps:"
echo "1. Edit the file and add your content"
echo "2. Add images to assets/images/blog/ if needed"
echo "3. Preview with: bundle exec jekyll serve --livereload"
echo "4. Commit and push: git add $post_file && git commit -m 'Add blog post: $title' && git push"
echo ""

# Open in default editor (optional)
read -p "Open in editor now? (y/n): " open_editor
if [[ $open_editor == "y" || $open_editor == "Y" ]]; then
    ${EDITOR:-nano} "$post_file"
fi
