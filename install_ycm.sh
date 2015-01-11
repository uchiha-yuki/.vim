usage()
{
cat << EOF
Usage: $0 [OPTION]...
Install yuki's Vim (the default platform is Ubuntu 14.04 LTS)
Example: $0 --platform=14.04

Options:
-h	                     show this message
--platform=<14.04|12.04> specify a platform version, the default is Ubuntu 14.04 LTS
							  	 	
EOF
}

tmp=`getopt -o h --long platform:: -n "$0" -- "$@"`
if [ "$?" == "1"]; then
	exit 1;
fi
set -- $tmp

platform="14.04"
case "$1" in
	-h) usage; exit 0;;
	--platform)
		case "$2" in
			"12.04"|"14.04") platform="$2";;
			"") ;;
			*) 
				echo "the only possibilities for platform is 12.04 and 14.04"
				exit 1;;				
		esac;;
esac

sudo apt-get -y install cmake
sudo apt-get -y install python-dev

cd
if [ ! -d .tmp ]; then
	mkdir .tmp
fi

cd .tmp
if [ "$platform" == "12.04" ]; then
	wget http://llvm.org/releases/3.4.2/clang+llvm-3.4.2-x86_64-unknown-ubuntu12.04.xz
	tar -xvf clang+llvm-3.4.2-x86_64-unknown-ubuntu12.04.xz clang+llvm
	rm clang+llvm-3.4.2-x86_64-unknown-ubuntu12.04.xz 
else
	wget http://llvm.org/releases/3.5.0/clang+llvm-3.5.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
	tar -xvf clang+llvm-3.5.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz clang+llvm
	rm clang+llvm-3.5.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
fi

mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=clang+llvm . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs

cd ..
rm -rf clang+llvm
rm -rf ycm_build


