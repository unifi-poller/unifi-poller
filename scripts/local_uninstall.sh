#!/bin/bash

# This script removes a local installation of unifi-poller.
# Recommend using Makefile to invoke: make uninstall
# Supports Linux (systemd only) and macOS.

BINARY=unifi-poller

echo "Uninstall unifi-poller. If you get errors, you may need sudo."

# Stopping the daemon
if [ -x /bin/systemctl ]; then
   /bin/systemctl stop ${BINARY}
fi
if [ -x /bin/launchctl ] && [ -f ~/Library/LaunchAgents/com.github.davidnewhall.${BINARY}.plist ]; then
  /bin/launchctl unload ~/Library/LaunchAgents/com.github.davidnewhall.${BINARY}.plist
fi

# Deleting config file, binary, man page, launch agent or unit file.
rm -rf /usr/local/{etc,bin}/${BINARY} /usr/local/share/man/man1/${BINARY}.1.gz
rm -f ~/Library/LaunchAgents/com.github.davidnewhall.${BINARY}.plist
rm -f /etc/systemd/system/${BINARY}.service

# Making systemd happy by telling it to reload.
if [ -x /bin/systemctl ]; then
  /bin/systemctl --system daemon-reload
fi