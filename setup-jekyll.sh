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

# Detect OS
echo -e "${CYAN}→ Detecting operating system...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo -e "${GREEN}✓ macOS detected${NC}"
elif [ -f /etc/arch-release ]; then
    OS="arch"
    echo -e "${GREEN}✓ Arch Linux detected${NC}"
elif [ -f /etc/debian_version ]; then
    OS="debian"
    echo -e "${GREEN}✓ Debian/Ubuntu detected${NC}"
elif [ -f /etc/fedora-release ]; then
    OS="fedora"
    echo -e "${GREEN}✓ Fedora detected${NC}"
elif [ -f /etc/redhat-release ]; then
    OS="rhel"
    echo -e "${GREEN}✓ RHEL/CentOS detected${NC}"
else
    OS="unknown"
    echo -e "${YELLOW}⚠ Unknown OS, will attempt generic installation${NC}"
fi

# Check if Ruby is installed
echo -e "${CYAN}→ Checking Ruby installation...${NC}"
if ! command -v ruby &> /dev/null; then
    echo -e "${YELLOW}⚠ Ruby is not installed${NC}"
    echo ""
    
    # Auto-install Ruby based on OS
    case $OS in
        macos)
            echo -e "${CYAN}→ Installing Ruby via Homebrew...${NC}"
            if ! command -v brew &> /dev/null; then
                echo -e "${RED}✗ Homebrew not found. Please install it first:${NC}"
                echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
                exit 1
            fi
            brew install ruby
            ;;
        arch)
            echo -e "${CYAN}→ Installing Ruby and dependencies...${NC}"
            sudo pacman -S --noconfirm ruby base-devel
            ;;
        debian)
            echo -e "${CYAN}→ Installing Ruby and dependencies...${NC}"
            sudo apt update
            sudo apt install -y ruby-full build-essential zlib1g-dev
            ;;
        fedora)
            echo -e "${CYAN}→ Installing Ruby and dependencies...${NC}"
            sudo dnf install -y ruby ruby-devel @development-tools
            ;;
        rhel)
            echo -e "${CYAN}→ Installing Ruby and dependencies...${NC}"
            sudo yum install -y ruby ruby-devel gcc gcc-c++ make
            ;;
        *)
            echo -e "${RED}✗ Cannot auto-install Ruby on this system${NC}"
            echo ""
            echo "Please install Ruby manually:"
            echo "  macOS:   brew install ruby"
            echo "  Ubuntu:  sudo apt install ruby-full build-essential zlib1g-dev"
            echo "  Arch:    sudo pacman -S ruby base-devel"
            echo "  Fedora:  sudo dnf install ruby ruby-devel @development-tools"
            echo ""
            exit 1
            ;;
    esac
    
    # Verify installation
    if ! command -v ruby &> /dev/null; then
        echo -e "${RED}✗ Ruby installation failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ Ruby installed successfully${NC}"
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
