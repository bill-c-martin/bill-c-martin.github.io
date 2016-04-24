---
layout: blog_post
title: Install YNAB on Arch Linux
category: blog
---

Installing You Need A Budget (YNAB) on the average Linux distro is a no-brainer, but Arch Linux requires a few extra strokes to get purring.

This is primarily due to Arch's minimalist foundation, as well as YNAB being reluctant about running in 64 bit.

I had to do six simple steps:

1. [Enable Multilib](#enable-multilib)
1. [Sync Pacman](#sync-pacman)
1. [Install Wine & friends](#install-wine)
1. [Install 32-bit Open GL for video card](#install-open-gl)
1. [Install Windows Corefonts](#install-corefonts)
1. [Install YNAB](#install-ynab)

<a name="enable-multilib"></a>

### Enable multilib

Enable 32-bit package repositories (multilib) for pacman so it finds wine:

```shell
$ sudo vi /etc/pacman.conf
```

Change:

```aconf
\#[multilib-testing]
Include = /etc/pacman.d/mirrorlist
\#[multilib]
Include = /etc/pacman.d/mirrorlist
```

to:

```aconf
[multilib-testing]
Include = /etc/pacman.d/mirrorlist
[multilib]
Include = /etc/pacman.d/mirrorlist
```

<a name="sync-pacman"></a>

### Sync Pacman

Sync pacman with the newly added multilib repositories:

```shell
$ sudo pacman -Sy
```

<a name="install-wine"></a>

### Install Wine & Friends


```shell
$ sudo pacman -S wine
$ sudo pacman -S lib32-lcms lib32-lcms2
$ sudo pacman -S samba wine-mono wine_gecko lib32-gnutls lib32-mpg123 lib32-ncurses
```

<a name="install-open-gl"></a>

### Install 32-bit Open GL

This had to be done because I got an error: *"X Error of failed request:  BadValue (integer parameter out of range for operation)"* while trying to launch YNAB.

Installation of 32-bit Open GL is not only optional when setting up your video card drivers in Arch for the first time, but the 32-bit repos were also disabled by default.

I have an Nvidia card, so I had to install the 32-bit Open GL library (which is also from the multilib repositories) in addition the nvidia drivers already installed.

``` shell
$ sudo pacman -S lib32-nvidia-libgl
```
<a name="install-corefonts"></a>

### Install Windows Corefonts

This step is required because the tooltips in YNAB will show strange characters. In order to install the corefonts, you have to install winetricks. Winetricks has to be installed from the [AUR](https://aur.archlinux.org/packages/winetricks-git/). I use a preexisting ~/builds folder for building AUR packages in:

``` sh
$mkdir ~/builds
$ cd ~/builds/
$ curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/winetricks-git.tar.gz
$ tar -xvf winetricks-git.tar.gz
$ cd winetricks-git
$ makepkg -sri
```

And then install the Corefonts using Winetricks:

```shell
$ WINEPREFIX=~/.wine-YNAB WINEARCH=win32 winetricks corefonts
```
<a name="install-ynab"></a>

### Install YNAB

Download the YNAB trial from their site (link pending). Then go to the folder you downloaded it in and:

```shell
$ WINEARCH=win32 WINEPREFIX=~/.wine-YNAB wine YNAB\ 4_4.3.352_Setup.exe
```
<a name="inspiration"></a>

## Inspiration

This is a reduced demi-glace of [push.cx](https://push.cx/2015/installing-you-need-a-budget-ynab-on-arch-linux), seasoned with my own detailed commands for every step of the way, and a touch of Open GL info gleaned from [Arch's NVIDIA wiki](https://wiki.archlinux.org/index.php/NVIDIA#Installing).
