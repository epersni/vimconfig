#!/bin/sh

ln -sf vimrc ${HOME}/.vimrc
if ! [ -d ${HOME}/.vim/plugin ];then
  mkdir -p ${HOME}/.vim/plugin
fi
ln -sf plugin/* ${HOME}/.vim/plugin
