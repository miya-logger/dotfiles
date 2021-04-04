#!/bin/bash

# 参考サイト
# http://vdeep.net/github-dotfiles
# http://kitakitabauer.hatenablog.com/entry/2016/09/13/173456

set -u

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

cd $THIS_DIR
git submodule init
git submodule update

echo "start setup..."
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    # echo ${THIS_DIR}/"$f"
    ln -snfv ${THIS_DIR}/"$f" ~/
done

# symlink zsh configuration files into ~/.zsh
if [ ! -d ~/.zsh ] ; then
  mkdir ~/.zsh
fi
for file in .zsh/.*
do
  if [ $file != "." -a $file != ".." -a $file != ".git" ] ; then
    ln -sf $THIS_DIR/$file ~/.zsh/
  fi
done

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END
