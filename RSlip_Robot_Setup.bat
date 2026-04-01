@echo off
REM ============================================================================
REM R-Slip Robot Experiment Setup Script
REM ============================================================================
REM This batch file automates the setup and execution of the R-Slip robot
REM experiment across multiple machines (sbRIO and Jetson Orin Nano)
REM ============================================================================

setlocal enabledelayedexpansion

cls
echo.
echo ============================================================================
echo                 R-Slip Robot Experiment Setup
echo ============================================================================
echo.

REM Step 1: Get sbRIO IP Address
:GET_IP
cls
echo Step 1: Determine sbRIO IP Address
echo ============================================================================
echo.
echo Choose method to get IP address:
echo [1] Run 'arp -a' to find "NI sbRIO" IP
echo [2] Manually enter IP address
echo [3] Use default (192.168.0.100)
echo.
set /p METHOD="Enter choice (1-3): "

if "%METHOD%"=="1" (
    cls
    echo Running: arp -a
    echo.
    arp -a
    echo.
    echo Look for an entry with "NI sbRIO" or similar description
    echo.
    set /p ROBOT_IP="Enter the sbRIO IP address: "
) else if "%METHOD%"=="2" (
    set /p ROBOT_IP="Enter the sbRIO IP address: "
) else if "%METHOD%"=="3" (
    set ROBOT_IP=192.168.0.100
    echo Using default IP: !ROBOT_IP!
) else (
    echo Invalid choice. Please try again.
    goto GET_IP
)

REM Validate IP format
if not defined ROBOT_IP (
    echo ERROR: No IP address provided
    goto GET_IP
)

echo.
echo Confirmed sbRIO IP: !ROBOT_IP!
echo.

REM Get Orin IP (with intelligent guessing)
set /p ORIN_IP="Enter Jetson Orin Nano IP address (usually !ROBOT_IP:~0,-3!.101 or .102): "
if not defined ORIN_IP (
    set ORIN_IP=192.168.0.101
    echo Using default Orin IP: !ORIN_IP!
)

echo.
echo ============================================================================
echo Setup Summary:
echo   sbRIO IP: !ROBOT_IP!
echo   Orin IP:  !ORIN_IP!
echo ============================================================================
echo.
pause

REM ============================================================================
REM WINDOW 1: sbRIO Setup
REM ============================================================================
echo Launching sbRIO setup window...
start "sbRIO" cmd /k "call "%~dp0RSlip_sbRIO_Setup.bat" !ROBOT_IP! !ORIN_IP!"

timeout /t 2 /nobreak

REM ============================================================================
REM WINDOW 2: Orin1 (ROS Bridge)
REM ============================================================================
echo Launching Orin1 ROS bridge window...
start "Orin1-Bridge" powershell -NoExit -Command "& {. '%~dp0RSlip_Orin1_Bridge.ps1' -sbRIOIP '!ROBOT_IP!' -orinIP '!ORIN_IP!'}"

timeout /t 3 /nobreak

REM ============================================================================
REM WINDOW 3: Orin2 (Control Commands)
REM ============================================================================
echo Launching Orin2 control window...
start "Orin2-Control" powershell -NoExit -Command "& {. '%~dp0RSlip_Orin2_Control.ps1' -sbRIOIP '!ROBOT_IP!'}"

timeout /t 2 /nobreak

REM ============================================================================
REM Main Window Instructions
REM ============================================================================
cls
echo.
echo ============================================================================
echo                 R-Slip Robot Setup Complete
echo ============================================================================
echo.
echo Three new windows have been opened:
echo.
echo [1] sbRIO Window:
echo     - SSH connection to sbRIO
echo     - Starts grpccore and fpga_driver
echo     - Verifies services are running
echo.
echo [2] Orin1 Window (ROS Bridge):
echo     - Sets up ROS2 environment
echo     - Starts rinbo_ros_bridge
echo.
echo [3] Orin2 Window (Robot Control):
echo     - Sets up ROS2 environment for control
echo     - Ready for power and movement commands
echo.
echo ============================================================================
echo Next Steps:
echo ============================================================================
echo.
echo When all windows are ready (no errors), follow these steps in Orin2:
echo.
echo 1. POWER UP (digital=true, signal=false, power=false):
echo    [Run] Open Orin2 window and execute the provided power-up command
echo.
echo 2. ENABLE SENSORS (digital=true, signal=true, power=false):
echo    [Run] Execute the provided sensor enable command
echo.
echo 3. ENABLE RELAY (digital=true, signal=true, power=true):
echo    [Run] Execute the provided relay enable command
echo.
echo 4. CALIBRATE (standing position):
echo    [Run] ros2 run rinbo_fsm rinbo_cali
echo.
echo 5. START STANDING:
echo    [Run] ros2 run rinbo_fsm rinbo_standing
echo.
echo 6. START TRIPOD GAIT:
echo    [Run] ros2 run rinbo_fsm rinbo_tripod
echo.
echo ============================================================================
echo.
echo Check all three windows to ensure:
echo   - sbRIO: "grpccore" and "fpga_driver" are running
echo   - Orin1: "rinbo_ros_bridge" is connected
echo   - Orin2: Ready for commands
echo.
echo Press any key to close this window...
pause
