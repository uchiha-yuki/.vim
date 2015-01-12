#!/bin/bash
if [ ! -d /usr/lib/python2.7/config ]; then
	echo "directory /usr/lib/python2.7/config not exists"
	exit 1
fi

cd
if [ ! -d ".tmp" ]; then
	mkdir .tmp
fi

cd .tmp
git clone https://github.com/nschloe/vim.git
cd vim
./configure --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config
make
make install

rm -rf ../vim
