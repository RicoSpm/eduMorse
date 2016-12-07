#!/bin/bash

CURDIR=`pwd`

# Install dependencies
sudo apt-get install -y cmake
sudo apt-get install -y cmake-data
sudo apt-get install -y pkg-config
sudo apt-get install -y g++
sudo apt-get install -y scons
sudo apt-get install -y openjdk-8-jre-headless
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install -y blender
sudo apt-get install -y git

sudo apt-get install -y python3
sudo apt-get install -y python3-dev
sudo apt-get install -y python3-numpy
sudo apt-get install -y python3-pip

sudo pip3 install --upgrade pip
sudo pip3 install pytoml

# Install Morse simulator
cd /tmp
git clone https://github.com/morse-simulator/morse.git
cd morse
mkdir build && cd build
cmake ..
sudo make install
morse check

# Retrieving the custom simulation files
cd /tmp
FILE=morseLab
URL="https://rlabgw0.unipv.it:10026/index.php/s/Fwlt7mdJDKifOC4/download"
wget --no-check-certificate -O $FILE.tar.gz $URL
sudo tar -xvzf /tmp/$FILE.tar.gz -C /opt
cd /opt/morseLab/libraries/cBindings
scons
scons -c

cd $CURDIR
sudo cp eduMorseCreate.sh /opt/morseLab
sudo cp eduMorseRunner.py /opt/morseLab

# Setting the environment variables
echo "# MORSELAB variables" >> $HOME/.bashrc
echo "export PYTHONPATH=PYTHONPATH:/usr/local/lib/python3/dist-packages/" >> $HOME/.bashrc
echo "export MORSELABPATH=/opt/morseLab" >> $HOME/.bashrc
