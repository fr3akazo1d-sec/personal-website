#!/usr/bin/env bash

# ========================================
# Gallery Creator Script
# Automates adding new photo galleries
# ========================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
GALLERY_DATA_FILE="_data/gallery.yml"
GALLERY_IMAGES_DIR="assets/images/gallery"

echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   Gallery Creator for fr3akazo1d      ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if source folder is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a folder containing photos${NC}"
    echo -e "Usage: ./add_gallery.sh /path/to/photos"
    exit 1
fi

SOURCE_FOLDER="$1"

# Check if source folder exists
if [ ! -d "$SOURCE_FOLDER" ]; then
    echo -e "${RED}Error: Folder '$SOURCE_FOLDER' does not exist${NC}"
    exit 1
fi

# Count images in folder
IMAGE_COUNT=$(find "$SOURCE_FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | wc -l)

if [ "$IMAGE_COUNT" -eq 0 ]; then
    echo -e "${RED}Error: No images found in '$SOURCE_FOLDER'${NC}"
    exit 1
fi

echo -e "${GREEN}Found $IMAGE_COUNT images in source folder${NC}"
echo ""

# Get gallery information
echo -e "${YELLOW}Please provide gallery information:${NC}"
echo ""

read -p "Gallery name (e.g., 'DEF CON 32'): " GALLERY_NAME
read -p "Location (e.g., 'Las Vegas, USA'): " GALLERY_LOCATION
read -p "Date (YYYY-MM-DD, e.g., '2024-08-01'): " GALLERY_DATE
read -p "Description: " GALLERY_DESCRIPTION

# Generate slug from name
GALLERY_SLUG=$(echo "$GALLERY_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

echo ""
echo -e "${CYAN}Gallery slug: ${GALLERY_SLUG}${NC}"

# Check if gallery already exists
if grep -q "slug: $GALLERY_SLUG" "$GALLERY_DATA_FILE" 2>/dev/null; then
    echo -e "${RED}Error: Gallery with slug '$GALLERY_SLUG' already exists!${NC}"
    exit 1
fi

# Create gallery folder
GALLERY_FOLDER="$GALLERY_IMAGES_DIR/$GALLERY_SLUG"
mkdir -p "$GALLERY_FOLDER"
echo -e "${GREEN}✓ Created gallery folder: $GALLERY_FOLDER${NC}"

# Check for dedicated cover image in source folder
echo ""
echo -e "${YELLOW}Looking for cover image...${NC}"
COVER_SOURCE=""
for COVER_EXT in cover.jpg cover.jpeg cover.png cover.JPG cover.JPEG cover.PNG; do
    if [ -f "$SOURCE_FOLDER/$COVER_EXT" ]; then
        COVER_SOURCE="$SOURCE_FOLDER/$COVER_EXT"
        echo -e "  ${GREEN}✓${NC} Found: $COVER_EXT"
        break
    fi
done

if [ -n "$COVER_SOURCE" ]; then
    cp "$COVER_SOURCE" "$GALLERY_FOLDER/cover.jpg"
    echo -e "  ${CYAN}✓${NC} Using dedicated cover image"
    COVER_IMAGE="/$GALLERY_IMAGES_DIR/$GALLERY_SLUG/cover.jpg"
    USE_FIRST_AS_COVER=false
else
    echo -e "  ${YELLOW}!${NC} No cover image found (cover.jpg/jpeg/png)"
    echo -e "  ${YELLOW}→${NC} Will use first photo as cover"
    USE_FIRST_AS_COVER=true
fi

# Copy and process images
echo ""
echo -e "${YELLOW}Copying images...${NC}"

COUNTER=1
PHOTO_ENTRIES=""

for IMAGE in "$SOURCE_FOLDER"/*.jpg "$SOURCE_FOLDER"/*.jpeg "$SOURCE_FOLDER"/*.png "$SOURCE_FOLDER"/*.gif "$SOURCE_FOLDER"/*.JPG "$SOURCE_FOLDER"/*.JPEG "$SOURCE_FOLDER"/*.PNG "$SOURCE_FOLDER"/*.GIF; do
    [ -e "$IMAGE" ] || continue
    
    # Skip the cover image file if it exists (don't process it as a regular photo)
    BASENAME=$(basename "$IMAGE")
    if [[ "$BASENAME" =~ ^cover\.(jpg|jpeg|png|JPG|JPEG|PNG)$ ]]; then
        continue
    fi
    
    # Get file extension
    EXT="${IMAGE##*.}"
    EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')
    
    # Generate new filename
    NEW_NAME="photo-$(printf "%03d" $COUNTER).$EXT_LOWER"
    
    # Copy image
    cp "$IMAGE" "$GALLERY_FOLDER/$NEW_NAME"
    echo -e "  ${GREEN}✓${NC} Copied: $NEW_NAME"
    
    # If no dedicated cover, use first image as cover (but don't add it to gallery)
    if [ "$USE_FIRST_AS_COVER" = true ] && [ $COUNTER -eq 1 ]; then
        cp "$IMAGE" "$GALLERY_FOLDER/cover.jpg"
        echo -e "  ${CYAN}✓${NC} Set as cover image (will not appear in gallery)"
        COVER_IMAGE="/$GALLERY_IMAGES_DIR/$GALLERY_SLUG/cover.jpg"
    else
        # Add to photo entries (will be added to YAML) - using $'\n' for actual newlines
        PHOTO_ENTRIES+=$'      - image: /'"$GALLERY_IMAGES_DIR/$GALLERY_SLUG/$NEW_NAME"$'\n'
        PHOTO_ENTRIES+=$'        caption: Photo from '"$GALLERY_NAME"$'\n'
        PHOTO_ENTRIES+=$'        date: '"$GALLERY_DATE"$'\n'
    fi
    
    COUNTER=$((COUNTER + 1))
done

echo ""
echo -e "${GREEN}✓ Copied $((COUNTER - 1)) images${NC}"

# Add to gallery.yml
echo ""
echo -e "${YELLOW}Updating gallery.yml...${NC}"

# Create gallery entry
GALLERY_ENTRY="
  - name: $GALLERY_NAME
    slug: $GALLERY_SLUG
    date: $GALLERY_DATE
    location: $GALLERY_LOCATION
    description: $GALLERY_DESCRIPTION
    cover_image: $COVER_IMAGE
    visible: true
    photos:
$PHOTO_ENTRIES"

# Check if galleries array exists
if ! grep -q "^galleries:" "$GALLERY_DATA_FILE" 2>/dev/null; then
    # Create new file
    echo "# Gallery Configuration" > "$GALLERY_DATA_FILE"
    echo "galleries:" >> "$GALLERY_DATA_FILE"
fi

# Append gallery entry
echo "$GALLERY_ENTRY" >> "$GALLERY_DATA_FILE"

echo -e "${GREEN}✓ Updated $GALLERY_DATA_FILE${NC}"

# Summary
echo ""
echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║          Gallery Created!              ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "Gallery: ${GREEN}$GALLERY_NAME${NC}"
echo -e "Slug: ${GREEN}$GALLERY_SLUG${NC}"
echo -e "Images: ${GREEN}$((COUNTER - 1))${NC}"
echo -e "Location: ${GREEN}$GALLERY_FOLDER${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Review and edit captions in: ${CYAN}$GALLERY_DATA_FILE${NC}"
echo -e "2. View your gallery at: ${CYAN}http://localhost:4000/gallery/${NC}"
echo -e "3. Commit changes: ${CYAN}git add . && git commit -m 'Add $GALLERY_NAME gallery'${NC}"
echo ""
