#!/bin/bash

# Jekyll Site Setup Script for fr3akazo1d
# This script sets up your Jekyll environment

set -e

echo "=================================================="
echo "  🚀 Jekyll Setup for fr3akazo1d Website"
echo "=================================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Ruby is installed
echo -e "${CYAN}→ Checking Ruby installation...${NC}"
if ! command -v ruby &> /dev/null; then
    echo -e "${RED}✗ Ruby is not installed${NC}"
    echo ""
    echo "Please install Ruby first:"
    echo "  macOS:   brew install ruby"
    echo "  Ubuntu:  sudo apt install ruby-full build-essential"
    echo "  Fedora:  sudo dnf install ruby ruby-devel"
    echo ""
    exit 1
fi

RUBY_VERSION=$(ruby -v | awk '{print $2}')
echo -e "${GREEN}✓ Ruby ${RUBY_VERSION} installed${NC}"

# Check if Bundler is installed
echo -e "${CYAN}→ Checking Bundler installation...${NC}"
if ! command -v bundle &> /dev/null; then
    echo -e "${YELLOW}⚠ Bundler not found, installing...${NC}"
    gem install bundler
    echo -e "${GREEN}✓ Bundler installed${NC}"
else
    echo -e "${GREEN}✓ Bundler already installed${NC}"
fi

# Install Jekyll dependencies
echo ""
echo -e "${CYAN}→ Installing Jekyll and dependencies...${NC}"
echo "This may take a few minutes..."
bundle install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Dependencies installed successfully!${NC}"
else
    echo -e "${RED}✗ Failed to install dependencies${NC}"
    echo "Try running: bundle install --verbose"
    exit 1
fi

# Create _site directory if it doesn't exist
mkdir -p _site

echo ""
echo "=================================================="
echo "  ✅ Jekyll Setup Complete!"
echo "=================================================="
echo ""
echo -e "${GREEN}Your Jekyll site is ready!${NC}"
echo ""
echo "📝 Next steps:"
echo ""
echo "1. Start the development server:"
echo -e "   ${CYAN}bundle exec jekyll serve${NC}"
echo ""
echo "2. Open your browser:"
echo -e "   ${CYAN}http://localhost:4000${NC}"
echo ""
echo "3. Create new blog posts:"
echo -e "   ${CYAN}nano _posts/$(date +%Y-%m-%d)-my-new-post.md${NC}"
echo ""
echo "4. Jekyll will rebuild automatically when you save!"
echo ""
echo "=================================================="
echo "  📚 Quick Commands"
echo "=================================================="
echo ""
echo "Start server:        bundle exec jekyll serve"
echo "Build site:          bundle exec jekyll build"
echo "Serve with drafts:   bundle exec jekyll serve --drafts"
echo "Live reload:         bundle exec jekyll serve --livereload"
echo ""
echo "=================================================="
echo ""
echo -e "${CYAN}💡 Tip: Blog posts must be named: YYYY-MM-DD-title.md${NC}"
echo ""
