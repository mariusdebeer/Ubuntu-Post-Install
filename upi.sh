#!/bin/bash
 
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
else
    #Update and Upgrade
    echo "Updating and Upgrading"
    apt-get update && sudo apt-get upgrade -y
 
    sudo apt-get install dialog
    cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
    options=(1 "LAMP Stack" off
            2 "Essential Utilities - NCDU/HTOP/Terminator" off
            3 "Node.js" off
            4 "Snapd" off
            5 "Rocket Chat" off
            6 "JDK 8" off
            7 "Magic Wormhole" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
        do
            case $choice in
                1)
                    #Install LAMP stack
                    echo "Installing Apache"
                    apt install apache2 -y
 
                    echo "Installing Mysql Server"
                    apt install mysql-server -y
 
                    echo "Installing PHP"
                    apt install php libapache2-mod-php php-mcrypt php-mysql -y
 
                    echo "Installing Phpmyadmin"
                    apt install phpmyadmin -y
 
                    echo "Configuring apache to run Phpmyadmin"
                    echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
 
                    echo "Restarting Apache Server"
                    service apache2 restart
                    ;;
                2)
                    #Install Essential Utilities
                    echo "Installing Essential Utilities"
                    apt install -y ncdu && apt install -y htop && apt install  -y terminator
                    ;;
 
                3)
                    #Install Nodejs
                    echo "Installing Nodejs"
                    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
                    apt install -y nodejs
                    ;;
                4)
                    #Install Snapd
                    echo "Installing Snapd."
                    apt install snapd -y
                    ;;
                5)
                    #Rocketchat
                    echo "Installing Rocket Chat"
                    snap install rocketchat-server -y
                    ;;
 
                6)
                    #JDK 8
                    echo "Installing JDK 8"
                    apt install python-software-common -y
                    add-apt-repository ppa:webupd8team/java -y
                    apt update
                    apt install oracle-java8-installer -y
                    ;;
                    
                7)
                    #Magic Wormhole
                    echo "Installing Magic Wormhole"
                    apt install magic-wormhole -y
                    ;;
        esac  
    done
fi
