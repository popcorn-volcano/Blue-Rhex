# Blue Rhex - R-Slip Robot Automation

[![GitHub](https://img.shields.io/badge/GitHub-popcorn--volcano/Blue--Rhex-blue)](https://github.com/popcorn-volcano/Blue-Rhex)

One-click automation for R-Slip hexapod robot experiment setup across distributed systems (Windows, sbRIO controller, Jetson Orin Nano).

## 🚀 Quick Start

```bash
Double-click: RSlip_Robot_Setup.bat
```

Enter sbRIO IP → Wait 30 seconds → Done! ✅  
Automates 23+ manual steps into one launcher.

## ✨ What It Does

- **Multi-Machine Orchestration** - SSH to sbRIO + 2 Jetson boards
- **Service Startup & Verification** - grpccore, fpga_driver, ROS2 bridge
- **Intelligent IP Detection** - Auto-finds sbRIO, accepts manual entry
- **Environment Setup** - Network config, ROS2 setup, health checks
- **Robot Control Ready** - Pre-configured power, calibration, gait commands

## 📊 Impact

| Metric | Before | After |
|--------|--------|-------|
| **Setup Time** | 15+ minutes | 30 seconds |
| **Manual Steps** | 23+ commands | 1 click |
| **Error Rate** | High | Minimal |
| **Learning Curve** | Steep | Simple |

## 📦 Files

| File | Purpose |
|------|---------|
| **RSlip_Robot_Setup.bat** | Main launcher |
| **RSlip_sbRIO_Setup.bat** | sbRIO SSH & services |
| **RSlip_Orin1_Bridge.ps1** | ROS2 bridge setup |
| **RSlip_Orin2_Control.ps1** | Robot control interface |
| **SETUP_GUIDE.md** | Complete documentation & commands |

## 🔧 Requirements

- Windows 10/11 with OpenSSH client
- NI sbRIO with ROS2 workspace
- Jetson Orin Nano (x2)
- WiFi network

## 🎮 Workflow

1. Run launcher script
2. Enter sbRIO IP
3. Wait for 3 windows to initialize
4. Execute robot control commands in sequence

Commands: Power Up → Enable Sensors → Enable Relay → Calibrate → Standing → Tripod Gait

See **[SETUP_GUIDE.md](SETUP_GUIDE.md)** for:
- Complete setup instructions
- All control commands with examples
- Troubleshooting & diagnostics
- Network configuration
- Verification checklist

## 🛠️ Technical Stack

- **Automation:** PowerShell, Batch scripts
- **Connectivity:** SSH over WiFi
- **Middleware:** ROS2 Humble, gRPC
- **Hardware:** NI sbRIO, Jetson Orin Nano

---

**Status:** ✅ Production Ready | [View on GitHub](https://github.com/popcorn-volcano/Blue-Rhex)
