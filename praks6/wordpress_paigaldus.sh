
# Wordpressi paigaldusskript
# a) Kontrollin, kas Wordpressi jaoks vajalikud teenused on püsti.
mysql <<EOF
SHOW DATABASES; # kuvame kõikide andmebaaside nimed
SELECT NOW(); # kuvame hetkeaja väärtuse
EOF

# b) Loon andmebaasi serveris vajaliku andmebaasi, kasutaja ja parooli.
mysql --user="root" --password="qwerty" --execute="CREATE DATABASE wpdatabase;
CREATE USER wpuser@localhost IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON wpdatabase.* to wpuser@localhost;
FLUSH PRIVILEGES;
EXIT"

# c) Laadin alla wordpressi paketi, pakin selle lahti ja sisustan andmetega.
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sed -i "/s/database_name_here/wpdatabase/g/" /var/www/html/wordpress/wp-config.php
sed -i "/s/username_here/wpuser/g/" /var/www/html/wordpress/wp-config.php
sed -i "/s/password_here/qwerty/g/" /var/www/html/wordpress/wp-config.php

#  d) Kontrollin kliendi kaudu wordpressi tööd
mysql <<EOF
SHOW DATABASES;
SELECT NOW();
EOF
