@echo off
REM ============================================================================
REM sbRIO Setup Script
REM Handles SSH connection and service startup on sbRIO
REM ============================================================================

setlocal enabledelayedexpansion

set ROBOT_IP=%~1
set ORIN_IP=%~2

if not defined ROBOT_IP (
    echo ERROR: sbRIO IP address not provided
    pause
    exit /b 1
)

if not defined ORIN_IP (
    set ORIN_IP=192.168.0.101
)

cls
echo.
echo ============================================================================
echo                 sbRIO Setup - SSH and Service Startup
echo ============================================================================
echo.
echo Robot IP:  !ROBOT_IP!
echo Orin IP:   !ORIN_IP!
echo.
echo ============================================================================
echo.

REM Step 2: SSH into sbRIO
echo [STEP 1/2] Connecting to sbRIO via SSH...
echo Command: ssh admin@!ROBOT_IP!
echo.
echo When prompted, enter password: admin
echo.

ssh admin@!ROBOT_IP! "cd /home/admin/rinbo_sbRIO_ws/rinbo_fpga_driver/build/ && export CORE_LOCAL_IP=!ROBOT_IP! && export CORE_MASTER_ADDR=!ROBOT_IP!:50051 && echo. && echo ============================================ && echo Starting grpccore service... && echo ============================================ && nohup /home/admin/rinbo_sbRIO_ws/install/bin/grpccore >/tmp/grpccore.log 2>&1 & && sleep 2 && echo. && echo ============================================ && echo Starting fpga_driver service... && echo ============================================ && nohup /home/admin/rinbo_sbRIO_ws/rinbo_fpga_driver/build/fpga_driver >/tmp/fpga_driver.log 2>&1 & && sleep 2 && echo. && echo ============================================ && echo Verifying services... && echo ============================================ && ps -ef | egrep 'grpccore|fpga_driver' | grep -v grep && echo. && echo ============================================ && echo Checking TCP port 50051... && echo ============================================ && netstat -tn | grep 50051 || echo 'NO TCP on 50051' && echo. && echo ============================================ && echo sbRIO Setup Complete! && echo ============================================ && echo. && echo Keep this window open. Services are running in background. && echo. && echo sbRIO is ready for Orin connection. && echo."

if errorlevel 1 (
    echo.
    echo ERROR: Connection or setup failed
    echo.
    echo Troubleshooting:
    echo - Verify sbRIO IP address is correct
    echo - Ensure sbRIO is connected to network
    echo - Check SSH is enabled on sbRIO
    echo - Verify password (default: admin)
    echo.
)

echo.
echo ============================================================================
echo Keep this window open while running the experiment
echo ============================================================================
echo.
pause
