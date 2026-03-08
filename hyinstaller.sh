###
installer() {
    sudo mkdir -p /opt/hyperuefi/ /sbin/
    echo $HYMENU_B64 | base64 -d | sudo tee /sbin/hymenu > /dev/null 2>&1
    echo $KVMD_B64 | base64 -d | sudo tee /opt/hyperuefi/kvmd > /dev/null 2>&1
    sudo chmod +x /sbin/hymenu
    sudo chmod +x /opt/hyperuefi/kvmd
}
yes | sudo apt update
yes | sudo apt install -y util-linux usbutils telnet dialog qemu-block-extra qemu-utils qemu-system-gui qemu-system-data qemu-system-common qemu-efi-aarch64 qemu-system-misc qemu-system qemu-system-aarch64
printf "Installing hyperuefi... "
installer
echo "done!"
echo "Add 'sudo /sbin/hymenu' to your .bashrc"
echo "Set your login shell to bash and enable autologin. Then, disable sudo password protection."