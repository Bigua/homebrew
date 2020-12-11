#! /bin/bash
# Reset
Color_Off='\033[0m'       # Text Reset
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

brew update
echo  -e "$Green atualizando os apps"
brew upgrade
brew upgrade --cask
echo  -e "$Cyan atualizando os casks manualmente"
for c in $(brew list --cask); do
        info=$(brew info --cask $c)
        current_ver=$(echo "$info" | sed 's/(auto_updates)//g' | sed '2,$d' | cut -d':' -f2| xargs)
        installed_ver=$(echo "$info" |cut -d' ' -f1  | rev | cut -d'/' -f 1 | rev | sed '4,$d' | sed '1,2d')
        if [[ "$installed_ver" != *"$current_ver"* ]]; then
                echo -e "$Purple  $c installed it's $installed_ver , current its $current_ver"
                echo -e "$Yellow $c needs reinstall"
                brew fetch --cask $c
                brew uninstall --cask --force $c
                brew install --cask $c
        fi
done
echo -e "$Cyan limpando"
brew cleanup
echo -e "$Purple  verificar se nada quebrou... $Color_Off"
brew doctor