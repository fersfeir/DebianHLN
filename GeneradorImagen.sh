#!/bin/bash
# Script generador de configuraciones para Live-Build Debian GNU Linux Buster
# Autor Fernando Sfeir - NiuX para la HLN
# fersfeir EN niux PUNTO com PUNTO ar
# https://niux.com.ar/

# Instalo los paquetes necesarios
apt install -y live-build

# Directorio donde se generará la imagen
DIRECTORIO=/home/LiLeN

# Copio el theme a utlizar
mkdir -p $DIRECTORIO/config/includes.chroot/usr/share/themes/ 
cp -r imagen/Windows-10-theme $DIRECTORIO/config/includes.chroot/usr/share/themes/

# Copio el fondo de pantalla, icono de inicio y pantallas de inicio
mkdir -p $DIRECTORIO/config/includes.chroot/usr/share/images/
cp -r imagen/desktop-base $DIRECTORIO/config/includes.chroot/usr/share/images/

# Copio la configuracion de xfce para los usuarios a crear
mkdir -p $DIRECTORIO/config/includes.chroot/etc/skel/.config
cp -r imagen/xfce4 $DIRECTORIO/config/includes.chroot/etc/skel/.config

# Copio la configuracion de xfce para el usuario por defecto
#mkdir -p $DIRECTORIO/config/includes.chroot/home/lilen/.config
#cp -r imagen/xfce4 $DIRECTORIO/config/includes.chroot/home/lilen/.config

# Agrego los paquetes adicionales 
mkdir -p $DIRECTORIO/config/packages.chroot/
cp paquetes/* $DIRECTORIO/config/packages.chroot/

# Agrego el script de configuracion
mkdir -p $DIRECTORIO/config/includes.chroot/usr/sbin
cp ConfigurarLiLeN.sh $DIRECTORIO/config/includes.chroot/usr/sbin

# Archivo de respuestas pre-configurado
mkdir -p $DIRECTORIO/config/includes.installer/
cp preseed.cfg $DIRECTORIO/config/includes.installer/

# Me posiciono en el directorio creado
cd $DIRECTORIO

# lb clean -> is  responsible  for  cleaning up after a system is built. It removes the build directories, and removes some other files including stage files,  and  any  detritus  left behind by other live-build commands.
#lb clean

# Genero la estructura de configuración
# Las opciones utilizadas son:
# lb config  -> populates the configuration directory for live-build
# --binary-images iso-hybrid -> defines the image type to build. By default, for images using syslinux this is set to iso-hybrid to build CD/DVD images that may also be used like hdd images
# --mode debian -> defines a global mode to load project specific defaults. By default this is set to debian
# --architectures i386 -> defines the architecture of the to be build image
# --linux-flavours 686-pae -> sets the kernel flavours to be installed
# --distribution buster -> defines the distribution of the resulting live system
# --archive-areas "main contrib non-free" -> defines which package archive areas of a debian packages archive should be used for configured debian package mirrors
# --updates true -> defines if debian updates package archives should be included in the image or not
# --security true -> efines if the security repositories specified in the security mirror options should be used or not
# --cache true -> defines globally if any cache should be used at all. Different caches can be controlled through the their own options
# --apt-recommends true -> defines if apt should install recommended packages automatically
# --debian-installer live -> When live is chosen, the live-installer udeb is included so that debian-installer will behave different than usual - instead of installing the debian system from packages from the medium or the network, it installs the live system to the disk
# --debian-installer-gui true -> defines if the debian-installer graphical GTK interface should be true or not
# --win32-loader false -> defines if win32-loader should be included in the binary image or not
# --iso-application LiLeN -> sets the APPLICATION field in the header of a resulting CD/DVD image
# --iso-preparer FerSfeir -> sets the PREPARER field in the header of a resulting CD/DVD image
# --iso-publisher NiuX-https://niux.com.ar -> sets the PUBLISHED field in the header of a resulting CD/DVD image
# --iso-volume LiLeN -> sets the VOLUME field in the header of a resulting CD/DVD

# lb config --binary-images iso-hybrid --mode debian --architectures i386 --linux-flavours 686-pae --distribution buster --archive-areas "main contrib non-free" --updates true --security true --cache true --apt-recommends true --debian-installer live --debian-installer-gui true --win32-loader false --iso-application LiLeN --iso-preparer FerSfeir --iso-publisher NiuX-https://niux.com.ar --iso-volume LiLeN
lb config --binary-images iso-hybrid --mode debian --architectures amd64 --distribution buster --archive-areas "main contrib non-free" --updates true --security true --cache true --apt-recommends true --debian-installer live --debian-installer-gui true --win32-loader false --iso-application "LiLeN" --iso-preparer "FerSfeir" --iso-publisher "HLN-https://legnqn.gob.com.ar" --iso-volume "LiLeN"

# Agrego tareas
echo task-xfce-desktop > $DIRECTORIO/config/package-lists/tareas.list.chroot
echo task-ssh-server >> $DIRECTORIO/config/package-lists/tareas.list.chroot

# Agrego paquetes
echo "htop net-tools dnsutils libirs161 openssh-server dialog vim vim-runtime vim-common gvfs-backends libavahi-glib1 libcdio-cdda2 libcdio-paranoia2 libgdata-common libgdata22 libgoa-1.0-0b libgoa-1.0-common libmtp-common libmtp-runtime libmtp9 libnfs12 liboauth0 psmisc dialog" > $DIRECTORIO/config/package-lists/paquetes.list.chroot

# Comienzo la generación de la imagen
# lb build -> alias for all build stages

lb build
