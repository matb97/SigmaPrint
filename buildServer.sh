cd ~
sudo apt update
sudo apt upgrade -y
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
wget https://github.com/matb97/SigmaPrint/raw/master/webcam
wget https://github.com/matb97/SigmaPrint/raw/master/webcamDaemon
chmod +x /home/pi/scripts/webcam
chmod +x /home/pi/scripts/webcamDaemon
wget https://github.com/matb97/SigmaPrint/raw/master/webcamStart && sudo mv webcamStart /etc/init.d/webcamStart
sudo update-rc.d webcamStart defaults
