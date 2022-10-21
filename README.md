Usage
-----

To put all the files in correct places:

    cd ~
    git clone git@github.com:tayfun/.dotfiles.git
    mv .bashrc .bashrc.bak
    ln -s .dotfiles/vim/vimrc .vimrc && ln -s .dotfiles/vim/gvimrc .gvimrc && ln -s .dotfiles/vim .vim && ln -s .dotfiles/bash/bashrc .bashrc && ln -s .dotfiles/bash/bash_profile .bash_profile && ln -s .dotfiles/git/gitconfig .gitconfig
    mkdir ~/.vim/backupdir/

To install all the vim plugins that are defined, run

    :PlugInstall

inside vim/gvim itself.

Dependencies
------------

ripgrep for search tool.
