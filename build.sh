cd ~
sudo apt update
sudo apt upgrade -y
#sudo apt remove -y python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake
sudo rm -r OctoPrint
sudo rm -r mjpg-streamer
sudo rm -r .octoprint
sudo rm -r scripts
sudo rm -r venv
cd /etc/init.d
sudo rm octoprint
sudo rm webcamStart
cd /etc/default
sudo rm octoprint
#sudo apt autoremove -y
cd ~
sudo apt install -y python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake
mkdir OctoPrint && cd OctoPrint
virtualenv venv
source venv/bin/activate
pip install pip --upgrade
pip install octoprint
sudo usermod -a -G tty pi
sudo usermod -a -G dialout pi
wget https://github.com/foosel/OctoPrint/raw/master/scripts/octoprint.init && sudo mv octoprint.init /etc/init.d/octoprint
wget https://github.com/matb97/SigmaPrint/raw/master/octoprint.default && sudo mv octoprint.default /etc/default/octoprint
sudo chmod +x /etc/init.d/octoprint
sudo update-rc.d octoprint defaults
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
sudo sed -i -e '$i /home/pi/scripts/webcam start \n' rc.local
pip install "https://github.com/OctoPrint/OctoPrint-DisplayProgress/archive/master.zip"
pip install "https://github.com/jneilliii/OctoPrint-CustomBackground/archive/master.zip"
pip install "https://github.com/derPicknicker1/OctoPrint-Mmu2filamentselect/archive/master.zip"
pip install "https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/master.zip"
pip install "https://github.com/jneilliii/OctoPrint-TPLinkSmartplug/archive/master.zip"
pip install "https://github.com/marian42/octoprint-preheat/archive/master.zip"
pip install "https://github.com/BrokenFire/OctoPrint-SimpleEmergencyStop/archive/master.zip"
#pip install "https://github.com/TheSpaghettiDetective/OctoPrint-TheSpaghettiDetective/archive/master.zip"
cd ~
wget https://github.com/matb97/SigmaPrint/raw/master/_default.profile && sudo mv _default.profile /home/pi/.octoprint/printerProfiles/_default.profile
wget https://github.com/matb97/SigmaPrint/raw/master/config.yaml && sudo mv config.yaml /home/pi/.octoprint/config.yaml
wget https://github.com/matb97/SigmaPrint/raw/master/users.yaml && sudo mv users.yaml /home/pi/.octoprint/users.yaml
sudo shutdown -r now
