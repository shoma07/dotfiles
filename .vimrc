" Shoma Ohara .vimrc

" エンコード設定
set encoding=utf-8
scriptencoding utf-8
"" 保存時の文字コード
set fileencoding=utf-8
"" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
"" 改行コードの自動判定・左側が優先される
set fileformats=unix,dos,mac
"" 文字が崩れる問題を解決
set ambiwidth=double

" netrw.vimの設定
"" netrwは常にtree view
let g:netrw_liststyle = 3
"" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
"" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

" 表示系の設定
"" 行番号を表示する
set number
"" カーソルラインをハイライト
set cursorline
"" シンタクッスクハイライトをオンにする
syntax enable
"" カレントタブをハイライト
hi TabLineSel ctermbg=1
"" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>
"" 対応括弧をハイライト表示する
set showmatch
"" 対応括弧の表示秒数を3秒にする
set matchtime=3
"" 不可視文字を表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
"" 全角括弧関連
set matchpairs+=「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”

" タブの設定
"" タブ入力を複数の空白入力に置き換える
set expandtab
"" 画面上でタブ文字が占める幅
set tabstop=2
"" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2
"" 改行時に前の行のインデントを継続する
set autoindent
"" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
"" smartindentで増減する幅
set shiftwidth=2

" 検索の設定
"" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
"" 検索パターンに大文字小文字を区別しない
set ignorecase
"" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
"" 検索結果をハイライト
set hlsearch
"" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" 入力設定
"" バックスペースを有効にする
set backspace=indent,eol,start

" キーバインド設定
nnoremap s <Nop>
"" 画面分割
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
"" 画面移動
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sw <C-w>w
"" 画面入れ替え
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
"" 画面サイズ変更
nnoremap so <C-w>_<C-w>|
nnoremap s= <C-w>=
nnoremap s. <C-w>>
nnoremap s> <C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>>
nnoremap s< <C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
"" タブ操作
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT
"" 画面閉じる
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>

" プラグイン deni.vim
"" Vim起動完了時にインストール
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END
"" 各プラグインをインストールするディレクトリ
let s:plugin_dir = expand('~/.vim/dein/')
"" dein.vimをインストールするディレクトリをランタイムパスへ追加
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
"" dein.vimがまだ入ってなければ 最初に`git clone`
if !isdirectory(expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'))
  call mkdir(expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'), 'p')
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'))
endif
if dein#load_state(expand('~/.vim/dein/'))
    call dein#begin(expand('~/.vim/dein/'))
    call dein#add('Shougo/dein.vim')
    "" ここにプラグインを追加
    """ Yggdroot/indentLine インデントをわかりやすする
    call dein#add('Yggdroot/indentLine')
    """ itchyny/lightline.vim ステータスラインをいい感じにする
    call dein#add('itchyny/lightline.vim')
    set laststatus=2 " ステータスラインを常に表示
    set showmode " 現在のモードを表示
    set showcmd " 打ったコマンドをステータスラインの下に表示
    set ruler " ステータスラインの右側にカーソルの現在位置を表示する
    """ bronson/vim-trailing-whitespace 末尾の全角と半角の空白文字を赤くハイライト
    call dein#add('bronson/vim-trailing-whitespace')
    "" !プラグイン追加
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
