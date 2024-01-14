#!/bin/bash

# 定义函数
function sync(){
  echo "syncing..."

  # 检查目录是否存在，如果不存在则创建
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi

  # 提示用户是否确认执行操作
  echo "是否确认同步配置？(y/n)"
  read -p "(y/n) " answer
  if [ "$answer" != "y" ]; then
    echo "取消同步"
    return
  fi

  # 使用 rsync 命令合并 rm 和 cp 命令
  rsync -a "$1" .

  echo "同步配置到云端"
  # 同步到云端
  git add .
  git commit -m "$1"
  git push
}

# 执行函数
sync "hypr"
sync "kitty"
sync "neofetch"
sync "nvim"
sync "rofi"
sync "swappy"
sync "swaylock"
sync "swww"
sync "waybar"
sync "wlogout"
sync ".zshrc"
sync ".vimrc"
sync ".zimrc"
sync ".ideavimrc"

