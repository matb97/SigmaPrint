#Update server backbone
cd ~
sudo apt update
sudo apt upgrade -y

#Removal of OctoPrint system files
sudo rm -r OctoPrint
sudo rm -r mjpg-streamer
sudo rm -r .octoprint
sudo rm -r scripts
cd /etc/init.d
sudo rm octoprint
cd /etc/default
sudo rm octoprint

#Removal of OctoPrint dependencies
sudo apt remove -y python3-pip python3-dev python3-setuptools python3-virtualenv git libyaml-dev build-essential subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake

#Clean up
sudo apt autoremove -y

#Install OctoPrint dependencies
cd ~
sudo apt install -y python3 python3-pip python3-dev python3-setuptools python3-virtualenv git libyaml-dev build-essential subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake

#Install OctoPrint system files
mkdir OctoPrint && cd OctoPrint
python3 -m virtualenv -p /usr/bin/python3 venv
source venv/bin/activate
sudo -H pip3 install --upgrade pip
pip3 install octoprint==1.4.0
sudo usermod -a -G tty pi
sudo usermod -a -G dialout pi
wget https://github.com/foosel/OctoPrint/raw/master/scripts/octoprint.init && sudo mv octoprint.init /etc/init.d/octoprint
wget https://github.com/matb97/SigmaPrint/raw/master/octoprint.default && sudo mv octoprint.default /etc/default/octoprint
sudo chmod +x /etc/init.d/octoprint
sudo update-rc.d octoprint defaults

#Install Plugins
pip3 install "https://github.com/OctoPrint/OctoPrint-DisplayProgress/archive/master.zip"
pip3 install "https://github.com/jneilliii/OctoPrint-CustomBackground/archive/master.zip"
pip3 install "https://github.com/derPicknicker1/OctoPrint-Mmu2filamentselect/archive/master.zip"
pip3 install "https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/master.zip"
pip3 install "https://github.com/jneilliii/OctoPrint-TPLinkSmartplug/archive/master.zip"
pip3 install "https://github.com/marian42/octoprint-preheat/archive/master.zip"
pip3 install "https://github.com/BrokenFire/OctoPrint-SimpleEmergencyStop/archive/master.zip"
pip3 install "https://github.com/FormerLurker/Octolapse/archive/v0.3.4.zip"
deactivate

#Install webcam feed
cd ~
git clone https://github.com/jacksonliam/mjpg-streamer.git
cd mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
make
cd ~
mkdir scripts
wget https://github.com/matb97/SigmaPrint/raw/master/webcam && sudo mv webcam /home/pi/scripts/webcam
wget https://github.com/matb97/SigmaPrint/raw/master/webcamDaemon && sudo mv webcamDaemon /home/pi/scripts/webcamDaemon
chmod +x /home/pi/scripts/webcam
chmod +x /home/pi/scripts/webcamDaemon
cd /etc
if grep -Fxq "/home/pi/scripts/webcam start " /etc/rc.local
then
    echo "rc.local already updated"
else
    sudo sed -i -e '$i /home/pi/scripts/webcam start \n' rc.local
fi

#Retrieve and apply Sigma settings
cd ~
mkdir .octoprint
cd .octoprint
mkdir printerProfiles
mkdir data
cd data
mkdir custombackground
mkdir octolapse
cd ~
wget https://github.com/matb97/SigmaPrint/raw/master/_default.profile
sudo mv _default.profile /home/pi/.octoprint/printerProfiles/_default.profile
wget https://github.com/matb97/SigmaPrint/raw/master/config.yaml
sudo mv config.yaml /home/pi/.octoprint/config.yaml
wget https://github.com/matb97/SigmaPrint/raw/master/users.yaml
sudo mv users.yaml /home/pi/.octoprint/users.yaml
wget https://github.com/matb97/SigmaPrint/raw/master/logoBg.png
sudo mv logoBg.png /home/pi/.octoprint/data/custombackground/logoBg.png
wget https://github.com/matb97/SigmaPrint/raw/master/settings.json
sudo mv settings.json /home/pi/.octoprint/data/octolapse/settings.json

#Clean up and restart
sudo rm $0
sudo shutdown -r now
