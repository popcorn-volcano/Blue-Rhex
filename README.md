# Blue Rhex - R-Slip Robot Automation

One-click automation for R-Slip hexapod robot experiment setup across distributed systems (Windows, sbRIO controller, Jetson Orin Nano).

## 🚀 Quick Start

```bash
Double-click: RSlip_Robot_Setup.bat
```

That's it! The script handles:
- Multi-machine SSH orchestration
- Service startup and verification
- ROS2 environment configuration
- Complete robot initialization

**From 23+ manual steps → 1 click**

## 📋 What's Included

- **RSlip_Robot_Setup.bat** - Main automation launcher
- **RSlip_sbRIO_Setup.bat** - sbRIO service initialization
- **RSlip_Orin1_Bridge.ps1** - Jetson ROS2 bridge setup
- **RSlip_Orin2_Control.ps1** - Robot control interface
- **SETUP_GUIDE.md** - Complete documentation
- **PROJECT_SUMMARY.md** - Project overview

## 🎯 Features

✅ **Single-Click Launch** - Automated multi-window coordination  
✅ **Intelligent IP Detection** - Auto-finds sbRIO on network  
✅ **Service Verification** - Confirms all systems operational  
✅ **ROS2 Configuration** - Automatic environment setup  
✅ **Pre-Configured Commands** - Ready-to-execute robot sequence  

## 🔧 System Requirements

- Windows 10/11 with OpenSSH client
- NI sbRIO (Real-Time controller)
- Jetson Orin Nano (x2 for bridge + control)
- ROS2 Humble installed
- Network connectivity via WiFi

## 📖 Documentation

- **SETUP_GUIDE.md** - Complete setup, troubleshooting, and robot control commands
- **PROJECT_SUMMARY.md** - Project overview and impact metrics

## 🎮 Robot Control Workflow

After initialization, run these commands in order:

1. **Power Up** - `ros2 topic pub --once /power/command ...`
2. **Enable Sensors** - Activate sensor suite
3. **Enable Relay** - Full power engagement
4. **Calibrate** - Position feet to Hall sensor
5. **Standing** - Set standing position
6. **Tripod Gait** - Begin locomotion experiment

See SETUP_GUIDE.md for complete commands.

## ⚠️ Troubleshooting

For setup issues, network problems, or service failures, see **SETUP_GUIDE.md** which includes:
- 12+ common issues with solutions
- Network diagnostic steps
- Service startup debugging
- Quick-fix reference table

## 📊 Impact

- **Setup Time:** 15+ minutes → 30 seconds
- **Error Reduction:** Scripted vs manual (23+ steps)
- **Reproducibility:** Consistent automation
- **Learning Curve:** Single script to launch

## 🛠️ Technical Stack

- **Automation:** PowerShell, Batch scripting
- **Connectivity:** SSH over WiFi
- **Robotics Middleware:** ROS2 Humble
- **Real-Time Controller:** NI sbRIO
- **Edge Compute:** Jetson Orin Nano
- **Communication Protocol:** gRPC

## 📝 License

[Add your license here]

## 👤 Author

[Your name/team]

## 📞 Support

Refer to SETUP_GUIDE.md for comprehensive documentation and troubleshooting.

---

**Status:** ✅ Production Ready  
**Version:** 1.0  
**Last Updated:** April 2026
