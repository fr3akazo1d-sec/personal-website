#!/bin/bash

# Jekyll Cleanup Script
# Removes all Jekyll dependencies, build artifacts, and locally installed gems
# Use this when you're done with local development and want to clean up

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║         Jekyll Environment Cleanup Script                 ║"
echo "║         Removes all dependencies and build artifacts      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Confirm before proceeding
echo -e "${YELLOW}⚠️  WARNING: This will remove:${NC}"
echo "  - Jekyll build artifacts (_site/)"
echo "  - Locally installed gems (vendor/bundle/)"
echo "  - Bundle configuration (.bundle/)"
echo "  - Gemfile.lock (dependency lock file)"
echo "  - Ruby version files (.ruby-version, .ruby-gemset)"
echo ""
read -p "Are you sure you want to continue? (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Cleanup cancelled.${NC}"
    exit 0
fi

echo ""
echo -e "${CYAN}Starting cleanup...${NC}"
echo ""

# Function to remove directory/file with status
remove_item() {
    local item=$1
    local description=$2
    
    if [ -e "$item" ]; then
        echo -e "${YELLOW}Removing $description...${NC}"
        rm -rf "$item"
        echo -e "${GREEN}✓ Removed: $item${NC}"
    else
        echo -e "${CYAN}⊘ Not found: $item (already clean)${NC}"
    fi
}

# Remove build artifacts
remove_item "_site" "Jekyll build directory"
remove_item ".jekyll-cache" "Jekyll cache"
remove_item ".jekyll-metadata" "Jekyll metadata"

# Remove local gems
remove_item "vendor" "locally installed gems"
remove_item ".bundle" "bundle configuration"

# Remove lock files
remove_item "Gemfile.lock" "Gemfile lock"

# Remove Ruby version files
remove_item ".ruby-version" "Ruby version file"
remove_item ".ruby-gemset" "Ruby gemset file"

# Remove any temporary files
remove_item ".sass-cache" "Sass cache"
remove_item "node_modules" "Node modules (if any)"

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Cleanup complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYAN}Your repository is now clean.${NC}"
echo -e "${CYAN}To set up Jekyll again, run: ${YELLOW}./setup-jekyll.sh${NC}"
echo ""
echo -e "${YELLOW}Note: Ruby itself was NOT removed.${NC}"
echo -e "${YELLOW}To remove Ruby completely, use your system's package manager:${NC}"
echo "  - macOS (Homebrew): brew uninstall ruby"
echo "  - Arch Linux: sudo pacman -R ruby"
echo "  - Debian/Ubuntu: sudo apt remove ruby-full"
echo "  - Fedora: sudo dnf remove ruby"
echo "  - RHEL/CentOS: sudo yum remove ruby"
echo ""
