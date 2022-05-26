if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

startup() {
  echo "Starting up proxies"
  sudo apt install tmux
  chmod +x start.sh
  chmod +x eagler.sh
  tmux new -d -s app ./start.sh
  tmux new -d -s eagler ./eagler.sh
  echo "Starting up PaperMC!"
  cd - 
  java -Xmx2g -Xms2g -jar paper-1.17.1-411.jar
}


multiport() {
    echo "Installing MultiPort"
    npm install jimp && npm install mime-types && npm install ws && npm install buffer-replace
    wget https://github.com/ayunami2000/ayunMultiPort/archive/refs/heads/master.zip
    sudo apt install unzip
    unzip master.zip
    rm master.zip
    cd ayunMultiPort-master
    rm eagler.js
    wget https://raw.githubusercontent.com/yeeterlol/Eaglerhost/main/storage/eagler.js
    wget https://github.com/yeeterlol/Eaglerhost/raw/main/storage/start.sh
    https://raw.githubusercontent.com/yeeterlol/Eaglerhost/main/storage/eagler.sh
    startup
}


paper() {
    echo "Installing PaperMC"
    mkdir paper
    cd paper
    wget https://api.papermc.io/v2/projects/paper/versions/1.17.1/builds/411/downloads/paper-1.17.1-411.jar
    echo "eula=true" >> eula.txt
    wget https://github.com/yeeterlol/Eaglerhost/raw/main/storage/server.properties
    mkdir plugins
    cd plugins
    echo Installing ProtocolSupport
    wget https://protocol.support/view/ProtocolSupport/job/ProtocolSupport/lastStableBuild/artifact/target/ProtocolSupport.jar
    cd - 
    multiport
}


installnode() {
    echo "Installing Nodejs"
    curl -s https://deb.nodesource.com/setup_16.x | sudo bash
    sudo apt install nodejs -y
    echo "Completed!"
}


nodejs() {
    while true; do
        read -p "Node JS (y/n?): " yn
        case $yn in
                [Yy]* ) paper; break;;
                [Nn]* ) installnode; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}


java16() {
    echo "Installing Java 16"
    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install software-properties-common ca-certificates apt-transport-https curl
    curl https://apt.corretto.aws/corretto.key | sudo apt-key add -
    sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
    sudo apt-get update
    sudo apt-get install -y java-17-amazon-corretto-jdk
    echo "Completed download!"
    nodejs
}


echo "Eaglercraft - Multiported"
while true; do
    read -p "Java 16 installed (y/n?): " yn
    case $yn in
        [Yy]* ) nodejs; break;;
        [Nn]* ) java16; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
