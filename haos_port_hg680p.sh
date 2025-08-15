#!/bin/bash
set -e

# Lokasi file
ARMBIAN_IMG="armbian_s905x.img"
HAOS_IMG="haos_generic_aarch64.img"

# Mount Armbian
mkdir -p armbian_boot armbian_root
sudo mount -o loop,offset=$((512*32768)) "$ARMBIAN_IMG" armbian_boot
sudo mount -o loop,offset=$((512*262144)) "$ARMBIAN_IMG" armbian_root

# Mount HAOS
mkdir -p haos_boot haos_root
sudo mount -o loop,offset=$((512*32768)) "$HAOS_IMG" haos_boot
sudo mount -o loop,offset=$((512*262144)) "$HAOS_IMG" haos_root

# Salin kernel & dtb dari Armbian ke HAOS
sudo cp -v armbian_boot/uImage haos_boot/
sudo cp -v armbian_boot/*.dtb haos_boot/dtb/

# Unmount
sudo umount armbian_boot armbian_root haos_boot haos_root
