#!/bin/bash

# fr3akazo1d Personal Website - Quick Start Script
# This script helps you get started quickly

set -e

echo "=================================================="
echo "  fr3akazo1d Personal Website - Quick Start"
echo "=================================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git is not installed. Please install Git first.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Git is installed${NC}"

# Check if we're in a git repository
if [ -d .git ]; then
    echo -e "${CYAN}ℹ Git repository already initialized${NC}"
else
    echo -e "${CYAN}→ Initializing Git repository...${NC}"
    git init
    echo -e "${GREEN}✓ Git repository initialized${NC}"
fi

# Check if remote exists
if git remote | grep -q origin; then
    echo -e "${CYAN}ℹ Remote 'origin' already exists${NC}"
    CURRENT_REMOTE=$(git remote get-url origin)
    echo -e "  Current remote: $CURRENT_REMOTE"
    read -p "Do you want to change it? (y/N): " CHANGE_REMOTE
    if [[ $CHANGE_REMOTE =~ ^[Yy]$ ]]; then
        read -p "Enter your GitHub username: " GH_USERNAME
        read -p "Enter repository name (default: personal-website): " REPO_NAME
        REPO_NAME=${REPO_NAME:-personal-website}
        
        git remote remove origin
        git remote add origin "https://github.com/$GH_USERNAME/$REPO_NAME.git"
        echo -e "${GREEN}✓ Remote updated${NC}"
    fi
else
    echo -e "${CYAN}→ Setting up GitHub remote...${NC}"
    read -p "Enter your GitHub username: " GH_USERNAME
    read -p "Enter repository name (default: personal-website): " REPO_NAME
    REPO_NAME=${REPO_NAME:-personal-website}
    
    git remote add origin "https://github.com/$GH_USERNAME/$REPO_NAME.git"
    echo -e "${GREEN}✓ Remote added: https://github.com/$GH_USERNAME/$REPO_NAME.git${NC}"
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "")
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo -e "${CYAN}→ Switching to 'main' branch...${NC}"
    git branch -M main
    echo -e "${GREEN}✓ On 'main' branch${NC}"
fi

# Check for uncommitted changes
if [[ -n $(git status -s) ]]; then
    echo -e "${CYAN}→ Uncommitted changes detected${NC}"
    read -p "Do you want to commit all changes? (Y/n): " COMMIT_CHANGES
    if [[ ! $COMMIT_CHANGES =~ ^[Nn]$ ]]; then
        read -p "Enter commit message (default: Initial commit): " COMMIT_MSG
        COMMIT_MSG=${COMMIT_MSG:-"Initial commit: fr3akazo1d personal website"}
        
        git add .
        git commit -m "$COMMIT_MSG"
        echo -e "${GREEN}✓ Changes committed${NC}"
    fi
fi

echo ""
echo "=================================================="
echo "  Next Steps"
echo "=================================================="
echo ""
echo "1. Create GitHub repository (if not already created):"
echo "   → Go to https://github.com/new"
echo "   → Repository name: $REPO_NAME"
echo "   → Set to Public"
echo "   → DO NOT initialize with README"
echo ""
echo "2. Push your code:"
echo "   ${CYAN}git push -u origin main${NC}"
echo ""
echo "3. Enable GitHub Pages:"
echo "   → Go to repository Settings → Pages"
echo "   → Source: main branch, / (root)"
echo "   → Click Save"
echo ""
echo "4. Your site will be live at:"
echo "   ${GREEN}https://$GH_USERNAME.github.io/$REPO_NAME/${NC}"
echo ""
echo "=================================================="
echo "  Customization"
echo "=================================================="
echo ""
echo "Update the following in index.html:"
echo "  • Email address"
echo "  • GitHub profile links"
echo "  • LinkedIn URL"
echo "  • Twitter handle"
echo "  • Blog post content"
echo "  • Project descriptions"
echo ""
echo "See README.md for detailed instructions."
echo ""

read -p "Do you want to push to GitHub now? (y/N): " PUSH_NOW
if [[ $PUSH_NOW =~ ^[Yy]$ ]]; then
    echo -e "${CYAN}→ Pushing to GitHub...${NC}"
    if git push -u origin main 2>&1; then
        echo -e "${GREEN}✓ Successfully pushed to GitHub!${NC}"
        echo ""
        echo "Next: Enable GitHub Pages in your repository settings"
    else
        echo -e "${RED}✗ Push failed. You may need to create the repository first.${NC}"
        echo "Visit: https://github.com/new"
    fi
fi

echo ""
echo -e "${GREEN}✓ Setup complete! Happy hacking! 🚀${NC}"
echo ""
