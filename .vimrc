set backspace=indent,eol,start


set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト
set hlsearch

" 行番号の表示
set number
" カーソルラインをハイライト
set cursorline

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" 括弧の対応関係を一瞬表示する
set showmatch
" %で対応する括弧に移動できる
source $VIMRUNTIME/macros/matchit.vim
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" マウスでのカーソル移動・スクロール移動を可能にする
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
" ペースト時のインデントを無効にする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" netrw.vimの設定
" netrwは常にtree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" deni.vim
" 事前に以下を実行
" $ mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
" $ git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
if &compatible
  set nocompatible
endif

" Vim起動完了時にインストール
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

" 各プラグインをインストールするディレクトリ
let s:plugin_dir = expand('~/.vim/dein/')
" dein.vimをインストールするディレクトリをランタイムパスへ追加
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
" dein.vimがまだ入ってなければ 最初に`git clone`
if !isdirectory(expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'))
  call mkdir(expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'), 'p')
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'))
endif
if dein#load_state(expand('~/.vim/dein/'))
    call dein#begin(expand('~/.vim/dein/'))
    call dein#add('Shougo/dein.vim')
    " 更新した場合は
    " :call dein#install()
    " を実行
    " ここにプラグインを追加
    " 自動補完
    " lua機能が有効になっている場合
    if has('lua')
        " コードの自動補完
        call dein#add('Shougo/neocomplete.vim')
        " スニペットの補完機能
        call dein#add('Shougo/neosnippet')
        " スニペット集
        call dein#add('Shougo/neosnippet-snippets')
    endif
    " neocomplete・neosnippetの設定
    if filereadable('/.vim/dein/repos/github.com/Shougo/neocomplete.vim')
        " Vim起動時にneocompleteを有効にする
        let g:neocomplete#enable_at_startup = 1
        " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
        let g:neocomplete#enable_smart_case = 1
        " 3文字以上の単語に対して補完を有効にする
        let g:neocomplete#min_keyword_length = 3
        " 区切り文字まで補完する
        let g:neocomplete#enable_auto_delimiter = 1
        " 1文字目の入力から補完のポップアップを表示
        let g:neocomplete#auto_completion_start_length = 1
        " バックスペースで補完のポップアップを閉じる
        inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

        " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
        imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
        " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
        imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
    endif
    call dein#add('Yggdroot/indentLine')
    " ステータスラインをいい感じにする
    call dein#add('itchyny/lightline.vim')
    set laststatus=2 " ステータスラインを常に表示
    set showmode " 現在のモードを表示
    set showcmd " 打ったコマンドをステータスラインの下に表示
    set ruler " ステータスラインの右側にカーソルの現在位置を表示する
    " 末尾の全角と半角の空白文字を赤くハイライト
    call dein#add('bronson/vim-trailing-whitespace')
    " !プラグイン追加
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable
