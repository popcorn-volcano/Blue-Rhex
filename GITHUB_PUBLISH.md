# Publishing to GitHub - Instructions

## Local Repository Status
✅ Git repository initialized locally  
✅ All files staged and committed  
✅ Ready to push to GitHub

## Steps to Complete:

### 1. Create Repository on GitHub
- Visit: https://github.com/new
- Repository name: `Blue Rhex`
- Description: `R-Slip Hexapod Robot Experiment Automation`
- Visibility: Public (or Private)
- Click "Create repository"

### 2. Get Your Repository URL
After creating, GitHub will show the URL:
- **HTTPS Format:** `https://github.com/YOUR_USERNAME/Blue-Rhex.git`
- **SSH Format:** `git@github.com:YOUR_USERNAME/Blue-Rhex.git`

(Use HTTPS if you haven't configured SSH keys)

### 3. Connect Local Repository to GitHub
Open PowerShell in the project folder and run:

```powershell
cd "c:\Users\jacob\OneDrive\NTU\NTU\LAB\Batch File for RHex"

# Add remote (replace with your actual URL)
git remote add origin https://github.com/YOUR_USERNAME/Blue-Rhex.git

# Set main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

### 4. Verify Success
- Your GitHub page should show all files
- README files should display automatically

### 5. Share the Link
Once published, provide the GitHub link:
- Format: `https://github.com/YOUR_USERNAME/Blue-Rhex`
- Example: `https://github.com/jacob/Blue-Rhex`

I'll then add it to PROJECT_SUMMARY.md

---

## Troubleshooting

**Error: "fatal: could not read Username"**
- You need to authenticate
- Option A: Use GitHub token (recommended)
  1. Generate token: https://github.com/settings/tokens
  2. Use token as password when prompted
- Option B: Configure SSH keys
  1. Setup guide: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

**Error: "remote origin already exists"**
- Run: `git remote remove origin`
- Then run the `git remote add origin` command again

**Error: "branch 'main' does not fully merge into 'master'"**
- Just skip the `git branch -M main` step if on different branch

---

**Once complete, send back the GitHub URL and I'll finalize PROJECT_SUMMARY.md**
