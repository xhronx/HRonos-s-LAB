[ -f /var/www/html/index.html ] || echo 'Executing no. 1' >/var/www/html/index.html && echo "Executing no. `awk {'print $NF'+1} /var/www/html/index.html `" > /var/www/html/index.html
