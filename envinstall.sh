#!/bin/bash
# General environment set up script.

# Install things
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install vim
sudo yum -y install git
sudo yum -y install tmux
sudo yum -y install pip

# Install pip
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py

if $?
then
	echo Pip could not be installed
	exit 1
else
	echo Successfully installed pip
fi

# Install flake8 python syntax checker
sudo pip install flake8

# Change PS1
ps1="$(curl -s connor.rocks/ps1)"
echo "${ps1}" >> ~/.bash_profile
echo "${ps1}" >> ~/.bashrc
source ~/.bash_profile

# Set up .vimrc
vimrc="$(curl -s connor.rocks/vimrc)"
echo "${vimrc}" > ~/.vimrc

# Install pathogen vim plugin manager
mkdir -p ~/.vim/autoload ~/.vim/plugins ~/.vim/colors

# Download pathogen
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

################################
# Begin installing vim plugins #
################################
cd ~/.vim/plugins
# Fugitive for git integration 
git clone https://github.com/tpope/vim-fugitive
# Vim-Airline to look nice
git clone https://github.com/bling/vim-airline
# Syntastic to check syntax
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
# NERD Tree for file exploration
git clone https://github.com/scrooloose/nerdtree
# NERD Tree git extension
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git
# Indentline to show indented lines
git clone https://github.com/yggdroot/indentline
cd -

vim -c Helptags
