# GNU/LiLeN
Script y configuraciones de pruebas para la generación de una live-build con GNU/Linux Debian Buster.

## Contenido
* imagen Contiene los archivos de personalización (theme, iconos, etc).
* paquetes Carpeta con archivos .deb de terceros que se instalan en la distribución.
* ConfigurarLilen.sh Script de configuración de la distribución para un ambiente específico.
* GeneradorImagen.sh Script de generación de imagen.
* preseed.cfg Archivo de respuestas (es descargado directamente desde el script GeneradorImagen.sh).


## Utilización
Desde una instalación ya realizada de Debian Buster GNU/Linux, descargar el archivo y ejecutarlo (debe ser root):
```
wget https://github.com/fersfeir/LiLeN/archive/master.zip && unzip master.zip && cd LiLeN-master && sh GeneradorImagen.sh
```

NiuX Servicios Informáticos - Neuquén - Patagonia Argentina
