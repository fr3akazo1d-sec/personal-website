#!/usr/bin/env fish
# All-in-one automation script for personal website management
# Usage: ./site-manager.fish

function show_menu
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
    read -P "Choose an option: " -n 1 choice
    echo ""
    return $choice
end

function create_blog_post
    echo ""
    echo "=== 📝 Create New Blog Post ==="
    echo ""
    
    read -P "Post title: " title
    read -P "Post slug (URL-friendly): " slug
    read -P "Category (e.g., offensive-security, red-team): " category
    read -P "Tags (comma-separated): " tags_input
    read -P "Description: " description
    
    set tags_array (string split "," $tags_input)
    set date (date +%Y-%m-%d)
    set time (date +%H:%M:%S)
    
    set post_file "_posts/$date-$slug.md"
    mkdir -p "_posts"
    
    echo "---
layout: post
title: \"$title\"
date: $date $time
categories: [$category]
tags: ["(string join '", "' $tags_array)"]
description: \"$description\"
author: fr3akazo1d
---

## Introduction

Write your introduction here...

## Main Content

Your content goes here...

## Conclusion

Wrap up your thoughts...

---

**Tags:** "(for tag in $tags_array; echo -n "#"(string trim $tag)" "; end) > $post_file
    
    echo ""
    echo "✅ Blog post created: $post_file"
    read -P "Press Enter to continue..."
end

function add_resource
    echo ""
    echo "=== 📚 Add New Resource ==="
    echo ""
    
    read -P "Resource title: " title
    read -P "URL: " url
    read -P "Description: " description
    read -P "Category (tools/articles/learning/other): " category
    read -P "Tags (comma-separated): " tags_input
    
    set tags_array (string split "," $tags_input)
    set date (date +%Y-%m-%d)
    set resources_file "_data/resources.yml"
    
    if not test -f "$resources_file"
        echo "Error: $resources_file not found!"
        read -P "Press Enter to continue..."
        return
    end
    
    set temp_file (mktemp)
    set found_items 0
    
    while read -l line
        echo $line >> $temp_file
        if string match -q "items:*" $line; and test $found_items -eq 0
            echo "" >> $temp_file
            echo "  - title: \"$title\"" >> $temp_file
            echo "    url: \"$url\"" >> $temp_file
            echo "    description: \"$description\"" >> $temp_file
            echo "    category: \"$category\"" >> $temp_file
            echo "    date: $date" >> $temp_file
            echo "    tags:" >> $temp_file
            for tag in $tags_array
                set tag (string trim $tag)
                echo "      - $tag" >> $temp_file
            end
            set found_items 1
        end
    end < $resources_file
    
    mv $temp_file $resources_file
    
    echo ""
    echo "✅ Resource added to $resources_file"
    read -P "Press Enter to continue..."
end

function add_calendar_event
    echo ""
    echo "=== 📅 Add Calendar Event ==="
    echo ""
    
    read -P "Event title: " title
    read -P "Start date (YYYY-MM-DD): " date_start
    read -P "End date (YYYY-MM-DD, or press Enter if same day): " date_end
    if test -z "$date_end"
        set date_end $date_start
    end
    read -P "Location: " location
    read -P "Type (conference/training/meetup/other): " type
    read -P "Description: " description
    read -P "URL (optional): " url
    
    set calendar_file "_data/calendar.yml"
    
    if not test -f "$calendar_file"
        echo "Error: $calendar_file not found!"
        read -P "Press Enter to continue..."
        return
    end
    
    set temp_file (mktemp)
    set found_events 0
    
    while read -l line
        echo $line >> $temp_file
        if string match -q "events:*" $line; and test $found_events -eq 0
            echo "" >> $temp_file
            echo "  - title: \"$title\"" >> $temp_file
            echo "    date_start: $date_start" >> $temp_file
            echo "    date_end: $date_end" >> $temp_file
            echo "    location: \"$location\"" >> $temp_file
            echo "    type: \"$type\"" >> $temp_file
            echo "    description: \"$description\"" >> $temp_file
            if test -n "$url"
                echo "    url: \"$url\"" >> $temp_file
            end
            set found_events 1
        end
    end < $calendar_file
    
    mv $temp_file $calendar_file
    
    echo ""
    echo "✅ Calendar event added to $calendar_file"
    read -P "Press Enter to continue..."
end

function add_conference
    echo ""
    echo "=== 🎤 Add Conference ==="
    echo ""
    
    read -P "Conference name: " name
    read -P "Year: " year
    read -P "Location: " location
    read -P "Date (e.g., August 8-11, 2025): " date
    read -P "Role (Attendee/Speaker/Volunteer): " role
    read -P "Description: " description
    read -P "Website URL: " website
    read -P "Highlights (comma-separated): " highlights_input
    
    set highlights_array (string split "," $highlights_input)
    set conferences_file "_data/conferences.yml"
    
    if not test -f "$conferences_file"
        echo "Error: $conferences_file not found!"
        read -P "Press Enter to continue..."
        return
    end
    
    set temp_file (mktemp)
    set found_conferences 0
    
    while read -l line
        echo $line >> $temp_file
        if string match -q "conferences:*" $line; and test $found_conferences -eq 0
            echo "" >> $temp_file
            echo "  - name: \"$name\"" >> $temp_file
            echo "    year: $year" >> $temp_file
            echo "    location: \"$location\"" >> $temp_file
            echo "    date: \"$date\"" >> $temp_file
            echo "    role: \"$role\"" >> $temp_file
            echo "    description: \"$description\"" >> $temp_file
            echo "    website: \"$website\"" >> $temp_file
            echo "    highlights:" >> $temp_file
            for highlight in $highlights_array
                set highlight (string trim $highlight)
                echo "      - \"$highlight\"" >> $temp_file
            end
            set found_conferences 1
        end
    end < $conferences_file
    
    mv $temp_file $conferences_file
    
    echo ""
    echo "✅ Conference added to $conferences_file"
    read -P "Press Enter to continue..."
end

function add_gallery_album
    echo ""
    echo "=== 📸 Add Gallery Album ==="
    echo ""
    
    read -P "Album name (e.g., defcon-33): " album_name
    read -P "Album title (e.g., DEF CON 33): " title
    read -P "Location: " location
    read -P "Date (YYYY-MM): " date
    read -P "Description: " description
    read -P "Cover photo filename (in assets/images/gallery/$album_name/): " cover
    
    set gallery_file "_data/gallery.yml"
    
    if not test -f "$gallery_file"
        echo "Error: $gallery_file not found!"
        read -P "Press Enter to continue..."
        return
    end
    
    # Create album directory
    set album_dir "assets/images/gallery/$album_name"
    mkdir -p "$album_dir"
    
    set temp_file (mktemp)
    set found_albums 0
    
    while read -l line
        echo $line >> $temp_file
        if string match -q "albums:*" $line; and test $found_albums -eq 0
            echo "" >> $temp_file
            echo "  - id: \"$album_name\"" >> $temp_file
            echo "    title: \"$title\"" >> $temp_file
            echo "    date: \"$date\"" >> $temp_file
            echo "    location: \"$location\"" >> $temp_file
            echo "    description: \"$description\"" >> $temp_file
            echo "    cover: \"$cover\"" >> $temp_file
            echo "    photos: []" >> $temp_file
            set found_albums 1
        end
    end < $gallery_file
    
    mv $temp_file $gallery_file
    
    echo ""
    echo "✅ Gallery album added to $gallery_file"
    echo "📁 Created directory: $album_dir"
    echo ""
    echo "Next steps:"
    echo "  1. Copy your photos to $album_dir/"
    echo "  2. Run: ./add_gallery_photos.fish $album_name"
    read -P "Press Enter to continue..."
end

function add_career_entry
    echo ""
    echo "=== 💼 Add Career Entry ==="
    echo ""
    
    read -P "Company name: " company
    read -P "Role/Position: " role
    read -P "Location: " location
    read -P "Start date (YYYY-MM): " start_date
    read -P "End date (YYYY-MM or 'present'): " end_date
    set current "false"
    if test "$end_date" = "present"
        set current "true"
    end
    read -P "Description: " description
    read -P "Technologies (comma-separated): " tech_input
    
    set tech_array (string split "," $tech_input)
    set career_file "_data/career.yml"
    
    if not test -f "$career_file"
        echo "Error: $career_file not found!"
        read -P "Press Enter to continue..."
        return
    end
    
    set temp_file (mktemp)
    set found_experiences 0
    
    while read -l line
        echo $line >> $temp_file
        if string match -q "experiences:*" $line; and test $found_experiences -eq 0
            echo "" >> $temp_file
            echo "  - company: $company" >> $temp_file
            echo "    role: $role" >> $temp_file
            echo "    location: $location" >> $temp_file
            echo "    start_date: $start_date" >> $temp_file
            echo "    end_date: $end_date" >> $temp_file
            echo "    current: $current" >> $temp_file
            echo "    description: |" >> $temp_file
            echo "      $description" >> $temp_file
            echo "    achievements:" >> $temp_file
            echo "      - Add your achievements here" >> $temp_file
            echo "    technologies:" >> $temp_file
            for tech in $tech_array
                set tech (string trim $tech)
                echo "      - $tech" >> $temp_file
            end
            set found_experiences 1
        end
    end < $career_file
    
    mv $temp_file $career_file
    
    echo ""
    echo "✅ Career entry added to $career_file"
    read -P "Press Enter to continue..."
end

function add_certification
    echo ""
    echo "=== 🎓 Add Certification/Course ==="
    echo ""
    
    read -P "Type (certification/course): " type
    read -P "Name/Abbreviation (e.g., OSCP, CRTO): " name
    read -P "Full name: " full_name
    read -P "Issuer/Provider: " provider
    read -P "Date obtained (YYYY-MM): " date
    read -P "Description: " description
    
    set career_file "_data/career.yml"
    
    if not test -f "$career_file"
        echo "Error: $career_file not found!"
        read -P "Press Enter to continue..."
        return
    end
    
    set temp_file (mktemp)
    
    if test "$type" = "certification"
        set found_section 0
        while read -l line
            echo $line >> $temp_file
            if string match -q "certifications:*" $line; and test $found_section -eq 0
                echo "" >> $temp_file
                echo "  - name: $name" >> $temp_file
                echo "    full_name: $full_name" >> $temp_file
                echo "    issuer: $provider" >> $temp_file
                echo "    date: $date" >> $temp_file
                read -P "Credential ID (optional): " cred_id
                if test -n "$cred_id"
                    echo "    credential_id: \"$cred_id\"" >> $temp_file
                end
                set found_section 1
            end
        end < $career_file
    else
        set found_section 0
        while read -l line
            echo $line >> $temp_file
            if string match -q "courses:*" $line; and test $found_section -eq 0
                echo "" >> $temp_file
                echo "  - name: $name" >> $temp_file
                echo "    full_name: $full_name" >> $temp_file
                echo "    provider: $provider" >> $temp_file
                echo "    date: $date" >> $temp_file
                echo "    description: $description" >> $temp_file
                set found_section 1
            end
        end < $career_file
    end
    
    mv $temp_file $career_file
    
    echo ""
    echo "✅ $type added to $career_file"
    read -P "Press Enter to continue..."
end

function preview_site
    echo ""
    echo "=== 🔍 Starting Jekyll Server ==="
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    bundle exec jekyll serve --livereload
    read -P "Press Enter to continue..."
end

function commit_and_push
    echo ""
    echo "=== 📤 Commit & Push Changes ==="
    echo ""
    
    git status
    echo ""
    read -P "Commit message: " commit_msg
    
    if test -z "$commit_msg"
        echo "❌ Commit message cannot be empty!"
        read -P "Press Enter to continue..."
        return
    end
    
    git add -A
    git reset HEAD _site 2>/dev/null
    git commit -m "$commit_msg"
    
    echo ""
    read -P "Push to GitHub? (y/n): " -n 1 push_confirm
    echo ""
    
    if test "$push_confirm" = "y" -o "$push_confirm" = "Y"
        git push origin main
        echo ""
        echo "✅ Changes pushed to GitHub!"
    else
        echo "⏸️  Changes committed locally but not pushed"
    end
    
    read -P "Press Enter to continue..."
end

# Main loop
while true
    show_menu
    set choice $status
    
    switch $choice
        case 1
            create_blog_post
        case 2
            add_resource
        case 3
            add_calendar_event
        case 4
            add_conference
        case 5
            add_gallery_album
        case 6
            add_career_entry
        case 7
            add_certification
        case 8
            preview_site
        case 9
            commit_and_push
        case 0
            echo ""
            echo "👋 Goodbye!"
            exit 0
        case '*'
            echo ""
            echo "❌ Invalid option. Please try again."
            sleep 1
    end
end
