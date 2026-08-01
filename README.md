# WinterLock

WinterLock is a KDE Plasma 6 lock-screen theme with the standard Plasma/Breeze
authentication interface, an ice-blue Orbitron clock, and a bundled live
Winter video background.

![WinterLock lock-screen preview](look-and-feel/io.github.fizzy444.winterlock/contents/previews/lockscreen.png)

![WinterLock Global Theme preview](look-and-feel/io.github.fizzy444.winterlock/contents/previews/preview.png)

## Features

- Bundled 1920×1080 looping Winter MP4 background.
- Ice-blue Orbitron clock and date treatment.
- Live video tint and blur effects.
- Stock Plasma 6 Breeze password authentication, session controls, and unlock
  behavior.

## Compatibility warning

WinterLock installs a complete local override of
`org.kde.plasma.desktop` in `~/.local/share/plasma/shells/`. This is necessary
because current Plasma 6 KScreenLocker loads its lock screen from the active
shell package rather than from a Look-and-Feel package.

The override may need to be rebuilt after major Plasma upgrades. Use the
included uninstaller before troubleshooting a Plasma shell issue.

## Installation

Requirements:

- KDE Plasma 6 and KScreenLocker
- `kpackagetool6` and `plasma-apply-lookandfeel`
- Qt 6 Multimedia (`qt6-multimedia` on Arch/CachyOS)

WinterLock ships its own `background.mp4`, redistributed with permission. It
does not require the Winter SDDM theme or any file under `/usr/share`.

```bash
git clone https://github.com/Fizzy444/plasma-winterlock.git
cd plasma-winterlock
./install.sh
```

Installation never modifies `/usr/share`. The bundled video is installed once
inside the WinterLock Global Theme package, where the local shell override can
resolve it through Qt's standard data path.

### Optional custom background

To use a personal video for one installation, pass it explicitly:

```bash
./install.sh --video /path/to/winter-background.mp4
```

The installer copies that video into WinterLock's installed package. The
original file is left untouched, including when WinterLock is uninstalled.

## Uninstallation

```bash
./uninstall.sh
```

The installer backs up an existing local `org.kde.plasma.desktop` override
before replacing it. The uninstaller removes only a WinterLock-managed
override and restores the newest backup when one is available.

## Testing

```bash
/usr/lib/kscreenlocker_greet --testing --shell org.kde.plasma.desktop
loginctl lock-session
```

## Repository layout

- `look-and-feel/io.github.fizzy444.winterlock` — Global Theme package.
- `shells/org.kde.plasma.desktop` — local fork containing the active
  WinterLock lock-screen implementation.

## Releases

Once you have tested installation and uninstallation on a clean Plasma 6
session, create a GitHub release (recommended first tag: `v1.0.0`).
