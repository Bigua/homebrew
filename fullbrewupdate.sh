#! /bin/bash
echo "atualizando o hombebrew"
brew update
echo "instalando os pacotes"
brew upgrade
echo "instalando os casks"
for c in $(brew cask list); do
        info=$(brew cask info $c)
        current_ver=$(echo "$info" | sed '2,$d' | cut -d':' -f2| xargs)
        installed_ver=$(echo "$info" |cut -d' ' -f1  | rev | cut -d'/' -f 1 | rev | sed '4,$d' | sed '1,2d')
        if [ "$installed_ver" != "$current_ver" ]; then
                echo "$c is installed $installed_ver , current is $current_ver"
                echo "$c needs reinstall"
                brew cask uninstall --force $c
                brew cask install $c
        fi
done
echo "limpando"
brew cleanup
brew cask cleanup
echo " verificar se nada quebrou"
brew doctor