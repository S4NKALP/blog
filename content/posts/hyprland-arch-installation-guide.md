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
├── configs
│   ├── Keybinds.conf
│   └── Settings.conf
├── hypridle.conf
├── hyprland.conf
├── hyprlock.conf
├── initial-boot.sh
├── scripts
│   ├── Polkit.sh
│   ├── RunCMD.sh
│   ├── ScreenShot.sh
│   ├── Ui_cmd.sh
│   └── wallpaper.py
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
  - > Super         F1       *cheatsheet*
  - > Super         Return   *term* (`kitty`)
  - > Super Shift   C        *quit* (closes (not kills) the active window)
  - > Super         C        *quit* (closes a specified window)
  - > Super         D        *show app menu* (`ags`)
  - > Super         F        *full screen*

- applications shortcuts
  - > Super         E         *file manager* (`thunar`) - if you chose to install

- container layout
  - > Super          F           *toggle tiling/floating mode*
  - > Super  Shift   F           *toggle all windows in float mode*
  - > Super  left mouse button   *move window*
  - > Super  right mouse button  *resize window* (note! only in float mode)

- workspaces
  - > Super 1 .. 0         *switch to workspace 1 .. 10*
  - > Super Shift 1 .. 0   *move (follow) container to workspace 1 .. 10*
  - > Super ALT   1 .. 0   *move (silent) container to workspace 1 .. 10*

- These are only some. ALl keybinds are located in  *~/dotfiles/hypr/configs/Keybinds.conf* and *~/dotfiles/hypr/UserConfigs/UserKeybinds.conf*


#### 🖼️ wallpaper / styling stuff
  - > Shift    ALT    w       *wallpaper shuffle*
  - > Super           w       *wallpaper select*

#### 🖼️ Taking Screen shots (you may need to hold down the function (`fn`) key. You can change keybinds in *~/.config/hypr/UserConfigs/UserKeybinds.conf*)
  - PrintScr(button)             *full screenshot*
  - Super           Z            *active window screenshot*

#### 🎗️ clipboard manager (cliphist)
  - Super Alt C   *launch clipboard manager*

#### ♨️ Adjusting fonts sizes and font scaling including waybar fonts
- nwg-look is a very good app. Use it to adjust your own preference.
- HiDPI users, I suggest you do the following to have a better appearance.
- > adjust scaling according to your taste by editing ~/.config/hypr/UserConfigs/Monitors.conf
- > adjust font size using nwg-look (GTK Settings)
- > You can tweak the fonts scaling in Font tab in nwg-look

#### 🎗️ Hyprland configurations
  - *Hyprland* configuration files are in `~/.config/hypr/UserConfigs` with some settings `~/.config/hypr/configs` in  Can view using ALT E (by default, will be opened with nano. You can edit default editor by editing `~/.config/hypr/scripts/Rofi_cmd.sh`(edit function)
  - In Generaral, costumize your own dots in `~/.config/hypr/UserConfigs`
  - files located in this folder can be edited using editor of your choice.


#### 🧲 notes for nvidia gpu users
  - Do note that you need to enable or disable some items in ENVariables.conf file located in `~/.config/hypr/UserConfigs/ENVariables.conf`
  - a guide on wiki - https://wiki.hyprland.org/Nvidia/

#### 💡 Reducing cpu usages / Battery saving
  - Hyprland has a nice animation but it cost cpu and gpu usages including ram usages.
  - You can also disable blur, reduce the shadow
  - You can also refer to [`Hyprland Wiki`](https://wiki.hyprland.org/hyprland-wiki/pages/FAQ/#how-do-i-make-hyprland-draw-as-little-power-as-possible-on-my-laptop)


