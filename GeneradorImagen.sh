#!/bin/bash
# Script generador de configuraciones para Live-Build Debian GNU Linux Buster
# Autor Fernando Sfeir - NiuX para la HLN
# fersfeir EN niux PUNTO com PUNTO ar

# Directorio donde se generará la imagen
DIRECTORIO=/home/HLN-Distro

cd $DIRECTORIO

# Genero la estructura de configuración
# Las opciones utilizadas son:
# lb config 
# --binary-images iso-hybrid 
# --mode debian 
# --architectures i386 
# --linux-flavours i386 
# --distribution buster 
# --archive-areas "main contrib non-free" 
# --updates true 
# --security true 
# --cache true 
# --apt-recommends true 
# --debian-installer live 
# --debian-installer-gui true 
# --win32-loader false 
# --iso-application debianHLN 
# --iso-preparer FerSfeir 
# --iso-publisher NiuX-https://niux.com.ar 
# --iso-volume debianHLN

lb config --binary-images iso-hybrid --mode debian --architectures i386 --linux-flavours i386 --distribution buster --archive-areas "main contrib non-free" --updates true --security true --cache true --apt-recommends true --debian-installer live --debian-installer-gui true --win32-loader false --iso-application debianHLN --iso-preparer FerSfeir --iso-publisher NiuX-https://niux.com.ar --iso-volume debianHLN

# Agrego tareas
echo task-xfce-desktop > $DIRECTORIO/config/package-lists/tareas.list.chroot
echo task-ssh-server >> $DIRECTORIO/config/package-lists/tareas.list.chroot

# Agrego paquetes
echo "htop net-tools dnsutils libirs161" > $DIRECTORIO/config/package-lists/paquetes.list.chroot

# Archivo de respuestas pre-configurado
wget https://github.com/fersfeir/DebianHLN/raw/master/preseed.cfg
mv preseed.cfg $DIRECTORIO/config/includes.installer/preseed.cfg

# Comienzo la generación de la imagen
lb build

