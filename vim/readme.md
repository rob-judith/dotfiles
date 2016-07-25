# Usage


To initiate submodules, the plugins, run:

git submodule update --init --recursive

The above command will also update all the plugins.

In your home directory create a .vimrc, mac unix, or _vimrc, windows, that has the folowing line:

source PATHTOVIMREPO/vimrc

Also create the following .gvimrc, mac/unix, or _gvimrc:

source PATHTOVIMREPO/gvimrc | for mac/unix

source PATHTOVIMREPO\wvimrc | for windows

This will ensure that your vimrc files will stay updated.
