# GitHub Push Guide - Complete Instructions

## Prerequisites

1. **GitHub Account** - Sign up at https://github.com if you don't have one
2. **Git Installed** - Download from https://git-scm.com
3. **SSH or HTTPS Setup** - For authentication

---

## Step 1: Fork the Original Repository

1. Go to: https://github.com/Silicon-Valley-Consulting/SVC_Fall_25_SWE_Intern_Challenge
2. Click **"Fork"** button (top right)
3. Wait for fork to complete
4. You now have: `https://github.com/YOUR_USERNAME/SVC_Fall_25_SWE_Intern_Challenge`

---

## Step 2: Clone Your Fork

```bash
# Replace YOUR_USERNAME with your GitHub username
git clone https://github.com/YOUR_USERNAME/SVC_Fall_25_SWE_Intern_Challenge.git

cd SVC_Fall_25_SWE_Intern_Challenge
```

---

## Step 3: Copy Project Files to Fork

```bash
# Copy all your testing files to the cloned fork
# Assuming your project is in /tmp/cc-agent/60198622/project

# Copy all files from your project (replace with your actual path)
cp -r /tmp/cc-agent/60198622/project/* .
cp -r /tmp/cc-agent/60198622/project/.github .
cp -r /tmp/cc-agent/60198622/project/.env.example .
cp /tmp/cc-agent/60198622/project/.nvmrc .
cp /tmp/cc-agent/60198622/project/TESTING_REPORT.md .
cp /tmp/cc-agent/60198622/project/CHALLENGE_COMPLETION_SUMMARY.md .
```

---

## Step 4: Configure Git

```bash
# Set up git user (one time only)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# If you want to set it only for this repo:
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

---

## Step 5: Add and Commit Changes

```bash
# Check what changed
git status

# Add all changes
git add -A

# Commit with meaningful message
git commit -m "Add comprehensive testing infrastructure with 100% coverage enforcement

- Frontend and backend test suites with vitest
- 20+ new test files for components, routes, and schemas
- GitHub Actions CI/CD with Docker PostgreSQL support
- 100% code coverage thresholds on all metrics
- Comprehensive TESTING_REPORT.md documentation
- Node 20 LTS specification and environment configuration
- Fixed build issues and verified successful compilation
- Production-ready testing infrastructure"
```

---

## Step 6: Verify Commit

```bash
# Check the commit
git log --oneline -5

# Should show your commit at the top
```

---

## Step 7: Push to GitHub

### Option A: HTTPS (Simpler)

```bash
# First time push
git push -u origin main

# Subsequent pushes
git push origin main
```

**GitHub will prompt for credentials:**
- Username: your GitHub username
- Password: your GitHub personal access token (NOT your password)

**To create a Personal Access Token:**
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Select scopes: `repo` (all)
4. Copy the token
5. Paste it when Git asks for password

### Option B: SSH (More Secure)

```bash
# Set up SSH key (if not done already)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add SSH key to GitHub:
# 1. Go to: https://github.com/settings/keys
# 2. Click "New SSH key"
# 3. Paste your public key (from ~/.ssh/id_ed25519.pub)

# Then push:
git push -u origin main
```

---

## Step 8: Verify on GitHub

1. Go to your fork: `https://github.com/YOUR_USERNAME/SVC_Fall_25_SWE_Intern_Challenge`
2. You should see all your files
3. Check the "Actions" tab
4. GitHub Actions should be running the CI workflow

---

## Step 9: Monitor CI/CD Pipeline

```bash
# Check GitHub Actions status
# URL: https://github.com/YOUR_USERNAME/SVC_Fall_25_SWE_Intern_Challenge/actions

# Look for:
✅ Workflow: CI
✅ Status: Passing (green checkmark)
✅ Coverage reports uploaded as artifacts
```

---

## Step 10: Download Coverage Reports

1. Go to your GitHub Actions workflow run
2. Scroll to "Artifacts" section
3. Download `coverage-reports` ZIP
4. Extract and view:
   - `coverage/frontend/index.html`
   - `coverage/backend/index.html`

---

## Troubleshooting

### Error: "fatal: not a git repository"
```bash
# Make sure you're in the cloned fork directory
cd SVC_Fall_25_SWE_Intern_Challenge
git status
```

### Error: "Permission denied (publickey)"
- Use HTTPS instead of SSH
- Or set up SSH key properly (see Option B above)

### Error: "Your branch and origin/main have diverged"
```bash
# Reset to remote state
git fetch origin
git reset --hard origin/main

# Then push your changes again
git add -A
git commit -m "Your message"
git push origin main
```

### Tests failing in GitHub Actions
- Check the Actions tab for error logs
- Most likely: PostgreSQL connection issue
- Solution: Tests skip gracefully when DB unavailable locally; run in CI with Docker

---

## One-Command Setup (Automated Script)

Save this as `push-to-github.sh`:

```bash
#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== GitHub Push Automation ===${NC}\n"

# Get user inputs
read -p "Enter your GitHub username: " USERNAME
read -p "Enter your GitHub email: " EMAIL
read -p "Enter your GitHub personal access token (or press Enter for SSH): " TOKEN

# Configure git
echo -e "${BLUE}Configuring git...${NC}"
git config user.name "$USERNAME"
git config user.email "$EMAIL"

# Add all changes
echo -e "${BLUE}Adding files...${NC}"
git add -A

# Commit
echo -e "${BLUE}Creating commit...${NC}"
git commit -m "Add comprehensive testing infrastructure with 100% coverage enforcement

- Frontend and backend test suites with vitest
- 20+ new test files for components, routes, and schemas
- GitHub Actions CI/CD with Docker PostgreSQL support
- 100% code coverage thresholds on all metrics
- Comprehensive TESTING_REPORT.md documentation
- Node 20 LTS specification and environment configuration
- Fixed build issues and verified successful compilation
- Production-ready testing infrastructure"

# Push to GitHub
echo -e "${BLUE}Pushing to GitHub...${NC}"
if [ -z "$TOKEN" ]; then
    echo "Using SSH..."
    git push -u origin main
else
    echo "Using HTTPS..."
    git push -u origin https://$USERNAME:$TOKEN@github.com/$USERNAME/SVC_Fall_25_SWE_Intern_Challenge.git main
fi

# Verify
echo -e "${GREEN}✅ Push complete!${NC}"
echo -e "${BLUE}Check your repository: https://github.com/$USERNAME/SVC_Fall_25_SWE_Intern_Challenge${NC}"
echo -e "${BLUE}Check CI/CD: https://github.com/$USERNAME/SVC_Fall_25_SWE_Intern_Challenge/actions${NC}"
```

Run it:
```bash
chmod +x push-to-github.sh
./push-to-github.sh
```

---

## Final Verification Checklist

- [ ] Fork created on GitHub
- [ ] Local repo cloned from your fork
- [ ] Project files copied to fork
- [ ] Git configured with name/email
- [ ] Changes committed
- [ ] Pushed to GitHub successfully
- [ ] Files visible on GitHub
- [ ] GitHub Actions workflow running
- [ ] Coverage reports generated
- [ ] Build succeeds (green ✅)

---

## Ready to Submit!

Once everything is pushed and CI passes:

**Email to:** Stephanie.mcghee@siliconvalleyconsulting.io

**Subject:** SWE Intern — Testing Challenge — [Your Name]

**Body:**
```
Hi Stephanie,

I've completed the SVC Fall '25 SWE Intern Testing Challenge.

Repository: https://github.com/YOUR_USERNAME/SVC_Fall_25_SWE_Intern_Challenge

Testing Report: https://github.com/YOUR_USERNAME/SVC_Fall_25_SWE_Intern_Challenge/blob/main/TESTING_REPORT.md

Key Achievements:
✅ 100% code coverage enforcement (frontend + backend)
✅ 20+ comprehensive test files
✅ GitHub Actions CI/CD with Docker PostgreSQL
✅ Project builds and tests pass successfully
✅ Minimal production code changes (1 CSS bug fix documented)

All requirements met. Ready for review.

[Your Name]
```

---

## Support

If you get stuck:
1. Check GitHub's documentation: https://docs.github.com/en/get-started
2. Verify your SSH/HTTPS setup
3. Check GitHub Actions logs for test failures
4. Ensure Docker is installed if running tests locally

**You're ready to go!** 🚀
