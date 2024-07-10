---
date: 2024-04-28
title: Hyprland Arch Installation Guide 🐧⚙️
description: Learn to customize hyprland for an efficient desktop on Arch Linux. This article shows you how to tweak every detail for a perfectly riced workspace.
tags:
 - Arch, Hyprland, Customization, Linux
---

## Introduction

Welcome to this guide to install HYPRLAND in your Arch Linux.

Hyprland stands out by fully embracing the Wayland dispaly server protocol, positioning itself as cutting-edge  and future-oriented window manager. Through its integration with Wayland, Hyprland guarantees heightened security, seamless graphical performance, and expanded compatibilty with graphics hardware.

Like many other dynamic tiling windows managers, Hyprland is extremly customizable and highly configurable:
 - Here are some [examples](https://hyprland.org/hall_of_fame/)
 - Please check out also the [Hyprland Wiki](https://wiki.hyprland.org/)

*- **Note**: To follow this guide, we assume that you already have Arch Linux installed. If you have not installed it yet, you can refer to the [Arch Linux Installation Guide](/posts/arch-installation-guide).*

# 1) Installing paru (Aur helper)
Aur Helper is a tool which help you download apps and binaries stored and uploaded in Arch User Repository thus, giving you access to a large in no packages which are not available in official pacman repo’s

To install these packages, open a terminal and run the following command:

    $ pacman -S --needed base-devel
    $ git clone https://aur.archlinux.org/paru.git
    $ cd paru
    $ makepkg -si


# 2) Installing Hyprland With My scripts
```
     $ git clone https://github.com/S4NKALP/hyprland.git
     $ cd hyprland
     $ chmod +x setup
     $ ./setup
```
Then follow the instructions and the script do its rest of work.
``````
[~/dotfiles] $ tree

hypr
├── assets
│   ├── bell.png
│   ├── reload.svg
│   └── rofi.png
├── configs
│   ├── emojis
│   ├── Keybinds.conf
│   └── Settings.conf
├── hypridle.conf
├── hyprland.conf
├── hyprlock.conf
├── initial-boot.sh
├── scripts
│   ├── Device_cmd.sh
│   ├── Music_cmd.sh
│   ├── Ref.sh
│   ├── Rofi_cmd.sh
│   ├── RunCMD.sh
│   ├── System_cmd.sh
│   ├── Ui_cmd.sh
│   └── Xmenu.sh
└── UserConfigs
    ├── ENVariables.conf
    ├── LaptopDisplay.conf
    ├── Laptops.conf
    ├── Monitors.conf
    ├── Startup_Apps.conf
    ├── UserKeybinds.conf
    ├── UserSettings.conf
    └── WindowRules.conf

``````

# 3) Tips and Tricks
#### ⌨️ Common Operation Keys
  >> Super = Windows Key

- common operations
  - > Super         F1       *keyhint* (Keyhints)
  - > Super         Return   *term* (`kitty`)
  - > Super Shift   C        *quit* (closes (not kills) the active window)
  - > Super         C        *quit* (closes a specified window)
  - > Super         D        *show app menu* (`rofi`)
  - > Super         F        *full screen*

- applications shortcuts
  - > Super         E		  *file manager* (`thunar`) - if you chose to install

- container layout
  - > Super          F           *toggle tiling/floating mode*
  - > Super  Shift   F           *toggle all windows in float mode*
  - > Super  left mouse button   *move window*
  - > Super  right mouse button  *resize window* (note! only in float mode)

- workspaces
  - > Super 1 .. 0         *switch to workspace 1 .. 10*
  - > Super Shift 1 .. 0   *move (follow) container to workspace 1 .. 10*
  - > Super ALT   1 .. 0   *move (silent) container to workspace 1 .. 10*

- waybar
  - > Alt      W           *waybar layout* (waybar)

- refresh waybar, swaync, rofi
  - > Super Alt      R     *reloads waybar, rofi, swaync*
- These are only some. ALl keybinds are located in  *~/dotfiles/hypr/configs/Keybinds.conf* and *~/dotfiles/hypr/UserConfigs/UserKeybinds.conf*


#### 🖼️ wallpaper / styling stuff
  - > Shift    ALT    w       *wallpaper shuffle* (right click on wallpaper 🖼️  waybar module)
  - > Super           w       *wallpaper select* (click on wallpaper waybar  🖼️  module) add more wallpaper in ~/Pictures/wallpapers
  - right click on update   waybar module  *wallpaper cycle using swww*
  - scripts for wallpaper stuff are located in *~/.config/hypr/scripts/Ui_cmd.sh* file names  `auto_wall` `random_wall` `select_wall` funtion (first one for automatic wallpaper changed every 5 mins)
  - if your wallpapers are on a different path, edit the scripts above.

#### 💻 Monitor, executables, keybindings, window rules,
  - files are located in *~/.config/hypr/UserConfigs* . View with SUPER E
  - Keybindings file is located here *~/.config/hypr/UserConfigs/UserKeybinds.conf*

#### 🖼️ Taking Screen shots (you may need to hold down the function (`fn`) key. You can change keybinds in *~/.config/hypr/UserConfigs/UserKeybinds.conf*)
  - PrintScr(button)             *full screenshot*
  - Super           Z            *active window screenshot*

#### 🎗️ clipboard manager (cliphist)
  - Super Alt C   *launch the rofi menu of clipboard manager*
    - > click to select the clipboard. And paste as normal (CTRL V or right click menu)
    - > to clean up clipboard manager, launch kitty (super enter) then type ```cliphist wipe```

#### ♨️ Adjusting fonts sizes and font scaling including waybar fonts
- nwg-look is a very good app. Use it to adjust your own preference.
- for qt-apps, use qt5ct and/or qt6ct
- HiDPI users, I suggest you do the following to have a better appearance.
- > adjust scaling according to your taste by editing ~/.config/hypr/UserConfigs/Monitors.conf
- > adjust font size using nwg-look (GTK Settings)
- > You can tweak the fonts scaling in Font tab in nwg-look
- > Lastly, if desired, adjust waybar fonts sizes in ~/dotfiles/waybar/styles.css .

#### 💫 GTK and QT apps theming.
  - For GTK apps theming, use nwg-look (GTK Settings) utility. Its a very powerful gtk utility theming.
  - For QT Apps theming, use qt5ct, and/or qt6ct and Kvantum Manager. By default, the qt-theme (set using kvantum), is set to Dracula theme. You can change the qt apps theme using kvantum-manager.

#### 🎗️ waybar customizations
  > [!TIP]
  > Rename your waybar configs and styles that you have costumized so it wont be overwritten during upgrade (plan for v2.2.4)

  - waybar font too big or too small. Edit the font-size in waybar styles located in ~/dotfiles//waybar/styles.css . By default, it is set to 97%. After adjusting the GTK font scaling to your liking, edit all the waybar styles. Reduce or increase according to your needs. NOTE that its on percent %. You can also change to px whichever suits you. Note: This corresponds well with nwg-look (GTK Settings). So suggest to adjust first your font settings using nwg-look. And then adjust the waybar.

  - if you want 12h format instead of 24H format, edit the ~/.config/waybar/modules look for clock. for 12h format, should be like %I:%M%P; for 24H format, %H:%M:%S.. ensure to disable one format by adding // before that line. For clock formatting, you can use website: https://help.gnome.org/users/gthumb/stable/gthumb-date-formats.html.en

  - CPU Temperature:
    - to change from deg C to deg F , edit the ~/.config/waybar/modules look for "temperature". Change the format to "format": "{temperatureF}°F {icon}",
    - to fix the temperature if not showing correctly, edit the hwmon-path accordingly.
    - use this function to easily identify the hwmon path
      ```bash
      for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done
      ```
    - look for `K10temp` for AMD CPU and `coretemp` for Intel CPU's

  - For weather, edit the weather module located in  ~/.config/waybar/modules(change to your location)

  - plenty waybar hyprland/workspaces to choose from. Circle, Roman Number, pacman, and workspace number and icons. Just assign accordingly on waybar configs. Check `~/.config/waybar/modules` for their modules names

  - Regarding the waybar keyboard module, If you want to add in different waybar layout, the module name is custom/keyboard. Kindly NOTE that this will read your kb_layout in your Settings.conf. to change kb_layout, add in your Settings.conf .... i.e. kb_layout=us,es,ru and then refresh waybar (SUPER ALT R), then you can change keyboard by left clicking the keyboard module.

  - unwanted waybar module:
    - Simplest is to edit `~/.config/waybar/modules` . Put // before or delete that module.
    - Or you dont really need to worry about since the modules not defined on waybar configs are not loaded.

#### 🎗️ Hyprland configurations
  - *Hyprland* configuration files are in `~/.config/hypr/UserConfigs` with some settings `~/.config/hypr/configs` in  Can view using ALT E (by default, will be opened with nano. You can edit default editor by editing `~/.config/hypr/scripts/Rofi_cmd.sh`(edit function)
  - In Generaral, costumize your own dots in `~/.config/hypr/UserConfigs`
  - files located in this folder can be edited using editor of your choice.


#### 🧲 notes for nvidia gpu users
  - Do note that you need to enable or disable some items in ENVariables.conf file located in `~/.config/hypr/UserConfigs/ENVariables.conf`
  - a guide on wiki - https://wiki.hyprland.org/Nvidia/


#### 🔔 SwayNC
  - if you only want to use notification part of swayNC, edit ~/dotfiles/swaync/config.json
  - look at the widgets part. you can disable by putting /* <widget> */ i.e. /*"buttons-grid",*/ or delete that line. Then you can refresh with `SUPER ALT R`

#### 🎗️ other notes
  - *Multimedia keys* - may not work for every keyboard may need to hold down the function (`fn`) key
  - Follow the wiki - https://wiki.hyprland.org/
  - Follow the github - https://github.com/hyprwm/Hyprland

#### 🎗️ HIDDEN FEATURES!
  - ONLINE Music ( ALT M) (note: you may need to install yt-dlp or youtube-dl). You can edit the links of your choice. Script is located in `~/.config/hypr/scripts/Music_cmd.sh` .
  - EMOTICONS (SUPER .) - useful for chats or messages ). Click to copy and CTRL V to paste

#### 💡 Reducing cpu usages / Battery saving
  - Hyprland has a nice animation but it cost cpu and gpu usages including ram usages.
  - On this dotfiles, you disable the borderangle animation in Hyprland settings under animations.
  - You can also disable blur, reduce the shadow
  - You can also refer to [`Hyprland Wiki`](https://wiki.hyprland.org/hyprland-wiki/pages/FAQ/#how-do-i-make-hyprland-draw-as-little-power-as-possible-on-my-laptop)


