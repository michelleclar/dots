hypr(){
   echo "syncing...hypr "

   local expected_value=$(sha256sum ~/.config/hypr | cut -d " " -f 1)
   if sha256sum hypr | grep -q "$expected_value"
   then
      echo "hypr配置文件已同步"
   else
      echo "hypr文件校验值不匹配，重新同步"
      rm -rf hypr
      cp -r ~/.config/hypr .
      echo "执行命令 
      rm -rf hypr &&
      cp -r ~/.config/hypr . "
      echo "同步hypr配置到云端"
      # 同步到云端
      git add .
      git commit -m "hypr"
      git push
   fi
}
hypr
