# HyperUEFI
Use Windows on your Raspberry Pi 3/4/5.

# How does it work?
HyperUEFI uses QEMU with KVM to use Pi's processor to run Windows on a thin Linux layer (Pi OS Lite).<br>
It has:<br>

* Audio
* Networking
* USB hotplug

<br>

HyperUEFI minimizes overhead by not using a DE or a WM. It uses SDL with GL to show the guest display.<br>
HyperUEFI only has ONE display support. (1st HDMI)<br>
HyperUEFI keeps the guest and the host's network separated.

# Installation
> You need Raspberry Pi OS Lite (64-bit). <br>


To install, clone this repo then run the following in the repo root:<br>
`bash $(bash mkinst)`<br>
Then, enable autologin using `raspi-config` and add the following to your bashrc file `~/.bashrc`:<br>
`sudo /sbin/hymenu`<br>
Reboot and use the configurator to configure the guest

# Windows Installation
Download a Windows 10 ARM ISO and flash it to a USB drive (use a tool like WinDiskWriter or Rufus). Plug the USB drive into the Pi. Boot the guest. Hit ESC on your keyboard to enter OVMF settings. Select `Boot Manager` and select your drive. Wait for the Windows installer to boot. When it boots, press `Shift`+`F10` to open the command prompt.<br><br>
Run `diskpart` and list disks using `list disk`. Select the drive that Windows will be installed into using `select disk DISK_NUMBER`.<br> Then run the following commands in diskpart:<br>
* `clean`
* `convert gpt`
* `cre par efi size 512`
* `form fs fat32 quick`
* `assign letter P`
* `cre par msr size 16`
* `cre par pri`
* `form quick label Windows`
* `assign letter Q`
* `exit`
<br><br>

Now, `cd` to the folder that contains the `install.wim` file.<br>
To list editions, run `dism /get-wiminfo /wimfile:install.wim`. Then, note the ID of your desired edition.<br>
To install (will take a long time), run `dism /apply-image /imagefile:install.wim /index:ID /applydir:Q:`.<br>
To install the bootloader, run `bcdboot Q:\Windows /s P:`.<br>
To reboot, run `wpeutil reboot`.<br>