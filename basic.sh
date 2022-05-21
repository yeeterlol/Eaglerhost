if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

eagler() {
    echo "Installing Eaglercraft server"
    wget https://raw.githubusercontent.com/LAX1DUDE/eaglercraft/main/stable-download/stable-download-new.zip
    sudo apt install unzip
    unzip stable-download-new.zip
    echo "Setting up server"
    sudo apt install tmux
    echo Starting Bungeecord
    cd java/bungee_command
    tmux new -d -s bungee java -Xmx32M -Xms32M -jar bungee-dist.jar
    cd -
    echo Starting Bukkit
    cd java/bukkit_command
    java -Xmx2g -Xms2g -jar craftbukkit-1.5.2-R1.0.jar
    cd -
    echo Done!
}

java8 () {
   echo 'Installing Java 8'
   sudo apt-get update
   sudo apt-get install openjdk-8-jdk
   echo Java 8 has been installed
   eagler
}


echo Eaglerhost - Normal Server
while true; do
    read -p "Java 8 installed (y/n?): " yn
    case $yn in
        [Yy]* ) eagler; break;;
        [Nn]* ) java8; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
