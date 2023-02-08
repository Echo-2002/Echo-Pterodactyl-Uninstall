#!/bin/bash

# Script Author: Cameron
# Copyright (c) 2023 Cameron. All rights reserved.
#
# This script is provided "as is," without warranty of any kind. The author is not responsible
# for any damage or loss of data that may result from the use of this script. Use at your own risk.

echo "Which service(s) would you like to uninstall? [P]anel, [W]ings, or [B]oth:"
read service

case "$service" in
  [Pp])
    # Stop the panel service
    systemctl stop pterodactyl

    # Remove the panel service
    systemctl disable pterodactyl

    # Remove the panel installation directory
    rm -rf /var/www/pterodactyl

    # Remove the panel database
    mysql -e "DROP DATABASE panel;"

    # Remove the panel database user
    mysql -e "DROP USER 'pterodactyl'@'localhost';"

    # Remove the panel's Let's Encrypt certificate
    certbot delete --cert-name pterodactyl.example.com

    echo "Pterodactyl Panel has been successfully uninstalled."
    ;;
  [Ww])
    # Stop the wings service
    systemctl stop wings

    # Remove the wings service
    systemctl disable wings

    # Remove the wings installation directory
    rm -rf /var/www/wings

    # Remove the wings database
    mysql -e "DROP DATABASE wings;"

    # Remove the wings database user
    mysql -e "DROP USER 'wings'@'localhost';"

    # Remove the wings' Let's Encrypt certificate
    certbot delete --cert-name wings.example.com

    echo "Pterodactyl Wings has been successfully uninstalled."
    ;;
  [Bb])
    # Stop the panel and wings services
    systemctl stop pterodactyl
    systemctl stop wings

    # Remove the panel and wings services
    systemctl disable pterodactyl
    systemctl disable wings

    # Remove the panel and wings installation directories
    rm -rf /var/www/pterodactyl
    rm -rf /var/www/wings

    # Remove the panel and wings databases
    mysql -e "DROP DATABASE panel;"
    mysql -e "DROP DATABASE wings;"

    # Remove the panel and wings database users
    mysql -e "DROP USER 'pterodactyl'@'localhost';"
    mysql -e "DROP USER 'wings'@'localhost';"

    # Remove the panel and wings' Let's Encrypt certificates
    certbot delete --cert-name pterodactyl.example.com
    certbot delete --cert-name wings.example.com

    echo "Pterodactyl Panel and Wings have been successfully uninstalled."
    ;;
  *)
    echo "Invalid option selected. Exiting."
    exit 1
    ;;
esac

# Restart the MySQL service
systemctl restart mysql
