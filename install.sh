release=`lsb_release -r | cut -f2`
if [ "$release" != "12.04" ] && [ "$release" != "14.04" ]; then
	echo "can only support for Ubuntu of version of 12.04 or 14.04"
	exit 1;
fi

cd
rm .vimrc
ln -s .vimrc .vim/.vimrc
cd .vim
git submodule init
git submodule update --remote
vim +PluginInstall +qall
source install_ycm.sh 
