" はっさん用のVim

let mapleader = "\<Space>"

" ノーマルモード
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>e :q!<CR>

" クリップボードをon
set clipboard=unnamed,autoselect

"-------------------------
" 基本設定 Basics
"-------------------------

let mapleader = ","              " キーマップリーダー
set mouse=a                      " mouse scroll on
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
set notitle                      " vimを使ってくれてありがとう
set tw=0
set formatoptions=q

"-------------------------------------------------------------------------------
" 編集関連 Edit
"-------------------------------------------------------------------------------

"insertモードを抜けるとIMEオフ
 set noimdisable
 set iminsert=0 imsearch=0
 set noimcmdline
 set expandtab " Tabキーを空白に変換
 inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>"

" コンマの後に自動的にスペースを挿入
 inoremap , ,<Space>

" カーソルから行頭まで削除
 nnoremap <silent> <C-d> d0"

" autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
 autocmd BufWritePre * :%s/\t/  /ge

"-------------------------------------------------------------------------------
" ステータスライン StatusLine
"-------------------------------------------------------------------------------

set laststatus=2   " 常にステータスラインを表示
set statusline=%F%m%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
set ruler    " カーソルが何行目の何列目に置かれているかを表示する

" ステータスラインに文字コードと改行文字を表示する
" 入力モード時、ステータスラインのカラーを変更
 augroup InsertHook
 autocmd!
 autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 ctermfg=cyan
 autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 ctermfg=white
 augroup END

"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------

set autoindent   " 自動でインデント
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める
" set paste      " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ,BSにも影響する
set tabstop=2
set shiftwidth=2
set softtabstop=0

filetype plugin indent on
"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline

" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline

" コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast

"-------------------------------------------------------------------------------
" 補完・履歴 Complete
"-------------------------------------------------------------------------------

set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete+=k            " 補完に辞書ファイル追加

"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------

" ハイライト on
syntax on
set t_Co=256

" 補完候補の色づけ for vim7
 hi PmenuSel ctermbg=blue ctermfg=black
 hi PmenuSbar ctermbg=0 ctermfg=9

" 行番号の色を設定
 hi LineNr ctermfg=0

autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/=

" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
