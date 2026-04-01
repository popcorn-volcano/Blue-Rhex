param(
    [string]$sbRIOIP = "192.168.0.100"
)

# ============================================================================
# Orin2 Robot Control Script
# ============================================================================

Clear-Host

Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "                  Orin2 Setup - Robot Control" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "sbRIO IP: $sbRIOIP"
Write-Host "Master Address: $($sbRIOIP):50051"
Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""

# SSH into Orin and setup ROS environment
Write-Host "[STEP 1] Connecting to Jetson Orin Nano (Orin2)..." -ForegroundColor Yellow
Write-Host "Command: ssh jetson@192.168.0.102" -ForegroundColor Gray
Write-Host ""
Write-Host "[INFO] Setting up ROS2 environment for control commands..." -ForegroundColor Gray
Write-Host ""

# Build setup commands
$setupCommand = @"
cd ~/rinbo_ros_ws/; `
source /opt/ros/humble/setup.bash; `
source ~/rinbo_ros_ws/install/setup.bash; `
export CORE_MASTER_ADDR=$($sbRIOIP):50051; `
export CORE_LOCAL_IP=192.168.0.102; `
echo ""; `
echo "============================================"; `
echo "Orin2 Environment Setup Complete!"; `
echo "============================================"; `
echo ""; `
echo "Environment Variables:"; `
echo "  CORE_MASTER_ADDR: `$CORE_MASTER_ADDR"; `
echo "  CORE_LOCAL_IP: `$CORE_LOCAL_IP"; `
echo ""
"@

# Try to connect with a default user (may need adjustment)
$orinUser = "jetson"
$orinIP = "192.168.0.102"

Write-Host "[CONNECTING] SSH to $orinUser@$orinIP..." -ForegroundColor Yellow
Write-Host ""

# Attempt connection with setup
ssh $orinUser@$orinIP $setupCommand

Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "Control Commands Available:" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[1] POWER UP COMMAND" -ForegroundColor Green
Write-Host "    digital=true, signal=false, power=false" -ForegroundColor Gray
Write-Host "    Command in Orin2:" -ForegroundColor Gray
Write-Host "    ros2 topic pub --once /power/command rinbo_msgs/msg/PowerCmdStamped " + `
          """{header: {seq: 1, stamp: {sec: 0, nanosec: 0}}, digital: true,signal: false,power: false}""" -ForegroundColor White
Write-Host ""

Write-Host "[2] ENABLE SENSORS" -ForegroundColor Green
Write-Host "    digital=true, signal=true, power=false" -ForegroundColor Gray
Write-Host "    Command in Orin2:" -ForegroundColor Gray
Write-Host "    ros2 topic pub --once /power/command rinbo_msgs/msg/PowerCmdStamped " + `
          """{header: {seq: 1, stamp: {sec: 0, nanosec: 0}},digital: true,signal: true,power: false}""" -ForegroundColor White
Write-Host ""

Write-Host "[3] ENABLE RELAY" -ForegroundColor Green
Write-Host "    digital=true, signal=true, power=true" -ForegroundColor Gray
Write-Host "    Command in Orin2:" -ForegroundColor Gray
Write-Host "    ros2 topic pub --once /power/command rinbo_msgs/msg/PowerCmdStamped " + `
          """{header: {seq: 1, stamp: {sec: 0, nanosec: 0}},digital: true,signal: true,power: true}""" -ForegroundColor White
Write-Host ""

Write-Host "[4] CALIBRATE" -ForegroundColor Green
Write-Host "    Command: ros2 run rinbo_fsm rinbo_cali" -ForegroundColor White
Write-Host ""

Write-Host "[5] STANDING POSITION" -ForegroundColor Green
Write-Host "    Command: ros2 run rinbo_fsm rinbo_standing" -ForegroundColor White
Write-Host ""

Write-Host "[6] START TRIPOD GAIT (RUN!)" -ForegroundColor Green
Write-Host "    Command: ros2 run rinbo_fsm rinbo_tripod" -ForegroundColor White
Write-Host ""

Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "Keep this window open and execute commands as needed" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to close this window"
