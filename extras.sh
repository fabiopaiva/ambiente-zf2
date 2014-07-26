#!/bin/bash
if [ $USER != 'root' ]
then
	echo 'É PRECISO EXECUTAR COMO ROOT, (sudo ./script.sh)'
	exit
fi

echo 'Instalando componentes extras';

apt-get install php5-common php5-memcached php5-gd php5-dev php-pear php-apc php5-dev mysql-client vim memcached -y

echo "INSTALANDO O PHPUNIT E DOCTRINE"
pear channel-discover pear.phpunit.de
pear install --onlyreqdeps phpunit/PHPUnit
pear channel-discover pear.doctrine-project.org
pear install --onlyreqdeps doctrine/DoctrineORM-2.3.2
echo ''
