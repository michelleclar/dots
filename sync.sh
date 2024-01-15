#!/bin/bash
# 定义函数
function sync(){
  echo "syncing... $1"

  # 使用 rsync 命令合并 rm 和 cp 命令
  # rm -rf $2
  # cp -r $1 .
  # rsync -av --delete $1 $2
  rsync -av --delete $1 .
  echo "rsync -av --delete $1 $2"

  # 检查退出码
  if [ $? -eq 0 ]; then
    echo "没有变化，跳过 git 命令"
  else
    echo "有变化，执行 git 命令"

    # 同步到云端
    git add .
    git add .*
    git commit -m "$1"
    git push
  fi 
  echo "sync $1 end"
}

menu(){
  echo "===================="
  echo "[1]:sync nvim"
  echo "[2]:sync hypr"
  echo "[3]:sync kitty"
  echo "[4]:sync neofetch"
  echo "[5]:sync rofi"
  echo "[6]:sync swappy"
  echo "[7]:sync swaylock"
  echo "[8]:sync swww"
  echo "[9]:sync waybar"
  echo "[10]:sync wlogout"
  echo "[11]:sync .zshrc"
  echo "[12]:sync .vimrc"
  echo "[13]:sync .zimrc"
  echo "[14]:sync .ideavimrc"
  echo "===================="
}
menu
read num
case $num in
  1) sync "/home/carl/.config/nvim" "nvim";;
  2) sync "~/.config/hypr" "hypr";;
  3) sync "~/.config/kitty" "kitty";;
  4) sync "~/.config/neofetch" "neofetch";;
  5) sync "~/.config/rofi" "rofi";;
  6) sync "~/.config/swappy" "swappy";;
  7) sync "~/.config/swaylock" "swaylock";;
  8) sync "~/.config/swww" "swww";;
  9) sync "~/.config/waybar" "waybar";;
  10) sync "~/.config/wlogout" "wlogout";;
  11) sync "~/.zshrc" ".zshrc";;
  12) sync "~/.vimrc" ".vimrc";;
  13) sync "~/.zimrc" ".zimrc";;
  14) sync "~/.ideavimrc" ".ideavimrc";;
  q) echo "quit" ;;
  *) echo "Invalid option" ;;
esac;
