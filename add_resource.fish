#!/usr/bin/env fish
# Fish shell version - Script to add a new resource to resources.yml
# Usage: ./add_resource.fish

echo "=== Add New Resource ==="
echo ""

# Get resource details
read -P "Resource title: " title
read -P "URL: " url
read -P "Description: " description
read -P "Category (tools/articles/learning/other): " category
read -P "Tags (comma-separated, e.g., c2,red-team,python): " tags_input

# Convert tags to array
set tags_array (string split "," $tags_input)

# Get current date
set date (date +%Y-%m-%d)

# Resources file path
set resources_file "_data/resources.yml"

# Check if file exists
if not test -f "$resources_file"
    echo "Error: $resources_file not found!"
    exit 1
end

# Create temporary file with new entry
set temp_file (mktemp)

# Read the file and insert after "items:" line
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

# Replace original file
mv $temp_file $resources_file

echo ""
echo "✅ Resource added to $resources_file"
echo ""
echo "Resource details:"
echo "  Title: $title"
echo "  URL: $url"
echo "  Category: $category"
echo "  Tags: $tags_array"
echo ""
echo "Next steps:"
echo "1. Review the changes in $resources_file"
echo "2. Test locally: bundle exec jekyll serve --livereload"
echo "3. Commit: git add $resources_file && git commit -m 'Add resource: $title' && git push"
echo ""
