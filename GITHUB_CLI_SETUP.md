# GitHub CLI Setup & Auto-Publish

GitHub CLI is installed but needs authentication. Follow these steps:

## Step 1: Authenticate GitHub CLI

Run this in PowerShell:

```powershell
&"C:\Program Files\GitHub CLI\gh.exe" auth login
```

When prompted:
- Choose: **GitHub.com**
- Choose authentication method: **HTTPS** (easier) or **SSH**
- When asked for token: 
  - If you have one, paste it
  - If not, choose "Paste an authentication token" and generate one at: https://github.com/settings/tokens

## Step 2: After Authentication, Run This

```powershell
cd "c:\Users\jacob\OneDrive\NTU\NTU\LAB\Batch File for RHex"

# Create repository on GitHub
&"C:\Program Files\GitHub CLI\gh.exe" repo create Blue-Rhex --public --source=. --remote=origin --push
```

This will:
1. Create repository "Blue-Rhex" on GitHub as Public
2. Set up remote connection
3. Push all files automatically

## Step 3: Get Your Repository Link

After successful push, your repository will be at:

```
https://github.com/YOUR_USERNAME/Blue-Rhex
```

---

## Quick Commands Summary

```powershell
# Login to GitHub
&"C:\Program Files\GitHub CLI\gh.exe" auth login

# Check status
&"C:\Program Files\GitHub CLI\gh.exe" auth status

# Create and push repo (from project folder)
&"C:\Program Files\GitHub CLI\gh.exe" repo create Blue-Rhex --public --source=. --remote=origin --push
```

---

**Once published, provide the GitHub link and I'll add it to PROJECT_SUMMARY.md**
