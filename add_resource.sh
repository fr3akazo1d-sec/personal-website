#!/bin/bash
# Script to add a new resource to resources.yml
# Usage: ./add_resource.sh

echo "=== Add New Resource ==="
echo ""

# Get resource details
read -p "Resource title: " title
read -p "URL: " url
read -p "Description: " description
read -p "Category (tools/articles/learning/other): " category
read -p "Tags (comma-separated, e.g., c2,red-team,python): " tags_input

# Convert tags to array
IFS=',' read -ra tags_array <<< "$tags_input"

# Get current date
date=$(date +%Y-%m-%d)

# Resources file path
resources_file="_data/resources.yml"

# Check if file exists
if [ ! -f "$resources_file" ]; then
    echo "Error: $resources_file not found!"
    exit 1
fi

# Create temporary entry
temp_entry=$(cat << EOF

  - title: "${title}"
    url: "${url}"
    description: "${description}"
    category: "${category}"
    date: "${date}"
    tags:
EOF
)

# Add tags to entry
for tag in "${tags_array[@]}"; do
    tag=$(echo "$tag" | xargs) # trim whitespace
    temp_entry="${temp_entry}
      - ${tag}"
done

# Add entry to resources file (after the "items:" line)
awk -v entry="$temp_entry" '
/^items:/ { print; print entry; next }
{ print }
' "$resources_file" > "${resources_file}.tmp" && mv "${resources_file}.tmp" "$resources_file"

echo ""
echo "✅ Resource added to $resources_file"
echo ""
echo "Resource details:"
echo "  Title: $title"
echo "  URL: $url"
echo "  Category: $category"
echo "  Tags: ${tags_array[@]}"
echo ""
echo "Next steps:"
echo "1. Review the changes in $resources_file"
echo "2. Test locally: bundle exec jekyll serve --livereload"
echo "3. Commit: git add $resources_file && git commit -m 'Add resource: $title' && git push"
echo ""
