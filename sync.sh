# rm -rf hypr
rm -rf kitty
rm -rf neofetch
rm -rf nvim
rm -rf rofi
rm -rf swappy
rm -rf swaylock
rm -rf swww
rm -rf waybar
rm -rf wlogout
rm -rf .zshrc
rm -rf .vimrc
rm -rf .zimrc
rm -rf .ideavimrc

# cp -r ~/.config/hypr .
cp -r ~/.config/kitty .
cp -r ~/.config/neofetch .
cp -r ~/.config/nvim .
cp -r ~/.config/rofi .
cp -r ~/.config/swappy .
cp -r ~/.config/swaylock .
cp -r ~/.config/swww .
cp -r ~/.config/waybar .
cp -r ~/.config/wlogout .
cp -r ~/.zshrc .
cp -r ~/.vimrc .
cp -r ~/.zimrc .
cp -r ~/.ideavimrc .

function log(){
   echo "$@" >> .log.log 
}
hyper(){
	echo "syncing...hypr "
	if sha256sum hypr | grep ~/.config/hypr
	rm -rf hypr
	cp -r ~/.config/hypr .
	echo "sync hypr end"

	echo "同步到云端"
	git add .
	git commit -m "hypr"
	git push
}
function hyper(){
   echo "syncing...hypr "

   local expected_value=$(sha256sum ~/.config/hypr | cut -d " " -f 1)
   if sha256sum hypr | grep -q "$expected_value"
   then
      log "hypr配置文件已同步"
   else
      log "hypr文件校验值不匹配，重新同步"
      rm -rf hypr
      cp -r ~/.config/hypr .
      log "执行命令 
      rm -rf hypr &&
      cp -r ~/.config/hypr . "
      log "同步hypr配置到云端"
      # 同步到云端
      git add .
      git commit -m "hypr"
      git push
   fi
}

