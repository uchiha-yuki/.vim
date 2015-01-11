release=`lsb_release -r | cut -f2`
case "$release" in
	"12.04"|"14.04") ;;
	*)
		echo "can only support for Ubuntu of version of 12.04 or 14.04"
		exit 1;;
esac

cd
rm .vimrc
ln -s .vimrc .vim/vimrc
cd .vim
git submodule init
git submodule update --remote
vim +PluginInstall +qall
./install_ycm.sh "--platform=$platform"
