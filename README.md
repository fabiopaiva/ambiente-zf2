Instalador de servidor LAMPP e projetos ZF2
=======================

## Instalação

    git clone https://github.com/fabiopaiva/ambiente-zf2
    chmod +x ambiente-zf2 -R
    sudo ./ambiente-zf2/install.sh

Nesta etapa será instalado o básico:
php5 php5-cli php5-curl php5-mysql apache2 mysql-server curl
Siga as instruções de instalações

## Instalar recursos extras

Para instalar recursos como php5-common phpunit doctrine e outros

    sudo ./ambiente-zf2/extras.sh

Será instalado:
php5-common php5-memcached php5-gd php5-dev php-pear php-apc php5-dev mysql-client vim memcached

## Criando um novo projeto

Para criar um novo projeto ZF2

    ./ambiente-zf2/projeto.sh /caminho/pasta-projetos
