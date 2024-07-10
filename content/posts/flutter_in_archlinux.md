---
date: 2024-06-08
title: Install Flutter in Linux without Android Studio
description: Flutter in Linux
tags:
  - flutter, linux, install
---

# INSTALL FLUTTER WITHOUT ANDROID STUDIO ON LINUX
<br>
Here I will show you how we can set up Flutter in Linux without installing Android Studio. This is very useful if your pc runs slow or don't like the android studio and you want to code in some other editor.
<br>
Remainder: Guys, This all process is tested in arch based distros. Please install the packages accordingly with your package installer.

<br>
Use the terminal for this tutorial.<br>

<h2><B>Install OpenJDK 17</B></h2><br>
I am using java 17. You can use other version too.
In termminal type:

```
sudo pacman -S jdk17-openjdk
```

<h2><B>Install Git </B></h2><br>
In termical type:

```
sudo pacman -S git
```

<h2><b>Setting Up Folder</b></h2><br>
I am keeping everything in a single directory. Use a terminal or you can make a folder inside the “Home” directory.

```
cd ~/
mkdir Android
cd Android
mkdir cmdline-tools
```

<h2><b>Install Flutter SDK</b></h2>

[Download](https://docs.flutter.dev/get-started/install/linux?source=post_page-----a14a66a88f9f--------------------------------) Flutter

Go to the folder where you downloaded the zip file and unzip the file. You can unzip it by right click on the file and click on extract here or using the terminal by the following code<br>
```
unzip flutter_linux_3.3.10-stable.tar.xz
```
Now move the <b>“flutter”</b> folder to the <b>“Home/Android/” directory</b>
```
sudo mv flutter/ ~/Android/
```
<br>
Now the full path looks like this
<h4><b>Home/Android/flutter</b></h4>
<h2><b>Install Android Command Line Tools</b></h2>
<br>

[Download](https://developer.android.com/studio#command-tools) Android command-line tools for Linux
<br>
Got to the folder where you downloaded the file and unzip the file.
```
sudo tar -xvf commandlinetools-linux-11076708_latest.zip
```
Now move the <b>"tools"</b> folder to the <b>"HOME/Android/cmdline-tools"</b> directory
```
sudo mv tools/ ~/Android/cmdline-tools/
```
Now the full path looks like this
<h4><b>Home/Android/cmdline-tools/tools</b></h4>
<h2><b>Set Some Environment Variables</b></h2>
now go back to the <b>“Home”</b> directory and open up the <b>".zshrc" or ".bashrc"</b> file for setting up some environment variables

```
cd ~
sudo nano .zshrc  //i am using here zsh
```
Now write this at the end of the .zsrch or .bashrc file

```
export ANDROID=$HOME/Android
export PATH=$ANDROID/cmdline-tools/tools:$PATH
export PATH=$ANDROID/cmdline-tools/tools/bin:$PATH
export PATH=$ANDROID/platform-tools:$PATH# Android SDK
export PATH=$ANDROID/emulator:$PATH
export ANDROID_SDK=$HOME/ANDROID
export PATH=$ANDROID_SDK:$PATH# Flutter
export FLUTTER=$ANDROID/flutter
export PATH=$FLUTTER/bin:$PATH

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH # Java
```
save the file

<h2><b>Download Android SDK</b></h2>
So for Flutter to run we need to install system-image, platform-ttols,buil-tools,platforms:android,cmdline-tools;latest.<br><br>
I am using android-31, you can use the version which is compatible with your Android device. If you want to see all available versionsfor system-image, platform-tools, build-tools, and platforms; android type the following in the terminal

```
sdkmanager --list
```
for version 31 type the following command in terminal
```
sdkmanager “system-images;android-31;default;x86_64”
sdkmanager "platforms;android-31"
sdkmanager “platform-tools”
sdkmanager "build-tools;31.0.0"
```
Now accept the licenses.
```
sdkmanager --licenses
```
<h2><b>Install Android Emulator</b></h2>

```
sdkmanager "emulator"
```

<h2><b>Setup Android Emulator</b></h2>


```
sdkmanager "system-images;android-31;default;x86_64"
avdmanager create avd -n pixel -k "system-images;android-31;default;x86_64" --device "pixel"
```

In my case the .android folder is located in ~/.config to make flutter recognize it.


```
ln -sf ~/.config/android/ ~/
```

<h2><b>Configure SDK path for Flutter</b></h2>


```
flutter config --android-sdk ~/Android
```

<h2><b>Call To Flutter Doctor</b></h2>
Run this command in terminal


```
flutter doctor -v
```

This command give you all green tick, ignore [!] at android studio because we are not using it.<br>
if it ask for Accept Licenses with flutter doctor use below command to accept licenses


```
flutter doctor --android-licenses
```

<h2><b>Setup Your Android Phone</b></h2>
For running Flutter App on our physical device we need to turn on USB Debugging on your Android phone. It's very simple to do a search on Google “how to turn USB Debugging on ‘phone_name’ ”
<br>
<h2><b>Again Run Flutter Doctor</b></h2>

Run this command
```
flutter doctor -v
```
your phone show a popup click on <b><u>allow</u></b> <br>

<h2><b>If you dont want to use your phone then do following</b></h2>

In terminal type
```
emulator -avd pixel
```
then run following commands.

<h2><b>Test Flutter Code</b></h2>
Let's create a Flutter project
<br>

In terminal type:


```
cd Desktop/
flutter create hello_world
cd hello_world
flutter run
```

<h4><b>Now you can code in any code editor you want, I prefer Visual Studio Code because it provides great plugins for flutter code for beginners.But I use Neovim.</b></h4>
