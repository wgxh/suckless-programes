install_target=( "dwm" "st" "dmenu" )

function install() {
  echo -e "\033[32m\033[01m===> Installing $1...\033[0m"
  cd "./$1"
  make
  if [ $? == 1 ]
  then
    echo -e "\033[31m\033[01m===> Compiletion failed!\033[0m"
    echo "===> Retry? [Y/n]"
    read selectResult
    case $selectResult in
      "Y")
        echo "===> Retry..."
        install $1
        ;;
      "y")
        echo "===> Retry..."
        install $1
        ;;
      "N")
        return
        ;;
      "n")
        return
        ;;
    esac
  fi
  sudo make clean install
  if [ $? == 1 ]
  then
    echo "===> Installing failed!"
    echo "===> Retry? [Y/n]"
    read selectResult
    case $selectResult in
      "Y")
        echo "===> Retry..."
        install $1
        ;;
      "y")
        echo "===> Retry..."
        install $1
        ;;
      "N")
        return
        ;;
      "n")
        return
        ;;
    esac
  else
    echo "\033[32m\033[01m===> Installing $1 finish!\033[0m"
  fi
}

for loop in $install_target
do
  install $loop
done

echo "===> Installing finish!"
echo "===> Copying scripts to ~/.dwm"
if [ ! -e "~/.dwm" ]
then
  git clone https://github.com/wgxh/.dwm.git ~/.dwm
else
  echo "===> File already exists, delete it? [y/N]"
  read a
  case $a in
    "y")
      rm -rf ~/.dwm
      ;;
    "n")
      git clone https://github.com/wgxh/.dwm.git ~/.dwm
    esac
fi
