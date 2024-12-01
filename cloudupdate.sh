#!/bin/bash
#
# ------------------------------------------------------------------------
# A Simple Script to update a Debian or Ubuntu-based Cloud Server Instance
# ------------------------------------------------------------------------
#

debian-greeting (){
    sudo echo " "
    fastfetch
    echo " "
    echo "+------------------------------------------------------------------------------+"
    echo "| This is a helper script for server update checks and maintenance tasks for a |"
    echo "| Debian 12 Server on a generic Cloud Hosting platform as a basic instance.    |"
    echo "+------------------------------------------------------------------------------+"
    echo " "
    echo "If you don't want to continue, press Control-C now to exit the script."
    echo " "
    read -p "If you are ready to proceed, press [Enter] to start the script..."
    echo " "
}

ubuntu-greeting (){
    sudo echo " "
    fastfetch
    echo " "
    echo "+------------------------------------------------------------------------------+"
    echo "| This is a helper script for server update checks and maintenance tasks for a |"
    echo "| Ubuntu 24.04 Server on a generic Cloud Hosting platform as a basic instance. |"
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
}

showstatus (){
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

debian-updateall () {
    echo " "
    echo "Beginning the server update process..."
    echo " "
    sudo nala update && sudo nala upgrade
    echo " "
}

ubuntu-updateall () {
    echo " "
    echo "Beginning the server update process..."
    echo " "
    sudo ucaresystem-core
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

distrocheck () {
    clear
    echo " "
    echo "Checking your distribution and version..."
    echo " "
    if [ ! -f /etc/os-release ]; then
        echo " "
        echo "This script was unable to determine your OS. /etc/os-release file not found."
        echo " "
        echo "Update script will be stopped."
        echo " "
        exit 1
    fi
    . /etc/os-release
    if [ "$ID" = "debian" ]; then
        if [ $(echo "$VERSION_ID >= 12" | bc) != 1 ]; then
            echo " "
            echo "This script is not compatible with your version of Debian."
            echo " "
            echo "Your computer is is currently running: $ID $VERSION_ID"
            echo " "
            echo "This script is for Debian 12 - Update helper stopped."
            exit 1
        fi
        debian-greeting
        backstage
        showstatus
        checkupdate
        debian-updateall
    elif [ "$ID" = "ubuntu" ]; then
        if [ $(echo "$VERSION_ID >= 24.04" | bc) != 1 ]; then
            echo " "
            echo "This script is not compatible with your version of Ubuntu."
            echo " "
            echo "Your computer is is currently running: $ID $VERSION_ID"
            echo " "
            echo "This script is for Ubuntu 24 - Update helper stopped."
            exit 1
        fi
        ubuntu-greeting
        backstage
        showstatus
        checkupdate
        ubuntu-updateall
    else 
        echo " "
        echo "This script is not compatible with your distribution."
        echo " "
        echo "Your computer is is currently running: $ID $VERSION_ID"
        echo " "
        echo "This script is for Debian 12 or Ubuntu 24 - Update helper stopped."
        exit 1
    fi
}

distrocheck
cleanup
needrestart
exit 0
