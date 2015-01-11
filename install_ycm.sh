#!/bin/bash
sudo apt-get -y install cmake
sudo apt-get -y install python-dev

cd
if [ ! -d .tmp ]; then
	mkdir .tmp
fi

cd .tmp
mkdir clang+llvm
if [ "$release" == "12.04" ]; then
	wget http://llvm.org/releases/3.4.2/clang+llvm-3.4.2-x86_64-unknown-ubuntu12.04.xz
	tar -xJf clang+llvm-3.4.2-x86_64-unknown-ubuntu12.04.xz -C clang+llvm --strip-components=1
	rm clang+llvm-3.4.2-x86_64-unknown-ubuntu12.04.xz 
else
	wget http://llvm.org/releases/3.5.0/clang+llvm-3.5.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
	tar -xJf clang+llvm-3.5.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz -C clang+llvm --strip-components=1
	rm clang+llvm-3.5.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
fi

mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=../clang+llvm . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs

cd ..
rm -rf clang+llvm
rm -rf ycm_build


