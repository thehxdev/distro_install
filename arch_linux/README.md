# arch install script

A shell script to make installing arch easier.

Use scripts after chroot to `/mnt`. It means you MUST install base system with pacstrap to /mnt.

## Install Base System Command:

```bash
pacstrap /mnt base base-devel linux linux-firmware linux-headers vi vim nano git curl
```

## Useful Packages

```bash
# Bases (IMPORTANT)
sudo pacman -Sy --needed --noconfirm --disable-download-timeout base-devel git xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings intel-ucode xf86-video-intel

# WMs & Some Pkgs
sudo pacman -S --needed --noconfirm --disable-download-timeout xmonad xmonad-contrib qtile nitrogen picom lxappearance rofi volumeicon  python-pip htop emacs neovim polkit lxsession xdg-user-dirs fish python-psutil

# Needed Pkgs
sudo pacman -S --needed --noconfirm --disable-download-timeout firefox kitty alacritty pcmanfm neovim xdeg-user-dirs fish polkit-gnome network-manager-applet bleachbit gvfs ntfs-3g vi vim nano galculator brightnessctl font-manager sxiv  xorg-xclipboard xclip feh acpid curl wget go ripgrep fd uget

sudo pamcan -S --needed --noconfirm --disable-download-timeout nodejs yarn aria2 yt-dlp pyright

# Wallpapers & Themes
sudo pacman -S --needed --noconfirm --disable-download-timeout materia-gtk-theme papirus-icon-theme archlinux-wallpaper arc-gtk-theme

## If you installed yay already, install kali-themes pkg. It's a beautiful gtk theme.
yay -S kali-themes

# VPN & PDF & Compression pkgs
sudo pacman -S --needed --noconfirm --disable-download-timeout alsa-utils pamixer unrar unzip p7zip xarchiver openvpn networkmanager-openvpn xreader

## If you want 7zip archive manager, Install it with this command:
yay -S p7zip-gui

# Fonts
sudo pacman -S --needed --noconfirm --disable-download-timeout ttf-roboto ttf-roboto-mono ttf-font-awesome ttf-ubuntu-font-family ttf-fira-code ttf-fira-mono adobe-source-code-pro-fonts adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts

## Noto fonts and emoji fonts
sudo pacman -S --needed --noconfirm --disable-download-timeout noto-fonts-cjk noto-fonts-emoji ttf-ionicons

# Other useful pkgs
sudo pacman -S --needed --noconfirm --disable-download-timeout bleachbit gvfs ntfs-3g vi vim nano galculator brightnessctl font-manager sxiv yt-dlp xorg-xclipboard xclip feh acpid pyright curl wget go ripgrep fd nodejs yarn aria2 uget

# TouchPad
sudo pacman -S --needed --noconfirm --disable-download-timeout xorg-xinput

chsh -s /usr/bin/fish
```
