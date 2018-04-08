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

echo -e "$Green atualizando o hombebrew "
brew update
echo  -e "$Green instalando os pacotes"
brew upgrade
echo  -e "$Cyan instalando os casks"
for c in $(brew cask list); do
        info=$(brew cask info $c)
        current_ver=$(echo "$info" | sed '2,$d' | cut -d':' -f2| xargs)
        installed_ver=$(echo "$info" |cut -d' ' -f1  | rev | cut -d'/' -f 1 | rev | sed '4,$d' | sed '1,2d')
        if [[ "$installed_ver" != *"$current_ver"* ]]; then
                echo -e "$Yellow  $c installed is $installed_ver , current is $current_ver"
                echo -e "$Cyan $c needs reinstall"
                brew cask fetch  $c
                brew cask uninstall --force $c
                brew cask install $c
        fi
done
echo -e "$Cyan limpando"
brew cleanup
brew cask cleanup
echo -e "$Yellow  verificar se nada quebrou... $Color_Off"
brew doctor