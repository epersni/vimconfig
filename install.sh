#!/bin/sh

ln -snf ${PWD}/vimrc ${HOME}/.vimrc

if ! [ -d ${HOME}/.vim/plugin ];then
  mkdir -p ${HOME}/.vim/plugin
fi

ln -snf ${PWD}/plugin/* ${HOME}/.vim/plugin
