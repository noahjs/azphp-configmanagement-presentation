
# Development Tool
sudo yum -y groupinstall "Development Tools"

# Utilities
sudo yum install -y git vim unzip make wget


# Server programs
# Mod Security
sudo yum install -y httpd mod_ssl mod_security mysql-server

# Add webtatic (PHP)
sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm

# PHP
sudo yum install -y php55w php55w-common php55w-devel php55w-cli php55w-gd php55w-mcrypt php55w-mbstring php55w-mysql php55w-pecl-memcache php55w-opcache php55w-process php55w-xml

# YOU MUST HAVE THE boxname IN THE /etc/hosts FILE!!!!!

# Add Apache VHosts
sudo bash -c 'echo "Include /opt/azphp/conf/development.conf" >> /etc/httpd/conf/httpd.conf'
sudo sed -i 's/ServerSignature On.*/ServerSignature Off/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/ServerTokens OS.*/ServerTokens Off/' /etc/httpd/conf/httpd.conf

# PHP Configs
sudo bash -c 'echo "date.timezone = America/Phoenix" >> /etc/php.ini'
sudo sed -i 's/display_errors = Off.*/display_errors = On/' /etc/php.ini
sudo sed -i 's/E_ALL & ~E_DEPRECATED & ~E_STRICT.*/E_ALL/' /etc/php.ini
sudo sed -i 's/expose_php = on.*/expose_php = off/' /etc/php.ini

# Install composer
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# IPTables
sudo /sbin/iptables -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo /sbin/iptables -A INPUT -m state --state NEW -p tcp --dport 3306 -j ACCEPT
sudo service iptables restart

# Start everything
sudo service mysqld start
sudo service httpd start

sudo chkconfig mysqld on
sudo chkconfig httpd on

# Add hosts
sudo bash -c 'echo "127.0.0.1 app.azphp" > /etc/hosts'
sudo bash -c 'echo "127.0.0.1 db.azphp" > /etc/hosts'
