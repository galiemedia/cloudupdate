#!/bin/bash
#
# ------------------------------------------------------------------------
# A Simple Script to update a Debian or Ubuntu-based Cloud Server Instance
# ------------------------------------------------------------------------
#

greeting (){
    sudo echo " "
    fastfetch
    echo " "
    echo "+------------------------------------------------------------------------------+"
    echo "| This is a helper script for server update checks and maintenance tasks for a |"
    echo "| Debian 12 or Ubuntu 24 LTS basic device or non-specialized instance .        |"
    echo "+------------------------------------------------------------------------------+"
    echo " "
    echo "If you don't want to continue, press Control-C now to exit the script."
    echo " "
    read -p "If you are ready to proceed, press [Enter] to start the script..."
    echo " "
}

backstage (){
    sudo apt-get update
    clear
    echo " "
    echo "Checking on current Service statuses..."
    echo " "
    sudo service --status-all
    echo " "
    read -p "Press [Enter] to continue..."
    echo " "
}

checkupdate () {
    echo " "
    echo "Updating the available package lists..."
    echo " "
    sudo nala update
    echo " "
    echo "Here are the packages that have updates..."
    echo " "
    sudo nala list --upgradable
    echo " "
    read -p "Press [Enter] to continue..."
    echo " "
}

updateall () {
    echo " "
    echo "Beginning the server update process..."
    echo " "
    sudo nala update && sudo nala upgrade
    echo " "
}

cleanup () {
    echo " "
    echo "Beginning the update cleanup script..."
    echo " "
    sudo apt update
    sudo apt install --fix-missing -y
    sudo apt upgrade --allow-downgrades -y
    sudo apt full-upgrade --allow-downgrades -V -y
    sudo apt install -f
    sudo apt autoremove -y --purge
    sudo apt autoclean
    sudo apt clean
    sudo nala clean
    echo " "
}

needrestart () {
    echo " "
    duf -hide special
    echo " "
    sudo /sbin/needrestart
    echo " "
    echo "+------------------------------------------------------------------------------+"
    echo "|                  The server update script is now completed.                  |"
    echo "+------------------------------------------------------------------------------+"
    echo " "
}

greeting
backstage
checkupdate
updateall
cleanup
needrestart
exit 0