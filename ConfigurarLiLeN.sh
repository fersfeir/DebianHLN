#!/bin/bash
# Script para configuración de la distribución GNU/LiLeN.
# Copyright (C) 2020 Fernando SFEIR
# fsfeir@legnqn.gob.ar - Honorable Legislatura del Neuquén
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

 
# Funcion para instalar los paquetes necesarios
function instaladebs () {
	if [ ! -f /home/LiLeN/instaladebs.ejecutado ]; then
		echo "Entraste OK!"
		touch /home/LiLeN/instaladebs.ejecutado
		sleep 5
	else echo "Usted ya ha ejecutado el script de instalacion con anterioridad."
	fi
}
 
# Funcion para configurar la ip
function configurared () {
	if [ ! -f /home/LiLeN/configurared.ejecutado ]; then
		echo "Entraste a configurar la red!"
		touch /home/LiLeN/configurared.ejecutado
		sleep 5
	else echo "Usted ya ha ejecutado el script de instalacion con anterioridad."
	fi
}

# Funcion para configurar el nombre del equipo
function configurahostname () {
	if [ ! -f /home/LiLeN/configurahostname.ejecutado ]; then
		echo "Entraste a configurar el nombre de la computadora!"
		touch /home/LiLeN/configurahostname.ejecutado
		sleep 5
	else echo "Usted ya ha ejecutado el script de instalacion con anterioridad."
	fi
}

# Funcion para unir a un dominio windows existente
function unedominio () {
	if [ ! -f /home/LiLeN/unedominio.ejecutado ]; then
		echo "Entraste a configurar el dominio. Recuerde que DEBE TENER CONFIGURADA CORRECTAMENTE LA RED/DNS!"
		wget -O - http://repo.pbis.beyondtrust.com/apt/RPM-GPG-KEY-pbis|sudo apt-key add -
		wget -O /etc/apt/sources.list.d/pbiso.list http://repo.pbis.beyondtrust.com/apt/pbiso.list
		apt-get update
		apt-get install -y pbis-open
		touch /home/LiLeN/unedominio.ejecutado
		sleep 5
	else echo "Usted ya ha ejecutado el script de instalacion con anterioridad."
	fi
}

# Funcion para configurar el monitoreo Ansible
function configuraansible () {
	if [ ! -f /home/LiLeN/configuraansible.ejecutado ]; then
		echo "Entraste a configurar Ansible!"
		touch /home/LiLeN/configuraansible.ejecutado
		sleep 5
	else echo "Usted ya ha ejecutado el script de instalacion con anterioridad."
	fi
}
 
# Funcion para configurar el escritorio XFCE con apariencia de W10
function configuraescritorio () {
	if [ ! -f /home/LiLeN/configuraescritorio.ejecutado ]; then
		echo "Entraste a configurar la apariencia del escritorio!"
		touch /home/LiLeN/configuraescritorio.ejecutado
		sleep 5
	else echo "Usted ya ha ejecutado el script de instalacion con anterioridad."
	fi
}

function menu () {
 
while [ 1 ]; do
dialog --backtitle "Honorable Legislatura del Neuquen" \
--cancel-label "Salir" --title "Menu de opciones" \
--menu "Por favor elija una de las siguientes:" 20 50 7 \
1 "Configuración COMPLETA de GNU LiLeN" \
2 "Configurar red" \
3 "Configurar nombre de host" \
4 "Unir a un dominio existente" \
5 "Configurar monitoreo Ansible" \
6 "Configurar apariencia de escritorio" 2>/tmp/ans
 
if [ $? = 1 ]; then
	rm -f /tmp/ans
	clear
	echo "Gracias por utilizar el script $0 !"
        sleep 5
	exit 0
fi
op="`cat /tmp/ans`"
case $op in
	1 )
		dialog --backtitle "Honorable Legislatura del Neuquen" \
		--title "Configuración COMPLETA de GNU LiLeN" \
        --msgbox "Se realizara la instalación de software, configuración de red, configuración de nombre de host, unión al dominio y las modificaciones necesarias.

Proceda bajo su propio riesgo y RECUERDE REALIZAR UNA COPIA DE SEGURIDAD (BACKUP) PREVIAMENTE." 18 60
		instaladebs
		configurared
		configurahostname
		unedominio $1	
		configuraansible	
		configuraescritorio
		;;
	2 )
        dialog --backtitle "Honorable Legislatura del Neuquen" \
        --title "Configurar red" \
       --msgbox "Se realizara la configuración de la placa de red." 18 60
		configurared
		;;
	3 )
        dialog --backtitle "Honorable Legislatura del Neuquen" \
        --title "Configurar nombre de host" \
       --msgbox "Se realizara la configuración del nombre de host." 18 60
		configurahostname
		;;
	4 )
        dialog --backtitle "Honorable Legislatura del Neuquen" \
        --title "Unir a un dominio existente" \
       --msgbox "Se realizara la unión a un dominio existente." 18 60
		unedominio $1
		;;
	5 )
        dialog --backtitle "Honorable Legislatura del Neuquen" \
        --title "Configurar monitoreo Ansible" \
       --msgbox "Se realizara la configuración del sistema de monitoreo Ansible." 18 60
		configuraansible 
		;;
	6 )
        dialog --backtitle "Honorable Legislatura del Neuquen" \
        --title "Configurar apariencia de escritorio" \
       --msgbox "Se realizara la configuración de la apariencia de escritorio para que luzca como W10." 18 60
		configuraescritorio 
		;;
esac
done
}
 
# Licencia del script
function autor () {
dialog --backtitle "Honorable Legislatura del Neuquen" \
	--title "Licencia de script de configuración de GNU LiLeN" \
	--yesno "Copyright (C) 2020 Fernando SFEIR fsfeir@legnqn.gob.ar

 
This program comes with ABSOLUTELY NO WARRANTY.
 
This is free software, and you are welcome to redistribute it under certain conditions.
 
Type 'cat gpl.txt' for details
 
Acepta la licencia GPL v3?" 18 60
}
 
# Funcion para verificar que está el paquete dialog
function requisitos () {
which dialog &> /dev/null
[ $? -ne 0 ]  && dpkg -i /home/LiLeN/paquetes/dialog*_amd64.deb
}

requisitos
autor
case $? in
	0 ) menu $1
	;;
 
	1 ) clear && exit
	;;
esac