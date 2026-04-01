param(
    [string]$sbRIOIP = "192.168.0.100",
    [string]$orinIP = "192.168.0.101"
)

# ============================================================================
# Orin1 ROS Bridge Setup Script
# ============================================================================

Clear-Host

Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "                  Orin1 Setup - ROS2 Bridge" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "sbRIO IP: $sbRIOIP"
Write-Host "Orin IP:  $orinIP"
Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""

# SSH into Orin and setup
Write-Host "[STEP 1] Connecting to Jetson Orin Nano (Orin1)..." -ForegroundColor Yellow
Write-Host "Command: ssh jetson@$orinIP" -ForegroundColor Gray
Write-Host ""
Write-Host "When prompted for password, enter your Orin password (usually: jetson)" -ForegroundColor Gray
Write-Host ""

# Build the SSH command
$sshCommand = @"
cd ~/rinbo_ros_ws/; `
source /opt/ros/humble/setup.bash; `
source ~/rinbo_ros_ws/install/setup.bash; `
export CORE_MASTER_ADDR=$($sbRIOIP):50051; `
export CORE_LOCAL_IP=$orinIP; `
echo ""; `
echo "============================================"; `
echo "Orin1 Environment Setup Complete"; `
echo "============================================"; `
echo ""; `
echo "Environment Variables:"; `
echo "  CORE_MASTER_ADDR: `$CORE_MASTER_ADDR"; `
echo "  CORE_LOCAL_IP: `$CORE_LOCAL_IP"; `
echo ""; `
echo "============================================"; `
echo "Starting ROS2 Bridge..."; `
echo "============================================"; `
echo ""; `
ros2 run rinbo_ros_bridge rinbo_ros_bridge; `
"@

ssh jetson@$orinIP $sshCommand

Write-Host ""
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host "Orin1 Bridge Connection Closed" -ForegroundColor Cyan
Write-Host "============================================================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to close this window"
