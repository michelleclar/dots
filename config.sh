menu(){
  echo "===================="
  echo "[1]:config nvim"
  echo "[2]:config hypr"
  echo "[3]:config kitty"
  echo "[4]:config neofetch"
  echo "[5]:config rofi"
  echo "[6]:config swappy"
  echo "[7]:config swaylock"
  echo "[8]:config swww"
  echo "[9]:config waybar"
  echo "[10]:config wlogout"
  echo "[11]:config .zshrc"
  echo "[12]:config .vimrc"
  echo "[13]:config .zimrc"
  echo "[14]:config .ideavimrc"
  echo "===================="
}
menu

function sync(){
  path=$1
  echo "syncing... $path "

  filename=$(date +%Y%m%d)_$(date +%H%M%S)

  mv $path ${path}${filename}
  echo "mv $path ${path}${filename}"
  cp -r $2 $1
  echo "cp -r $2 $1"
}

read num


case $num in
  1) sync "/home/carl/.config/nvim" "nvim";;
  2) sync "/home/carl/.config/hypr" "hypr";;
  3) sync "/home/carl/.config/kitty" "kitty";;
  4) sync "/home/carl/.config/neofetch" "neofetch";;
  5) sync "/home/carl/.config/rofi" "rofi";;
  6) sync "/home/carl/.config/swappy" "swappy";;
  7) sync "/home/carl/.config/swaylock" "swaylock";;
  8) sync "/home/carl/.config/swww" "swww";;
  9) sync "/home/carl/.config/waybar" "waybar";;
  10) sync "/home/carl/.config/wlogout" "wlogout";;
  11) sync "~/.zshrc" ".zshrc";;
  12) sync "~/.vimrc" ".vimrc";;
  13) sync "~/.zimrc" ".zimrc";;
  14) sync "~/.ideavimrc" ".ideavimrc";;
  q) echo "quit" ;;
  *) echo "Invalid option" ;;
esac;
