#!/usr/bin/env bash

set -euo pipefail

# === Constants ===
DISK="/dev/nvme0n1"
EFI_PART="${DISK}p1"
SWAP_PART="${DISK}p2"
ROOT_PART="${DISK}p3"

# === Sanity check ===
if [[ "$EUID" -ne 0 ]]; then
    echo "❌ Please run this script as root."
    exit 1
fi

if ! [ -e "$DISK" ]; then
    echo "❌ Disk $DISK not found!"
    exit 1
fi

echo "⚙️ Installing NixOS on $DISK ..."

# === Partition the disk ===
echo "🧹 Partitioning disk..."
parted --script "$DISK" \
  mklabel gpt \
  mkpart primary fat32 1MiB 513MiB \
  set 1 esp on \
  mkpart primary linux-swap 513MiB 4609MiB \
  mkpart primary ext4 4609MiB 100%

# === Format partitions ===
echo "💾 Formatting partitions..."
mkfs.fat -F 32 -n EFI "$EFI_PART"
mkswap "$SWAP_PART"
mkfs.ext4 -L nixos "$ROOT_PART"

# === Mount and enable swap ===
echo "📁 Mounting and enabling swap..."
mount "$ROOT_PART" /mnt
mkdir -p /mnt/boot
mount "$EFI_PART" /mnt/boot
swapon "$SWAP_PART"

# === Copy your configuration.nix ===
echo "📄 Copying configuration.nix..."
if [[ ! -f ./configuration.nix ]]; then
    echo "❌ configuration.nix not found in current directory!"
    exit 1
fi

mkdir -p /mnt/etc/nixos
cp ./configuration.nix /mnt/etc/nixos/

# === Generate hardware config ===
echo "⚙️ Generating hardware-configuration.nix..."
nixos-generate-config --root /mnt

# === Optional: Patch hostname into config (optional if you're hardcoding it) ===
echo "ℹ️ NOTE: You will need to set networking.hostName = \"$HOSTNAME\" in your configuration.nix if not already present."

# === Install ===
echo "📦 Installing NixOS..."
nixos-install --no-root-passwd

# === Change user Password ===
echo "🔐 Setting password for alec..."
nixos-enter --root /mnt -c 'passwd alec'

# === Done ===
echo "✅ NixOS installation complete!"
echo "💡 You can now run 'reboot'."
