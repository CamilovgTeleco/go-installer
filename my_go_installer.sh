#!/bin/bash

# This is a programm to download and install go in a Linux based OS. This script will use a Python script to extract the url that leads to the latest stable version of go. In order to use the program, you must have Python installed


check() {
    is_installed=$(pip list | grep $1)
    if [[ $? -ne 0 ]]; then
        pip install $1
    fi
}

install_process () {
    sudo apt install -y python3-venv
    
    python3 -m venv venv_to_install_go
    
    source venv_to_install_go/bin/activate
    
    check "requests"
    
    check "lxml"
        
}
#checking if python3 version is installed
is_py_installed=$(python3 --version)

if [[ $? -ne 0 ]]; then
    sudo apt-get update
    sudo apt-get install python
fi

install_process

link=$(python3 url_scraper.py)

deactivate

rm -r venv_to_install_go

sudo wget $link

sudo tar -C /usr/local -xzf *.linux-amd64.tar.gz

rm *.tar.gz

user=$(whoami)

echo "export GOPATH=/home/$user/go" >> ~/.bashrc
echo "export GOBIN=/home/$user/go/bin" >> ~/.bashrc
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOBIN:$GOROOT/bin" >> ~/.bashrc

clear

go version
