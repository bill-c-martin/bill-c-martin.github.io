---
layout: blog_post
title: Install Arch Linux on VirtualBox
category: blog
---

Ah, the ultimate OS for Level 110 Necromancers, or so they say. They say it's best prodded from afar before taking the plunge. They say a lot of things.

It could be my past six years of LAMP development experience in a corporate environment, but I don't think Arch lives up to its hyped difficulty.

I initially took the plunge and installed Arch right on my hard drive next to Windows, using their [beginner's guide](https://wiki.archlinux.org/index.php/beginners'_guide). Most of the installation time is spent learning its glorious innards.

However, I recently had to install Arch Linux on VirtualBox to help reproduce and debug an [issue I reported](https://github.com/gnumdk/lollypop/issues/409) for the [Lollypop](https://github.com/gnumdk/lollypop) music player. I have compiled the meat of its actual installation process just to prove it's not the monster people think it is:

### Pregaming

1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads), and get the [Arch ISO](https://www.archlinux.org/download/)
2. Create a new VDI in VirtualBox, boot it, select the Arch .iso as the startup disk

Within five seconds, a root shell is born. Beware: When you gaze long into the root shell, the root shell also gazes also into you!

### Installation

#### Initial Preparation (5 min)

1. Verify Internet Connection: ``` $ ping google.com ```
2. Update System Clock: ``` $ timedatectl set-ntp true```
3. Identify the "hard drive": ``` $ lsblk```
4. Open "hard drive" in Parted: ``` $ parted /dev/sda```
5. Assign a Label: ``` $ (parted) mklabel msdos```
6. Create Partition: ``` $ (parted) mkpart primary ext4 1M 100%```
7. Set Boot Flag: ``` $ (parted) set 1 boot on```
8. Verify Partition: ``` $ (parted) print```
9. Exit Parted: ``` $ ctrl+C```
10. Format Partition: ``` $ mkfs.ext4 /dev/sda1```
11. Mount Partition: ``` $ mount /dev/sda1 /mnt```

#### Package Installation (5 min of waiting)

1. Install Base Packages: ``` $ pacstrap -i /mnt base base-devel```
  1. Hit enter, enter, Y

#### Configuration (5 min)

1. Generate fstab: ``` $ genfstab -U /mnt > /mnt/etc/fstab```
2. Change to Root in New System: ``` $ arch-chroot /mnt /bin/bash```
3. Set Locale: ``` $ echo "LANG=en_US.UTF-8" > /etc/local.conf```
4. Download Boot Loader: ``` $ pacman -S grub os-prober```
5. Install Boot Loader: ``` $ grub-install --target=i386-pc --recheck /dev/sda```
6. Generate Boot Config: ``` $ grub-mkconfig -o /boot/grub/grub.cfg```
7. Set Some Hostname: ``` $ echo "myhostname" > /etc/hostname```
8. Get NIC Name: ``` $ ip link```
9. Autostart Internet Connectivity: ``` $ systemctl enable dhcpcd@xxx.service```
 1. where *xxx* is the NIC name from ``` $ ip link```
10. Set Root Password: ``` $ passwd```
11. Exit New System: ``` $ exit```
12. Reboot: ``` $ reboot```
 1. Select option 3 "Boot existing OS" to boot into Arch
 2. Login as root

#### GUI (10 min, mostly waiting)
<ol>
    <li>Install OpenGL Drivers
        <ol>
            <li>Enable Multilib
                <ol>
                    <li><code># vi /etc/pacman.conf</code></li>
                    <li>Uncomment the two multilib lines:
                        <div class="highlight">
                            <pre><code class="language-sh" data-lang="sh"><span class="c">#[multilib]</span><br/><span class="c">#Include = /etc/pacman.d/mirrorlist</span></code></pre>
                        </div>
                        <p>To:</p>
                        <div class="highlight">
                            <pre><code class="language-sh" data-lang="sh"><span class="c">#[multilib]</span><br/><span class="c">#Include = /etc/pacman.d/mirrorlist</span></code></pre>
                        </div>
                    </li>
                </ol>
            <li>Update Pacman: <code># pacman -Syu</code></li>
            <li>Install OpenGL: <code># pacman -S mesa-libgl</code></li>
            <li>Install 32 bit OpenGL: <code># pacman -S lib32-mesa-libgl</code></li>
        </ol>
    </li>
    <li>Install VirtualBox Guest Utilities: <code># pacman -S virtualbox-guest-utils</code></li>
    <li>Install Gnome: <code># pacman -S gnome gnome-extra</code>
        <ol>
            <li>Hit <code>enter enter enter enter Y</code></li>
        </ol>
    </li>
    <li>Enable GDM: <code># systemctl enable gdm.service</code></li>
    <li>Install Gnome Tweak Tool: <code># pacman -S gnome-tweak-tool</code></li>
    <li>The Final Reboot Before Things Become Civilized: <code># reboot</code></li>
</ol>

And that's all there is to it.
