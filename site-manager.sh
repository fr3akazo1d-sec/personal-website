#!/bin/bash
# All-in-one automation script for personal website management
# Usage: ./site-manager.sh

show_menu() {
    clear
    echo "╔════════════════════════════════════════════════════╗"
    echo "║     🚀 Personal Website Manager 🚀                ║"
    echo "╚════════════════════════════════════════════════════╝"
    echo ""
    echo "  [1] 📝 Create Blog Post"
    echo "  [2] 📚 Add Resource"
    echo "  [3] 📅 Add Calendar Event"
    echo "  [4] 🎤 Add Conference"
    echo "  [5] 📸 Add Gallery Album"
    echo "  [6] 💼 Add Career Entry"
    echo "  [7] 🎓 Add Certification/Course"
    echo "  [8] 🔍 Preview Site (Jekyll Serve)"
    echo "  [9] 📤 Commit & Push Changes"
    echo "  [0] ❌ Exit"
    echo ""
    read -p "Choose an option: " -n 1 choice
    echo ""
}

create_blog_post() {
    echo ""
    echo "=== 📝 Create New Blog Post ==="
    echo ""
    
    read -p "Post title: " title
    read -p "Post slug (URL-friendly): " slug
    read -p "Category (e.g., offensive-security, red-team): " category
    read -p "Tags (comma-separated): " tags_input
    read -p "Description: " description
    
    IFS=',' read -ra tags_array <<< "$tags_input"
    date=$(date +%Y-%m-%d)
    time=$(date +%H:%M:%S)
    
    post_file="_posts/${date}-${slug}.md"
    mkdir -p "_posts"
    
    # Format tags for Jekyll frontmatter
    tags_formatted=""
    for i in "${!tags_array[@]}"; do
        tag=$(echo "${tags_array[$i]}" | xargs)
        if [ $i -eq 0 ]; then
            tags_formatted="$tag"
        else
            tags_formatted="${tags_formatted}, ${tag}"
        fi
    done
    
    # Format tags for display
    tags_display=""
    for tag in "${tags_array[@]}"; do
        tag=$(echo "$tag" | xargs)
        tags_display="${tags_display}#${tag} "
    done
    
    cat > "$post_file" << EOF
---
layout: post
title: "${title}"
date: ${date} ${time}
categories: [${category}]
tags: [${tags_formatted}]
description: "${description}"
author: fr3akazo1d
---

## Introduction

Write your introduction here...

## Main Content

Your content goes here...

## Conclusion

Wrap up your thoughts...

---

**Tags:** ${tags_display}
EOF
    
    echo ""
    echo "✅ Blog post created: $post_file"
    read -p "Press Enter to continue..."
}

add_resource() {
    echo ""
    echo "=== 📚 Add New Resource ==="
    echo ""
    
    read -p "Resource title: " title
    read -p "URL: " url
    read -p "Description: " description
    read -p "Category (tools/articles/learning/other): " category
    read -p "Tags (comma-separated): " tags_input
    
    IFS=',' read -ra tags_array <<< "$tags_input"
    date=$(date +%Y-%m-%d)
    resources_file="_data/resources.yml"
    
    if [ ! -f "$resources_file" ]; then
        echo "Error: $resources_file not found!"
        read -p "Press Enter to continue..."
        return
    fi
    
    # Create the new entry
    temp_entry="
  - title: \"${title}\"
    url: \"${url}\"
    description: \"${description}\"
    category: \"${category}\"
    date: \"${date}\"
    tags:"
    
    for tag in "${tags_array[@]}"; do
        tag=$(echo "$tag" | xargs)
        temp_entry="${temp_entry}
      - ${tag}"
    done
    
    # Insert after "items:" line
    awk -v entry="$temp_entry" '
    /^items:/ { print; print entry; next }
    { print }
    ' "$resources_file" > "${resources_file}.tmp" && mv "${resources_file}.tmp" "$resources_file"
    
    echo ""
    echo "✅ Resource added to $resources_file"
    read -p "Press Enter to continue..."
}

add_calendar_event() {
    echo ""
    echo "=== 📅 Add Calendar Event ==="
    echo ""
    
    read -p "Event title: " title
    read -p "Start date (YYYY-MM-DD): " date_start
    read -p "End date (YYYY-MM-DD, or press Enter if same day): " date_end
    if [ -z "$date_end" ]; then
        date_end="$date_start"
    fi
    read -p "Location: " location
    read -p "Type (conference/training/meetup/other): " type
    read -p "Description: " description
    read -p "URL (optional): " url
    
    calendar_file="_data/calendar.yml"
    
    if [ ! -f "$calendar_file" ]; then
        echo "Error: $calendar_file not found!"
        read -p "Press Enter to continue..."
        return
    fi
    
    # Create the new entry
    temp_entry="
  - title: \"${title}\"
    date_start: \"${date_start}\"
    date_end: \"${date_end}\"
    location: \"${location}\"
    type: \"${type}\"
    description: \"${description}\""
    
    if [ -n "$url" ]; then
        temp_entry="${temp_entry}
    url: \"${url}\""
    fi
    
    # Insert after "events:" line
    awk -v entry="$temp_entry" '
    /^events:/ { print; print entry; next }
    { print }
    ' "$calendar_file" > "${calendar_file}.tmp" && mv "${calendar_file}.tmp" "$calendar_file"
    
    echo ""
    echo "✅ Calendar event added to $calendar_file"
    read -p "Press Enter to continue..."
}

add_conference() {
    echo ""
    echo "=== 🎤 Add Conference ==="
    echo ""
    
    read -p "Conference name: " name
    read -p "Year: " year
    read -p "Location: " location
    read -p "Date (e.g., August 8-11, 2025): " date
    read -p "Role (Attendee/Speaker/Volunteer): " role
    read -p "Description: " description
    read -p "Website URL: " website
    read -p "Highlights (comma-separated): " highlights_input
    
    IFS=',' read -ra highlights_array <<< "$highlights_input"
    conferences_file="_data/conferences.yml"
    
    if [ ! -f "$conferences_file" ]; then
        echo "Error: $conferences_file not found!"
        read -p "Press Enter to continue..."
        return
    fi
    
    # Create the new entry
    temp_entry="
  - name: \"${name}\"
    year: ${year}
    location: \"${location}\"
    date: \"${date}\"
    role: \"${role}\"
    description: \"${description}\"
    website: \"${website}\"
    highlights:"
    
    for highlight in "${highlights_array[@]}"; do
        highlight=$(echo "$highlight" | xargs)
        temp_entry="${temp_entry}
      - \"${highlight}\""
    done
    
    # Insert after "conferences:" line
    awk -v entry="$temp_entry" '
    /^conferences:/ { print; print entry; next }
    { print }
    ' "$conferences_file" > "${conferences_file}.tmp" && mv "${conferences_file}.tmp" "$conferences_file"
    
    echo ""
    echo "✅ Conference added to $conferences_file"
    read -p "Press Enter to continue..."
}

add_gallery_album() {
    echo ""
    echo "=== 📸 Add Gallery Album ==="
    echo ""
    
    read -p "Album name (e.g., defcon-33): " album_name
    read -p "Album title (e.g., DEF CON 33): " title
    read -p "Location: " location
    read -p "Date (YYYY-MM): " date
    read -p "Description: " description
    read -p "Cover photo filename (in assets/images/gallery/$album_name/): " cover
    
    gallery_file="_data/gallery.yml"
    
    if [ ! -f "$gallery_file" ]; then
        echo "Error: $gallery_file not found!"
        read -p "Press Enter to continue..."
        return
    fi
    
    # Create album directory
    album_dir="assets/images/gallery/${album_name}"
    mkdir -p "$album_dir"
    
    # Create the new entry
    temp_entry="
  - id: \"${album_name}\"
    title: \"${title}\"
    date: \"${date}\"
    location: \"${location}\"
    description: \"${description}\"
    cover: \"${cover}\"
    photos: []"
    
    # Insert after "albums:" line
    awk -v entry="$temp_entry" '
    /^albums:/ { print; print entry; next }
    { print }
    ' "$gallery_file" > "${gallery_file}.tmp" && mv "${gallery_file}.tmp" "$gallery_file"
    
    echo ""
    echo "✅ Gallery album added to $gallery_file"
    echo "📁 Created directory: $album_dir"
    echo ""
    echo "Next steps:"
    echo "  1. Copy your photos to $album_dir/"
    echo "  2. Update the photos array in $gallery_file"
    read -p "Press Enter to continue..."
}

add_career_entry() {
    echo ""
    echo "=== 💼 Add Career Entry ==="
    echo ""
    
    read -p "Company name: " company
    read -p "Role/Position: " role
    read -p "Location: " location
    read -p "Start date (YYYY-MM): " start_date
    read -p "End date (YYYY-MM or 'present'): " end_date
    current="false"
    if [ "$end_date" = "present" ]; then
        current="true"
    fi
    read -p "Description: " description
    read -p "Technologies (comma-separated): " tech_input
    
    IFS=',' read -ra tech_array <<< "$tech_input"
    career_file="_data/career.yml"
    
    if [ ! -f "$career_file" ]; then
        echo "Error: $career_file not found!"
        read -p "Press Enter to continue..."
        return
    fi
    
    # Create the new entry
    temp_entry="
  - company: ${company}
    role: ${role}
    location: ${location}
    start_date: ${start_date}
    end_date: ${end_date}
    current: ${current}
    description: |
      ${description}
    achievements:
      - Add your achievements here
    technologies:"
    
    for tech in "${tech_array[@]}"; do
        tech=$(echo "$tech" | xargs)
        temp_entry="${temp_entry}
      - ${tech}"
    done
    
    # Insert after "experiences:" line
    awk -v entry="$temp_entry" '
    /^experiences:/ { print; print entry; next }
    { print }
    ' "$career_file" > "${career_file}.tmp" && mv "${career_file}.tmp" "$career_file"
    
    echo ""
    echo "✅ Career entry added to $career_file"
    read -p "Press Enter to continue..."
}

add_certification() {
    echo ""
    echo "=== 🎓 Add Certification/Course ==="
    echo ""
    
    read -p "Type (certification/course): " type
    read -p "Name/Abbreviation (e.g., OSCP, CRTO): " name
    read -p "Full name: " full_name
    read -p "Issuer/Provider: " provider
    read -p "Date obtained (YYYY-MM): " date
    read -p "Description: " description
    
    career_file="_data/career.yml"
    
    if [ ! -f "$career_file" ]; then
        echo "Error: $career_file not found!"
        read -p "Press Enter to continue..."
        return
    fi
    
    if [ "$type" = "certification" ]; then
        read -p "Credential ID (optional): " cred_id
        
        temp_entry="
  - name: ${name}
    full_name: ${full_name}
    issuer: ${provider}
    date: ${date}"
        
        if [ -n "$cred_id" ]; then
            temp_entry="${temp_entry}
    credential_id: \"${cred_id}\""
        fi
        
        # Insert after "certifications:" line
        awk -v entry="$temp_entry" '
        /^certifications:/ { print; print entry; next }
        { print }
        ' "$career_file" > "${career_file}.tmp" && mv "${career_file}.tmp" "$career_file"
    else
        temp_entry="
  - name: ${name}
    full_name: ${full_name}
    provider: ${provider}
    date: ${date}
    description: ${description}"
        
        # Insert after "courses:" line
        awk -v entry="$temp_entry" '
        /^courses:/ { print; print entry; next }
        { print }
        ' "$career_file" > "${career_file}.tmp" && mv "${career_file}.tmp" "$career_file"
    fi
    
    echo ""
    echo "✅ ${type} added to $career_file"
    read -p "Press Enter to continue..."
}

preview_site() {
    echo ""
    echo "=== 🔍 Starting Jekyll Server ==="
    echo ""
    echo "Choose server mode:"
    echo "  [1] Localhost only (127.0.0.1)"
    echo "  [2] Network accessible (0.0.0.0)"
    echo ""
    read -p "Select mode (1/2): " -n 1 server_mode
    echo ""
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    
    if [ "$server_mode" = "2" ]; then
        echo "Starting server on 0.0.0.0:4000 (accessible from network)"
        echo "You can access it from:"
        echo "  - Local: http://localhost:4000"
        echo "  - Network: http://$(hostname -I | awk '{print $1}'):4000"
        echo ""
        bundle exec jekyll serve --host 0.0.0.0 --livereload
    else
        echo "Starting server on localhost:4000 (local only)"
        echo ""
        bundle exec jekyll serve --livereload
    fi
    
    read -p "Press Enter to continue..."
}

commit_and_push() {
    echo ""
    echo "=== 📤 Commit & Push Changes ==="
    echo ""
    
    git status
    echo ""
    read -p "Commit message: " commit_msg
    
    if [ -z "$commit_msg" ]; then
        echo "❌ Commit message cannot be empty!"
        read -p "Press Enter to continue..."
        return
    fi
    
    git add -A
    git reset HEAD _site 2>/dev/null
    git commit -m "$commit_msg"
    
    echo ""
    read -p "Push to GitHub? (y/n): " -n 1 push_confirm
    echo ""
    
    if [[ "$push_confirm" =~ ^[Yy]$ ]]; then
        git push origin main
        echo ""
        echo "✅ Changes pushed to GitHub!"
    else
        echo "⏸️  Changes committed locally but not pushed"
    fi
    
    read -p "Press Enter to continue..."
}

# Main loop
while true; do
    show_menu
    
    case $choice in
        1)
            create_blog_post
            ;;
        2)
            add_resource
            ;;
        3)
            add_calendar_event
            ;;
        4)
            add_conference
            ;;
        5)
            add_gallery_album
            ;;
        6)
            add_career_entry
            ;;
        7)
            add_certification
            ;;
        8)
            preview_site
            ;;
        9)
            commit_and_push
            ;;
        0)
            echo ""
            echo "👋 Goodbye!"
            exit 0
            ;;
        *)
            echo ""
            echo "❌ Invalid option. Please try again."
            sleep 1
            ;;
    esac
done
