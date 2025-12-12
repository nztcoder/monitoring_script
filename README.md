# 🖥️ System Monitoring Script (Born2beRoot)

A Bash script developed to monitor system performance and broadcast vital information to all logged-in users via the terminal.

## 📋 About The Project

This project is a simple yet powerful system monitoring tool. It collects specific system metrics (CPU load, RAM usage, LVM status, etc.) and displays them on all open terminals using the `wall` command. The script is designed to run automatically at server startup and then every 10 minutes.

## ⚙️ Features

The script reports the following metrics:
- **Architecture:** OS architecture and kernel version.
- **CPU Info:** Number of physical and virtual processors.
- **Memory:** Available RAM and usage percentage.
- **Disk:** Available storage and usage percentage.
- **Load:** Current CPU utilization rate.
- **Uptime:** Date and time of the last system reboot.
- **LVM:** Checks if LVM (Logical Volume Manager) is active.
- **Connections:** Number of active TCP connections.
- **Users:** Count of users currently logged in.
- **Network:** IPv4 address and MAC address.
- **Sudo:** Number of commands executed with `sudo`.

## 📖 Requirements

The script is written in pure Bash and relies only on standard system tools commonly available on Debian-like distributions:
- `bash`
- `uname`
- `grep`, `awk`, `sort`, `wc`, `tr`
- `free`
- `df`
- `vmstat`
- `who`
- `lsblk`
- `ss`
- `hostname`
- `ip`
- `wall`

For the sudo command counter, you also need sudo logging configured.
