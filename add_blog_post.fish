#!/usr/bin/env fish
# Fish shell version - Script to create a new blog post
# Usage: ./add_blog_post.fish

echo "=== Create New Blog Post ==="
echo ""

# Get post details
read -P "Post title: " title
read -P "Post slug (URL-friendly, e.g., my-awesome-post): " slug
read -P "Category (e.g., offensive-security, red-team, tools): " category
read -P "Tags (comma-separated, e.g., c2,malware,evasion): " tags_input
read -P "Description (short summary): " description

# Convert tags to array
set tags_array (string split "," $tags_input)

# Get current date
set date (date +%Y-%m-%d)
set time (date +%H:%M:%S)

# Create blog post directory and file
set post_dir "_posts"
mkdir -p "$post_dir"

set post_file "$post_dir/$date-$slug.md"

# Create frontmatter and content
echo "---
layout: post
title: \"$title\"
date: $date $time
categories: [$category]
tags: ["(string join ", " $tags_array)"]
description: \"$description\"
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

**Tags:** "(for tag in $tags_array; echo -n "#$tag "; end) > $post_file

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
read -P "Open in editor now? (y/n): " -n 1 open_editor
if test "$open_editor" = "y" -o "$open_editor" = "Y"
    eval (printenv EDITOR; or echo "nano") $post_file
end
