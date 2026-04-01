@echo off
REM ============================================================================
REM Blue Rhex - GitHub Publishing Automation
REM ============================================================================
REM This script automates GitHub CLI authentication and repository creation
REM ============================================================================

setlocal enabledelayedexpansion

cls
echo.
echo ============================================================================
echo                   Blue Rhex - GitHub Auto-Publisher
echo ============================================================================
echo.

REM Check if GitHub CLI is installed
if not exist "C:\Program Files\GitHub CLI\gh.exe" (
    echo ERROR: GitHub CLI not found at C:\Program Files\GitHub CLI\gh.exe
    echo.
    echo Please install GitHub CLI from: https://cli.github.com/
    echo.
    pause
    exit /b 1
)

REM Check authentication status
echo [STEP 1/3] Checking GitHub CLI authentication...
echo.

"C:\Program Files\GitHub CLI\gh.exe" auth status >nul 2>&1
if errorlevel 1 (
    echo GitHub CLI is not authenticated yet.
    echo.
    echo [ACTION REQUIRED] A browser window will open to authenticate with GitHub.
    echo.
    pause
    
    REM Perform authentication
    "C:\Program Files\GitHub CLI\gh.exe" auth login
    
    if errorlevel 1 (
        echo.
        echo ERROR: Authentication failed
        echo.
        pause
        exit /b 1
    )
)

echo ✓ Authentication verified
echo.

REM Step 2: Navigate to project directory
echo [STEP 2/3] Preparing repository...
cd /d "c:\Users\jacob\OneDrive\NTU\NTU\LAB\Batch File for RHex"

if errorlevel 1 (
    echo ERROR: Could not change to project directory
    pause
    exit /b 1
)

echo ✓ Project directory ready
echo.

REM Step 3: Create and push repository
echo [STEP 3/3] Creating and publishing repository on GitHub...
echo.
echo Command: gh repo create Blue-Rhex --public --source=. --remote=origin --push
echo.

"C:\Program Files\GitHub CLI\gh.exe" repo create Blue-Rhex --public --source=. --remote=origin --push

if errorlevel 1 (
    echo.
    echo ERROR: Repository creation failed
    echo.
    echo Possible reasons:
    echo - Repository "Blue-Rhex" already exists on your GitHub
    echo - Network connectivity issue
    echo - GitHub authentication issue
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================================================
echo                    ✓ SUCCESS - Repository Published!
echo ============================================================================
echo.

REM Get username for link display
for /f "tokens=*" %%A in ('"C:\Program Files\GitHub CLI\gh.exe" api user -q .login 2^>nul"') do set USERNAME=%%A

if defined USERNAME (
    echo Repository URL:
    echo   https://github.com/!USERNAME!/Blue-Rhex
    echo.
    echo Repository created as PUBLIC - visible to everyone
    echo.
) else (
    echo Repository has been created successfully on GitHub.
    echo Check your GitHub profile to find the "Blue-Rhex" repository.
    echo.
)

echo Next steps:
echo 1. Share your GitHub link
echo 2. I will add it to PROJECT_SUMMARY.md
echo 3. Repository will be finalized
echo.

pause
