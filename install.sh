#!/bin/sh

ln -snf ${PWD}/vimrc ${HOME}/.vimrc

if ! [ -d ${HOME}/.vim/autoload ];then
  mkdir -p ${HOME}/.vim/autoload
fi

ln -snf ${PWD}/autoload/* ${HOME}/.vim/autoload
