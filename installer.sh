#!/bin/sh
ln -sf $(pwd)/.vimrc $HOME/.vimrc
ls -sf $(pwd)/.tmux.conf $HOME/.tmux.conf
ln -sf $(pwd)/.tigrc $HOME/.tigrc

exit 0
