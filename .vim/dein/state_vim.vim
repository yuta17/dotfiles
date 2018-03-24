if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['$HOME/.vimrc', '$HOME/dotfiles/.vim/dein/syntax.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '$HOME/dotfiles/.vim/dein'
let g:dein#_runtime_path = '$HOME/dotfiles/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '$HOME/dotfiles/.vim/dein/.cache/.vimrc'
let &runtimepath = '$HOME/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim/,$HOME/.vim,$HOME/.vim/dein/.cache/.vimrc/.dein,$HOME/dotfiles/.vim/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,$HOME/dotfiles/.vim/dein/.cache/.vimrc/.dein/after,$HOME/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,$HOME/.vim/after'
