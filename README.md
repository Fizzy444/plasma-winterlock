# WinterLock

WinterLock is a KDE Plasma 6 lock-screen customization that keeps the stock
Plasma/Breeze authentication flow while displaying the live Winter scene used
by the companion SDDM theme.

## What it includes

- A looping Winter video background from the SDDM `winter` theme.
- An ice-blue Orbitron clock with date styling.
- Stock Plasma 6 password, PAM authentication, session controls, and unlock
  behavior.

## Layout

The repository intentionally contains two Plasma packages:

- `look-and-feel/org.mithun.winterlock` is the Global Theme shown by Plasma.
- `shells/org.kde.plasma.desktop` is a complete local fork of the official
  desktop shell. Plasma 6.7's KScreenLocker loads its lock screen from the
  active shell package, so this override is what makes the Winter lock screen
  active.

## Dependency

The animated background is read directly from:

`/usr/share/sddm/themes/winter/bg.mp4`

Install and select the SDDM `winter` theme before using this build. Qt 6
Multimedia is also required for video playback.

## Verification

Run the lock-screen greeter against the local shell override:

```bash
/usr/lib/kscreenlocker_greet --testing --shell org.kde.plasma.desktop
```

Then lock the real session:

```bash
loginctl lock-session
```

## Updating Plasma

Because the shell package is a local fork, update it from the corresponding
system package after a major Plasma upgrade, then reapply the WinterLock
changes in `contents/lockscreen`.
