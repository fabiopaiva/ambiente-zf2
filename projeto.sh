#!/bin/bash

PROJETOS_PATH=$1

cd $PROJETOS_PATH

read -p 'DIGITE O NOME DO PROJETO EM CAIXA BAIXA SEM ESPAÇOS' -e -i 'projeto1' PROJETO
if [ -z $PROJETO ]
then
	echo "NÃO FOI DIGITADO O NOME DO PROJETO"
	exit
fi

DIRPROJETO="$PROJETOS_PATH/$PROJETO"

php composer.phar create-project -sdev --repository-url="https://packages.zendframework.com" zendframework/skeleton-application $DIRPROJETO

echo ''
echo "AJUSTANDO O HOST LOCAL PARA ACESSAR, http://local.$PROJETO"
echo "127.0.0.1		local.$PROJETO" >> /etc/hosts
HOSTPROJETO="<VirtualHost *:80>\n
\tServerName local.$PROJETO\n
\tDocumentRoot $DIRPROJETO/public\n
\tSetEnv APPLICATION_ENV \"development\"
\t<Directory $DIRPROJETO/public>\n
\t\tDirectoryIndex index.php\n
\t\tAllowOverride FileInfo\n
\t\tOrder allow,deny\n
\t\tallow from all\n
\t\tRequire all granted
\t</Directory>\n
</VirtualHost>
"
cd /etc/apache2/sites-available
echo -e $HOSTPROJETO > $PROJETO
a2ensite $PROJETO
a2enmod rewrite
service apache2 restart

read USUARIO -p 'DIGITE O NOME DE USUÁRIO DONO DO PROJETO: ' -e -i 'root:www-data'
if [ -z $USUARIO ]
then
	echo 'NÃO FOI DIGITADO O USUÁRIO, NÃO FOI POSSÍVEL MUDAR O DONO DA PASTA'
	exit
fi
chown $USUARIO $DIRPROJETOS/* -R

echo "CONCLUÍDO!\n A PASTA DO PROJETO ESTÁ EM $DIRPROJETO\n ACESSO http://local.$PROJETO"
