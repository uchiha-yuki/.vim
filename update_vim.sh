#!/bin/bash
config_path="/usr/lib/python2.7/config"
read -p "where is your config (press y for default $config_path): " key
if [ $key != "y" ]; then
	config_path="$key"
fi

if [ ! -d "$config_path" ]; then
	echo "directory  $config_path not exists"
	exit 1
fi

cd
if [ ! -d ".tmp" ]; then
	mkdir .tmp
fi

cd .tmp
git clone https://github.com/nschloe/vim.git
cd vim
./configure --enable-pythoninterp "--with-python-config-dir=$config_path"
make
make install

rm -rf ../vim
