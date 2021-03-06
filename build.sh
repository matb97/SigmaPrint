#Update server backbone
cd ~
sudo apt update
sudo apt upgrade -y

#Build OctoPi
sudo apt-get install gawk util-linux qemu-user-static git p7zip-full python3
git clone https://github.com/guysoft/CustomPiOS.git
git clone https://github.com/guysoft/OctoPi.git
cd OctoPi/src/image
wget -c --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf_latest'
cd ..
../../CustomPiOS/src/update-custompios-paths
sudo modprobe loop
sudo bash -x ./build_dist

#Update OctoPrint to 1.4.0
cd ~
source oprint/bin/activate
pip install --upgrade pip
pip install --upgrade octoprint

#Install Plugins
pip install "https://github.com/OctoPrint/OctoPrint-DisplayProgress/archive/master.zip"
pip install "https://github.com/jneilliii/OctoPrint-CustomBackground/archive/master.zip"
pip install "https://github.com/derPicknicker1/OctoPrint-Mmu2filamentselect/archive/master.zip"
pip install "https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/master.zip"
pip install "https://github.com/jneilliii/OctoPrint-TPLinkSmartplug/archive/master.zip"
pip install "https://github.com/marian42/octoprint-preheat/archive/master.zip"
pip install "https://github.com/BrokenFire/OctoPrint-SimpleEmergencyStop/archive/master.zip"
pip install "https://github.com/FormerLurker/Octolapse/archive/v0.3.4.zip"
pip install "https://github.com/TheSpaghettiDetective/OctoPrint-TheSpaghettiDetective/archive/master.zip"
deactivate

#Retrieve and apply Sigma settings
#HAProxy
cd /etc/haproxy
sudo rm haproxy.cfg
sudo wget https://github.com/matb97/SigmaPrint/raw/master/haproxy.cfg

cd ~
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
