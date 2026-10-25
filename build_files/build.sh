#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

# Build and install klassy from master branch
dnf5 install -y git cmake extra-cmake-modules gettext
dnf5 install -y "cmake(KF5Config)" "cmake(KF5CoreAddons)" "cmake(KF5FrameworkIntegration)"  "cmake(KF5GuiAddons)" "cmake(KF5WindowSystem)" "cmake(KF5I18n)" "cmake(Qt5DBus)" "cmake(Qt5Quick)" "cmake(Qt5Widgets)" "cmake(Qt5X11Extras)" "cmake(KDecoration3)" "cmake(KF6ColorScheme)" "cmake(KF6Config)" "cmake(KF6CoreAddons)" "cmake(KF6FrameworkIntegration)" "cmake(KF6GuiAddons)" "cmake(KF6I18n)" "cmake(KF6KCMUtils)" "cmake(KF6WindowSystem)" "cmake(Qt6Core)" "cmake(Qt6DBus)" "cmake(Qt6Quick)" "cmake(Qt6Svg)" "cmake(Qt6Widgets)" "cmake(Qt6Xml)"

git clone https://github.com/paulmcauley/klassy
cd klassy
git checkout master
./install.sh

cd ..
rm -rf ./klassy

### Other package installs
dnf5 config-manager setopt terra.enabled=1
dnf5 install -y --exclude=setroubleshoot* qemu-kvm virt-manager @xfce-desktop-environment xfce4-whiskermenu-plugin blueman

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket

