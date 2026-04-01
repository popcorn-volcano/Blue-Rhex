# R-Slip Robot Experiment - Complete Setup & Troubleshooting Guide

**For quick start overview, see [README.md](README.md)**

## 🔧 Detailed Setup

### Prerequisites
- Windows 10/11 with OpenSSH client
- NI sbRIO with ROS2 workspace installed
- Jetson Orin Nano (x2) on same WiFi network
- IP addresses: sbRIO (192.168.0.100), Orin1 (192.168.0.101), Orin2 (192.168.0.102)

### Step 1: Launch Script
```bash
Double-click: RSlip_Robot_Setup.bat
```

### Step 2: Provide IP Addresses
- **sbRIO IP:** Auto-detect with `arp -a` or enter manually
- **Orin IP:** Usually .101 or .102 (script auto-guesses)

### Step 3: Wait for 3 Windows
- sbRIO window loads services
- Orin1 window starts ROS2 bridge
- Orin2 window prepares control interface

---

## ✅ Verification

After launching, check all 3 windows:

**sbRIO Window:**
- [ ] `grpccore` running (1 instance)
- [ ] `fpga_driver` running (1 instance)  
- [ ] `TCP on 50051` listening

**Orin1 Window:**
- [ ] "Environment Setup Complete"
- [ ] CORE_MASTER_ADDR and CORE_LOCAL_IP shown
- [ ] ROS2 bridge connected

**Orin2 Window:**
- [ ] Environment setup complete
- [ ] No SSH errors
- [ ] Control commands displayed

---

## 🎮 Robot Control Commands

Execute **in Orin2 window** in order:

### 1. Power Up
```bash
ros2 topic pub --once /power/command rinbo_msgs/msg/PowerCmdStamped "{header: {seq: 1, stamp: {sec: 0, nanosec: 0}}, digital: true,signal: false,power: false}"
```
**Expected:** Robot powers on (lights/beeps)

### 2. Enable Sensors
```bash
ros2 topic pub --once /power/command rinbo_msgs/msg/PowerCmdStamped "{header: {seq: 1, stamp: {sec: 0, nanosec: 0}},digital: true,signal: true,power: false}"
```
**Expected:** Sensors activate

### 3. Enable Relay (Full Power)
```bash
ros2 topic pub --once /power/command rinbo_msgs/msg/PowerCmdStamped "{header: {seq: 1, stamp: {sec: 0, nanosec: 0}},digital: true,signal: true,power: true}"
```
**Expected:** Main power relay engages

### 4. Calibrate
```bash
ros2 run rinbo_fsm rinbo_cali
```
**Expected:** Feet rotate to Hall sensor position and stop. **Must complete before next step!**

### 5. Standing Position
```bash
ros2 run rinbo_fsm rinbo_standing
```
**Expected:** Feet rotate 180° to standing position

### 6. Start Tripod Gait (Experiment!)
```bash
ros2 run rinbo_fsm rinbo_tripod
```
**Expected:** Robot starts tripod motion! 🤖

---

## 🔧 Default Configuration

| Component | Default Value | Notes |
|-----------|-------|-------|
| sbRIO IP | 192.168.0.100 | Customizable at startup |
| Orin1 IP | 192.168.0.101 | Auto-guessed, can change |
| Orin2 IP | 192.168.0.102 | Edit script if different |
| ROS2 Master Port | 50051 | Fixed channel |
| sbRIO User | admin | Fixed |
| sbRIO Password | admin | Fixed |
| Jetson User | jetson | Fixed |

**To change Orin2 IP permanently:**
- Edit `RSlip_Orin2_Control.ps1`
- Find: `$orinIP = "192.168.0.102"`
- Change to your actual Orin2 IP

---

## 🐛 Troubleshooting

### SSH Command Not Found
**Error:** `'ssh' is not recognized as an internal or external command`

**Fix:**
1. Open Settings → Apps → Apps & features
2. Find "Optional features"
3. Add "OpenSSH Client"
4. Restart PowerShell
5. Retry script

---

### Cannot Connect to sbRIO

**Symptoms:** `Connection refused` or `Connection timed out`

**Debugging:**
```powershell
# Check if sbRIO is online
ping 192.168.0.100

# Find sbRIO IP using ARP
arp -a | findstr "NI sbRIO"

# Or list all devices
arp -a
```

**Solutions:**
- Verify IP address is correct (use `arp -a` to confirm)
- Ensure sbRIO is powered on and connected to WiFi
- Check network connectivity: `ping 192.168.0.100`
- Verify SSH is enabled on sbRIO
- Try credentials manually: `ssh admin@192.168.0.100` (password: admin)

---

### Cannot Connect to Jetson Orin

**Symptoms:** `Connection refused` when connecting to 192.168.0.101 or .102

**Debugging:**
```powershell
# Test each Orin board
ping 192.168.0.101
ping 192.168.0.102
ping 192.168.0.103
```

**Solutions:**
- Verify Orin boards are powered on
- Check they're on the same WiFi network
- Get correct IP: Connect HDMI display to Jetson, login locally, run `hostname -I`
- Update IP address in script before running

---

### Services Don't Start (grpccore/fpga_driver)

**Symptoms:** Services shown as "command not found" or fail immediately

**Debugging:**
```bash
# SSH into sbRIO first
ssh admin@192.168.0.100

# Check if binaries exist
ls -la /home/admin/rinbo_sbRIO_ws/install/bin/grpccore
ls -la /home/admin/rinbo_sbRIO_ws/rinbo_fpga_driver/build/fpga_driver

# Check logs
cat /tmp/grpccore.log
cat /tmp/fpga_driver.log
```

**Solutions:**
- Verify build process completed on sbRIO: `colcon build`
- Check if binary paths match your installation
- Review error logs for missing dependencies
- Try starting services manually to see actual error messages

---

### Port 50051 Not Listening

**Symptoms:** `NO TCP on 50051` in sbRIO window

**Debugging:**
```bash
ssh admin@192.168.0.100

# Check if grpccore is actually running
ps -ef | grep grpccore

# Try starting manually
/home/admin/rinbo_sbRIO_ws/install/bin/grpccore

# View detailed logs
tail -f /tmp/grpccore.log
```

**Solutions:**
- Restart sbRIO: Ensure grpccore service started properly
- Check grpccore configuration file exists
- Verify grpccore binary can run (permission issues?)
- May need to supply config path to grpccore command

---

### Orin1/Orin2 Windows Hang or Timeout

**Symptoms:** Connection opens but waits indefinitely (30+ seconds)

**Cause:** sbRIO services not running properly

**Fix:**
1. Check sbRIO window first for errors
2. Ensure all services running: `ps -ef | egrep "grpccore|fpga_driver"`
3. Ensure port 50051 listening: `netstat -tn | grep 50051`
4. From the hanging Orin window, press Ctrl+C to cancel
5. Debug sbRIO issues, then retry

---

### ROS2 Commands Not Found

**Symptoms:** `Command "ros2" not found` in Orin windows

**Cause:** ROS2 Humble not installed or environment not sourced

**Fix:**
```bash
# Verify ROS2 installed
ls /opt/ros/humble/

# Manually source in that window
source /opt/ros/humble/setup.bash
source ~/rinbo_ros_ws/install/setup.bash

# Try ros2 command again
ros2 --version
```

---

### Robot Doesn't Respond to Power Command

**Symptoms:** Command executes but robot shows no response

**Debugging:**
```bash
# Verify message published
ros2 topic echo /power/command --once

# Check if message format correct
# Expected: {...digital: true, signal: false, power: false}

# If bridge not connected: Orin1 window may have disconnected
# Check Orin1 window for errors
```

**Solutions:**
1. Verify ROS2 bridge is connected (check Orin1 window)
2. Copy exact command from documentation (spacing/brackets matter)
3. Ensure calibration NOT required first
4. Check fpga_driver logs: `ssh admin@192.168.0.100` → `cat /tmp/fpga_driver.log`
5. Verify hardware connections/power supply

---

### Script Freezes/Hangs

**Symptoms:** Something seems stuck, no output progress

**Solutions:**
- **Password prompt hidden:** Script may be waiting for SSH password - type it (even if not visible) and press Enter
- **Network timeout:** Press Ctrl+C to cancel, check network, retry
- **Process deadlock:** Close window, restart script

---

## 🔄 Workflow Summary

1. **Startup:** Run `RSlip_Robot_Setup.bat`
2. **Configuration:** Enter IP addresses (can auto-detect)  
3. **Initialization:** Wait for 3 windows (~30 seconds)
4. **Verification:** Check all windows have no errors
5. **Power Sequence:** Run power/sensor/relay commands
6. **Calibration:** Run calibration and standing commands
7. **Execution:** Run tripod gait or custom sequence
8. **Cleanup:** Close windows after experiment

---

## 📝 Configuration Customization

### Edit Network IPs
- **sbRIO IP:** Prompted at startup each time
- **Orin1 IP:** Script parameter (edit RSlip_Orin1_Bridge.ps1 if persistent change needed)
- **Orin2 IP:** Edit `RSlip_Orin2_Control.ps1`, change `$orinIP = "192.168.0.102"`

### Edit Remote Paths
- Edit `RSlip_sbRIO_Setup.bat`
- Update paths if your sbRIO different setup:
  - `cd rinbo_sbRIO_ws/rinbo_fpga_driver/build/`
  - `/home/admin/rinbo_sbRIO_ws/install/bin/grpccore`

### Edit Credentials
- sbRIO: Edit `RSlip_sbRIO_Setup.bat` - change `admin` username if different
- Jetson: Hardcoded as `jetson` - edit PowerShell scripts if different

---

## ⚠️ Common Issues Quick-Fix Table

| Issue | Quick Fix |
|-------|-----------|
| SSH not found | Install OpenSSH client (Win Settings) |
| Cannot reach sbRIO | Check IP with `arp -a`, verify power |
| Cannot reach Orin | Power it on, verify IP, check WiFi |
| Services fail to start | Check log files: `/tmp/grpccore.log` |
| Port 50051 not listening | Restart sbRIO services |
| ROS2 bridge hangs | Verify sbRIO services running first |
| Robot doesn't move | Check calibration done, verify connections |
| Command not found | Re-source ROS2: `source /opt/ros/humble/setup.bash` |

---

## 🎯 Important Notes

- **All 3 windows must stay open** during entire experiment
- **Commands must run in order** (calibration before standing, etc.)
- **Calibration MUST complete** before standing position
- **Standing position MUST complete** before tripod gait begins
- Network must remain stable (WiFi shouldn't disconnect)
- SSH must be enabled on all machines
- Default credentials: sbRIO `admin/admin`, Jetson `jetson/[your-password]`

---

## 📞 Need More Help?

**Quick Diagnostic:**
```powershell
# Test network connectivity from Windows
ping 192.168.0.100    # sbRIO
ping 192.168.0.101    # Orin1
ping 192.168.0.102    # Orin2

# Check ARP table for device IPs
arp -a | grep -i "192.168.0"
```

**Collect for Support:**
- Screenshots of error messages
- Output of all 3 windows (last 50 lines)
- Result of `arp -a` showing your devices
- Network topology (how devices connected)
- Your Windows OS version

---

**Version:** 1.0  
**Updated:** 2026-03-31  
**Compatible:** ROS2 Humble, sbRIO, Jetson Orin Nano  
**Automation:** All 23+ steps condensed into one-click launch!
