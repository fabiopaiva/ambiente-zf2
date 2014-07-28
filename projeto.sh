#!/bin/bash

PROJETOS_PATH=$1

cd $PROJETOS_PATH

read -p 'DIGITE O NOME DO PROJETO EM CAIXA BAIXA SEM ESPAÇOS: ' -e -i 'projeto1' PROJETO
if [ -z $PROJETO ]
then
	echo "NÃO FOI DIGITADO O NOME DO PROJETO"
	exit
fi

DIRPROJETO="$PROJETOS_PATH/$PROJETO"

composer self-update

cp /usr/local/bin/composer composer.phar

php composer.phar create-project -sdev --repository-url="https://packages.zendframework.com" zendframework/skeleton-application $DIRPROJETO

echo ''
echo "AJUSTANDO O HOST LOCAL PARA ACESSAR, http://local.$PROJETO"
echo "127.0.0.1		local.$PROJETO" >> /etc/hosts
HOSTPROJETO="<VirtualHost *:80>\n
\tServerName local.$PROJETO\n
\tDocumentRoot $DIRPROJETO/public\n
\tSetEnv APPLICATION_ENV \"development\"\n
\t<Directory $DIRPROJETO/public>\n
\t\tDirectoryIndex index.php\n
\t\tAllowOverride FileInfo\n
\t\tOrder allow,deny\n
\t\tallow from all\n
\t</Directory>\n
</VirtualHost>
"
echo -e $HOSTPROJETO > "/etc/apache2/sites-available/${PROJETO}"
a2ensite $PROJETO
service apache2 restart

echo "CONCLUÍDO!\n A PASTA DO PROJETO ESTÁ EM $DIRPROJETO\n ACESSO http://local.$PROJETO"
