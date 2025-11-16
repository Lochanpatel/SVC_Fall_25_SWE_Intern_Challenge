#!/bin/bash

# GitHub Push Automation Script
# Complete setup and push for SVC Testing Challenge

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   GitHub Push - SVC Testing Challenge  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"

# Step 1: Verify prerequisites
echo -e "${YELLOW}Step 1: Verifying prerequisites...${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git not found. Install from https://git-scm.com${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Git is installed${NC}"

if ! command -v npm &> /dev/null; then
    echo -e "${RED}✗ Node/npm not found. Install from https://nodejs.org${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Node/npm is installed${NC}\n"

# Step 2: Verify build
echo -e "${YELLOW}Step 2: Verifying project builds...${NC}"
npm run build > /dev/null 2>&1
echo -e "${GREEN}✓ Project builds successfully${NC}\n"

# Step 3: Get GitHub details
echo -e "${YELLOW}Step 3: GitHub configuration${NC}"
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter your GitHub email: " GITHUB_EMAIL
echo ""

# Step 4: Configure git
echo -e "${YELLOW}Step 4: Configuring git...${NC}"
git config user.name "$GITHUB_USERNAME"
git config user.email "$GITHUB_EMAIL"
echo -e "${GREEN}✓ Git configured${NC}\n"

# Step 5: Check git status
echo -e "${YELLOW}Step 5: Checking git status...${NC}"
git status
echo ""

# Step 6: Add files
echo -e "${YELLOW}Step 6: Adding files to git...${NC}"
git add -A
CHANGES=$(git status --short | wc -l)
echo -e "${GREEN}✓ Added $CHANGES files${NC}\n"

# Step 7: Create commit
echo -e "${YELLOW}Step 7: Creating commit...${NC}"
git commit -m "Add comprehensive testing infrastructure with 100% coverage enforcement

- Frontend and backend test suites with vitest
- 20+ new test files for components, routes, and schemas
- GitHub Actions CI/CD with Docker PostgreSQL support
- 100% code coverage thresholds on all metrics
- Comprehensive TESTING_REPORT.md documentation
- Node 20 LTS specification and environment configuration
- Fixed build issues and verified successful compilation
- Production-ready testing infrastructure" || echo -e "${YELLOW}Note: No changes to commit${NC}"

COMMIT=$(git log -1 --pretty=format:"%h - %s" 2>/dev/null || echo "Initial commit")
echo -e "${GREEN}✓ Commit created: $COMMIT${NC}\n"

# Step 8: Show instructions
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        Next Steps (Manual)             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"

echo -e "${YELLOW}1. Fork the repository on GitHub:${NC}"
echo -e "   ${BLUE}https://github.com/Silicon-Valley-Consulting/SVC_Fall_25_SWE_Intern_Challenge${NC}"
echo -e "   → Click 'Fork' button\n"

echo -e "${YELLOW}2. Add your fork as remote:${NC}"
echo -e "   ${BLUE}git remote add origin https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge.git${NC}\n"

echo -e "${YELLOW}3. Rename branch to main:${NC}"
echo -e "   ${BLUE}git branch -M main${NC}\n"

echo -e "${YELLOW}4. Push to GitHub (choose one):${NC}"
echo -e "   ${BLUE}Option A (HTTPS):${NC}"
echo -e "   git push -u origin main"
echo -e "   ${BLUE}Option B (SSH):${NC}"
echo -e "   git push -u origin main\n"

echo -e "${YELLOW}5. Verify on GitHub:${NC}"
echo -e "   ${BLUE}https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge${NC}"
echo -e "   ${BLUE}https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge/actions${NC}\n"

echo -e "${GREEN}✅ Setup complete!${NC}"
echo -e "${YELLOW}Follow the steps above to complete the push to GitHub.${NC}\n"

# Optional: Ask if they want to try automatic push
echo -e "${YELLOW}Would you like to try automatic push? (requires SSH or Personal Access Token)${NC}"
read -p "Continue? (y/n): " CONTINUE

if [[ $CONTINUE == "y" || $CONTINUE == "Y" ]]; then
    echo ""
    echo -e "${YELLOW}Step 8: Setting up remote and pushing...${NC}"

    # Check if origin already exists
    if git remote get-url origin &> /dev/null; then
        echo -e "${YELLOW}Updating existing remote...${NC}"
        git remote set-url origin "https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge.git"
    else
        echo -e "${YELLOW}Adding new remote...${NC}"
        git remote add origin "https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge.git"
    fi

    git branch -M main

    echo -e "${YELLOW}Attempting to push...${NC}"
    if git push -u origin main 2>&1; then
        echo -e "${GREEN}✓ Push successful!${NC}"
        echo -e "${GREEN}✓ View your repository at:${NC}"
        echo -e "${BLUE}https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge${NC}\n"
    else
        echo -e "${RED}✗ Push failed. Try manual push with Personal Access Token or SSH.${NC}\n"
    fi
fi

# Final summary
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          Summary                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"

echo "GitHub Username: $GITHUB_USERNAME"
echo "GitHub Email: $GITHUB_EMAIL"
echo "Repository: https://github.com/$GITHUB_USERNAME/SVC_Fall_25_SWE_Intern_Challenge"
echo "Branch: main"
echo ""
echo -e "${YELLOW}After pushing, send submission email to:${NC}"
echo "Stephanie.mcghee@siliconvalleyconsulting.io"
echo ""
echo -e "${YELLOW}Subject:${NC} SWE Intern — Testing Challenge — $GITHUB_USERNAME"
echo ""
echo -e "${GREEN}✅ Script complete!${NC}\n"
