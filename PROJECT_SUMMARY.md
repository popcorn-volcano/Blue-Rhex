# R-Slip Robot Experiment Automation - Introduction Summary

**GitHub Repository:** https://github.com/popcorn-volcano/Blue-Rhex

## Project Overview

The R-Slip is a hexapod robot platform designed for slip-based locomotion research. This project automates the complex multi-machine setup process, reducing 23+ manual SSH commands across distributed systems (Windows, sbRIO controller, Jetson Orin Nano boards) into a single-click launcher.

## Problem Solved

**Before:** Operators required:
- Manual SSH connections to multiple machines
- Sequential setup of network configurations
- Starting and verifying multiple services
- Coordinating three parallel system activations
- High error-prone complexity with 23+ individual steps

**After:** One-click automation handling:
- Intelligent IP detection and validation
- Automatic multi-window orchestration
- Service startup and health verification
- Complete environment variable configuration
- User-guided setup with clear feedback

## What It Does

1. **Orchestrates Multi-Machine Setup**
   - Windows PC → sbRIO (controller)
   - Windows PC → Jetson Orin Nano (Orin1: ROS bridge)
   - Windows PC → Jetson Orin Nano (Orin2: control)

2. **Automates Service Startup**
   - SSH authentication
   - grpccore service initialization
   - fpga_driver service activation
   - Network port verification (50051)

3. **Configures ROS2 Environment**
   - Sources ROS2 Humble setup
   - Sets master address and local IP
   - Starts communication bridge
   - Prepares control interface

4. **Enables Robot Operation**
   - One-click power sequence
   - Sensor calibration
   - Standing position control
   - Tripod gait execution

## Key Features

✅ **Single-Click Launch** - One batch file handles everything  
✅ **Intelligent IP Detection** - Auto-finds sbRIO, manual entry for customization  
✅ **Multi-Window Coordination** - Manages 3 parallel SSH sessions  
✅ **Service Verification** - Confirms all systems operational  
✅ **Comprehensive Documentation** - Setup guide, troubleshooting, quick reference  
✅ **Pre-Configured Commands** - Ready-to-execute robot control sequence  

## Technical Stack

- **Automation:** Batch scripts (.bat) and PowerShell (.ps1)
- **Connectivity:** SSH over WiFi
- **Platforms:** Windows 10/11, NI sbRIO, Jetson Orin Nano
- **Middleware:** ROS2 Humble, gRPC
- **Network:** 192.168.0.x WiFi, port 50051

## Workflow

1. Run `RSlip_Robot_Setup.bat`
2. Input sbRIO IP (auto-detected or manual)
3. Wait 30 seconds for 3 windows to open
4. Verify services running (sbRIO, Orin1, Orin2)
5. Execute robot control commands in sequence
6. Start tripod gait experiment

## Impact

- **Reduces Setup Time:** 15+ minutes → 30 seconds
- **Eliminates Manual Errors:** Scripted automation vs manual typing
- **Improves Reproducibility:** Consistent startup procedure
- **Lowers Learning Curve:** Single script vs 23+ individual commands
- **Saves Developer Time:** Focus on research, not system setup

---

**Files Delivered:**
- RSlip_Robot_Setup.bat (main launcher)
- 3 supporting PowerShell/Batch scripts
- SETUP_GUIDE.md (comprehensive documentation)

**Status:** ✅ Complete and ready for deployment
