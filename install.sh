#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Mithun A
# SPDX-License-Identifier: GPL-2.0-or-later
# Install WinterLock without modifying /usr/share.
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
data_dir="${XDG_DATA_HOME:-$HOME/.local/share}"
plasma_dir="$data_dir/plasma"
package_id="io.github.fizzy444.winterlock"
source_lnf="$repo_dir/look-and-feel/$package_id"
source_shell="$repo_dir/shells/org.kde.plasma.desktop"
video_path=""

usage() {
    echo "Usage: $0 [--video /path/to/background.mp4]"
    echo ""
    echo "By default, install the background.mp4 bundled with WinterLock."
    echo "Use --video to replace that bundled background for this installation."
}

while (($#)); do
    case "$1" in
        --video)
            (($# >= 2)) || { echo "--video needs a path" >&2; exit 2; }
            video_path=$2
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

for command in kpackagetool6 plasma-apply-lookandfeel; do
    command -v "$command" >/dev/null || {
        echo "Missing required Plasma command: $command" >&2
        exit 1
    }
done

[[ -d "$source_lnf" && -d "$source_shell" ]] || {
    echo "Run this script from a complete WinterLock checkout." >&2
    exit 1
}

if [[ -z "$video_path" ]]; then
    video_path="$source_lnf/contents/lockscreen/assets/background.mp4"
fi

[[ -n "$video_path" && -f "$video_path" ]] || {
    echo "Bundled background video is missing: $video_path" >&2
    exit 1
}

if command -v ffprobe >/dev/null && ! ffprobe -v error "$video_path" >/dev/null; then
    echo "The selected background video could not be read: $video_path" >&2
    exit 1
fi

if command -v pacman >/dev/null && ! pacman -Q qt6-multimedia >/dev/null 2>&1; then
    echo "qt6-multimedia is required for the animated background." >&2
    exit 1
fi

target_lnf="$plasma_dir/look-and-feel/$package_id"
target_shell="$plasma_dir/shells/org.kde.plasma.desktop"
backup_root="$data_dir/winterlock/backups"
state_file="$data_dir/winterlock/install-state"
stage_dir=$(mktemp -d)
trap 'rm -rf "$stage_dir"' EXIT

# Stage first: this keeps installation safe even when the checkout already
# lives in ~/.local/share/plasma.
mkdir -p "$stage_dir/look-and-feel" "$stage_dir/shells"
cp -a "$source_lnf" "$stage_dir/look-and-feel/$package_id"
cp -a "$source_shell" "$stage_dir/shells/org.kde.plasma.desktop"
# A custom --video is copied into the package; the original user file is never
# removed by uninstall.
install -Dm644 "$video_path" "$stage_dir/look-and-feel/$package_id/contents/lockscreen/assets/background.mp4"

previous_lnf=""
if command -v kreadconfig6 >/dev/null; then
    previous_lnf=$(kreadconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage 2>/dev/null || true)
fi
# This was WinterLock's pre-release identifier. It is no longer installed
# after the package-ID migration, so never restore it on uninstall.
if [[ "$previous_lnf" == "org.mithun.winterlock" ]]; then
    previous_lnf="org.kde.breeze.desktop"
fi

mkdir -p "$plasma_dir/look-and-feel" "$plasma_dir/shells" "$backup_root" "$(dirname "$state_file")"
if [[ -d "$target_shell" && ! -f "$target_shell/.winterlock-managed" ]]; then
    backup="$backup_root/org.kde.plasma.desktop-$(date +%Y%m%d-%H%M%S)"
    mv "$target_shell" "$backup"
    echo "Backed up the existing local shell override to: $backup"
elif [[ -d "$target_shell" ]]; then
    rm -rf "$target_shell"
fi

rm -rf "$target_lnf"
cp -a "$stage_dir/look-and-feel/$package_id" "$target_lnf"
cp -a "$stage_dir/shells/org.kde.plasma.desktop" "$target_shell"

printf '%s\n' "$previous_lnf" > "$state_file"
plasma-apply-lookandfeel --apply "$package_id"

echo "WinterLock installed. Lock the session to use the new screen."
