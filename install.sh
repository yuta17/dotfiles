#!/bin/bash

# 未定義の変数を使った時にエラーにする
set -u

THIS_DIR=$(cd $(dirname $0); pwd)

cd $THIS_DIR

echo "start setup..."

for f in .??*; do
  ln -snfv ~/dotfiles/"$f" ~/
done

echo "done!"
