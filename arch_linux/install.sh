#!/usr/bin/env bash

# Colors
Color_Off='\033[0m'
Black='\033[0;30m' 
Red='\033[0;31m'   
Green='\033[0;32m' 
Yellow='\033[0;33m'
Blue='\033[0;34m'  
Purple='\033[0;35m'
Cyan='\033[0;36m'  
White='\033[0;37m' 

# Variables
OK="${Green}[OK]"
ERROR="${Red}[ERROR]"
INFO="${Yellow}[INFO]"
SLEEP="sleep 0.2"
PRIMARY_STORAGE_DEVICE=$(lsblk | grep -E "/$" | grep -Eo "sd[a-z]|nvme[0-9]{1,2}n[0-9]{1,2}|vd[a-z]")
REFLECTOR_CONFIG_FILE="/etc/xdg/reflector/reflector.conf"
PACMAN_CONFIG="/etc/pacman.conf"

#print OK
function print_ok() {
    echo -e "${OK} $1 ${Color_Off}"
}

#print ERROR
function print_error() {
    echo -e "${ERROR} $1 ${Color_Off}"
}

#print INFO
function print_info() {
    echo -e "${INFO} $1 ${Color_Off}"
}

function installit() {
    configure_pacman
    pacman -Sy --needed --noconfirm --disable-download-timeout $*
}

# Check exit code of previous command
function judge() {
    if [[ 0 -eq $? ]]; then
        print_ok "$1 Finished"
        $SLEEP
    else
        print_error "$1 Failed"
        exit 1
    fi
}

# Check root access
function check_root() {
    if [[ "${EUID}" != 0 ]]; then
        print_error "This script requires root user access!"
        exit 1
    else
        print_ok "Root user checked!"
    fi
}

function check_os() {
    if [[ -e "/etc/os-release" ]]; then
        source /etc/os-release
    else
        print_error "Can't find /etc/os-release file"
        exit 1
    fi

    if [[ ${ID} != "arch" ]]; then
        print_error "This script only runs on Arch Linux!"
        exit 1
    else
        print_ok "Arch linux detected!"
    fi
}

function set_tehran_timezone() {
    ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime
    judge "Set Tehran as current timezone"
    hwclock --systohc
    judge "Run hwclock"
}

function configure_en_locale() {
    cp /etc/locale.gen /etc/locale.gen.bak
    judge "Make a backup from /etc/locale.gen to /etc/locale.gen.bak"
    if [[ -e "/etc/locale.gen.bak" ]]; then
        echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
        judge "Set en_US.UTF-8 to locale.gen"
        locale-gen
        judge "Run locale-gen"
    else
        print_error "Can't find locale.gen backup file!"
        exit 1
    fi
}

function us_keymap() {
    echo "KEYMAP=us" >> /etc/vconsole.conf
    judge "Set us keymap"
}

function set_hostname() {
    read -rp "Enter your hostname (default: arch): " user_chosen_hostname
    [ -z "${user_chosen_hostname}" ] && user_chosen_hostname="arch"
    echo ${user_chosen_hostname} > /etc/hostname
    judge "Add ${user_chosen_hostname} to /etc/hostname"
}

function configure_hosts() {
    user_hostname=$(cat /etc/hostname)
    echo -e "127.0.0.1 localhost" >> /etc/hosts
    judge "add 127.0.0.1 to /etc/hosts"
    echo -e "::1       localhost" >> /etc/hosts
    judge "add ::1 to /etc/hosts"
    echo -e "127.0.1.1 ${user_hostname}.localdomain ${user_hostname}" >> /etc/hosts
    judge "add ${user_hostname}.localdomain to /etc/hosts"
}

function install_bootloader_mbr() {
    echo -e "${Blue}Time to install boot loader.${Color_Off}"
    echo -e "${Yellow}If you want to choose installation target manually, select number 3 (Recommended)${Color_Off}"
    echo -e "${Yellow}1 and 3 numbering is correct.${Color_Off}"
    echo -e "  ${Green}1) Automatice install (May cause some issues)${Color_Off}"
    echo -e "  ${Green}3) Manual install (Recommended)"

    read -rp "Enter an Option: " install_bootloader_option
    case $install_bootloader_option in
        1)
            print_info "Automatice Installation"
            if [[ -e "/dev/${PRIMARY_STORAGE_DEVICE}" ]]; then
                grub-install --target=i386-pc /dev/${PRIMARY_STORAGE_DEVICE}
                judge "grub install"
                grub-mkconfig -o /boot/grub/grub.cfg
                judge "create grub config"
            else
                print_info "Can't find your primary storage device to install bootloader"
                exit 1
            fi
            ;;
        3)
            print_info "Manual Installation"
            lsblk | grep -Eo "sd[a-z]|nvme[0-9]{1,2}n[0-9]{1,2}|vd[a-z]" | uniq
            read -rp "Enter Installation target: " grub_installatoin_target
            if [[ -e "/dev/${grub_installatoin_target}" ]]; then
                grub-install --target=i386-pc /dev/${grub_installatoin_target}
                judge "grub install"
                grub-mkconfig -o /boot/grub/grub.cfg
                judge "create grub config"
            else
                print_info "Can't find your primary storage device to install bootloader"
                exit 1
            fi
            ;;
    esac
}

function install_bootloader_gpt() {
    if [[ -e "/boot" ]]; then
        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
        judge "Install Grub on /boot partition"
        grub-mkconfig -o /boot/grub/grub.cfg
        judge "create Grub config"
    else
        print_error "Can't find /boot partition or it's not mounted"
        print_error "Can't Install grub"
        exit 1
    fi
}

function configure_users() {
    echo -e "${Blue}Setting root user password${Color_Off}"
    read -rp "Enter NEW root password: " new_root_password
    echo root:$new_root_password | chpasswd

    echo -e "${Blue}Creating a new user${Color_Off}"
    read -rp "Enter New user's username: " new_user_name
    read -rp "Enter New user's password: " new_user_password

    useradd -m $new_user_name
    judge "Create user ${new_user_name}"

    echo $new_user_name:$new_user_password | chpasswd
    judge "change user ${new_user_name} password"

    usermod -aG wheel $new_user_name 
    judge "Add user ${new_user_name} to wheel group"

    echo "%wheel   ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers
    judge "Add wheel group to sudoers file"
}

# This function enables reflector.timer that starts reflector.service
# weekly.
function install_and_configure_reflector_auto() {
    installit reflector
    judge "Install reflector"

    cp -f /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    judge "Make a copy of old mirrorlist file"

    tee ${REFLECTOR_CONFIG_FILE} << EOF
--save /etc/pacman.d/mirrorlist
--country Germany
--protocol http,https
--latest 5
EOF
    systemctl enable --now reflector.timer

    print_info "Running reflector. This may take some time..."
    # List top 5 mirrors and save them in mirrorlist file. Germany mirrors are better for iran.
    reflector --latest 5 --country Germany --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
    judge "Save top 5 mirrors for pacman"
}

function install_reflector_manual() {
    installit reflector
    judge "Install reflector"

    cp -f /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    judge "Make a copy of old mirrorlist file"

    print_info "Running reflector. This may take some time..."
    # List top 5 mirrors and save them in mirrorlist file. Germany mirrors are better for iran.
    reflector --latest 5 --country Germany --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
    judge "Save top 5 mirrors for pacman"
}

# Halifax Mirrors (Germany)
function halifax_pacman_mirror() {
    cp -f /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    judge "Make a copy of old mirrorlist file"
    echo "Server = http://ftp.halifax.rwth-aachen.de/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
    judge "Add halifax mirror to mirrorlist"
    pacman -Syy
    judge "Sync Pacman"
}

function configure_pacman() {
    if grep -E "^SigLevel = TrustAll" ${PACMAN_CONFIG}; then
        print_ok "SigLevel is configured to Trust All"
    else
        sed -ibak "/^SigLevel/d" ${PACMAN_CONFIG}
        judge "Remove old SigLevel"
        sed -ibak "/^#ParallelDownloads/i SigLevel = TrustAll" ${PACMAN_CONFIG}
        judge "Add SigLevel"
    fi

    if grep -E "^ParallelDownloads" ${PACMAN_CONFIG}; then
        print_ok "Parallel Download is enabled"
    else
        sed -ibak "/^#ParallelDownloads/i ParallelDownloads = 5" ${PACMAN_CONFIG}
        judge "Enable Parallel Downloads"
    fi
}

function install_mbr_packages() {
    installit grub networkmanager network-manager-applet \
        dialog mtools dosfstools xdg-user-dirs xdg-utils \
        nfs-utils inetutils dnsutils bluez bluez-utils cups \
        bash-completion openssh reflector acpi acpi_call \
        pipewire pipewire-pulse pipewire-alsa alsa-utils \
        acpid ipset iptables os-prober ntfs-3g git
    judge "Install mbr base system packages"
}

function install_gpt_packages() {
    installit grub networkmanager network-manager-applet \
        dialog mtools dosfstools xdg-user-dirs xdg-utils \
        nfs-utils inetutils dnsutils bluez bluez-utils cups \
        bash-completion openssh reflector acpi acpi_call \
        pipewire pipewire-pulse pipewire-alsa alsa-utils \
        acpid ipset iptables os-prober ntfs-3g git \
        efibootmgr
    judge "Install gpt base system packages"
}

function enable_mbr_installed_services() {
    systemctl enable NetworkManager
    systemctl enable bluetooth
    systemctl enable cups.service
    systemctl enable sshd
    #systemctl enable reflector.timer
    systemctl enable acpid
}

function install_base_packages() {
    pacstrap /mnt base base-devel linux linux-firmware linux-headers networkmanager vim
    judge "Install Base packages"

    genfstab -U /mnt > /mnt/etc/fstab
    judge "Generate fstab file"
    print_info "Now you can chroot to new installed Arch linux with ${Blue}arch-chroot /mnt${Color_Off}"
}

function install_yay() {
    installit base-devel git go
    judge "install base-devel git go"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ~/
}

function install_xfce() {
    installit xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settigs \
        xfce4 xfce4-goodies xfce4-xkb-plugin arandr firefox papirus-icon-theme \
        unrar unzip p7zip dbus mpv openvpn networkmanager-openvpn networkmanager-pptp \
        networkmanager-openconnect networkmanager-l2tp networkmanager-strongswan alacritty \
        fish zsh aria2 alsa-utils pamixer bleachbit gvfs vim neovim font-manager xarchiver \
        xreader tmux htop galculator qt5ct kvantum
    judge "Install XFCE Desktop Environment"

    systemctl enable dbus
    judge "Enable dbus"
    systemctl enable lightdm.service
    judge "Enable lightdm"
    systemctl set-default graphical.target
    judge "Set graphical target as default"
}

function install_kde_lite() {
    installit xorg sddm plasma pcmanfm firefox arandr papirus-icon-theme ksystemlog \
        gparted ark kate kcalc krunner kfind kcron unrar unzip p7zip viewnior okular \
        dbus mpv openvpn networkmanager-openvpn networkmanager-pptp networkmanager-l2tp \
        networkmanager-strongswan networkmanager-openconnect spectacle kwallet kwalletmanager \
        alacritty fish zsh aria2 alsa-utils pamixer bleachbit gvfs vim neovim font-manager \
        tmux xarchiver htop galculator
    judge "Install packages for KDE Plasma lite desktop"

    systemctl enable dbus
    judge "Enable dbus"
    systemctl enable sddm
    judge "Enable sddm"
    systemctl set-default graphical.target
    judge "Set graphical target as default"
}

function install_kde_standard() {
    installit xorg sddm plasma firefox arandr papirus-icon-theme dolphin dolphin-plugins \
        kde-system-meta ark kate kcalc krunner kfind donsole unrar unzip p7zip gwenview \
        okular dbus plasma-wayland-sessoin mpv networkmanager-openvpn networkmanager-pptp \
        networkmanager-l2tp networkmanager-strongswan networkmanager-openconnect openvpn \
        spectacle kwallet kwalletmanager alacritty fish zsh viewnior aria2 alsa-utils \
        pamixer bleachbit gvfs tmux vim neovim font-manager xarchiver htop galculator

    systemctl enable dbus
    systemctl enable sddm
    judge "Enable dbus"
    judge "Enable sddm"
    systemctl set-default graphical.target
    judge "Set graphical target as default"
}

function install_kde_full() {
    installit xorg sddm plasma kde-applications arandr firefox papirus-icon-theme unrar \
        unzip p7zip dbus plasma-wayland-sessoin mpv vlc openvpn networkmanager-openvpn \
        networkmanager-openconnect networkmanager-pptp networkmanager-l2tp networkmanager-strongswan \
        alacritty fish zsh aria2 alsa-utils pamixer bleachbit gvfs vim neovim font-manager \
        libreoffice-still libreoffice-still-fa xarchiver htop galculator

    systemctl enable dbus
    judge "Enable dbus"
    systemctl enable sddm
    judge "Enable sddm"
    systemctl set-default graphical.target
    judge "Set graphical target as default"
}

function install_kde_menu() {
    echo -e "============================== KDE Plasma =============================="
    echo -e "${Green}1) Lite (No Bloatware)${Color_Off}"
    echo -e "${Green}2) Standard (Less Bloated)${Color_Off}"
    echo -e "${Green}3) Full (Bloated and has office suite)${Color_Off}"
    echo -e "${Yellow}Exit${Color_Off}"

    read -rp "Enter an Option: " kde_menu_num

    case $kde_menu_num in
        1)
            print_info "This option will install KDE Lite"
            read -n1 -r -p "Press any key to continue..."
            install_kde_lite
            ;;
        2)
            print_info "This option will install KDE Standard"
            read -n1 -r -p "Press any key to continue..."
            install_kde_standard
            ;;
        3)
            print_info "This option will install KDE Full"
            read -n1 -r -p "Press any key to continue..."
            install_kde_full
            ;;
        4)
            print_ok "Exit"
            exit 0
            ;;
        *)
            print_error "Invalid Option. Run the script again!"
            exit 1
            ;;
    esac
}

function mbr_base_system() {
    install_mbr_packages
    set_tehran_timezone
    configure_en_locale
    us_keymap
    set_hostname
    configure_hosts
    install_bootloader_mbr
    configure_users
}

function gpt_base_system() {
    install_gpt_packages
    set_tehran_timezone
    configure_en_locale
    us_keymap
    set_hostname
    configure_hosts
    install_gpt_packages
    configure_users
}

function main_menu() {
    clear
    echo -e '
 █████╗ ██████╗  ██████╗██╗  ██╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
██╔══██╗██╔══██╗██╔════╝██║  ██║    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
███████║██████╔╝██║     ███████║    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
██╔══██║██╔══██╗██║     ██╔══██║    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
██║  ██║██║  ██║╚██████╗██║  ██║    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝

==> By TheHxDev
==> https://github.com/thehxdev
'

    echo -e "============================== Base =============================="
    echo -e "${Green}1) Install base packages with pacstrap to /mnt${Color_Off}"
    echo -e "${Green}3) Install packages and boot loader for ${Red}MBR ${Cyan}(After Chroot)${Color_Off}"
    echo -e "${Green}5) Install packages and boot loader for ${Red}GPT ${Cyan}(After Chroot)${Color_Off}"
    echo -e "=============================== DE ==============================="
    echo -e "${Green}7) Install XFCE Desktop${Color_Off}"
    echo -e "${Green}8) Install KDE Desktop${Color_Off}"
    echo -e "${Yellow}9) Exit${Color_Off}"

    read -rp "Enter an Option: " menu_num
    case $menu_num in
        1)
            print_info "This option will install base packages to /mnt"
            read -n1 -r -p "Press any key to continue..."
            install_base_packages
            ;;
        3)
            print_info "This option will install base system for MBR"
            read -n1 -r -p "Press any key to continue..."
            mbr_base_system
            ;;
        5)
            print_info "This option will install base system for GPT"
            read -n1 -r -p "Press any key to continue..."
            gpt_base_system
            ;;
        7)
            print_info "This option will install XFCE Desktop Environment"
            read -n1 -r -p "Press any key to continue..."
            install_xfce
            ;;
        8)
            install_kde_menu
            ;;
        9)
            print_ok "Exit"
            exit 0
            ;;
        *)
            print_error "Invalid Option. Run the script again!"
            exit 1
    esac
}

check_root
check_os
main_menu "$@"

