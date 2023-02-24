# インストールが上手くいかない時のエラー解決
# https://qiita.com/aves/items/1195e64fa30402b7e1f6
# http://masaru.hateblo.jp/entry/2016/02/08/223120
# chmod +x ~/dotfiles/homebrew_install.sh

#!/bin/bash

echo "installing homebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade..."

brew upgrade

formulas=(
    git
    curl
    openssl
    zsh-completions
    cask
    peco
    ag
    hub
    tig
    node
    python3
    mysql
    rbenv
    ruby-build
    nodenv
    node-build
    redis
    direnv
    ghq
    yarn
    zsh
)

"brew tap..."
brew tap sanemat/font

echo "start brew install apps..."
for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

casks=(
    google-chrome
    google-japanese-ime
    slack
    iterm2
    docker
    visual-studio-code
    sequel-pro-nightly
    notion
    postman
    line
    deepl
)

echo "start brew cask install apps..."
for cask in "${casks[@]}"; do
    brew install --cask $cask
done

brew cleanup

cat << END

**************************************************
              HOMEBREW INSTALLED!
**************************************************

END
