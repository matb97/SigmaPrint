#Update server backbone
cd ~
sudo apt update
sudo apt upgrade -y

#Install Plugins
cd ~
source oprint/bin/activate
pip install "https://github.com/OctoPrint/OctoPrint-DisplayProgress/archive/master.zip"
pip install "https://github.com/jneilliii/OctoPrint-CustomBackground/archive/master.zip"
pip install "https://github.com/derPicknicker1/OctoPrint-Mmu2filamentselect/archive/master.zip"
pip install "https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/master.zip"
pip install "https://github.com/jneilliii/OctoPrint-TPLinkSmartplug/archive/master.zip"
pip install "https://github.com/marian42/octoprint-preheat/archive/master.zip"
pip install "https://github.com/BrokenFire/OctoPrint-SimpleEmergencyStop/archive/master.zip"
pip install "https://github.com/FormerLurker/Octolapse/archive/v0.3.4.zip"
deactivate

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
