#!/usr/bin/env bash
FUNCTIONS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ "$1" == "startup" ]; then
  errors=0
  while [ -z "$(kreadconfig6 --file $HOME/.config/khotkeysrc --group Data --key DataCount)" ]; do
    if [[ $errors -ge 30 ]]; then
      exit
    fi
    sleep 1.5
    errors=$((errors+1))
  done
fi

#gtkrc
if ! grep -q gtk-theme-name=\"Breeze\" $HOME/.config/gtkrc &>/dev/null; then
  echo "include \"/usr/share/themes/Breeze/gtk-2.0/gtkrc\"" >> $HOME/.config/gtkrc
  echo "gtk-theme-name=\"Breeze\"" >> $HOME/.config/gtkrc
fi

# dolphin
# Set View Mode to Details
kwriteconfig6 --file $HOME/.local/share/dolphin/view_properties/global/.directory --group Dolphin --key ViewMode "1"

# discoverrc
# Enable Flathub
kwriteconfig6 --file $HOME/.config/discoverrc --group FlatpakSources --key Sources "flathub"

#elisarc
kwriteconfig6 --file $HOME/.config/elisarc --group PlayerSettings --key ShowSystemTrayIcon "true"

# flameshot
kwriteconfig6 --file $HOME/.config/flameshot/flameshot.ini --group General --key showDesktopNotification "false"
kwriteconfig6 --file $HOME/.config/flameshot/flameshot.ini --group General --key showStartupLaunchMessage "false"

# okularpartrc
kwriteconfig6 --file $HOME/.config/okularpartrc --group "Dlg Accessibility" --key HighlightLinks "true"
kwriteconfig6 --file $HOME/.config/okularpartrc --group "General" --key ShellOpenFileInTabs "true"

if grep -iq touchpad /proc/bus/input/devices; then
  # get touchpad name
  TOUCHPAD_NAME=$(grep -i 'touchpad' /proc/bus/input/devices | cut -d \" -f2)
  kwriteconfig6 --file $HOME/.config/touchpadxlibinputrc --group "$TOUCHPAD_NAME" --key tapToClick "true"
  kwriteconfig6 --file $HOME/.config/touchpadxlibinputrc --group "$TOUCHPAD_NAME" --key naturalScroll "true"
  kwriteconfig6 --file $HOME/.config/touchpadxlibinputrc --group "$TOUCHPAD_NAME" --key pointerAcceleration "0.2"
fi


# kactivitymanagerdrc
cat <<EOF > $HOME/.config/kactivitymanagerdrc
[Plugins]
org.kde.ActivityManager.VirtualDesktopSwitchEnabled=true

[activities]
7df277cc-9d8f-4533-9eae-562776d47268=Communication
c78831cf-f1b4-460a-bccb-030368e69032=Default

[activities-icons]
c78831cf-f1b4-460a-bccb-030368e69032=activities
7df277cc-9d8f-4533-9eae-562776d47268=activities

[main]
currentActivity=c78831cf-f1b4-460a-bccb-030368e69032
EOF

# plasmashellrc
kwriteconfig6 --file $HOME/.config/plasmashellrc --group "Notification Messages" --key klipperClearHistoryAskAgain "false"

# kdeglobals
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key BrowserApplication "brave-browser.desktop"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key ColorScheme "ArcDark"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key ColorSchemeHash "aebe9d6820d9f1e51aac1699e8a985f6d0d84f4d"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key Name "Arc Dark"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key XftAntialias "true"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key XftHintStyle "hintslight"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key XftSubPixel "rgb"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key shadeSortColumn "true"
kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key widgetStyle "Breeze"
kwriteconfig6 --file $HOME/.config/kdeglobals --group Icons --key Theme "breeze-dark"
kwriteconfig6 --file $HOME/.config/kdeglobals --group KDE --key ColorScheme "Breeze"
kwriteconfig6 --file $HOME/.config/kdeglobals --group KDE --key LookAndFeelPackage "com.github.varlesh.arc-dark"
kwriteconfig6 --file $HOME/.config/kdeglobals --group KDE --key widgetStyle "Breeze"
kwriteconfig6 --file $HOME/.config/kdeglobals --group KDE --key Theme "breeze-dark"
kwriteconfig6 --file $HOME/.config/kdeglobals --group "KFileDialog Settings" --key "Show Bookmarks" "true"

# kglobalshortcutsrc
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group "org.kde.konsole.desktop" --key "_launch" "Ctrl+Alt+T,none,Konsole"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group "org.kde.konsole.desktop" --key "_k_friendly_name" "Konsole"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group "KDE Keyboard Layout Switcher" --key "Switch to Next Keyboard Layout" "Meta+Alt+K\tMeta+Space,Meta+Alt+K,Switch to Next Keyboard Layout"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group khotkeys --key "{064409b0-b6ed-4f03-ad56-e1b4f4feceb0}" "Ctrl+Alt+Shift+S,none,xrandr-display"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group khotkeys --key "{4be88b94-ce99-4571-abb8-faef98b64764}" "Ctrl+Alt+Shift+A,none,select-display"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group khotkeys --key "{5cf0e99b-98c5-4f76-bda8-44243adff58a}" "Meta+Shift+S,none,Flameshot"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group khotkeys --key "{fdc6ae09-f6bc-4d73-81ef-e0c3ba6a3cc0}" "Ctrl+Alt+K,none,change-keyboard-layout"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group ksmserver --key "Halt Without Confirmation" "Ctrl+Alt+Shift+PgDown,,Halt Without Confirmation"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group ksmserver --key "Lock Session" "Meta+L\tCtrl+Alt+L\tScreensaver,Meta+L\tScreensaver,Lock Session"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group ksmserver --key "Log Out Without Confirmation" "Ctrl+Alt+Shift+Del,,Log Out Without Confirmation"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group ksmserver --key "Reboot Without Confirmation" "Ctrl+Alt+Shift+PgUp,,Reboot Without Confirmation"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Left" "Ctrl+Alt+Left\tMeta+Ctrl+Left,Meta+Ctrl+Left,Switch One Desktop to the Left"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Right" "Ctrl+Alt+Right\tMeta+Ctrl+Right,Meta+Ctrl+Right,Switch One Desktop to the Right"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Window Close" "Alt+F4\tMeta+Q,Alt+F4,Close Window"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Kill Window" "Meta+Ctrl+Esc\tCtrl+Alt+Esc,Meta+Ctrl+Esc,Kill Window"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Expose" "Ctrl+F9\tMeta+A,Ctrl+F9,Toggle Present Windows (Current desktop)"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Window Maximize" "Meta+PgUp\tMeta+Up,Meta+PgUp,Maximize Window"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Window Quick Tile Top" "none,Meta+Up,Quick Tile Window to the Top"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Window One Desktop to the Left" "Meta+Ctrl+Shift+Left\tCtrl+Alt+Shift+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group kwin --key "Window One Desktop to the Right" "Meta+Ctrl+Shift+Right\tCtrl+Alt+Shift+Right,Meta+Ctrl+Shift+Right,Window One Desktop to the Right"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group mediacontrol --key "playpausemedia" "Media Play\tCtrl+Alt+D,Media Play,Play/Pause media playback"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group plasmashell --key "manage activities" "none,Meta+Q,Show Activity Switcher"
kwriteconfig6 --file $HOME/.config/kglobalshortcutsrc --group plasmashell --key "show-barcode" "Ctrl+Alt+B\tMeta+Ctrl+B,,Show Barcode…"
sed -i 's/\\\\/\\/g' $HOME/.config/kglobalshortcutsrc

# khotkeysrc
rm $HOME/.config/autostart/kde-configuration.desktop &> /dev/null
DATA_COUNT=$(kreadconfig6 --file $HOME/.config/khotkeysrc --group Data --key "DataCount")
if [ -z "$DATA_COUNT" ]; then
  DATA_COUNT=0
fi
function addHotKey() {
  if grep -q "Name=$2" $HOME/.config/khotkeysrc && grep -q "Key=$4" $HOME/.config/khotkeysrc; then
    return
  fi
  DATA_COUNT=$((DATA_COUNT + 1))
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}" --key "Comment" "$1"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}" --key "Enabled" "true"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}" --key "Name" "$2"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}" --key "Type" "SIMPLE_ACTION_DATA"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Actions" --key "ActionsCount" "1"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Actions0" --key "CommandURL" "$3"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Actions0" --key "Type" "COMMAND_URL"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Conditions" --key "Comment" ""
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Conditions" --key "ConditionsCount" "0"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Triggers" --key "Comment" "Simple_action"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Triggers" --key "TriggersCount" "1"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Triggers0" --key "Key" "$4"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Triggers0" --key "Type" "SHORTCUT"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group "Data_${DATA_COUNT}Triggers0" --key "Uuid" "$5"
}
if [ ! "$DATA_COUNT" = "0" ]; then
  addHotKey "Keyboard Layout" "change-keyboard-layout" "$HOME/bin/change-keyboard-layout" "Ctrl+Alt+K" "{fdc6ae09-f6bc-4d73-81ef-e0c3ba6a3cc0}"
  addHotKey "Flameshot" "Flameshot" "/usr/bin/flameshot gui" "Meta+Shift+S" "{5cf0e99b-98c5-4f76-bda8-44243adff58a}"
  addHotKey "xrandr display" "xrandr-display" "$HOME/bin/xrandr-display && $HOME/bin/switch-display linux && xdotool key ctrl+alt+shift+d" "Ctrl+Alt+Shift+S" "{064409b0-b6ed-4f03-ad56-e1b4f4feceb0}"
  addHotKey "Switch display to Windows" "switch-display" "$HOME/bin/switch-display windows" "Ctrl+Alt+Shift+A" "{4be88b94-ce99-4571-abb8-faef98b64764}"
  kwriteconfig6 --file $HOME/.config/khotkeysrc --group Data --key "DataCount" "$DATA_COUNT"
else
  mkdir -p $HOME/.config/autostart
  cat <<EOF > $HOME/.config/autostart/kde-configuration.desktop
[Desktop Entry]
Exec=$FUNCTIONS_DIR/kde.sh startup
Icon=dialog-scripts
Name=kde-configuration
Path=
Type=Application
X-KDE-AutostartScript=true
X-KDE-autostart-phase=2
X-KDE-startup-notify=false
EOF
fi

# konsolerc
$FUNCTIONS_DIR/downloadMesloFonts.sh
DEFAULT_PROFILE="$(kreadconfig6 --file $HOME/.config/konsolerc --group "Desktop Entry" --key "DefaultProfile")"
if [[ -n "$DEFAULT_PROFILE" && -f "$HOME/.local/share/konsole/$DEFAULT_PROFILE" ]]; then
  FONT="$(kreadconfig6 --file "$HOME/.local/share/konsole/$DEFAULT_PROFILE" --group "Appearance" --key "Font")"
  if ! echo "$FONT" | grep -q "MesloLGS NF"; then
    kwriteconfig6 --file "$HOME/.local/share/konsole/$DEFAULT_PROFILE" --group "Appearance" --key "Font" "MesloLGS NF,10,-1,5,50,0,0,0,0,0"
  fi
else
  kwriteconfig6 --file $HOME/.config/konsolerc --group "Desktop Entry" --key "DefaultProfile" "GreenOnBlack.profile"
fi

# kscreenlockerrc
kwriteconfig6 --file $HOME/.config/kscreenlockerrc --group Daemon --key "Autolock" "false"
kwriteconfig6 --file $HOME/.config/kscreenlockerrc --group Greeter --group Wallpaper --group org.kde.image --group General --key "Image" "/usr/share/wallpapers/Next/"
kwriteconfig6 --file $HOME/.config/kscreenlockerrc --group Greeter --group Wallpaper --group org.kde.image --group General --key "SlidePaths" "/usr/share/wallpapers"

# ksmserverrc
kwriteconfig6 --file $HOME/.config/ksmserverrc --group "General" --key "loginMode" "emptySession"
kwriteconfig6 --file $HOME/.config/ksmserverrc --group "General" --key "shutdownType" "2"

# kwinrc
kwriteconfig6 --file $HOME/.config/kwinrc --group MouseBindings --key CommandActiveTitlebar2 "Minimize"
kwriteconfig6 --file $HOME/.config/kwinrc --group MouseBindings --key CommandAllWheel "Maximize/Restore"
kwriteconfig6 --file $HOME/.config/kwinrc --group MouseBindings --key CommandInactiveTitlebar2 "Minimize"
kwriteconfig6 --file $HOME/.config/kwinrc --group MouseBindings --key CommandTitlebarWheel "Previous/Next Desktop"
kwriteconfig6 --file $HOME/.config/kwinrc --group Desktops --key Id_1 "699437fe-a239-4ea3-a9cc-b1dbe9643f49"
kwriteconfig6 --file $HOME/.config/kwinrc --group Desktops --key Id_2 "26144853-18e0-4491-9025-7116f2b2d843"
kwriteconfig6 --file $HOME/.config/kwinrc --group Desktops --key Id_3 "84cebb9d-5e00-4b41-a89e-98cc70ae1dfd"
kwriteconfig6 --file $HOME/.config/kwinrc --group Desktops --key Id_4 "785899c3-fedc-4bfb-87a6-f9c7599a9e7b"
kwriteconfig6 --file $HOME/.config/kwinrc --group Desktops --key Number "4"
kwriteconfig6 --file $HOME/.config/kwinrc --group Desktops --key Rows "1"
kwriteconfig6 --file $HOME/.config/kwinrc --group Windows --key DelayFocusInterval "0"
kwriteconfig6 --file $HOME/.config/kwinrc --group Windows --key FocusPolicy "FocusFollowsMouse"
kwriteconfig6 --file $HOME/.config/kwinrc --group Windows --key NextFocusPrefersMouse "true"
# Night Color
kwriteconfig6 --file $HOME/.config/kwinrc --group NightColor --key Active "true"
kwriteconfig6 --file $HOME/.config/kwinrc --group NightColor --key LatitudeAuto ""
kwriteconfig6 --file $HOME/.config/kwinrc --group NightColor --key LongitudeAuto ""
kwriteconfig6 --file $HOME/.config/kwinrc --group NightColor --key NightTemperature "3000"
# disable stupid touch screen edges and weird corners and thir animations
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-Cube --key BorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-Cube --key BorderActivateCylinder "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-Cube --key BorderActivateSphere "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-Cube --key TouchBorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-Cube --key TouchBorderActivateCylinder "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-Cube --key TouchBorderActivateSphere "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-DesktopGrid --key BorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-DesktopGrid --key TouchBorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key BorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key BorderActivateAll "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key BorderActivateClass "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key TouchBorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key TouchBorderActivateAll "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group Effect-PresentWindows --key TouchBorderActivateClass "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group TabBox --key LayoutName "thumbnail_grid"
kwriteconfig6 --file $HOME/.config/kwinrc --group TabBox --key BorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group TabBox --key BorderAlternativeActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group TabBox --key TouchBorderActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group TabBox --key TouchBorderAlternativeActivate "9"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key Bottom "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key BottomLeft "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key BottomRight "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key Left "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key Right "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key Top "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key TopLeft "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group ElectricBorders --key TopRight "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group TouchEdges --key Bottom "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group TouchEdges --key Left "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group TouchEdges --key Right "None"
kwriteconfig6 --file $HOME/.config/kwinrc --group TouchEdges --key Top "None"
# set titlebar buttons
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key BorderSize "Normal"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "M"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "FIAX"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key CloseOnDoubleClickOnMenu "false"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ShowToolTips "false"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key library "org.kde.breeze"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key theme "Breeze"
# a bit of sugar
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "blurEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "contrastEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "desktopchangeosdEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "glideEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "highlightwindowEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "kwin4_effect_dimscreenEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "kwin4_effect_scaleEnabled" "false"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "kwin4_effect_squashEnabled" "false"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "magiclampEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "minimizeallEnabled" "false"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "overviewEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "slideEnabled" "false"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "thumbnailasideEnabled" "true"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "videowallEnabled" "false"
kwriteconfig6 --file $HOME/.config/kwinrc  --group "Plugins"  --key "wobblywindowsEnabled" "true"

# krunnerrc
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key CharacterRunnerEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key DictionaryEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key "Kill RunnerEnabled" "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key PowerDevilEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key "Spell CheckerEnabled" "false"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key baloosearchEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key bookmarksEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key browsertabsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key calculatorEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key desktopsessionsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key katesessionsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key konsoleprofilesEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key krunner_appstreamEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key kwinEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key locationsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key org.kde.activitiesEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key org.kde.datetimeEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key org.kde.windowedwidgetsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key placesEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key plasma-desktopEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key recentdocumentsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key servicesEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key shellEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key unitconverterEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key webshortcutsEnabled "true"
kwriteconfig6 --file $HOME/.config/krunnerrc --group Plugins --key windowsEnabled "true"

# plasmawindowed-appletsrc
kwriteconfig6 --file $HOME/.config/plasmawindowed-appletsrc --group ActionPlugins --group 0 --key "MiddleButton;NoModifier" "org.kde.paste"
kwriteconfig6 --file $HOME/.config/plasmawindowed-appletsrc --group ActionPlugins --group 0 --key "RightButton;NoModifier" "org.kde.contextmenu"
kwriteconfig6 --file $HOME/.config/plasmawindowed-appletsrc --group ActionPlugins --group 0 --key "wheel:Vertical;NoModifier" "org.kde.switchdesktop"


# TODO font
#kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key fixed "Monospace,9,-1,5,50,0,0,0,0,0"
#kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key font "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"
#kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key menuFont "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"
#kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key shadeSortColumn "true"
#kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key smallestReadableFont "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"
#kwriteconfig6 --file $HOME/.config/kdeglobals --group General --key toolBarFont "Cantarell,10,-1,5,50,0,0,0,0,0,Regular"

# kcminputrc
kwriteconfig6 --file $HOME/.config/kcminputrc  --group Mouse --key "XLbInptAccelProfileFlat" "true"

# keyboard settings
kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "Options" "grp:win_space_toggle,caps:escape"
kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "ResetOldOptions" "true"
kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "ShowFlag" "true"
kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "ShowLabel" "true"
kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "ShowLayoutIndicator" "true"
kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "ShowSingle" "false"
! grep -q "Use=true" $HOME/.config/kxkbrc && kwriteconfig6 --file $HOME/.config/kxkbrc  --group Layout --key "Use" "false"

# background services
kwriteconfig6 --file $HOME/.config/kded5rc  --group "Module-device_automounter" --key "autoload" "false"

# powermanagement
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group DPMSControl --key idleTime --delete
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group DPMSControl --key lockBeforeTurnOff --delete
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group DimDisplay --key idleTime --delete
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key lidAction 1
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key powerButtonAction 16
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key powerDownAction 16
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group AC --group HandleButtonEvents --key triggerLidActionWhenExternalMonitorPresent false
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group DPMSControl --key idleTime 480
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group DPMSControl --key lockBeforeTurnOff 0
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group DimDisplay --key idleTime 360000
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group SuspendSession --key idleTime 720000
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group SuspendSession --key suspendThenHibernate true
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group SuspendSession --key suspendType 1
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key lidAction 1
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key powerButtonAction 16
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key powerDownAction 16
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group Battery --group HandleButtonEvents --key triggerLidActionWhenExternalMonitorPresent false
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group BrightnessControl --key value 5
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group DPMSControl --key idleTime 120
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group DPMSControl --key lockBeforeTurnOff 0
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group DimDisplay --key idleTime 60000
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group SuspendSession --key idleTime 300000
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group SuspendSession --key suspendThenHibernate false
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group SuspendSession --key suspendType 2
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key lidAction 1
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key powerButtonAction 16
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key powerDownAction 16
kwriteconfig6 --file $HOME/.config/powermanagementprofilesrc --group LowBattery --group HandleButtonEvents --key triggerLidActionWhenExternalMonitorPresent false

kwriteconfig6 --file $HOME/.config/systemsettingsrc --group systemsettings_sidebar_mode --key HighlightNonDefaultSettings true

[ "$(id -u)" = "0" ] || systemctl --user restart plasma-kded.service &>/dev/null
exit 0
