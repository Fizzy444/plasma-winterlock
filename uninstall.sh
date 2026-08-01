#!/usr/bin/env bash
# Remove WinterLock and restore a pre-existing local shell override when safe.
set -euo pipefail

data_dir="${XDG_DATA_HOME:-$HOME/.local/share}"
plasma_dir="$data_dir/plasma"
package_id="io.github.fizzy444.winterlock"
target_lnf="$plasma_dir/look-and-feel/$package_id"
target_shell="$plasma_dir/shells/org.kde.plasma.desktop"
backup_root="$data_dir/winterlock/backups"
state_file="$data_dir/winterlock/install-state"

if [[ -d "$target_shell" && -f "$target_shell/.winterlock-managed" ]]; then
    rm -rf "$target_shell"
    echo "Removed the WinterLock local shell override."
else
    echo "No WinterLock-managed shell override found; leaving $target_shell unchanged."
fi

# This removes only WinterLock's installed package copy of the bundled or
# overridden video; it never removes the user's original --video source.
rm -rf "$target_lnf"

if [[ -d "$backup_root" ]]; then
    latest_backup=$(find "$backup_root" -mindepth 1 -maxdepth 1 -type d -name 'org.kde.plasma.desktop-*' -printf '%T@ %p\n' | sort -nr | head -n 1 | cut -d' ' -f2-)
    if [[ -n "${latest_backup:-}" && ! -e "$target_shell" ]]; then
        mv "$latest_backup" "$target_shell"
        echo "Restored local shell override from: $latest_backup"
    fi
fi

if [[ -f "$state_file" ]] && command -v kwriteconfig6 >/dev/null; then
    previous_lnf=$(<"$state_file")
    if [[ -n "$previous_lnf" ]]; then
        kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage "$previous_lnf"
    fi
    rm -f "$state_file"
fi

echo "WinterLock uninstalled. Log out and back in after restoring a shell override."
