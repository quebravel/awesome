## Mostrar a interface da rede
```css
ip -s -c -h a
```

## Carregar teclado

```css
loadkeys br-abnt2
```

## Configurar rede

```php
net-setup nomePlacaRede
```

## Se for preciso levante a placa de rede com

```javascript
ifconfig nomePlacaRede up
```

## Configurar data MÊS DIA HORA MINUTO ANO com

```
date MMDDHHMMAAAA</td>

```

Formatar HD com parted para EFI

```
parted -a optimal /dev/sda ↵  <br>
(parted) mklabel gpt ↵  <br>
(parted) rm 2 ↵  <br>
(parted) unit mib ↵  <br>
(parted) mkpart primary 1 513 ↵  <br>
(parted) name 1 efi_grub ↵  <br>
(parted) set 1 boot on ↵  <br>
(parted) print ↵  <br>
(parted) mkpart primary 514 1026 ↵  <br>
(parted) name 2 boot ↵  <br>
(parted) mkpart primary 1027 13315 ↵  <br>
(parted) name 3 swap ↵  <br>
(parted) mkpart primary 13316 -1 ↵  <br>
(parted) name 4 rootfs ↵  <br>
(parted) quit ↵  <br>

```

## Formatando partições
```
mkfs.vfat -F32 /dev/sda1  <br>
mkfs.ext2 /dev/sda2  <br>
mkfs.ext4 /dev/sda4  <br>

Swap  <br>
mkswap /dev/sda3  <br>
swapon /dev/sda3
```
## Criando e montando pastas para instação "não coloque a / no final"

```mkdir /mnt/gentoo  <br>
mount /dev/sda4 /mnt/gentoo  <br>
cd /mnt/gentoo  <br>
```

## Verifique se a internet esta funcionado

```ping -c3 gentoo.org
```

## Baixando arquivo tar.bz2 para instalação, use o comando  
links para navegar e achar o aquivo "stage3-amd64-*.tar.bz2"
```links https://www.gentoo.org/downloads/mirrors/#BR  

releases/ ↵  <br>
amd64/ ↵  <br>
autobuilds/ ↵  <br>
current-stage3-amd64/ ↵  <br>
stage3-amd64-*.tar.bz2
```

## Descompactar, use o nome completo

```

tar xpf stage3-*.tar.<p1 class="cyan">bz2</p1> --xattrs-include='*.*' --numeric-owner

tar xpf stage3-amd64-*.tar.<p1 class="cyan">xz</p1> --xattrs-include='*.*' --numeric-owner

```

## Montando partições de boot/EFI

```
mkdir /mnt/gentoo/<p1 class="cyan">boot</p1>  
mount /dev/sda2 /mnt/gentoo/<p1 class="cyan">boot</p1>  

mkdir /mnt/gentoo/boot/<p1 class="cyan">efi</p1>  
mount /dev/sda1 /mnt/gentoo/boot/<p1 class="cyan">efi</p1>  
```

## Verifique/Edite o make.conf para o seu processador.

```
grep -c processor /proc/cpuinfo <p1 class="gray">número de núcleos</p1>  
grep -m1 -A3 "vendor_id" /proc/cpuinfo <p1 class="gray">modelo do processador [cflags](https://wiki.gentoo.org/wiki/Safe_CFLAGS)</p1>  

nano -w <p1 class="cyan">/mnt/gentoo</p1>/etc/portage/make.conf  
```

Então adicione ao make.conf.
```
<p1 class="yellowtext">CHOST="x86_64-pc-linux-gnu"</p1>  
<p1 class="yellowtext">COMMON_FLAGS="-march=<p1 class="redtext">native</p1> -O2 -pipe"</p1>  
<p1 class="yellowtext">CFLAGS="${COMMON_FLAGS}"</p1>  
<p1 class="yellowtext">CXXFLAGS="${COMMON_FLAGS}"</p1>  
<p1 class="gray">#USE="acpi bindist git dbus ffmpeg jpeg jpeg2k -modemmanager mp3 mp4 mpeg png sound opengl X"</p1>  
EMERGE_DEFAULT_OPTS="<p1 class="cyan">--quiet-build=y --ask --load-average=2 --autounmask-write=y --with-bdeps=y</p1>"  
FEATURES="<p1 class="cyan">preserve-libs collision-protect candy</p1>"  
<p1 class="gray">#INPUT_DEVICES="evdev keyboard synaptics mouse</p1>"  
<p1 class="gray">#VIDEO_CARDS="vesa intel amdgpu nvidia virtualbox</p1>"  
LINGUAS="<p1 class="cyan">pt_BR.UTF-8 pt_BR.ISO-8859-1 pt_BR pt-BR</p1>"  
MAKEOPTS="<p1 class="cyan">-j4</p1>"  
ACCEPT_LICENSE="<p1 class="cyan">*</p1>"  
L10N="<p1 class="cyan">pt-BR</p1>"  
GRUB_PLATFORMS="<p1 class="cyan">efi-64</p1>"
```

Observação: Editar make.conf para funcionar com UEFI. Adicione a linha:

```
GRUB_PLATFORMS="<p1 class="cyan">efi-64</p1>"
```

## Montando pastas de instalação e configuração "não coloque /  
no final.

```
mount --types proc /proc /mnt/gentoo/proc  
mount --rbind /sys /mnt/gentoo/sys  
mount --rbind /dev /mnt/gentoo/dev  

test -L /dev/shm && rm /dev/shm && mkdir /dev/shm  
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm  
chmod 1777 /dev/shm  
```

## Copie as informações de DNS

```
cp -L /etc/resolv.conf /mnt/gentoo/etc/
```

## Entrando no novo ambiente

```
chroot /mnt/gentoo /bin/bash  
source /etc/profile <p1 class="cyan">&&</p1> export PS1="(chroot) $PS1"  <p1 class="cyan">

livecd ~ # 
```
## Instalando um instantâneo do repositório ebuild da web

```
emerge-<p1 class="cyan">webrsync</p1>  
emerge <p1 class="cyan">--sync --quiet</p1>  
```

## Escolhendo o perfil correto/de sua escolha

```
eselect profile list
```
## Escolha o perfil com o comando... "substitua o X pelo número  
de sua escolha.
```
eselect profile set "X"  

     default/linux/amd64/17.0/desktop
```

## Use eselect para verificar
```
eselect profile list</td>
```

## Atualize

```
emerge --ask --update --deep --newuse @world
```
## Fuso horário.

```
echo "America/Belem" > /etc/timezone  
emerge --config sys-libs/timezone-data  
vim /etc/locale.gen  

     pt_BR.UTF-8 UTF-8  
     #pt_BR ISO-8859-1

locale-gen  
locale -a  
eselect locale list  
eselect locale set [pt_br.utf8]  
vim /etc/env.d/02locale  

     LANG="pt_BR.UTF-8"  
     LC_COLLATE="C"
```

## Carregando o ambiente.
```
env-update && source /etc/profile && export PS1="(chroot) $PS1"
```
```
emerge -auDN @world

```

## CPU flags.

```
emerge app-portage/cpuid2cpuflags  
cpuid2cpuflags-x86  
cpuid2cpuflags-x86 >> /etc/portage/make.conf  

apague o primero CPU_FLAGS_X86 da linha do make.conf  
modifique colocando entre aspas =""

vim /etc/portage/make.conf  

env-update && source /etc/profile && export PS1="(chroot) $PS1"  
```

## Instalando pacotes para o kernel.

- gentoo kernel

```
emerge -aq gentoo-sources genkernel usbutils dosfstools pciutils gentoolkit ufed eix axel xfsprogs<
```
## Configurando o genkernel

```
vim /etc/genkernel.conf
```
```
   MENUCONFIG="<p1 class="cyan">yes</p1>"  
   CLEAN="<p1 class="cyan">no</p1>"  
   MRPROPER="<p1 class="cyan">no</p1>"  

descomente:
   MAKEOPTS="$(portageq envvar MAKEOPTS)"  
   TMPDIR="/var/tmp/genkernel"
```

## Configurando o fstab.
```
vim /etc/fstab</td>
```
```
/dev/sda1</td>

<td id="fstab">/boot/efi</td>

<td id="fstab">vfat</td>

<td id="fstab">noauto,noatime</td>

<td id="fstab">0 2</td>

</tr>

<tr id="fstab">

<td id="fstab">/dev/sda2</td>

<td id="fstab">/boot</td>

<td id="fstab">ext2</td>

<td id="fstab">defaults</td>

<td id="fstab">0 2</td>

</tr>

<tr id="fstab">

<td id="fstab">/dev/sda3</td>

<td id="fstab">none</td>

<td id="fstab">swap</td>

<td id="fstab">sw</td>

<td id="fstab">0 0</td>

</tr>

<tr id="fstab">

<td id="fstab">/dev/sda4</td>

<td id="fstab">/</td>

<td id="fstab">ext4</td>

<td id="fstab">noatime</td>

<td id="fstab">0 1</td>

</tr>

<tr id="fstab">

<td id="fstab">/dev/cdrom</td>

<td id="fstab">/mnt/cdrom</td>

<td id="fstab">auto</td>

<td id="fstab">noauto,ro</td>

<td id="fstab">0 0</td>

</tr>

<tr id="fstab">

<td id="fstab">tmpfs</td>

<td id="fstab">/var/tmp</td>

<td id="fstab">tmpfs</td>

<td id="fstab">rw,nosuid,noatime,nodev,size=4G,mode=1777</td>

<td id="fstab">0 0</td>

</tr>

<tr id="fstab">

<td id="fstab">tmpfs</td>

<td id="fstab">/var/tmp/portage</td>

<td id="fstab">tmpfs</td>

<td id="fstab">rw,nosuid,noatime,nodev,size=4G,mode=775,uid=portage,gid=portage,x-mount.mkdir=775</td>

<td id="fstab">0 0
```

## Verifique/Edite o make.conf para o seu processador.

```
vim /etc/portage/make.conf
```
## Instalando o kernel.

```
genkernel all
```

## Configurar e construir o kernel automaticamente.

```
--------------------------------------------------------------------------------------  
video card nvidea  
Pre-allocated buffer size for HD audio drive = 2048  
Virtualization drivers  
DOS/FAT/NT Filessystems ---> * NTFS write support  

Device Drivers --->  
  Generic Driver Options --->  
   [*] Maintain a devtmpfs filesystem to mount at /dev  
   [ ]    Automount devtmpfs at /dev, after the kernel mounted the rootfs  

Verify SCSI disk support has been activated (CONFIG_BLK_DEV_SD):  
KERNEL Enabling SCSI disk support  

Device Drivers --->  
  SCSI device support --->  
   <*> SCSI disk support  

File systems --->  
  <*> Second extended fs support  
  <*> The Extended 3 (ext3) filesystem  
  <*> The Extended 4 (ext4) filesystem  
  <*> Reiserfs support  
  <*> JFS filesystem support  
  <*> XFS filesystem support  
  <*> Btrfs filesystem support  
  DOS/FAT/NT Filesystems --->  
     <*> MSDOS fs support  
     <*> VFAT (Windows-95) fs support  

Pseudo Filesystems --->  
   [*] /proc file system support  
   [*] Tmpfs virtual memory file system support (former shm fs)  

Device Drivers --->  
  Network device support --->  
   <*> PPP (point-to-point protocol) support  
   <*>    PPP support for async serial ports  
   <*>    PPP support for sync tty ports  

Processor type and features --->  
  [*] Symmetric multi-processing support  

Device Drivers --->  
  HID support --->  
   -*- HID bus support  
   <*> Generic HID driver  
   [*] Battery level reporting for HID devices  
    USB HID support --->  
    <*> USB HID transport layer  
  [*] USB support --->  
   <*>   xHCI HCD (USB 3.0) support  
   <*>   EHCI HCD (USB 2.0) support  
   <*>   OHCI HCD (USB 1.1) support  

Architecture specific kernel configuration  

Processor type and features --->  
  [ ] Machine Check / overheating reporting  
  [ ]   Intel MCE Features  
  [ ]   AMD MCE Features  
  Processor family (AMD-Opteron/Athlon64) --->  
   ( ) Opteron/Athlon64/Hammer/K8  
   ( ) Intel P4 / older Netburst based Xeon  
   ( ) Core 2/newer Xeon  
   ( ) Intel Atom  
   ( ) Generic-x86-64  
Executable file formats / Emulations --->  
  [*] IA32 Emulation  

Enable GPT partition  

-*- Enable the block layer --->  
  Partition Types --->  
   [*] Advanced partition selection  
   [*] EFI GUID Partition support  

Enable EFI stub support and EFI variables in the Linux kernel if UEFI is used to boot the system (CONFIG_EFI, CONFIG_EFI_STUB, CONFIG_EFI_MIXED, and CONFIG_EFI_VARS):  
KERNEL Enable support for UEFI  

Processor type and features --->  
   [*] EFI runtime service support  
   [*]   EFI stub support  
   [*]     EFI mixed-mode support  

Firmware Drivers --->  
   EFI (Extensible Firmware Interface) Support --->  
     <*> EFI Variable Support via sysfs  
------------------------------------------------------------------------------------
```
## Se estiver instalando em um ssd

```
vim /etc/profile.d/xdg_cache_home

   export XDG_CACHE_HOME="/tmp/${USER}/.cache"
```

## Instalando firmware

```
emerge --ask sys-kernel/linux-firmware<
```

## Informação de host e domínio

```
vim /etc/conf.d/hostname
```
```
   hostname="gentoo"
```   

## Configurando a rede  
Primeiro instale o pacote net-misc/netifrc

```emerge --ask --noreplace net-misc/netifrc</td>
```

Iniciando automaticamente a rede durante o boot precisam ser criados assim como fizemos com o net.eth0.  
Se após a inicialização do sistema descobrirmos que o nome que usamos para a interface de rede (que está atualmente documentada como eth0) está errado, então execute os seguintes passos para corrigir isso:  
1.Corrija o arquivo /etc/conf.d/net com o nome correto da interface de rede (tal como enp0s3 em vez de eth0).  
2.Crie um novo link simbólico (como /etc/init.d/net.enp0s3).  
3.Remova o link simbólico antigo (rm /etc/init.d/net.eth0).  
4.Adicione o novo ao runlevel default.  
5.Remova o antigo usando rc-update del net.eth0 default.

<table>

<tbody>

<tr>

<td>cd /etc/init.d  
ln -s net.lo net.<p1 class="cyan">enp0s3</p1>  
rc-update add net.<p1 class="cyan">enp0s3</p1> default  
cd /</td>

</tr>

</tbody>

</table>

## O arquivo hosts

### Adicione um nome depois de localhost

<table>

<tbody>

<tr>

<td>vim /etc/hosts  
<p1>   127.0.0.1 <p1 class="cyan">gentoo.homenetwork</p1> localhost</p1></td>

</tr>

</tbody>

</table>

## Adicionando senha para o root

<table>

<tbody>

<tr>

<td>passwd</td>

</tr>

</tbody>

</table>

## Teclado

<table>

<tbody>

<tr>

<td>vim /etc/conf.d/keymaps  

   keymap="<p1 class="cyan">br-abnt2</p1>"

</td>

</tr>

</tbody>

</table>

## Hora local.

<table>

<tbody>

<tr>

<td>vim /etc/conf.d/hwclock  

   clock="<p1 class="cyan">local</p1>"

</td>

</tr>

</tbody>

</table>

## Sistema de log

<table>

<tbody>

<tr>

<td>emerge -aq sysklogd cronie mlocate logrotate dhcpcd  
rc-update add <p1 class="cyan">sysklogd</p1> default  
rc-update add <p1 class="cyan">sshd</p1> default  
rc-update add <p1 class="cyan">cronie</p1> default  
rc-update add <p1 class="cyan">dhcpcd</p1> default</td>

</tr>

</tbody>

</table>

## Selecionando/Instalando um gerenciador de boot: GRUB2.

Obs: Cuidado no "grub.cfg" pois ao aperta tab ele altomaticamente coloca "grub.conf".

<table>

<tbody>

<tr>

<td><p1 class="yellowtext">Modo BIOS</p1>  
emerge --ask sys-boot/grub  
grub-install /dev/sda  
grub-mkconfig -o /boot/grub/grub.cfg</td>

</tr>

</tbody>

</table>

## Verifique se a partição do EFI/boot esta criada/montada

<table>

<tbody>

<tr>

<td><p1 class="yellowtext">Modo UEFI</p1>  
mkdir /boot/efi <p1 class="gray">Verifique antes</p1>  
mount /dev/sda1 /boot/efi <p1 class="gray">Verifique antes</p1>  

mount -o remount,rw <p1 class="cyan">/boot/efi</p1>  

echo 'sys-boot/grub:2 mount truetype' >> /etc/portage/package.use/grub:2  

emerge --ask --update --newuse --deep --verbose sys-boot/grub:2  

mount -o remount,rw /sys/firmware/efi/efivars  

grub-install --target=x86_64-efi --efi-directory=<p1 class="cyan">/boot/efi</p1> --removable  

grub-mkconfig -o /boot/grub/<p1 class="cyan">grub.cfg</p1>  
</td>

</tr>

</tbody>

</table>

## Adicionando um usuário e senha

<table>

<tbody>

<tr>

<td>useradd -m -G users,wheel,audio,video,root,sys,disk,adm,bin,daemon,portage,  
console,usb,games,cron,input,lp,uucp -s /bin/bash <p1 class="cyan">nomeUsuario</p1>  
passwd <p1 class="cyan">nomeUsuario</p1></td>

</tr>

</tbody>

</table>

## Saindo do sistema

<table>

<tbody>

<tr>

<td>exit  
cd  
cdimage ~# umount -l /mnt/gentoo/dev{/shm,/pts,}  
cdimage ~# umount -R /mnt/gentoo  
cdimage ~# shutdown -r now  
</td>

</tr>

</tbody>

</table>
