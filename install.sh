#!/bin/bash
if [ $USER != 'root' ]
then
	echo 'É PRECISO EXECUTAR COMO ROOT, (sudo ./ambiente-zf2/install.sh)'
	exit
fi

echo 'INÍCIO DA INSTALAÇÃO...'
echo 'UPDATE...'
add-apt-repository ppa:ondrej/php5
apt-get update
echo 'ATUALIZADO, INSTALAR APACHE, PHP5.4, MYSQL'
apt-get install php5 php5-cli php5-curl php5-mysql apache2 mysql-server curl -y
echo 'INSTALADO O LAMP!'

echo 'INSTALANDO O COMPOSER...'
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
echo ''
read -p 'Informe a pasta para salvar os projetos zf2: ' -e -i $HOME'/projetos' PROJETOS_PATH

if [ -d $PROJETOS_PATH ]
then
	mkdir PROJETOS_PATH
fi

source $(dirname $0)/projeto.sh $PROJETOS_PATH


