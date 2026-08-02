var desktopsArray = desktopsForActivity(currentActivity());
for (var j = 0; j < desktopsArray.length; j++) {
    // Set bundled wallpaper
    desktopsArray[j].wallpaperPlugin = "org.kde.image";
    desktopsArray[j].currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    desktopsArray[j].writeConfig("Image", "file:///home/mithun/.local/share/plasma/look-and-feel/io.github.fizzy444.winterlock/contents/images/wallhaven-7jeozo.jpg");

    // Add Desktop Widgets
    var clock = desktopsArray[j].addWidget("com.github.prayag2.modernclock");
    
    // Position clock at the bottom right
    desktopsArray[j].currentConfigGroup = ["General"];
    var geom = "Applet-" + clock.id + ":976,560,528,160,0;";
    desktopsArray[j].writeConfig("ItemGeometriesHorizontal", geom);
    desktopsArray[j].writeConfig("ItemGeometries-1536x864", geom);
    desktopsArray[j].writeConfig("ItemGeometries-1920x1080", geom);
}

// ----------------------------------------------------------------------------
// Bottom Panel (Containment 102)
// ----------------------------------------------------------------------------
var bottomPanel = new Panel("org.kde.panel");
bottomPanel.location = "bottom";
bottomPanel.height = 46;
bottomPanel.floating = true;
bottomPanel.hiding = "windowsgobelow"; // Panel visibility mode (Dodge Windows)

// Widgets for bottom panel
bottomPanel.addWidget("org.kde.plasma.spatium");

var kickoff = bottomPanel.addWidget("org.kde.plasma.kickoff");
kickoff.currentConfigGroup = ["General"];
kickoff.writeConfig("favoritesPortedToKAstats", "true");

var icontasks = bottomPanel.addWidget("org.kde.plasma.icontasks");
icontasks.currentConfigGroup = ["General"];
icontasks.writeConfig("launchers", "applications:firefox.desktop,preferred://filemanager,applications:systemsettings.desktop,applications:org.kde.konsole.desktop,applications:io.missioncenter.MissionCenter.desktop");

bottomPanel.addWidget("org.kde.plasma.marginsseparator");

// ----------------------------------------------------------------------------
// Top Panel (Containment 23)
// ----------------------------------------------------------------------------
var topPanel = new Panel("org.kde.panel");
topPanel.location = "top";
topPanel.height = 32;
topPanel.alignment = "right";
topPanel.floating = true;
topPanel.hiding = "autohide"; // Panel visibility mode
topPanel.minimumLength = 1508;
topPanel.maximumLength = 1508;

// Widgets for top panel
var systray = topPanel.addWidget("org.kde.plasma.systemtray");
systray.currentConfigGroup = ["General"];
systray.writeConfig("extraItems", "org.kde.kscreen,org.kde.plasma.cameraindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.kdeconnect,org.kde.plasma.bluetooth,org.kde.plasma.keyboardindicator,org.kde.plasma.battery,org.kde.plasma.brightness,org.kde.plasma.volume,org.kde.plasma.weather,org.kde.plasma.clipboard,org.kde.plasma.networkmanagement,org.kde.plasma.devicenotifier");
systray.writeConfig("knownItems", "org.kde.kscreen,org.kde.plasma.battery,org.kde.plasma.brightness,org.kde.plasma.cameraindicator,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.networkmanagement,org.kde.plasma.notifications,org.kde.plasma.volume,org.kde.kdeconnect,org.kde.plasma.bluetooth,org.kde.plasma.keyboardindicator,org.kde.plasma.weather");
systray.writeConfig("shownItems", "org.kde.plasma.battery,org.kde.plasma.brightness,org.kde.plasma.volume,org.kde.plasma.networkmanagement");
systray.writeConfig("hiddenItems", "org.kde.plasma.weather,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,Shelly,steam,Arch-Update");

topPanel.addWidget("org.kde.plasma.digitalclock");
topPanel.addWidget("org.kde.plasma.showdesktop");
